using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Pepper.Models.CodeFirst;
using System.Data.Objects;
using Pepper.Framework.Validation;

namespace PepperExcelImport {
	class ImportCapitalCallLineItem {

		public static void Import() {

			string tableName = "3-20Delta";

			PagingDataTable dt = Globals.GetExcelDataTable(tableName);

			int transactionID;
			DateTime dueDate;
			string fundNo;
			string member;
			string designation;
			decimal commitment;
			decimal calledCapital;
			decimal calledFees;
			decimal calledExpenses;
			decimal calledTotal;
			bool isPaid;
			DateTime paymentDate;

			int fundID;
			int investorID;
			DateTime minDate = Convert.ToDateTime("01/01/1900");
			CapitalCallLineItem capitalCallLineItem = null;
			IEnumerable<ErrorInfo> errorInfo;

			foreach (DataRow row in dt.Rows) {
				transactionID = DataTypeHelper.ToInt32(DataTypeHelper.ToString(row["CallID"]));
				dueDate = DataTypeHelper.ToFromOADate(DataTypeHelper.ToString(row["DueDate"]));
				fundNo = DataTypeHelper.ToString(row["AMB"]);
				member = DataTypeHelper.ToString(row["Member"]);
				designation = DataTypeHelper.ToString(row["Designation"]);
				commitment = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["Commitment"]));
				calledCapital = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["CalledCapital"]));
				calledFees = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["CalledFees"]));
				calledExpenses = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["CalledExpenses"]));
				calledTotal = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["CalledTotal"]));
				isPaid = DataTypeHelper.CheckBoolean(DataTypeHelper.ToString(row["Paid"]));
				paymentDate = DataTypeHelper.ToFromOADate(DataTypeHelper.ToString(row["PaymentDate"]));

				fundID = (Globals.GetFundID(fundNo) ?? 0);
				investorID = (Globals.GetInvestorID(member) ?? 0);

				capitalCallLineItem = null;

				using (PepperContext context = new PepperContext()) {
					capitalCallLineItem = (from item in context.CapitalCallLineItems
										   join capitalCall in context.CapitalCalls on item.CapitalCallID equals capitalCall.CapitalCallID
										   where item.InvestorID == investorID
										   && capitalCall.FundID == fundID
										   && EntityFunctions.TruncateTime(capitalCall.CapitalCallDueDate) == EntityFunctions.TruncateTime(dueDate)
										   && EntityFunctions.Truncate(item.CapitalAmountCalled, 2) == EntityFunctions.Truncate(calledTotal, 2)
											//&& EntityFunctions.Truncate((item.ManagementFees ?? 0), 2) == EntityFunctions.Truncate(calledFees, 2)
											//&& EntityFunctions.Truncate((item.FundExpenses ?? 0), 2) == EntityFunctions.Truncate(calledExpenses, 2)
											//&& EntityFunctions.Truncate((item.Commitment ?? 0), 2) == EntityFunctions.Truncate(commitment, 2)
											//&& EntityFunctions.Truncate((item.CalledCapital ?? 0), 2) == EntityFunctions.Truncate(calledCapital, 2)
										   select item).FirstOrDefault();
				}

				if (capitalCallLineItem != null) {
					Util.WriteError("CapitalCallLineItem already exist: TransactionID : " + transactionID + " UFSD ID : " + capitalCallLineItem.CapitalCallLineItemID);
				} else {
					//Util.WriteNewEntry("CapitalCallLineItem does not exist:" + transactionID);
					//capitalCallLineItem = new CapitalCallLineItem {
					//    CreatedBy = Globals.CurrentUser.UserID,
					//    CreatedDate = DateTime.Now
					//};
				}

				Util.WriteNewEntry("CapitalCallLineItem Updated TransactionID : " + transactionID + " ID: " + capitalCallLineItem.CapitalCallLineItemID);
				capitalCallLineItem.IsReconciled = isPaid;
				capitalCallLineItem.PaidON = paymentDate;

				capitalCallLineItem.LastUpdatedBy = Globals.CurrentUser.UserID;
				capitalCallLineItem.LastUpdatedDate = DateTime.Now;

				errorInfo = capitalCallLineItem.Save();
				if (errorInfo != null)
					Util.WriteError("CapitalCallLineItem Save Error:" + ValidationHelper.GetErrorInfo(errorInfo));
				else {
					Util.WriteNewEntry("CapitalCallLineItem Updated TransactionID : " + transactionID + " ID: " + capitalCallLineItem.CapitalCallLineItemID);
				}
			}
		}
	}
}

