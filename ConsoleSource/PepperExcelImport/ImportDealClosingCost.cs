using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Pepper.Models.CodeFirst;
using System.Data.Objects;
using Pepper.Framework.Validation;


namespace PepperExcelImport {
	class ImportDealClosingCost {

		private static List<C6_40tblDealExpenses> C6_40tblDealExpenses = new List<C6_40tblDealExpenses>();

		public static void Import() {
			Import_6_40();
			IEnumerable<ErrorInfo> errorInfo;
			int i = 2;
			int fundID;
			int dealID;
			DateTime minDate = Convert.ToDateTime("01/01/1900");
			DealClosingCost dealClosingCost = null;
			foreach (var dexp in C6_40tblDealExpenses) {
				i++;
				fundID = (Globals.GetFundID(dexp.AmberbrookFundNo) ?? 0);
				dealID = (Globals.GetDealID(dexp.AmberbrookDealNo, fundID) ?? 0);
				using (PepperContext context = new PepperContext()) {
					dealClosingCost = null;
					int logID = (Globals.GetImportLogID("DealClosingCost", dexp.TransactionID.ToString()) ?? 0);
					if (logID > 0) {
						dealClosingCost = (from exp in context.DealClosingCosts
										   where exp.DealClosingCostID == logID
										   select exp).FirstOrDefault();
					} else {
						if (i <= 3) {
							dealClosingCost = (from exp in context.DealClosingCosts
											   where exp.DealID == dealID
											   && EntityFunctions.Truncate(exp.Amount, 2) == EntityFunctions.Truncate((decimal)dexp.Amount, 2)
											   && EntityFunctions.TruncateTime((exp.Date ?? minDate)) == EntityFunctions.TruncateTime(dexp.Date)
												   //&& (exp.IsPaid ?? false) == (dexp.Paid ?? false)
											   //&& EntityFunctions.TruncateTime((exp.PaymentDate ?? minDate)) == EntityFunctions.TruncateTime((dexp.PaymentDate ?? minDate))
											   //&& (exp.Notes != null ? exp.Notes : "") == (dexp.Description != null ? dexp.Description : "")
											   select exp).FirstOrDefault();
						}
					}
				}
				if (dealClosingCost == null) {
					dealClosingCost = new DealClosingCost();
					Util.WriteNewEntry("dealClosingCost not exist row : " + i);
				} else {
					Util.WriteError("dealClosingCost exist row : " + i + " id : " + dealClosingCost.DealClosingCostID);
				}
				dealClosingCost.DealID = dealID;
				int dealClosingCostTypeID;
				if (dexp.Description.ToLower().Contains("legal")) {
					dealClosingCostTypeID = (Globals.GetDealClosingCostTypeID("Legal Fees") ?? 0);
				} else if (dexp.Description.ToLower().Contains("admin")) {
					dealClosingCostTypeID = (Globals.GetDealClosingCostTypeID("Administration Fees") ?? 0);
				} else if (dexp.Description.ToLower().Contains("consultant")) {
					dealClosingCostTypeID = (Globals.GetDealClosingCostTypeID("Consultant Fees") ?? 0);
				} else {
					dealClosingCostTypeID = (Globals.GetDealClosingCostTypeID("Other") ?? 0);
				}
				dealClosingCost.DealClosingCostTypeID = dealClosingCostTypeID;
				dealClosingCost.Amount = (decimal)dexp.Amount;
				dealClosingCost.Date = dexp.Date;
				dealClosingCost.Notes = dexp.Description;
				//dealClosingCost.IsPaid = dexp.Paid;
				//dealClosingCost.PaymentDate = dexp.PaymentDate;
				errorInfo = dealClosingCost.Save();
				if (errorInfo != null) {
					Util.WriteError("dealClosingCost row : " + i + " Errors: " + ValidationHelper.GetErrorInfo(errorInfo));
				} else {
					Util.WriteNewEntry("dealClosingCost row : " + i);
					Globals.ImportLog("DealClosingCost", dealClosingCost.DealClosingCostID, dexp.TransactionID.ToString());
				}
			}
		}

		public static void Import_6_40() {

			string tableName = "6-40Delta";

			PagingDataTable dt = Globals.GetExcelDataTable(tableName);

			int transactionID;
			DateTime date;
			string fundNo;
			int dealNo;
			decimal? amount;
			string description;
			bool isPaid;
			DateTime paymentDate;

			foreach (DataRow row in dt.Rows) {
				transactionID = DataTypeHelper.ToInt32(Convert.ToString(row["TransactionID"]));
				fundNo = DataTypeHelper.ToString(row["AmberbrookFundNo"]);
				dealNo = DataTypeHelper.ToInt32(DataTypeHelper.ToString(row["AmberbrookDealNo"]));
				date = DataTypeHelper.ToFromOADate(DataTypeHelper.ToString(row["Date"]));
				amount = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["Amount"]));
				description = DataTypeHelper.ToString(row["Description"]);
				isPaid = DataTypeHelper.CheckBoolean(DataTypeHelper.ToString(row["Paid"]));
				paymentDate = DataTypeHelper.ToFromOADate(DataTypeHelper.ToString(row["PaymentDate"]));

				C6_40tblDealExpenses.Add(new C6_40tblDealExpenses {
					AmberbrookDealNo = dealNo,
					AmberbrookFundNo = fundNo,
					Date = date,
					Amount = (double)amount,
					Description = description,
					Paid = isPaid,
					PaymentDate = paymentDate,
					TransactionID = transactionID
				});
			}
		}
	}
}

