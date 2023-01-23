using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Pepper.Models.CodeFirst;
using System.Data.Objects;
using Pepper.Framework.Validation;

namespace PepperExcelImport {
	class ImportSecuritySale {

		public static void Import() {


            //Globals.Import_4_10();
            //IEnumerable<ErrorInfo> errorInfo;
            //int i = 2;
            //foreach (var ss in Globals.C4_10tblSaleofStock) {
            //    i++;
            //    C4_10tblSaleofStock firstBlueSecuritySale = ss;
            //    int? fundID = Globals.GetFundID(ss.AmberbrookFundNo);
            //    int? dealID = Globals.GetDealID(ss.AmberbrookDealNo, (fundID ?? 0));
            //    SecuritySale securitySale = null;
            //    DateTime minDate = Convert.ToDateTime("01/01/1900");

            //    int securityID = (Globals.GetSecurityID(ss.StockSymbol) ?? 0);
            //    int securityTypeID = (int)Pepper.Models.CodeFirst.Enums.SecurityType.Equity;
            //    int brokerID = (Globals.GetBrokerID(ss.Broker) ?? 0);
            //    int underlyingFundID = (Globals.GetUnderlyingFundID(ss.Fund) ?? 0);

            //    decimal saleAmount = (decimal)(ss.NumberofShares * ss.SalePrice);

            //    using (PepperContext context = new PepperContext()) {
            //        securitySale = context.SecuritySales.Where(s => s.FundID == fundID
            //                && s.SecurityID == securityID
            //                && s.SecurityTypeID == securityTypeID
            //            //&& EntityFunctions.Truncate(s.SaleAmount, 2) == EntityFunctions.Truncate(saleAmount, 2)
            //            //&& EntityFunctions.Truncate(s.SellPrice, 2) == EntityFunctions.Truncate((decimal)ss.SalePrice, 2)
            //            //&& EntityFunctions.Truncate((s.Fees ?? 0), 2) == EntityFunctions.Truncate((decimal)ss.Fees, 2)
            //                && EntityFunctions.Truncate(s.SellQuantity, 2) == EntityFunctions.Truncate((decimal)ss.NumberofShares, 2)
            //                && s.EntityID == Globals.DefaultEntityID
            //                && EntityFunctions.TruncateTime(s.SellDate) == EntityFunctions.TruncateTime((ss.TradeDate ?? minDate))
            //            //&& EntityFunctions.TruncateTime((s.SettleDate ?? minDate)) == EntityFunctions.TruncateTime((ss.ReceivedDate ?? minDate))
            //            //&& (s.BrokerID ?? 0) == brokerID
            //        ).FirstOrDefault();
            //    }

            //    if (i > 53) {
            //        securitySale = new SecuritySale();
            //        securitySale.CreatedBy = Globals.CurrentUser.UserID;
            //        securitySale.CreatedDate = DateTime.Now;
            //        Util.WriteNewEntry("New Security Sale - > row : " + i);
            //    } else {
            //        if (securitySale == null) {
            //            securitySale = new SecuritySale();
            //            securitySale.CreatedBy = Globals.CurrentUser.UserID;
            //            securitySale.CreatedDate = DateTime.Now;
            //            Util.WriteNewEntry("New Security Sale - > row : " + i);
            //        } else {
            //            Util.WriteError("Already exist SecuritySale - >  row : " + i);
            //        }
            //    }

            //    securitySale.FundID = (fundID ?? 0);
            //    securitySale.SecurityID = securityID;
            //    securitySale.SecurityTypeID = securityTypeID;
            //    securitySale.SaleAmount = (decimal)(ss.NumberofShares * ss.SalePrice);
            //    securitySale.SellPrice = (decimal)ss.SalePrice;
            //    securitySale.Fees = (decimal)ss.Fees;
            //    securitySale.EntityID = Globals.DefaultEntityID;
            //    securitySale.SellDate = (ss.TradeDate ?? Convert.ToDateTime("01/01/1900"));
            //    securitySale.SellQuantity = (decimal)ss.NumberofShares;
            //    securitySale.SettleDate = ss.ReceivedDate;
            //    securitySale.BrokerID = Globals.GetBrokerID(ss.Broker);

            //    securitySale.LastUpdatedBy = Globals.CurrentUser.UserID;
            //    securitySale.LastUpdatedDate = DateTime.Now;
            //    securitySale.Multiple = (decimal)ss.Multiple;
            //    securitySale.NumberofSharesA = (decimal)ss.NumberofSharesA;
            //    securitySale.IsConfirmation = ss.Confirmation;
            //    securitySale.IsReceived = ss.Received;
            //    securitySale.SourceID = ss.SourceID;
            //    securitySale.IsAllocatedDistribution = ss.AllocatedDistribution;
            //    securitySale.DealID = dealID;
            //    securitySale.UnderlyingFundID = underlyingFundID;

            //    if ((securitySale.Fees ?? 0) <= 0) {
            //        securitySale.Fees = 0;
            //    }
            //    securitySale.FinalSaleAmount = securitySale.SaleAmount - (securitySale.Fees ?? 0);

            //    errorInfo = securitySale.Save();

            //    if (errorInfo != null) {
            //        Util.WriteError("Import securitySale update error : row : " + i + ValidationHelper.GetErrorInfo(errorInfo));
            //    } else {
            //        Util.WriteNewEntry("Import securitySale updated : row : " + i + securitySale.SecuritySaleID);
            //    }
            //}
		}

	}
}

