using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Pepper.Models.CodeFirst;
using System.Data.Objects;
using Pepper.Framework.Validation;

namespace PepperExcelImport {
	class ImportEquity {

		public static void Import() {

			string tableName = "4-20Delta";

			PagingDataTable dt = Globals.GetExcelDataTable(tableName);

			int transactionID;
			string stockSymbol;
			string stockName;
			string company;
			string security;
			string ticker;
			bool isPrivateStock;
			string weblink;

			int securityID;
			int issuerID;
			int equityTypeID;
			int securityTypeID = (int)Pepper.Models.CodeFirst.Enums.SecurityType.Equity;
			DateTime minDate = Convert.ToDateTime("01/01/1900");
			IEnumerable<ErrorInfo> errorInfo;
			Equity equity;

			foreach (DataRow row in dt.Rows) {
				transactionID = 0;
				stockSymbol = DataTypeHelper.ToString(row["Stock Symbol"]);
				stockName = DataTypeHelper.ToString(row["Stock Name"]);
				company = DataTypeHelper.ToString(row["Company"]);
				security = DataTypeHelper.ToString(row["Security"]);
				ticker = DataTypeHelper.ToString(row["Ticker"]);
				isPrivateStock = DataTypeHelper.CheckBoolean(DataTypeHelper.ToString(row["Private Stock?"]));
				weblink = DataTypeHelper.ToString(row["WebLink"]);

				securityID = (Globals.GetSecurityID(stockSymbol) ?? 0);
				issuerID = (Globals.GetIssuerID(company) ?? 0);
				equityTypeID = (Globals.GetEquityTypeID(security) ?? 0);
				equity = null;

				using (PepperContext context = new PepperContext()) {
					equity = context.Equities.Where(e => e.EquityID == securityID).FirstOrDefault();
				}

				if (equity != null) {
					Util.WriteError("Equity already exist: TransactionID : " + transactionID + " UFSD ID : " + equity.EquityID);
				} else {
					Util.WriteNewEntry("Equity does not exist:" + transactionID);
					equity = new Equity();
				}

				equity.EntityID = Globals.DefaultEntityID;
				equity.IssuerID = issuerID;
				equity.Public = isPrivateStock;
				equity.EquityTypeID = equityTypeID;

				Util.WriteNewEntry("Equity Updated TransactionID : " + transactionID + " ID: " + equity.EquityID);
				
				errorInfo = equity.Save();
				if (errorInfo != null)
					Util.WriteError("Equity Save Error:" + ValidationHelper.GetErrorInfo(errorInfo));
				else {
					Util.WriteNewEntry("Equity Updated TransactionID : " + transactionID + " ID: " + equity.EquityID);
				}
			}
		}
	}
}

