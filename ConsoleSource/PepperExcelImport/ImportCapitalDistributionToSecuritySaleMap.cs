using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Pepper.Models.CodeFirst;
using System.Data.Objects;
using Pepper.Framework.Validation;

namespace PepperExcelImport {
	class ImportCapitalDistributionToSecuritySaleMap {

		public static void Import() {

            //try {
            //    Globals.Import_2_10();
            //    Globals.Import_6_30();
            //    Globals.Import_1_10();
            //    Globals.Import_4_10();



            //    int i = 2;
            //    int logID = 0;
            //    foreach (var ss in Globals.C4_10tblSaleofStock) {
            //        i++;
            //        if ((ss.DistributionID ?? 0) > 0) {
            //            int? fundID = Globals.GetFundID(ss.AmberbrookFundNo);
            //            int? dealID = Globals.GetDealID(ss.AmberbrookDealNo, (fundID ?? 0));
            //            SecuritySale securitySale = null;

            //            DateTime minDate = Convert.ToDateTime("01/01/1900");

            //            int securityID = (Globals.GetSecurityID(ss.StockSymbol) ?? 0);
            //            int securityTypeID = (int)Pepper.Models.CodeFirst.Enums.SecurityType.Equity;
            //            int brokerID = (Globals.GetBrokerID(ss.Broker) ?? 0);
            //            int underlyingFundID = (Globals.GetUnderlyingFundID(ss.Fund) ?? 0);

            //            decimal saleAmount = (decimal)(ss.NumberofShares * ss.SalePrice);

            //            using (PepperContext context = new PepperContext()) {
            //                logID = 0;
            //                logID = (Globals.GetImportLogID("SecuritySale", ss.TransactionID.ToString()) ?? 0);
            //                if (logID > 0) {
            //                    securitySale = context.SecuritySales.Where(s => s.SecuritySaleID == logID).FirstOrDefault();
            //                } else {
            //                    securitySale = context.SecuritySales.Where(s => s.FundID == fundID
            //                            && s.SecurityID == securityID
            //                            && s.SecurityTypeID == securityTypeID
            //                        //&& EntityFunctions.Truncate(s.SaleAmount, 2) == EntityFunctions.Truncate(saleAmount, 2)
            //                        //&& EntityFunctions.Truncate(s.SellPrice, 2) == EntityFunctions.Truncate((decimal)ss.SalePrice, 2)
            //                        //&& EntityFunctions.Truncate((s.Fees ?? 0), 2) == EntityFunctions.Truncate((decimal)ss.Fees, 2)
            //                            && EntityFunctions.Truncate(s.SellQuantity, 1) == EntityFunctions.Truncate((decimal)ss.NumberofShares, 1)
            //                            && EntityFunctions.TruncateTime(s.SellDate) == EntityFunctions.TruncateTime((ss.TradeDate ?? minDate))
            //                        //&& EntityFunctions.TruncateTime((s.SettleDate ?? minDate)) == EntityFunctions.TruncateTime((ss.ReceivedDate ?? minDate))
            //                        //&& (s.BrokerID ?? 0) == brokerID
            //                    ).FirstOrDefault();
            //                }
            //            }

            //            if (securitySale != null) {
            //                logID = 0;
            //                Globals.ImportLog("SecuritySale", securitySale.SecuritySaleID, ss.TransactionID.ToString());

            //                CapitalDistribution capitalDistribution = null;

            //                var blueCapitalDistribution = (from blueCd in Globals.C2_10tblDistFromAmberbrookCash where blueCd.TransactionID == ss.DistributionID select blueCd).FirstOrDefault();

            //                if (blueCapitalDistribution == null) {
            //                    using (BlueEntities blueEntities = new BlueEntities()) {
            //                        blueCapitalDistribution = (from blueCd in blueEntities.C2_10tblDistFromAmberbrookCash where blueCd.TransactionID == ss.DistributionID select blueCd).FirstOrDefault();
            //                    }
            //                }

            //                if (blueCapitalDistribution != null) {

            //                    capitalDistribution = null;
            //                    logID = 0;
            //                    using (PepperContext context = new PepperContext()) {
            //                        logID = (Globals.GetImportLogID("CapitalDistribution", blueCapitalDistribution.TransactionID.ToString()) ?? 0);
            //                        if (logID > 0) {
            //                            capitalDistribution = (from cd in context.CapitalDistributions
            //                                                   where cd.CapitalDistributionID == logID
            //                                                   select cd).FirstOrDefault();
            //                        } else {
            //                            capitalDistribution = (from item in context.CapitalDistributions
            //                                                   where item.FundID == fundID
            //                                                   && EntityFunctions.TruncateTime(item.CapitalDistributionDate) == EntityFunctions.TruncateTime(blueCapitalDistribution.NoticeDate)
            //                                                   && EntityFunctions.TruncateTime(item.CapitalDistributionDueDate) == EntityFunctions.TruncateTime(blueCapitalDistribution.EffectiveDate)
            //                                                   && EntityFunctions.Truncate(item.DistributionAmount, 2) == EntityFunctions.Truncate((decimal)blueCapitalDistribution.TotalCashDistribution, 2)
            //                                                   select item).FirstOrDefault();
            //                        }
            //                    }
            //                    if (capitalDistribution != null) {
            //                        Globals.ImportLog("CapitalDistribution", capitalDistribution.CapitalDistributionID, blueCapitalDistribution.TransactionID.ToString());
            //                    }
            //                }
            //                if (capitalDistribution == null) {
            //                    Util.WriteError("ImportCapitalDistributionToSecuritySaleMap Capital Distribution Not Exist Row : " + i);
            //                }
            //                if (securitySale != null && capitalDistribution != null) {
            //                    CapitalDistributionSourceMapping map = null;
            //                    using (PepperContext context = new PepperContext()) {
            //                        map = context.CapitalDistributionSourceMappings.Where(m => m.CapitalDistributionID == capitalDistribution.CapitalDistributionID
            //                         && m.CapitalDistributionSourceID == securitySale.SecuritySaleID
            //                         && m.CapitalDistributionSourceTypeID == 2
            //                         ).FirstOrDefault();
            //                    }
            //                    if (map == null) {
            //                        map = new CapitalDistributionSourceMapping {
            //                            CapitalDistributionSourceID = securitySale.SecuritySaleID
            //                        ,
            //                            CapitalDistributionID = capitalDistribution.CapitalDistributionID
            //                        ,
            //                            CapitalDistributionSourceTypeID = (int)Pepper.Models.CodeFirst.Enums.CapitalDistributionSourceType.SaleOfSecurity
            //                        };
            //                        map.Save();
            //                        Util.WriteNewEntry("New CashDistributionToCapitalDistributionMappings Row " + i);
            //                    } else {
            //                        Util.WriteError("ImportCapitalDistributionToSecuritySaleMap Map already exist : " + map.CapitalDistributionSourceMappingID);
            //                    }
            //                }
            //            } else {
            //                Util.WriteError("Import securitySale security sale not exist : row : " + i);
            //            }
            //        }
            //    }
            //} catch (Exception ex) {
            //    Util.WriteError("ImportCapitalDistributionToSecuritySaleMap Exception Error : " + ex.Message);
            //}
		}
	}
}

