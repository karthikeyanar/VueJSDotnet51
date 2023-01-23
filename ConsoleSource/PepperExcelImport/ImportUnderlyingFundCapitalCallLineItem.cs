using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Pepper.Models.CodeFirst;
using System.Data.Objects;
using Pepper.Framework.Validation;

namespace PepperExcelImport {
	class ImportUnderlyingFundCapitalCallLineItem {

		public static void Import() {

			string tableName = "1-30Delta";
			PagingDataTable dt = Globals.GetExcelDataTable(tableName);

			int transactionID;
			DateTime effectiveDate;
			string type;
			string fundNo;
			int dealNo;
			string description;
			bool isIncldeFees;
			string underlyingFundName;
			decimal amount;

			int fundID;
			int underlyingFundID;
			int dealID;
			DateTime minDate = Convert.ToDateTime("01/01/1900");
			UnderlyingFundCapitalCallLineItem underlyingFundCapitalCallLineItem = null;
			CashDistribution cashDistribution = null;
			IEnumerable<ErrorInfo> errorInfo;

			foreach (DataRow row in dt.Rows) {
				transactionID = DataTypeHelper.ToInt32(DataTypeHelper.ToString(row["ID"]));
				effectiveDate = DataTypeHelper.ToFromOADate(DataTypeHelper.ToString(row["Effective Date"]));
				fundNo = DataTypeHelper.ToString(row["AMB #"]);
				dealNo = DataTypeHelper.ToInt32(DataTypeHelper.ToString(row["Deal Number"]));
				underlyingFundName = DataTypeHelper.ToString(row["Fund"]);
				type = DataTypeHelper.ToString(row["Transaction Type"]);
				amount = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["Amount (Dist) +Call"]));
				description = DataTypeHelper.ToString(row["Pre or Post RD"]);
				isIncldeFees = DataTypeHelper.CheckBoolean(DataTypeHelper.ToString(row["DO NOT INCLUDE FEES?"]));

				fundID = (Globals.GetFundID(fundNo) ?? 0);
				underlyingFundID = (Globals.GetUnderlyingFundID(underlyingFundName) ?? 0);
				dealID = (Globals.GetDealID(dealNo, fundID) ?? 0);

				if (amount < 0) {
					amount = amount * -1;
				}

				type = type.ToLower();

				if (type.Contains("call") || type.Contains("carry")
											  || type.Contains("adjustment")
											  || type.Contains("fees")
											  || type.Contains("stock dist.")) {


					underlyingFundCapitalCallLineItem = null;

					using (PepperContext context = new PepperContext()) {
						underlyingFundCapitalCallLineItem = (from item in context.UnderlyingFundCapitalCallLineItems
															 where item.UnderlyingFundCapitalCallID == null
															 && item.DealID == dealID
															 && item.UnderlyingFundID == underlyingFundID
															 && EntityFunctions.TruncateTime(item.CapitalCallDate) == EntityFunctions.TruncateTime(effectiveDate)
															 && EntityFunctions.Truncate(item.Amount, 2) == EntityFunctions.Truncate(amount, 2)
															 select item).FirstOrDefault();
					}

					if (underlyingFundCapitalCallLineItem != null) {
						Util.WriteError("UnderlyingFundCapitalCallLineItem already exist: TransactionID : " + transactionID + " UFSD ID : " + underlyingFundCapitalCallLineItem.UnderlyingFundCapitalCallLineItemID);
					} else {
						Util.WriteNewEntry("UnderlyingFundCapitalCallLineItem does not exist:" + transactionID);
						underlyingFundCapitalCallLineItem = new UnderlyingFundCapitalCallLineItem {
							CreatedBy = Globals.CurrentUser.UserID,
							CreatedDate = DateTime.Now
						};
					}


					Util.WriteNewEntry("UnderlyingFundCapitalCallLineItem Updated TransactionID : " + transactionID + " ID: " + underlyingFundCapitalCallLineItem.UnderlyingFundCapitalCallLineItemID);
					underlyingFundCapitalCallLineItem.Amount = amount;
					underlyingFundCapitalCallLineItem.CapitalCallDate = effectiveDate;
					underlyingFundCapitalCallLineItem.DealID = dealID;
					underlyingFundCapitalCallLineItem.DueDate = effectiveDate;
					//underlyingFundCapitalCallLineItem.IsReconciled = isPaid;
					underlyingFundCapitalCallLineItem.LastUpdatedBy = Globals.CurrentUser.UserID;
					underlyingFundCapitalCallLineItem.LastUpdatedDate = DateTime.Now;
					//underlyingFundCapitalCallLineItem.ManagementFee = fees;
					underlyingFundCapitalCallLineItem.NoticeDate = effectiveDate;
					//underlyingFundCapitalCallLineItem.PaidON = paymentDate;

					underlyingFundCapitalCallLineItem.ReceivedDate = effectiveDate;

					underlyingFundCapitalCallLineItem.UnderlyingFundCapitalCallLineItemID = underlyingFundCapitalCallLineItem.UnderlyingFundCapitalCallLineItemID;
					underlyingFundCapitalCallLineItem.UnderlyingFundID = underlyingFundID;
					errorInfo = underlyingFundCapitalCallLineItem.Save();
					if (errorInfo != null)
						Util.WriteError("UnderlyingFundCapitalCallLineItem Save Error:" + ValidationHelper.GetErrorInfo(errorInfo));
					else
						Util.WriteNewEntry("UnderlyingFundCapitalCallLineItem Updated TransactionID : " + transactionID + " ID: " + underlyingFundCapitalCallLineItem.UnderlyingFundCapitalCallLineItemID);
				} else if (type.Contains("cash")) {
					cashDistribution = null;

					using (PepperContext context = new PepperContext()) {
						cashDistribution = (from item in context.CashDistributions
											where item.UnderlyingFundCashDistributionID == null
											&& item.DealID == dealID
											&& item.UnderlyingFundID == underlyingFundID
											&& EntityFunctions.TruncateTime(item.DistributionDate) == EntityFunctions.TruncateTime(effectiveDate)
											&& EntityFunctions.Truncate(item.Amount, 2) == EntityFunctions.Truncate(amount, 2)
											select item).FirstOrDefault();
					}

					if (cashDistribution != null) {
						Util.WriteError("CashDistribution already exist: TransactionID : " + transactionID + " UFSD ID : " + cashDistribution.CashDistributionID);
					} else {
						Util.WriteNewEntry("CashDistribution does not exist:" + transactionID);
						cashDistribution = new CashDistribution {
							CreatedBy = Globals.CurrentUser.UserID,
							CreatedDate = DateTime.Now
						};
					}


					Util.WriteNewEntry("CashDistribution Updated TransactionID : " + transactionID + " ID: " + cashDistribution.CashDistributionID);
					cashDistribution.Amount = amount;
					cashDistribution.DistributionDate = effectiveDate;
					cashDistribution.DealID = dealID;
					//cashDistribution.IsReconciled = isPaid;
					cashDistribution.LastUpdatedBy = Globals.CurrentUser.UserID;
					cashDistribution.LastUpdatedDate = DateTime.Now;
					//cashDistribution.ManagementFee = fees;
					//cashDistribution.PaidON = paymentDate;
					cashDistribution.CashDistributionID = cashDistribution.CashDistributionID;
					cashDistribution.UnderlyingFundID = underlyingFundID;
					cashDistribution.CashDistributionTypeID = (int)Pepper.Models.CodeFirst.Enums.CashDistributionType.RegularDistribution;

					errorInfo = cashDistribution.Save();
					if (errorInfo != null)
						Util.WriteError("CashDistribution Save Error:" + ValidationHelper.GetErrorInfo(errorInfo));
					else
						Util.WriteNewEntry("CashDistribution Updated TransactionID : " + transactionID + " ID: " + cashDistribution.CashDistributionID);
				}
			}
		}
	}
}
