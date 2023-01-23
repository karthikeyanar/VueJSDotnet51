using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Pepper.Models.CodeFirst;
using System.Data.Objects;
using Pepper.Framework.Validation;

namespace PepperExcelImport {
	class ImportCashDistribution {

		public static void Import() {

			string tableName = "1-10Delta";
			PagingDataTable dt = Globals.GetExcelDataTable(tableName);

			int transactionID;
			DateTime noticeDate;
			string fundNo;
			int dealNo;
			string fund;
			DateTime effectiveDate;
			decimal amountDistributed;
			bool isUnusedCapital;
			bool isReceived;
			DateTime receivedDate;
			bool isAllocated;
			int distributionID;
			UnderlyingFundCashDistribution underlyingFundCashDistribution = null;
			CashDistribution cashDistribution = null;

			foreach (DataRow row in dt.Rows) {
				transactionID = DataTypeHelper.ToInt32(DataTypeHelper.ToString(row["TransactionID"]));
				noticeDate = DataTypeHelper.ToFromOADate(DataTypeHelper.ToString(row["Notice Date"]));
				fundNo = DataTypeHelper.ToString(row["AMB #"]);
				dealNo = DataTypeHelper.ToInt32(DataTypeHelper.ToString(row["Deal Number"]));
				fund = DataTypeHelper.ToString(row["Fund"]);
				effectiveDate = DataTypeHelper.ToFromOADate(DataTypeHelper.ToString(row["Effective Date"]));
				amountDistributed = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["Amount Distributed"]));
				isUnusedCapital = DataTypeHelper.CheckBoolean(DataTypeHelper.ToString(row["Unused Capital"]));
				isReceived = DataTypeHelper.CheckBoolean(DataTypeHelper.ToString(row["Received"]));
				receivedDate = DataTypeHelper.ToFromOADate(DataTypeHelper.ToString(row["ReceivedDate"]));
				isAllocated = DataTypeHelper.CheckBoolean(DataTypeHelper.ToString(row["Allocated?"]));
				distributionID = DataTypeHelper.ToInt32(DataTypeHelper.ToString(row["DistributionID"]));

				int fundID = (Globals.GetFundID(fundNo) ?? 0);
				int underlyingFundID = (Globals.GetUnderlyingFundID(fund) ?? 0);
				int dealID = (Globals.GetDealID(dealNo, fundID) ?? 0);
				bool isSkipAmountChecking = false;
				using (PepperContext context = new PepperContext()) {
					cashDistribution = (from ufcd in context.UnderlyingFundCashDistributions
										join cd in context.CashDistributions on ufcd.UnderlyingFundCashDistributionID equals cd.UnderlyingFundCashDistributionID
										where ufcd.UnderlyingFundID == underlyingFundID
										&& cd.DealID == dealID
										&& (isSkipAmountChecking == false ? EntityFunctions.Truncate(cd.Amount, 2) == EntityFunctions.Truncate(amountDistributed, 2) : cd.CashDistributionID > 0)
										&& EntityFunctions.TruncateTime(ufcd.NoticeDate) == EntityFunctions.TruncateTime(noticeDate)
										&& EntityFunctions.TruncateTime(ufcd.ReceivedDate) == EntityFunctions.TruncateTime(effectiveDate)
										select cd).FirstOrDefault();
					if (cashDistribution != null) {
						underlyingFundCashDistribution = (from ufcd in context.UnderlyingFundCashDistributions
														  where ufcd.UnderlyingFundCashDistributionID == cashDistribution.UnderlyingFundCashDistributionID
														  select ufcd).FirstOrDefault();
						Util.WriteNewEntry("Cash Distribution Already exist: " + cashDistribution.CashDistributionID);
					} else {
						Util.WriteNewEntry("Cash Distribution Not exist: " + transactionID);

						underlyingFundCashDistribution = new UnderlyingFundCashDistribution();
						//underlyingFundCashDistribution.CashDistributionTypeID = (int)Pepper.Models.CodeFirst.Enums.CashDistributionType.ShortTermNettedDistribution;
						underlyingFundCashDistribution.CreatedBy = Globals.CurrentUser.UserID;
						underlyingFundCashDistribution.CreatedDate = DateTime.Now;

						cashDistribution = new CashDistribution();
						cashDistribution.CashDistributionTypeID = (int)Pepper.Models.CodeFirst.Enums.CashDistributionType.ShortTermNettedDistribution;
						cashDistribution.CreatedBy = Globals.CurrentUser.UserID;
						cashDistribution.CreatedDate = DateTime.Now;
						
					}
				}

				underlyingFundCashDistribution.UnderlyingFundID = underlyingFundID;
				underlyingFundCashDistribution.FundID = fundID;
				underlyingFundCashDistribution.NoticeDate = noticeDate;
				underlyingFundCashDistribution.ReceivedDate = effectiveDate;

				underlyingFundCashDistribution.PaidDate = effectiveDate;
				underlyingFundCashDistribution.Amount = amountDistributed;

				underlyingFundCashDistribution.LastUpdatedBy = Globals.CurrentUser.UserID;
				underlyingFundCashDistribution.LastUpdatedDate = DateTime.Now;

				IEnumerable<ErrorInfo> errorInfo = underlyingFundCashDistribution.Save();
				if (errorInfo != null) {
					Util.WriteError("TransactionID : " + transactionID + " UnderlyingFundCashDistribution error : " + ValidationHelper.GetErrorInfo(errorInfo));
				} else {

					Util.WriteNewEntry("TransactionID : " + transactionID + " UnderlyingFundCashDistribution Success: " + underlyingFundCashDistribution.UnderlyingFundCashDistributionID);
					
					cashDistribution.DealID = dealID;
					cashDistribution.DistributionDate = effectiveDate;
					cashDistribution.IsAllocatedDistribution = isAllocated;
					cashDistribution.IsReconciled = isReceived;
					cashDistribution.PaidON = effectiveDate;
					cashDistribution.UnderlyingFundCashDistributionID = underlyingFundCashDistribution.UnderlyingFundCashDistributionID;
					cashDistribution.UnderlyingFundID = underlyingFundID;
					cashDistribution.UnusedCapital = isUnusedCapital;
					cashDistribution.Amount = amountDistributed;

					cashDistribution.LastUpdatedBy = Globals.CurrentUser.UserID;
					cashDistribution.LastUpdatedDate = DateTime.Now;

					errorInfo = cashDistribution.Save();
					if (errorInfo != null) {
						Util.WriteError("TransactionID :" + transactionID + " CashDistribution error: " + ValidationHelper.GetErrorInfo(errorInfo));
					} else {
						Util.WriteNewEntry("TransactionID :" + transactionID + " CashDistribution Success: " + cashDistribution.CashDistributionID);
					}
				}
			}
		}
	
	
	}
}
