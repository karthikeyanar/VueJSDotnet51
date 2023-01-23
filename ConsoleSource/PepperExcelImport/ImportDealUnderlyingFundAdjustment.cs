using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Pepper.Models.CodeFirst;
using System.Data.Objects;
using Pepper.Framework.Validation;

namespace PepperExcelImport {
	class ImportDealUnderlyingFundAdjustment {

		private static List<ImportAdjustmentTable> Adjustments = new List<ImportAdjustmentTable>();

		public static void Import() {
			List<UnderlyingFundCapitalCallLineItem> underlyingFundCapitalCallLineItems = null;
			List<CashDistribution> cashDistributions = null;
			DateTime minDate = Convert.ToDateTime("01/01/1900");
			DateTime targetDate = Convert.ToDateTime("07/08/2013");
			using (PepperContext context = new PepperContext()) {
				underlyingFundCapitalCallLineItems = context.UnderlyingFundCapitalCallLineItems.Where(cc =>
					cc.Deal.EntityID == Globals.DefaultEntityID
					&& cc.UnderlyingFundCapitalCallID != null
					&& EntityFunctions.TruncateTime(cc.CreatedDate) == targetDate
					).ToList();
				cashDistributions = context.CashDistributions.Where(cd => cd.Deal.EntityID == Globals.DefaultEntityID
					&& cd.CashDistributionTypeID == (int)Pepper.Models.CodeFirst.Enums.CashDistributionType.ShortTermNettedDistribution
					&& cd.UnderlyingFundCashDistributionID != null
					&& EntityFunctions.TruncateTime(cd.CreatedDate) == targetDate
					).ToList();
			}

			Import_1_25Delta();
			Import_5_30Delta();
			foreach (var cc in underlyingFundCapitalCallLineItems) {
				Adjustments.Add(new ImportAdjustmentTable {
					Amount = cc.Amount * -1,
					Date = (cc.ReceivedDate ?? minDate),
					DealUnderlyingFundAdjustmentReasonID = (int)Pepper.Models.CodeFirst.Enums.DealUnderlyingFundAdjustmentReason.CapitalCall,
					DealUnderlyingFundAdjustmentReasonSourceID = cc.UnderlyingFundCapitalCallLineItemID,
					DealID = cc.DealID,
					UnderlyingFundID = cc.UnderlyingFundID,
					Type = "Call"
				});
				Util.WriteNewEntry("Capital call initital :" + cc.UnderlyingFundCapitalCallLineItemID);
			}
			foreach (var cd in cashDistributions) {
				Adjustments.Add(new ImportAdjustmentTable {
					Amount = cd.Amount * -1,
					Date = (cd.DistributionDate ?? minDate),
					DealUnderlyingFundAdjustmentReasonID = (int)Pepper.Models.CodeFirst.Enums.DealUnderlyingFundAdjustmentReason.NettedDistribution,
					DealUnderlyingFundAdjustmentReasonSourceID = cd.CashDistributionID,
					DealID = cd.DealID,
					UnderlyingFundID = cd.UnderlyingFundID,
					Type = "Cash",
				});
				Util.WriteNewEntry("Cash distribution initital :" + cd.CashDistributionID);
			}
			Util.Log("Total adjustments:" + Adjustments.Count());
			List<ImportAdjustmentTable> sortedImportAdjustments = Adjustments.OrderBy(adj => adj.Date).ToList();
			foreach (var adjustment in sortedImportAdjustments) {
				if (adjustment.Date.Year <= 1900) {
					Util.WriteError("Wrong date: 1900  Type: " + adjustment.Type + " DealUnderlyingFundAdjustmentReasonSourceID: " + adjustment.DealUnderlyingFundAdjustmentReasonSourceID);
				} else {
					CreateDealUnderlyingFundAdjustment(adjustment);
				}
			}
		}

		private static void CreateDealUnderlyingFundAdjustment(ImportAdjustmentTable adjTable) {
			DealUnderlyingFund dealUnderlyingFund = null;
			using (PepperContext context = new PepperContext()) {
				dealUnderlyingFund = (from duf in context.DealUnderlyingFunds
									  join deal in context.Deals on duf.DealID equals deal.DealID
									  where deal.DealID == adjTable.DealID
									  && duf.UnderlyingFundID == adjTable.UnderlyingFundID
									  select duf).FirstOrDefault();
			}
			DealUnderlyingFundAdjustment prevDealUnderlyingFundAdjustment = null;
			DealUnderlyingFundAdjustment dealUnderlyingFundAdjustment = null;
			DateTime minDate = Convert.ToDateTime("01/01/1900");
			if (dealUnderlyingFund != null) {
				using (PepperContext context = new PepperContext()) {
					if (dealUnderlyingFund != null) {
						prevDealUnderlyingFundAdjustment = (from dufadj in context.DealUnderlyingFundAdjustments
															where dufadj.DealUnderlyingFundID == dealUnderlyingFund.DealUnderlyingFundID
															&& EntityFunctions.TruncateTime((dufadj.EffectiveDate ?? minDate)) <= EntityFunctions.TruncateTime(adjTable.Date)
															orderby new { dufadj.EffectiveDate, dufadj.DealUnderlyingFundAdjustmentID } descending
															select dufadj).FirstOrDefault();
						//dealUnderlyingFundAdjustment = (from dufadj in context.DealUnderlyingFundAdjustments
						//                                where dufadj.DealUnderlyingFundID == dealUnderlyingFund.DealUnderlyingFundID
						//                                && dufadj.DealUnderlyingFundAdjustmentReasonID == adjTable.DealUnderlyingFundAdjustmentReasonID
						//                                && (dufadj.DealUnderlyingFundAdjustmentReasonSourceID ?? 0) == (adjTable.DealUnderlyingFundAdjustmentReasonSourceID ?? 0)
						//                                && EntityFunctions.TruncateTime((dufadj.EffectiveDate ?? minDate)) == EntityFunctions.TruncateTime(adjTable.Date)
						//                                select dufadj).FirstOrDefault();
					}
				}

				dealUnderlyingFundAdjustment = new DealUnderlyingFundAdjustment();
				dealUnderlyingFundAdjustment.CreatedBy = Globals.CurrentUser.UserID;
				dealUnderlyingFundAdjustment.CreatedDate = DateTime.Now;

				dealUnderlyingFundAdjustment.LastUpdatedBy = Globals.CurrentUser.UserID;
				dealUnderlyingFundAdjustment.LastUpdatedDate = DateTime.Now;
				dealUnderlyingFundAdjustment.DealUnderlyingFundID = dealUnderlyingFund.DealUnderlyingFundID;
				dealUnderlyingFundAdjustment.EffectiveDate = adjTable.Date;
				if (prevDealUnderlyingFundAdjustment == null) {
					dealUnderlyingFundAdjustment.PrevUnfundedAmount = adjTable.Amount;
					dealUnderlyingFundAdjustment.UnfundedAmount = adjTable.Amount;
					dealUnderlyingFundAdjustment.CommitmentAmount = adjTable.Amount;
				} else {
					if (adjTable.Type == "Reset") {
						dealUnderlyingFundAdjustment.PrevUnfundedAmount = adjTable.Amount;
						dealUnderlyingFundAdjustment.UnfundedAmount = adjTable.Amount;
					} else {
						dealUnderlyingFundAdjustment.PrevUnfundedAmount = prevDealUnderlyingFundAdjustment.UnfundedAmount;
						dealUnderlyingFundAdjustment.UnfundedAmount = decimal.Add((prevDealUnderlyingFundAdjustment.UnfundedAmount ?? 0), adjTable.Amount);
					}
					dealUnderlyingFundAdjustment.CommitmentAmount = prevDealUnderlyingFundAdjustment.CommitmentAmount;
				}
				string notes = string.Empty;
				switch (adjTable.Type) {
					case "Call":
						notes = "Capital Call";
						break;
					case "Cash":
						notes = "Netted Distribution";
						break;
					case "Adjust":
						notes = "Adjustment";
						break;
					case "Reset":
						notes = "Override";
						break;
				}
				dealUnderlyingFundAdjustment.Notes = notes;
				dealUnderlyingFundAdjustment.DealUnderlyingFundAdjustmentReasonID = adjTable.DealUnderlyingFundAdjustmentReasonID;
				IEnumerable<ErrorInfo> errorInfo = dealUnderlyingFundAdjustment.Save();
				if (errorInfo != null) {
					Util.WriteError("Save deal underlying fund adjustment error : " + ValidationHelper.GetErrorInfo(errorInfo));
				}
				Util.WriteNewEntry("Save DealUnderlyingFundAdjustment: " + dealUnderlyingFundAdjustment.DealUnderlyingFundAdjustmentID);
			}
		}

		private static void Import_1_25Delta() {

			string tableName = "1-25Delta";
			PagingDataTable dt = Globals.GetExcelDataTable(tableName);

			int transactionID;
			DateTime date;
			string fundNo;
			int dealNo;
			string underlyingFundName;
			decimal unfundedAdjustment;
			bool isNonEventUpdate;

			int fundID;
			int underlyingFundID;
			int dealID;
			DateTime minDate = Convert.ToDateTime("01/01/1900");
			DealUnderlyingFund dealUnderlyingFund = null;

			foreach (DataRow row in dt.Rows) {
				transactionID = DataTypeHelper.ToInt32(DataTypeHelper.ToString(row["TransactionID"]));
				date = DataTypeHelper.ToFromOADate(DataTypeHelper.ToString(row["Date"]));
				fundNo = DataTypeHelper.ToString(row["AMB #"]);
				dealNo = DataTypeHelper.ToInt32(DataTypeHelper.ToString(row["DealNo"]));
				underlyingFundName = DataTypeHelper.ToString(row["Fund"]);
				unfundedAdjustment = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["Unfunded Adjustment"]));
				isNonEventUpdate = DataTypeHelper.CheckBoolean(DataTypeHelper.ToString(row["Non-eventUpdate"]));

				fundID = (Globals.GetFundID(fundNo) ?? 0);
				underlyingFundID = (Globals.GetUnderlyingFundID(underlyingFundName) ?? 0);
				dealID = (Globals.GetDealID(dealNo, fundID) ?? 0);

				dealUnderlyingFund = null;
				using (PepperContext context = new PepperContext()) {
					dealUnderlyingFund = (from duf in context.DealUnderlyingFunds
										  join deal in context.Deals on duf.DealID equals deal.DealID
										  where deal.DealID == dealID
										  && deal.FundID == fundID
										  && duf.UnderlyingFundID == underlyingFundID
										  select duf).FirstOrDefault();
					if (dealUnderlyingFund != null) {
						Adjustments.Add(new ImportAdjustmentTable {
							Amount = unfundedAdjustment,
							Date = date,
							DealUnderlyingFundAdjustmentReasonID = (int)Pepper.Models.CodeFirst.Enums.DealUnderlyingFundAdjustmentReason.GPAdjustment,
							DealUnderlyingFundAdjustmentReasonSourceID = null,
							DealID = dealID,
							UnderlyingFundID = underlyingFundID,
							Type = "Adjust",
						});
						Util.WriteNewEntry("C1_25tblAdjustmentstoUnfundedImport initital :" + transactionID);
					}
				}
			}
		}

		private static void Import_5_30Delta() {

			string tableName = "5-30Delta";
			PagingDataTable dt = Globals.GetExcelDataTable(tableName);

			int transactionID;
			DateTime date;
			string fundNo;
			int dealNo;
			string underlyingFundName;
			decimal unfundedAdjustment;

			int fundID;
			int underlyingFundID;
			int dealID;
			DateTime minDate = Convert.ToDateTime("01/01/1900");
			DealUnderlyingFund dealUnderlyingFund = null;

			foreach (DataRow row in dt.Rows) {
				transactionID = DataTypeHelper.ToInt32(DataTypeHelper.ToString(row["TransactionID"]));
				date = DataTypeHelper.ToFromOADate(DataTypeHelper.ToString(row["Date"]));
				fundNo = DataTypeHelper.ToString(row["AmberbrookFundNo"]);
				dealNo = DataTypeHelper.ToInt32(DataTypeHelper.ToString(row["DealNo"]));
				underlyingFundName = DataTypeHelper.ToString(row["Fund"]);
				unfundedAdjustment = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["AmountUnfunded"]));

				fundID = (Globals.GetFundID(fundNo) ?? 0);
				underlyingFundID = (Globals.GetUnderlyingFundID(underlyingFundName) ?? 0);
				dealID = (Globals.GetDealID(dealNo, fundID) ?? 0);

				dealUnderlyingFund = null;
				using (PepperContext context = new PepperContext()) {
					dealUnderlyingFund = (from duf in context.DealUnderlyingFunds
										  join deal in context.Deals on duf.DealID equals deal.DealID
										  where deal.DealID == dealID
										  && deal.FundID == fundID
										  && duf.UnderlyingFundID == underlyingFundID
										  select duf).FirstOrDefault();
					if (dealUnderlyingFund != null) {
						Adjustments.Add(new ImportAdjustmentTable {
							Amount = unfundedAdjustment,
							Date = date,
							DealUnderlyingFundAdjustmentReasonID = (int)Pepper.Models.CodeFirst.Enums.DealUnderlyingFundAdjustmentReason.GPAdjustment,
							DealUnderlyingFundAdjustmentReasonSourceID = null,
							DealID = dealID,
							UnderlyingFundID = underlyingFundID,
							Type = "Reset",
						});
						Util.WriteNewEntry("C5_30tblUnfundedOverrideImport initital :" + transactionID);
					}
				}
			}
		}
	}

	class ImportAdjustmentTable {

		public int? DealUnderlyingFundAdjustmentReasonID { get; set; }

		public int? DealUnderlyingFundAdjustmentReasonSourceID { get; set; }

		public int? DealID { get; set; }

		//public int? FundID { get; set; }

		public int? UnderlyingFundID { get; set; }

		public decimal Amount { get; set; }

		public DateTime Date { get; set; }

		public string Type { get; set; }
	}
}
