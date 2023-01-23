using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Pepper.Models.CodeFirst;
using System.Data.Objects;
using Pepper.Framework.Validation;


namespace PepperExcelImport {
	class ImportFundExpense {

		private static List<C13_10tblCashAdditions> C13_10tblCashAdditions = new List<C13_10tblCashAdditions>();

		public static void Import() {
			Import_13_10();
			int fundID;
			int? dealID;
			int? underlyingFundID;
			int fundExpenseTypeID;
			DateTime minDate = Convert.ToDateTime("01/01/1900");
			FundExpense fundExpense = null;
			IEnumerable<ErrorInfo> errorInfo;
			int i = 2;
			foreach (var cadd in C13_10tblCashAdditions) {
				i++;
				fundID = (Globals.GetFundID(cadd.AmberbrookFundNo) ?? 0);
				dealID = Globals.GetDealID((cadd.AmberbrookDealNo ?? 0), fundID);
				underlyingFundID = Globals.GetUnderlyingFundID(cadd.Fund);
				fundExpenseTypeID = (Globals.GetFundExpenseTypeID(cadd.Description) ?? 0);
				using (PepperContext context = new PepperContext()) {
					int logID = (Globals.GetImportLogID("FundExpense", cadd.TransactionID.ToString()) ?? 0);
					if (logID > 0) {
						fundExpense = (from exp in context.FundExpenses
										   where exp.FundExpenseID == logID
										   select exp).FirstOrDefault();
					} else {
						fundExpense = (from exp in context.FundExpenses
									   where exp.FundID == fundID
										   // && (exp.DealID ?? 0) == (dealID ?? 0)
										   // && (exp.UnderlyingFundID ?? 0) == (underlyingFundID ?? 0)
										   //&& EntityFunctions.Truncate(exp.Amount, 2) == EntityFunctions.Truncate((cadd.Amount ?? 0), 2)
									   && EntityFunctions.TruncateTime((exp.Date ?? minDate)) == EntityFunctions.TruncateTime((cadd.EffectiveDate ?? minDate))
									   //&& (exp.IsPaid ?? false) == (cadd.PaidRec ?? false)
									   //&& EntityFunctions.TruncateTime((exp.PaidOn ?? minDate)) == EntityFunctions.TruncateTime((cadd.PaidRecDate ?? minDate))
									   //&& exp.FundExpenseTypeID == fundExpenseTypeID
									   //&& (exp.Notes != null ? exp.Notes : "") == (cadd.Note != null ? cadd.Note : "")
									   select exp).FirstOrDefault();
					}
				}

				if (i > 8) {
					fundExpense = new FundExpense();
					fundExpense.CreatedBy = Globals.CurrentUser.UserID;
					fundExpense.CreatedDate = DateTime.Now;
					Util.WriteNewEntry("fundExpense not exist row : " + i);
				} else {
					if (fundExpense == null) {
						fundExpense = new FundExpense();
						fundExpense.CreatedBy = Globals.CurrentUser.UserID;
						fundExpense.CreatedDate = DateTime.Now;
						Util.WriteNewEntry("fundExpense not exist row : " + i);
					} else {
						Util.WriteError("fundExpense exist row : " + i);
					}
				}
				fundExpense.LastUpdatedBy = Globals.CurrentUser.UserID;
				fundExpense.LastUpdatedDate = DateTime.Now;
				fundExpense.FundID = fundID;
				fundExpense.DealID = (dealID > 0 ? dealID : null);
				fundExpense.UnderlyingFundID = (underlyingFundID > 0 ? underlyingFundID : null);
				fundExpense.FundExpenseTypeID = fundExpenseTypeID;
				fundExpense.Amount = (cadd.Amount ?? 0);
				fundExpense.Date = cadd.EffectiveDate;
				fundExpense.IsPaid = cadd.PaidRec;
				fundExpense.PaidOn = cadd.PaidRecDate;
				fundExpense.Notes = cadd.Note;
				fundExpense.ChequeNumber = cadd.CheckNumber;
				fundExpense.IsDistribution = cadd.ForDistribution;
				fundExpense.IsAllocatedDistribution = cadd.AllocatedDistribution;
				errorInfo = fundExpense.Save();
				if (errorInfo != null) {
					Util.WriteError("fundExpense row " + i + " error: " + ValidationHelper.GetErrorInfo(errorInfo));
				} else {
					Util.WriteNewEntry("fundExpense row : " + i);
					Globals.ImportLog("FundExpense", fundExpense.FundExpenseID, cadd.TransactionID.ToString());
				}
			}
		}

		public static void Import_13_10() {

			string tableName = "13-10Delta";

			PagingDataTable dt = Globals.GetExcelDataTable(tableName);

			int transactionID;
			string fundNo;
			int dealNo;
			DateTime effectiveDate;
			string description;
			decimal? amount;
			string underlyingFundName;
			string note;
			string checkNumber;
			bool isPaidRec;
			DateTime paidRecDate;
			bool isForDistribution;
			bool isAllocatedDistribution;
			int distributionID;


			foreach (DataRow row in dt.Rows) {
				transactionID = DataTypeHelper.ToInt32(Convert.ToString(row["TransactionID"]));
				fundNo = DataTypeHelper.ToString(row["AmberbrookFundNo"]);
				dealNo = DataTypeHelper.ToInt32(DataTypeHelper.ToString(row["AmberbrookDealNo"]));
				effectiveDate = DataTypeHelper.ToFromOADate(DataTypeHelper.ToString(row["EffectiveDate"]));
				amount = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["Amount"]));
				description = DataTypeHelper.ToString(row["Description"]);
				underlyingFundName = DataTypeHelper.ToString(row["Fund"]);
				note = DataTypeHelper.ToString(row["Note"]);
				checkNumber = DataTypeHelper.ToString(row["CheckNumber"]);
				isPaidRec = DataTypeHelper.CheckBoolean(DataTypeHelper.ToString(row["PaidRec"]));
				paidRecDate = DataTypeHelper.ToFromOADate(DataTypeHelper.ToString(row["PaidRecDate"]));
				isForDistribution = DataTypeHelper.CheckBoolean(DataTypeHelper.ToString(row["ForDistribution"]));
				isAllocatedDistribution = DataTypeHelper.CheckBoolean(DataTypeHelper.ToString(row["AllocatedDistribution"]));
				distributionID = DataTypeHelper.ToInt32(DataTypeHelper.ToString(row["DistributionID"]));


				C13_10tblCashAdditions.Add(new C13_10tblCashAdditions {
					AmberbrookDealNo = dealNo,
					AmberbrookFundNo = fundNo,
					Amount = (decimal)amount,
					Description = description,
					TransactionID = transactionID,
					AllocatedDistribution = isAllocatedDistribution,
					CheckNumber = checkNumber,
					DistributionID = distributionID,
					EffectiveDate = effectiveDate,
					ForDistribution = isForDistribution,
					Fund = underlyingFundName,
					Note = note,
					PaidRec = isPaidRec,
					PaidRecDate = paidRecDate,
				});
			}
		}
	}
}

