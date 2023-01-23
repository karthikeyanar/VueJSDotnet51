using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Pepper.Models.CodeFirst;
using System.Data.Objects;
using Pepper.Framework.Validation;


namespace PepperExcelImport {
	class UpdateCashDistributionTypeExcel {

		private static List<CashDistribution> CashDistribution = new List<CashDistribution>();

		public static void Import() {
			Import_CashDistribution();
			DateTime minDate = Convert.ToDateTime("01/01/1900");
			CashDistribution cashDistribution = null;
			UnderlyingFundCashDistribution underlyingFundCashDistribution = null;
			int cashDistributionTypeID = (int)Pepper.Models.CodeFirst.Enums.CashDistributionType.RegularDistribution;
			IEnumerable<ErrorInfo> errorInfo;
			int i = 1;
			foreach (var cadd in CashDistribution) {
				i++;
				cashDistribution = null;
				underlyingFundCashDistribution = null;
				using (PepperContext context = new PepperContext()) {
					cashDistribution = context.CashDistributions.Where(q => q.CashDistributionID == cadd.CashDistributionID).FirstOrDefault();
					if (cashDistribution != null) {
						underlyingFundCashDistribution = context.UnderlyingFundCashDistributions.Where(q => q.UnderlyingFundCashDistributionID == cashDistribution.UnderlyingFundCashDistributionID).FirstOrDefault();
					}
				}

				if (cashDistribution != null) {
					cashDistribution.CashDistributionTypeID = cashDistributionTypeID;
					errorInfo = cashDistribution.Save();
					if (errorInfo != null) {
						Util.WriteError("cashDistribution row " + i + " error: " + ValidationHelper.GetErrorInfo(errorInfo));
					} else {
						Util.WriteNewEntry("cashDistribution row : " + i);
					}
				}

				if (underlyingFundCashDistribution != null) {
					//underlyingFundCashDistribution.CashDistributionTypeID = cashDistributionTypeID;
					errorInfo = underlyingFundCashDistribution.Save();
					if (errorInfo != null) {
						Util.WriteError("underlyingFundCashDistribution row " + i + " error: " + ValidationHelper.GetErrorInfo(errorInfo));
					} else {
						Util.WriteNewEntry("underlyingFundCashDistribution row : " + i);
					}
				}
			}
		}

		public static void Import_CashDistribution() {

			string tableName = "CashDistribution";

			PagingDataTable dt = Globals.GetExcelDataTable(tableName);

			string fund;
			string investment;
			string dealName;
			int dealNumber;
			DateTime effectiveDate;
			DateTime noticeDate;
			bool reconciled;
			DateTime reconcileDate;
			decimal amount;
			decimal managementFee;
			decimal totalAmount;
			bool allocated;
			int distributionID;
			string stockName;
			string stockSymbol;
			string type;
			bool unusedCapital;

			int fundId;
			int underlyingFundId;
			int dealId;
			CashDistribution cashDistribution = null;

			DateTime minDate = Convert.ToDateTime("01/01/1900");
			int i = 1;
			foreach (DataRow row in dt.Rows) {
				i++;
				fund = DataTypeHelper.ToString(row["Fund"]);
				investment = DataTypeHelper.ToString(row["Investment"]);
				dealName = DataTypeHelper.ToString(row["DealName"]);
				dealNumber = DataTypeHelper.ToInt32(DataTypeHelper.ToString(row["DealNumber"]));
				effectiveDate = DataTypeHelper.ToFromOADate(DataTypeHelper.ToString(row["EffectiveDate"]));
				noticeDate = DataTypeHelper.ToFromOADate(DataTypeHelper.ToString(row["NoticeDate"]));
				reconciled = DataTypeHelper.CheckBoolean(DataTypeHelper.ToString(row["Reconciled"]));
				reconcileDate = DataTypeHelper.ToFromOADate(DataTypeHelper.ToString(row["ReconcileDate"]));
				amount = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["Amount"]));
				managementFee = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["ManagementFee"]));
				totalAmount = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["TotalAmount"]));
				allocated = DataTypeHelper.CheckBoolean(DataTypeHelper.ToString(row["Allocated"]));
				distributionID = DataTypeHelper.ToInt32(DataTypeHelper.ToString(row["DistributionID"]));
				stockName = DataTypeHelper.ToString(row["StockName"]);
				stockSymbol = DataTypeHelper.ToString(row["StockSymbol"]);
				type = DataTypeHelper.ToString(row["Type"]);
				unusedCapital = DataTypeHelper.CheckBoolean(DataTypeHelper.ToString(row["UnusedCapital"]));

				cashDistribution = null;
				using (PepperContext context = new PepperContext()) {
					fundId = context.Funds.Where(q => q.FundName == fund).FirstOrDefault().FundID;
					dealId = (Globals.GetDealID(dealNumber, fundId) ?? 0);
					underlyingFundId = (Globals.GetUnderlyingFundID(investment) ?? 0);
					cashDistribution = (from cd in context.CashDistributions
										where cd.UnderlyingFundID == underlyingFundId
										&& cd.DealID == dealId
										&& EntityFunctions.TruncateTime((cd.DistributionDate ?? minDate)) == EntityFunctions.TruncateTime(effectiveDate)
										&& EntityFunctions.Truncate(cd.Amount, 2) == EntityFunctions.Truncate(amount, 2)
										&& EntityFunctions.TruncateTime((cd.UnderlyingFundCashDistribution.NoticeDate ?? minDate)) == EntityFunctions.TruncateTime(noticeDate)
										&& (cd.IsReconciled ?? false) == reconciled
										&& EntityFunctions.TruncateTime((cd.PaidON ?? minDate)) == reconcileDate
										select cd).FirstOrDefault();
				}

				if (cashDistribution != null) {
					Pepper.Models.CodeFirst.Enums.CashDistributionType cashDistributionType = (Pepper.Models.CodeFirst.Enums.CashDistributionType)cashDistribution.CashDistributionTypeID;
					if (cashDistributionType != Pepper.Models.CodeFirst.Enums.CashDistributionType.ShortTermNettedDistribution) {
						Util.WriteError("Cash distribution does not netted distribution : " + i);
					} else {
						Util.WriteNewEntry("Cash distribution added : " + i);
						CashDistribution.Add(cashDistribution);
					}
				} else {
					Util.WriteError("Cash distribution does not exist row : " + i);
				}
			}
		}
	}
}

