using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Pepper.Models.CodeFirst;
using System.Data.Objects;
using Pepper.Framework.Validation;


namespace PepperExcelImport {
	class ImportDealUnderlyingDirect {

		private static List<C5_11tblDealOriginationDirects> C5_11tblDealOriginationDirects = new List<C5_11tblDealOriginationDirects>();

		public static void Import() {

			Import_5_11();

			DealUnderlyingDirect dealUnderlyingDirect;
			int dealID;
			int fundID;
			int securityID;
			int securityTypeID;
			DateTime minDate = Convert.ToDateTime("01/01/1900");
			IEnumerable<ErrorInfo> errorInfo;
			int i = 2;
			foreach (var blueDD in C5_11tblDealOriginationDirects) {
				i++;
				fundID = (Globals.GetFundID(blueDD.AmberbrookFundNo) ?? 0);
				dealID = (Globals.GetDealID((blueDD.DealNo ?? 0), fundID) ?? 0);
				securityID = (Globals.GetSecurityID(blueDD.StockSymbol) ?? 0);
				securityTypeID = (int)Pepper.Models.CodeFirst.Enums.SecurityType.Equity;
				dealUnderlyingDirect = new DealUnderlyingDirect {
					DealID = dealID,
					SecurityID = securityID,
					SecurityTypeID = securityTypeID,
					FMV = (decimal)blueDD.FairMarketValue,
					NumberOfShares = (decimal)blueDD.NShares,
					TaxCostBase = (decimal)blueDD.TaxCostBasis,
					TaxCostDate = (blueDD.TaxCostDate ?? minDate),
					PurchaseDate = (blueDD.PurchaseDate ?? minDate),
					PurchasePrice = (decimal)blueDD.PurchasePrice,
					IsActive = true,
					CreatedBy = Globals.CurrentUser.UserID,
					CreatedDate = DateTime.Now
				};
				//if (blueDealOrigination != null) {
				dealUnderlyingDirect.RecordDate = blueDD.PurchaseDate; //(blueDealOrigination.RecordDate ?? minDate);
				//}
				using (PepperContext pepperContext = new PepperContext()) {
					dealUnderlyingDirect = (from d in pepperContext.DealUnderlyingDirects
											where d.DealID == dealUnderlyingDirect.DealID
											&& d.SecurityID == dealUnderlyingDirect.SecurityID
											&& d.SecurityTypeID == dealUnderlyingDirect.SecurityTypeID
												//&& EntityFunctions.Truncate((d.FMV ?? 0), 2) == EntityFunctions.Truncate((dealUnderlyingDirect.FMV ?? 0), 2)
												//&& EntityFunctions.Truncate((d.NumberOfShares ?? 0), 2) == EntityFunctions.Truncate((dealUnderlyingDirect.NumberOfShares ?? 0), 2)
												//&& EntityFunctions.Truncate((d.TaxCostBase ?? 0), 2) == EntityFunctions.Truncate((dealUnderlyingDirect.TaxCostBase ?? 0), 2)
											&& EntityFunctions.TruncateTime((d.TaxCostDate ?? minDate)) == EntityFunctions.TruncateTime((dealUnderlyingDirect.TaxCostDate ?? minDate))
											&& EntityFunctions.TruncateTime((d.RecordDate ?? minDate)) == EntityFunctions.TruncateTime((dealUnderlyingDirect.RecordDate ?? minDate))
											&& EntityFunctions.TruncateTime((d.PurchaseDate ?? minDate)) == EntityFunctions.TruncateTime((dealUnderlyingDirect.PurchaseDate ?? minDate))
											select d).FirstOrDefault();
				}
				if (dealUnderlyingDirect == null) {
					dealUnderlyingDirect = new DealUnderlyingDirect();
					Util.WriteError("Deal underlying direct does not exist row no : " + i);
				} else {
					Util.WriteError("Deal underlying direct already exist row no : " + i);
				}
				dealUnderlyingDirect.LastUpdatedBy = Globals.CurrentUser.UserID;
				dealUnderlyingDirect.LastUpdatedDate = DateTime.Now;
				dealUnderlyingDirect.DealID = dealID;
				dealUnderlyingDirect.SecurityID = securityID;
				dealUnderlyingDirect.SecurityTypeID = securityTypeID;
				dealUnderlyingDirect.FMV = (decimal)blueDD.FairMarketValue;
				dealUnderlyingDirect.NumberOfShares = (decimal)blueDD.NShares;
				dealUnderlyingDirect.TaxCostBase = (decimal)blueDD.TaxCostBasis;
				dealUnderlyingDirect.TaxCostDate = (blueDD.TaxCostDate ?? minDate);
				dealUnderlyingDirect.PurchaseDate = (blueDD.PurchaseDate ?? minDate);
				dealUnderlyingDirect.PurchasePrice = (decimal)blueDD.PurchasePrice;
				dealUnderlyingDirect.RecordDate = blueDD.PurchaseDate;
				errorInfo =  dealUnderlyingDirect.Save();
				if (errorInfo != null) {
					Util.WriteError("Deal underlying direct error:" + ValidationHelper.GetErrorInfo(errorInfo));
				} else {
					Util.WriteNewEntry("Deal underlying direct updated: " + dealUnderlyingDirect.DealUnderlyingDirectID);
				}
				Util.WriteNewEntry("Update deal underlying direct : " + dealUnderlyingDirect.DealUnderlyingDirectID);
			}
		}

		public static void Import_5_11() {

			string tableName = "5-11Delta";

			PagingDataTable dt = Globals.GetExcelDataTable(tableName);

			int transactionID;
			string fundNo;
			int dealNo;
			string direct;
			string stockSymbol;
			decimal nShares;
			decimal multiple;
			decimal nSharesA;
			decimal fairMarketValue;
			decimal purchasePrice;
			decimal taxCostBasis;
			DateTime purchaseDate;
			DateTime taxCostDate;

			foreach (DataRow row in dt.Rows) {
				transactionID = DataTypeHelper.ToInt32(Convert.ToString(row["TransactionID"]));
				fundNo = DataTypeHelper.ToString(row["AmberbrookFundNo"]);
				dealNo = DataTypeHelper.ToInt32(DataTypeHelper.ToString(row["DealNo"]));
				direct = DataTypeHelper.ToString(row["Direct"]);
				stockSymbol = DataTypeHelper.ToString(row["StockSymbol"]);
				nShares = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["NShares"]));
				multiple = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["Multiple"]));
				nSharesA = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["NSharesA"]));
				fairMarketValue = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["FairMarketValue"]));
				purchasePrice = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["PurchasePrice"]));
				taxCostBasis = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["TaxCostBasis"]));
				purchaseDate = DataTypeHelper.ToFromOADate(DataTypeHelper.ToString(row["PurchaseDate"]));
				taxCostDate = DataTypeHelper.ToFromOADate(DataTypeHelper.ToString(row["TaxCostDate"]));

				C5_11tblDealOriginationDirects.Add(new C5_11tblDealOriginationDirects {
					AmberbrookFundNo = fundNo,
					DealNo = dealNo,
					Direct = direct,
					FairMarketValue = (double)fairMarketValue,
					Multiple = (double)multiple,
					NShares = (double)nShares,
					NSharesA = (double)nSharesA,
					PurchaseDate = purchaseDate,
					PurchasePrice = (double)purchasePrice,
					StockSymbol = stockSymbol,
					TaxCostBasis = (double)taxCostBasis,
					TaxCostDate = taxCostDate,
					TransactionID = transactionID,
				});
			}
		}
	}
}

