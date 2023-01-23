using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Pepper.Models.CodeFirst;
using System.Data.Objects;
using Pepper.Framework.Validation;


namespace PepperExcelImport {
	class ImportDealUnderlyingFund {

		private static List<C5_10tblDealOrigination> C5_10tblDealOrigination = new List<C5_10tblDealOrigination>();

		public static void Import() {

			Import_5_10();

			DealUnderlyingFund dealUnderlyingFund = null;
			int dealID = 0;
			int fundID = 0;
			int underlyingFundID = 0;
			DateTime minDate = Convert.ToDateTime("01/01/1900");
			int i = 2;
			IEnumerable<ErrorInfo> errorInfo;
			foreach (var blueAsset in C5_10tblDealOrigination) {
				i++;
				fundID = (Globals.GetFundID(blueAsset.AmberbrookFundNo) ?? 0);
				dealID = (Globals.GetDealID(blueAsset.DealNo, fundID) ?? 0);
				underlyingFundID = (Globals.GetUnderlyingFundID(blueAsset.Fund) ?? 0);
				using (PepperContext context = new PepperContext()) {
					dealUnderlyingFund = (from duf in context.DealUnderlyingFunds
										  where duf.DealID == dealID
										  && duf.UnderlyingFundID == underlyingFundID
										  && EntityFunctions.Truncate((duf.CommittedAmount ?? 0), 2) == EntityFunctions.Truncate((decimal)blueAsset.CapitalCommitment, 2)
										  && EntityFunctions.TruncateTime((duf.EffectiveDate ?? minDate)) == EntityFunctions.TruncateTime((blueAsset.EffectiveDate ?? minDate))
										  && EntityFunctions.TruncateTime((duf.RecordDate ?? minDate)) == EntityFunctions.TruncateTime((blueAsset.RecordDate ?? minDate))
										  //&& EntityFunctions.Truncate((duf.UnfundedAmount ?? 0), 2) == EntityFunctions.Truncate(blueAsset.AmountUnfunded, 2)
										  //&& EntityFunctions.Truncate((duf.GrossPurchasePrice ?? 0), 2) == EntityFunctions.Truncate((blueAsset.GrossPurchasePrice ?? 0), 2)
										  //  && EntityFunctions.Truncate((duf.AdjustedNAV ?? 0), 2) == EntityFunctions.Truncate((blueAsset.AdjNAV ?? 0), 2)
										  //  && EntityFunctions.Truncate((duf.DiscountNAV ?? 0), 2) == EntityFunctions.Truncate((blueAsset.DiscountNAV ?? 0), 2)
										  select duf).FirstOrDefault();
				}
				if (dealUnderlyingFund == null) {
					dealUnderlyingFund = new DealUnderlyingFund();
					Util.WriteNewEntry("Deal underlying fund does not exist row no : " + i + " deal no : " + blueAsset.DealNo + " fundNo : " + blueAsset.AmberbrookFundNo + " fund : " + blueAsset.Fund);
				} else {
					Util.WriteError("Deal underlying fund already exist row no : " + i + " deal no : " + blueAsset.DealNo + " fundNo : " + blueAsset.AmberbrookFundNo + " fund : " + blueAsset.Fund);
				}
				// The UI asks for the following fields
				dealUnderlyingFund.DealID = dealID;
				dealUnderlyingFund.UnderlyingFundID = underlyingFundID;


				dealUnderlyingFund.CommittedAmount = blueAsset.CapitalCommitment;
				dealUnderlyingFund.EffectiveDate = blueAsset.EffectiveDate;
				dealUnderlyingFund.RecordDate = blueAsset.RecordDate.Value.Date;
				// optional fields
				dealUnderlyingFund.GrossPurchasePrice = blueAsset.GrossPurchasePrice;
				dealUnderlyingFund.NetPurchasePrice = blueAsset.NetPurchasePrice;
				dealUnderlyingFund.UnfundedAmount = blueAsset.AmountUnfunded;
				dealUnderlyingFund.PostRecordDateCapitalCall = blueAsset.PostRecordDateCashFlows;
				dealUnderlyingFund.AdjustedNAV = blueAsset.AdjNAV;
				dealUnderlyingFund.DiscountNAV = blueAsset.DiscountNAV;
				dealUnderlyingFund.AdjustedUnfunded = blueAsset.AmountUnfundeda;
				errorInfo = dealUnderlyingFund.Save();

				if (errorInfo != null) {
					Util.WriteError("Deal underlying fund error:" + ValidationHelper.GetErrorInfo(errorInfo));
				} else {
					Util.WriteNewEntry("Deal underlying fund updated: " + dealUnderlyingFund.DealUnderlyingFundID);
				}

				Util.WriteNewEntry("Deal underlying fund updated: " + dealUnderlyingFund.DealUnderlyingFundID);

				UnderlyingFundNAV underlyingFundNAV = null;
				using (PepperContext context = new PepperContext()) {
					var query = context.UnderlyingFundNAVs.Where(fundNAV => fundNAV.UnderlyingFundID == dealUnderlyingFund.UnderlyingFundID
							&& fundNAV.FundID == fundID
							);
					if (dealUnderlyingFund.EffectiveDate.HasValue) {
						query = query.Where(ufv => EntityFunctions.TruncateTime((ufv.UpdateDate ?? minDate)) == EntityFunctions.TruncateTime((dealUnderlyingFund.EffectiveDate ?? minDate)));
					}
					underlyingFundNAV = query.FirstOrDefault();
				}
				if (underlyingFundNAV == null) {
					underlyingFundNAV = new UnderlyingFundNAV();
					underlyingFundNAV.CreatedBy = Globals.CurrentUser.UserID;
					underlyingFundNAV.CreatedDate = DateTime.Now;
				} 
				underlyingFundNAV.LastUpdatedBy = Globals.CurrentUser.UserID;
				underlyingFundNAV.LastUpdatedDate = DateTime.Now;
				underlyingFundNAV.FundNAV = blueAsset.FundNAV;
				underlyingFundNAV.FundNAVDate = (dealUnderlyingFund.EffectiveDate ?? minDate);
				underlyingFundNAV.UpdateDate = (dealUnderlyingFund.EffectiveDate ?? minDate);
				underlyingFundNAV.UnderlyingFundID = dealUnderlyingFund.UnderlyingFundID;
				underlyingFundNAV.FundID = fundID;
				errorInfo = underlyingFundNAV.Save();
				if (errorInfo != null) {
					Util.WriteError("underlyingFundNAV error:" + ValidationHelper.GetErrorInfo(errorInfo));
				} else {
					Util.WriteNewEntry("underlyingFundNAV fund updated: " + underlyingFundNAV.UnderlyingFundNAVID);
				}
				Util.WriteNewEntry("Underlying fund nav updated: " + underlyingFundNAV.UnderlyingFundNAVID);
				UnderlyingFundNAVHistory underlyingFundNAVHistory = new UnderlyingFundNAVHistory();
				underlyingFundNAVHistory.UnderlyingFundNAVID = underlyingFundNAV.UnderlyingFundNAVID;
				underlyingFundNAVHistory.FundNAV = underlyingFundNAV.FundNAV;
				underlyingFundNAVHistory.FundNAVDate = underlyingFundNAV.FundNAVDate;
				underlyingFundNAVHistory.Calculation = null;
				underlyingFundNAVHistory.IsAudited = false;
				underlyingFundNAVHistory.CreatedBy = Globals.CurrentUser.UserID;
				underlyingFundNAVHistory.CreatedDate = DateTime.Now;
				underlyingFundNAVHistory.LastUpdatedBy = Globals.CurrentUser.UserID;
				underlyingFundNAVHistory.LastUpdatedDate = DateTime.Now;
				errorInfo = underlyingFundNAVHistory.Save();
				if (errorInfo != null) {
					Util.WriteError("underlyingFundNAVHistory error:" + ValidationHelper.GetErrorInfo(errorInfo));
				} else {
					Util.WriteNewEntry("underlyingFundNAVHistory fund updated: " + underlyingFundNAVHistory.UnderlyingFundNAVHistoryID);
				}
				Util.WriteNewEntry("Underlying fund nav history updated: " + underlyingFundNAVHistory.UnderlyingFundNAVHistoryID);
			}

		}

		public static void Import_5_10() {

			string tableName = "5-10Delta";

			PagingDataTable dt = Globals.GetExcelDataTable(tableName);

			string fundNo;
			int dealNo;
			//int fundNo;
			string fund;
			DateTime valueDate;
			DateTime recordDate;
			DateTime purchaseDate;
			DateTime effectiveDate;
			decimal nav;
			decimal capitalCommitment;
			decimal unfunded;
			decimal adjNAV;
			decimal discountNAV;
			decimal gpp;
			decimal postRecordCashFlow;
			decimal npp;
			decimal unfundedA;
			bool isCalled;
			DateTime dateCalled;



			foreach (DataRow row in dt.Rows) {
				fundNo = DataTypeHelper.ToString(row["AMB"]);
				dealNo = DataTypeHelper.ToInt32(DataTypeHelper.ToString(row["Deal No."]));
				fund = DataTypeHelper.ToString(row["Fund"]);
				valueDate = DataTypeHelper.ToFromOADate(DataTypeHelper.ToString(row["Value Date"]));
				recordDate = DataTypeHelper.ToFromOADate(DataTypeHelper.ToString(row["Record Date"]));
				purchaseDate = DataTypeHelper.ToFromOADate(DataTypeHelper.ToString(row["Purchase Date"]));
				effectiveDate = DataTypeHelper.ToFromOADate(DataTypeHelper.ToString(row["Effective Date"]));
				nav = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["NAV"]));
				capitalCommitment = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["Capital Commitment"]));
				unfunded = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["Unfunded (Value Date)"]));
				adjNAV = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["AdjNAV"]));
				discountNAV = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["DiscountNAV"]));
				gpp = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["CALC Gross Purch. Price"]));
				postRecordCashFlow = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["CALC Post Record Date"]));
				npp = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["CALC Net Purch. Price"]));
				unfundedA = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["CALC Unfunded (Adj)"]));
				isCalled = DataTypeHelper.CheckBoolean(DataTypeHelper.ToString(row["Called"]));
				dateCalled = DataTypeHelper.ToFromOADate(DataTypeHelper.ToString(row["DateCalled"]));

				C5_10tblDealOrigination.Add(new C5_10tblDealOrigination {
					AdjNAV = adjNAV,
					AmberbrookFundNo = fundNo,
					AmountUnfunded = unfunded,
					AmountUnfundeda = unfundedA,
					Called = isCalled,
					CapitalCommitment = capitalCommitment,
					DateCalled = dateCalled,
					DealNo = dealNo,
					DiscountNAV = discountNAV,
					EffectiveDate = effectiveDate,
					Fund = fund,
					FundNAV = nav,
					//FundNo = fundNo,
					GrossPurchasePrice = gpp,
					NetPurchasePrice = npp,
					PostRecordDateCashFlows = postRecordCashFlow,
					PurchaseDate = purchaseDate,
					RecordDate = recordDate,
					ValueDate = valueDate,
				});
			}
		}
	}
}

