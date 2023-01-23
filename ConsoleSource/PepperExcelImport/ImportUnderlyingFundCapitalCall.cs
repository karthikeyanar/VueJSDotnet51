using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Pepper.Models.CodeFirst;
using System.Data.Objects;
using Pepper.Framework.Validation;

namespace PepperExcelImport {
	class ImportUnderlyingFundCapitalCall {

		public static void Import() {

			string tableName = "1-20Delta";
			PagingDataTable dt = Globals.GetExcelDataTable(tableName);

			int transactionID;
			DateTime noticeDate;
			string fundNo;
			int dealNo;
			string underlyingFundName;
			DateTime dueDate;
			decimal amount;
			decimal fees;
			bool isPaid;
			DateTime paymentDate;
			bool isCalled;
			bool isDataCalled;


			int fundID;
			int underlyingFundID;
			int dealID;
			DateTime minDate = Convert.ToDateTime("01/01/1900");
			UnderlyingFundCapitalCall underlyingFundCapitalCall = null;
			UnderlyingFundCapitalCallLineItem underlyingFundCapitalCallLineItem = null;

			foreach (DataRow row in dt.Rows) {
				transactionID = DataTypeHelper.ToInt32(DataTypeHelper.ToString(row["TransactionID"]));
				noticeDate = DataTypeHelper.ToFromOADate(DataTypeHelper.ToString(row["Notice Date"]));
				fundNo = DataTypeHelper.ToString(row["AMB #"]);
				dealNo = DataTypeHelper.ToInt32(DataTypeHelper.ToString(row["Deal Number"]));
				underlyingFundName = DataTypeHelper.ToString(row["Fund"]);
				dueDate = DataTypeHelper.ToFromOADate(DataTypeHelper.ToString(row["Due Date"]));
				amount = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["Amount"]));
				fees = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["Fees"]));
				isPaid = DataTypeHelper.CheckBoolean(DataTypeHelper.ToString(row["Paid"]));
				paymentDate = DataTypeHelper.ToFromOADate(DataTypeHelper.ToString(row["Payment Date"]));
				isCalled = DataTypeHelper.CheckBoolean(DataTypeHelper.ToString(row["Called"]));
				isDataCalled = DataTypeHelper.CheckBoolean(DataTypeHelper.ToString(row["DateCalled"]));

				fundID = (Globals.GetFundID(fundNo) ?? 0);
				underlyingFundID = (Globals.GetUnderlyingFundID(underlyingFundName) ?? 0);
				dealID = (Globals.GetDealID(dealNo, fundID) ?? 0);

				underlyingFundCapitalCall = null;
				underlyingFundCapitalCallLineItem = null;
				using (PepperContext context = new PepperContext()) {
					underlyingFundCapitalCall = (from ufcc in context.UnderlyingFundCapitalCalls
												 join item in context.UnderlyingFundCapitalCallLineItems on ufcc.UnderlyingFundCapitalCallID equals item.UnderlyingFundCapitalCallID
												 where item.DealID == dealID
												 && ufcc.FundID == fundID
												 && ufcc.UnderlyingFundID == underlyingFundID
												 && EntityFunctions.TruncateTime((ufcc.NoticeDate ?? minDate)) == EntityFunctions.TruncateTime(noticeDate)
												 && EntityFunctions.TruncateTime((ufcc.DueDate ?? minDate)) == EntityFunctions.TruncateTime(dueDate)
												 && EntityFunctions.TruncateTime((ufcc.ReceivedDate ?? minDate)) == EntityFunctions.TruncateTime(paymentDate)
												 select ufcc).FirstOrDefault();
					if (underlyingFundCapitalCall != null) {
						underlyingFundCapitalCallLineItem = (from item in context.UnderlyingFundCapitalCallLineItems
															 where item.UnderlyingFundCapitalCallID == underlyingFundCapitalCall.UnderlyingFundCapitalCallID
															 select item).FirstOrDefault();
					}
				}

				if (underlyingFundCapitalCall != null) {
					Util.WriteError("UnderlyingFundCapitalCall already exist: TransactionID : " + transactionID + " UFSD ID : " + underlyingFundCapitalCall.UnderlyingFundCapitalCallID);
				} else {
					Util.WriteNewEntry("UnderlyingFundCapitalCall does not exist:" + transactionID);
					underlyingFundCapitalCall = new UnderlyingFundCapitalCall {
						CreatedBy = Globals.CurrentUser.UserID,
						CreatedDate = DateTime.Now,
					};
					underlyingFundCapitalCallLineItem = new UnderlyingFundCapitalCallLineItem {
						CreatedBy = Globals.CurrentUser.UserID,
						CreatedDate = DateTime.Now
					};
				}

				underlyingFundCapitalCall.Amount = amount;
				underlyingFundCapitalCall.CapitalCallNumber = 0; 
				underlyingFundCapitalCall.DueDate = dueDate;
				underlyingFundCapitalCall.FundID = fundID;
				
				underlyingFundCapitalCall.LastUpdatedBy = Globals.CurrentUser.UserID;
				underlyingFundCapitalCall.LastUpdatedDate = DateTime.Now;
				underlyingFundCapitalCall.ManagementFee = fees;
				underlyingFundCapitalCall.NoticeDate = noticeDate;
				
				
				underlyingFundCapitalCall.ReceivedDate = dueDate;
				
				underlyingFundCapitalCall.UnderlyingFundID = underlyingFundID;
				IEnumerable<ErrorInfo> errorInfo = underlyingFundCapitalCall.Save();
				if (errorInfo != null) {
					Util.WriteError("UnderlyingFundCapitalCall Save Error:" + ValidationHelper.GetErrorInfo(errorInfo));
				} else {
					Util.WriteNewEntry("UnderlyingFundCapitalCall Updated TransactionID : " + transactionID + " ID: " + underlyingFundCapitalCall.UnderlyingFundCapitalCallID);
					underlyingFundCapitalCallLineItem.Amount = amount;
					underlyingFundCapitalCallLineItem.CapitalCallDate = paymentDate;
					underlyingFundCapitalCallLineItem.DealID = dealID;
					underlyingFundCapitalCallLineItem.DueDate = dueDate;
					underlyingFundCapitalCallLineItem.IsReconciled = isPaid;
					underlyingFundCapitalCallLineItem.LastUpdatedBy = Globals.CurrentUser.UserID;
					underlyingFundCapitalCallLineItem.LastUpdatedDate = DateTime.Now;
					underlyingFundCapitalCallLineItem.ManagementFee = fees;
					underlyingFundCapitalCallLineItem.NoticeDate = noticeDate;
					underlyingFundCapitalCallLineItem.PaidON = paymentDate;
					
					underlyingFundCapitalCallLineItem.ReceivedDate = dueDate;

					underlyingFundCapitalCallLineItem.UnderlyingFundCapitalCallID = underlyingFundCapitalCall.UnderlyingFundCapitalCallID;
					underlyingFundCapitalCallLineItem.UnderlyingFundID = underlyingFundID;
					errorInfo = underlyingFundCapitalCallLineItem.Save();
					if (errorInfo != null)
						Util.WriteError("UnderlyingFundCapitalCall Save Error:" + ValidationHelper.GetErrorInfo(errorInfo));
					else
						Util.WriteNewEntry("UnderlyingFundCapitalCallLineItem Updated TransactionID : " + transactionID + " ID: " + underlyingFundCapitalCallLineItem.UnderlyingFundCapitalCallLineItemID);
				}
			}
		}
	}
}
