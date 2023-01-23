using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Pepper.Models.CodeFirst;
using System.Data.Objects;
using Pepper.Framework.Validation;

namespace PepperExcelImport {
	class ImportEquitySplit {

		public static void Import() {

			string tableName = "4-30Delta";

			PagingDataTable dt = Globals.GetExcelDataTable(tableName);

			int transactionID;
			string stockSymbol;
			decimal multiple;
			DateTime effectiveDate;
			decimal stockSplit;

			int securityID;
			DateTime minDate = Convert.ToDateTime("01/01/1900");
			IEnumerable<ErrorInfo> errorInfo;
			EquitySplit equitySplit;

			foreach (DataRow row in dt.Rows) {
				transactionID = DataTypeHelper.ToInt32(DataTypeHelper.ToString(row["ID"]));
				stockSymbol = DataTypeHelper.ToString(row["StockSymbol"]);
				multiple = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["StockMultiple"]));
				effectiveDate = DataTypeHelper.ToFromOADate(DataTypeHelper.ToString(row["EffectiveDate"]));
				stockSplit = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["StockSplit"]));

				securityID = (Globals.GetSecurityID(stockSymbol) ?? 0);
				equitySplit = null;

				using (PepperContext context = new PepperContext()) {
					equitySplit = context.EquitySplits.Where(e => e.EquityID == securityID).FirstOrDefault();
				}

				if (equitySplit != null) {
					Util.WriteError("EquitySplit already exist: TransactionID : " + transactionID + " UFSD ID : " + equitySplit.EquiteSplitID);
				} else {
					Util.WriteNewEntry("EquitySplit does not exist:" + transactionID);
					equitySplit = new EquitySplit();
					equitySplit.CreatedBy = Globals.CurrentUser.UserID;
					equitySplit.CreatedDate = DateTime.Now;
				}
				equitySplit.LastUpdatedBy = Globals.CurrentUser.UserID;
				equitySplit.LastUpdatedDate = DateTime.Now;

				equitySplit.EquityID = securityID;
				equitySplit.SplitDate = effectiveDate;
				equitySplit.SplitFactor = stockSplit;

				Util.WriteNewEntry("EquitySplit Updated TransactionID : " + transactionID + " ID: " + equitySplit.EquiteSplitID);
				
				errorInfo = equitySplit.Save();
				if (errorInfo != null)
					Util.WriteError("EquitySplit Save Error:" + ValidationHelper.GetErrorInfo(errorInfo));
				else {
					Util.WriteNewEntry("EquitySplit Updated TransactionID : " + transactionID + " ID: " + equitySplit.EquiteSplitID);
				}
			}
		}
	}
}

