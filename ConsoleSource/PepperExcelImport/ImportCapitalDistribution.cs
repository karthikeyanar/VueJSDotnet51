using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Pepper.Models.CodeFirst;
using System.Data.Objects;
using Pepper.Framework.Validation;

namespace PepperExcelImport {
	class ImportCapitalDistribution {

		public static void Import() {

			string tableName = "2-10Delta";

			PagingDataTable dt = Globals.GetExcelDataTable(tableName);

			int transactionID;
			DateTime noticeDate;
			string fundNo;
			DateTime effectiveDate;
			decimal totalCashDistribution;
			decimal totalCarry;
			decimal totalRepayment;
			decimal totalUnusedCapital;



			int fundID;
			DateTime minDate = Convert.ToDateTime("01/01/1900");
			CapitalDistribution capitalDistribution = null;
			IEnumerable<ErrorInfo> errorInfo;

			foreach (DataRow row in dt.Rows) {
				transactionID = DataTypeHelper.ToInt32(DataTypeHelper.ToString(row["TransactionID"]));
				noticeDate = DataTypeHelper.ToFromOADate(DataTypeHelper.ToString(row["NoticeDate"]));
				fundNo = DataTypeHelper.ToString(row["AmberbrookFundNo"]);
				effectiveDate = DataTypeHelper.ToFromOADate(DataTypeHelper.ToString(row["EffectiveDate"]));
				totalCashDistribution = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["TotalCashDistribution"]));
				totalCarry = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["TotalCarry"]));
				totalRepayment = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["TotalRepayment"]));
				totalUnusedCapital = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["TotalUnusedCapital"]));

				fundID = (Globals.GetFundID(fundNo) ?? 0);

				capitalDistribution = null;

				using (PepperContext context = new PepperContext()) {
					capitalDistribution = (from item in context.CapitalDistributions
										   where item.FundID == fundID
										   && EntityFunctions.TruncateTime(item.CapitalDistributionDate) == EntityFunctions.TruncateTime(noticeDate)
										   && EntityFunctions.TruncateTime(item.CapitalDistributionDueDate) == EntityFunctions.TruncateTime(effectiveDate)
										   && EntityFunctions.Truncate(item.DistributionAmount, 2) == EntityFunctions.Truncate(totalCashDistribution, 2)
										   select item).FirstOrDefault();
				}

				if (capitalDistribution != null) {
					Util.WriteError("CapitalDistribution already exist: TransactionID : " + transactionID + " UFSD ID : " + capitalDistribution.CapitalDistributionID);
				} else {
					Util.WriteNewEntry("CapitalDistribution does not exist:" + transactionID);
					capitalDistribution = new CapitalDistribution {
						CreatedBy = Globals.CurrentUser.UserID,
						CreatedDate = DateTime.Now
					};
				}

				Util.WriteNewEntry("CapitalDistribution Updated TransactionID : " + transactionID + " ID: " + capitalDistribution.CapitalDistributionID);
				capitalDistribution.CapitalDistributionDate = noticeDate;
				capitalDistribution.CapitalDistributionDueDate = effectiveDate;
				capitalDistribution.DistributionAmount = totalCashDistribution;
				capitalDistribution.IsManual = true;
				capitalDistribution.FundID = fundID;
				
				capitalDistribution.ReturnManagementFees = totalRepayment;
				capitalDistribution.Profits = totalCarry;



				capitalDistribution.LastUpdatedBy = Globals.CurrentUser.UserID;
				capitalDistribution.LastUpdatedDate = DateTime.Now;

				errorInfo = capitalDistribution.Save();
				if (errorInfo != null)
					Util.WriteError("CapitalDistribution Save Error:" + ValidationHelper.GetErrorInfo(errorInfo));
				else {
					Util.WriteNewEntry("CapitalDistribution Updated TransactionID : " + transactionID + " ID: " + capitalDistribution.CapitalDistributionID);
					CreateCapitalDistributionLineItem(transactionID, capitalDistribution.CapitalDistributionID);
				}

			}
		}

		private static void CreateCapitalDistributionLineItem(int id, int capitalDistributionID) {
			string tableName = "6-30Delta";

			PagingDataTable dt = Globals.GetExcelDataTable(tableName);

			int transactionID;
			DateTime transactionDate;
			string fundNo;
			string name;
			decimal distributionAmount;
			decimal distributionShares;
			string stockSymbol;
			string distributionType;
			int distributionID;

			int fundID;
			int investorID;
			int? securityID;
			int? securityTypeID;
			DateTime minDate = Convert.ToDateTime("01/01/1900");
			CapitalDistributionLineItem item = null;
			IEnumerable<ErrorInfo> errorInfo;

			DataRow[] filterRows = dt.Select("DistributionID='" + id + "'");

			foreach (DataRow row in filterRows) {
				transactionID = DataTypeHelper.ToInt32(DataTypeHelper.ToString(row["ID"]));
				transactionDate = DataTypeHelper.ToFromOADate(DataTypeHelper.ToString(row["Transaction Date"]));
				fundNo = DataTypeHelper.ToString(row["AMB #"]);
				name = DataTypeHelper.ToString(row["Full Name"]);
				distributionAmount = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["Distribution Amount"]));
				distributionShares = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["DistributionShares"]));
				stockSymbol = DataTypeHelper.ToString(row["stockSymbol"]);
				distributionType = DataTypeHelper.ToString(row["DistributionType"]);
				distributionID = DataTypeHelper.ToInt32(DataTypeHelper.ToString(row["DistributionID"]));

				if (stockSymbol == "0") {
					stockSymbol = string.Empty;
				}

				if (string.IsNullOrEmpty(stockSymbol) == false) {
					securityID = Globals.GetSecurityID(stockSymbol);
					securityTypeID = (int)Pepper.Models.CodeFirst.Enums.SecurityType.Equity;
				} else {
					securityID = null;
					securityTypeID = null;
				}

				fundID = (Globals.GetFundID(fundNo) ?? 0);
				investorID = (Globals.GetInvestorID(name) ?? 0);
				item = null;

				using (PepperContext context = new PepperContext()) {
					item = (from cditem in context.CapitalDistributionLineItems
							where cditem.FundID == fundID
							&& cditem.InvestorID == investorID
							&& cditem.CapitalDistributionID == capitalDistributionID
							&& EntityFunctions.TruncateTime(cditem.PaidON) == EntityFunctions.TruncateTime(transactionDate)
							&& EntityFunctions.Truncate(cditem.DistributionAmount, 2) == EntityFunctions.Truncate(distributionAmount, 2)
							select cditem).FirstOrDefault();
				}

				if (item != null) {
					Util.WriteError("CapitalDistributionLineItem already exist: TransactionID : " + transactionID + " UFSD ID : " + item.CapitalDistributionLineItemID);
				} else {
					Util.WriteNewEntry("CapitalDistributionLineItem does not exist:" + transactionID);
					item = new CapitalDistributionLineItem {
						CreatedBy = Globals.CurrentUser.UserID,
						CreatedDate = DateTime.Now
					};
				}

				Util.WriteNewEntry("CapitalDistributionLineItem Updated TransactionID : " + transactionID + " ID: " + item.CapitalDistributionLineItemID);
				item.DistributionAmount = distributionAmount;
				item.InvestorID = investorID;
				item.PaidON = transactionDate;
				item.IsReconciled = true;

				item.SecurityID = securityID;
				item.SecurityTypeID = securityTypeID;
				item.FundID = fundID;
				item.NumberOfShares = distributionShares;

				item.LastUpdatedBy = Globals.CurrentUser.UserID;
				item.LastUpdatedDate = DateTime.Now;

				item.CapitalDistributionID = capitalDistributionID;

				errorInfo = item.Save();
				if (errorInfo != null)
					Util.WriteError("CapitalDistributionLineItem Save Error:" + ValidationHelper.GetErrorInfo(errorInfo));
				else
					Util.WriteNewEntry("CapitalDistributionLineItem Updated TransactionID : " + transactionID + " ID: " + item.CapitalDistributionLineItemID);
			}
		}
	}
}

