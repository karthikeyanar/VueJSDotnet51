using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Pepper.Models.CodeFirst;
using System.Data.Objects;
using Pepper.Framework.Validation;

namespace PepperExcelImport {
	class ImportSecuritySaleSourceMapping {

		public static void Import() {
            //try {
            //    Globals.Import_4_10();
            //    Globals.Import_1_15();
            //    Globals.Import_5_11();

            //    UnderlyingFundStockDistributionLineItem underlyingFundStockDistributionLineItem = null;
            //    DealUnderlyingDirect dealUnderlyingDirect = null;
            //    SecuritySale securitySale = null;
            //    int i = 2;
            //    foreach (var blueSS in Globals.C4_10tblSaleofStock) {
            //        i++;
            //        //if (i == 83 || i == 134) {
            //        underlyingFundStockDistributionLineItem = null;
            //        dealUnderlyingDirect = null;
            //        securitySale = GetSecuritySale(blueSS);
            //        if (securitySale != null) {
            //            Util.WriteNewEntry("Security sale exist row : " + i);
            //            if ((blueSS.SourceID ?? 0) > 0) {
            //                underlyingFundStockDistributionLineItem = GetUnderlyingFundStockDistributionLineItem((blueSS.SourceID ?? 0));
            //                if (underlyingFundStockDistributionLineItem != null) {
            //                    Util.WriteNewEntry("underlyingFundStockDistributionLineItem exist row : " + i);
            //                    CreateSecuritySaleMapping(securitySale.SecuritySaleID, (int)Pepper.Models.CodeFirst.Enums.SecuritySaleSourceType.UnderlyingFundStockDistributionLineItem, underlyingFundStockDistributionLineItem.UnderlyingFundStockDistributionLineItemID);
            //                } else {
            //                    Util.WriteError("underlyingFundStockDistributionLineItem not exist row : " + i);
            //                }
            //            } else {
            //                dealUnderlyingDirect = GetDealUnderlyingDirect((blueSS.SourceID ?? 0) * -1);
            //                if (dealUnderlyingDirect != null) {
            //                    Util.WriteNewEntry("dealUnderlyingDirect exist row : " + i);
            //                    CreateSecuritySaleMapping(securitySale.SecuritySaleID, (int)Pepper.Models.CodeFirst.Enums.SecuritySaleSourceType.DealUnderlyingDirect, dealUnderlyingDirect.DealUnderlyingDirectID);
            //                } else {
            //                    Util.WriteError("dealUnderlyingDirect not exist row : " + i);
            //                }
            //            }
            //        } else {
            //            Util.WriteError("Security sale not exist row : " + i);
            //        }
            //        //}
            //    }
            //} catch (Exception ex) {
            //    Util.WriteError("SecuritySaleToStockDistributionMap Import Exception: " + ex.Message);
            //}
		}

        //private static void CreateSecuritySaleMapping(int securitySaleID, int securitySaleSourceTypeID, int securitySaleSourceID) {
        //    try {
        //        SecuritySaleSourceMapping securitySaleSourceMapping = null;
        //        using (PepperContext context = new PepperContext()) {
        //            securitySaleSourceMapping = (from map in context.SecuritySaleSourceMappings
        //                                         where map.SecuritySaleID == securitySaleID
        //                                         && map.SecuritySaleSourceTypeID == securitySaleSourceTypeID
        //                                         && map.SecuritySaleSourceID == securitySaleSourceID
        //                                         select map).FirstOrDefault();
        //        }
        //        if (securitySaleSourceMapping == null) {
        //            securitySaleSourceMapping = new SecuritySaleSourceMapping { SecuritySaleSourceID = securitySaleSourceID, SecuritySaleSourceTypeID = securitySaleSourceTypeID, SecuritySaleID = securitySaleID };
        //            securitySaleSourceMapping.Save();
        //            Util.WriteNewEntry("New security sale mapping: " + securitySaleSourceMapping.SecuritySaleSourceMappingID);
        //        } else {
        //            Util.WriteError("Security sale mapping already exist : " + securitySaleSourceMapping.SecuritySaleSourceMappingID);
        //        }
        //    } catch (Exception ex) {
        //        Util.WriteError("CreateSecuritySaleMapping Exception: " + ex.Message);
        //    }
        //}

        //private static SecuritySale GetSecuritySale(C4_10tblSaleofStock blueSaleOfStock) {
        //    SecuritySale getSecuritySale = null;
        //    try {
        //        int? fundID = Globals.GetFundID(blueSaleOfStock.AmberbrookFundNo);
        //        int? dealID = Globals.GetDealID(blueSaleOfStock.AmberbrookDealNo, (fundID ?? 0));
        //        DateTime minDate = Convert.ToDateTime("01/01/1900");
        //        SecuritySale securitySale = new SecuritySale {
        //            FundID = (fundID ?? 0),
        //            SecurityID = (Globals.GetSecurityID(blueSaleOfStock.StockSymbol) ?? 0),
        //            SecurityTypeID = (int)Pepper.Models.CodeFirst.Enums.SecurityType.Equity,
        //            SaleAmount = (decimal)(blueSaleOfStock.NumberofShares * blueSaleOfStock.SalePrice),
        //            SellPrice = (decimal)blueSaleOfStock.SalePrice,
        //            Fees = (decimal)blueSaleOfStock.Fees,
        //            EntityID = Globals.DefaultEntityID,
        //            SellDate = (blueSaleOfStock.TradeDate ?? Convert.ToDateTime("01/01/1900")),
        //            SellQuantity = (decimal)blueSaleOfStock.NumberofShares,
        //            SettleDate = blueSaleOfStock.ReceivedDate,
        //            BrokerID = Globals.GetBrokerID(blueSaleOfStock.Broker),
        //            CreatedBy = Globals.CurrentUser.UserID,
        //            CreatedDate = DateTime.Now,
        //            LastUpdatedBy = Globals.CurrentUser.UserID,
        //            LastUpdatedDate = DateTime.Now,
        //            Multiple = (decimal)blueSaleOfStock.Multiple,
        //            NumberofSharesA = (decimal)blueSaleOfStock.NumberofSharesA,
        //            IsConfirmation = blueSaleOfStock.Confirmation,
        //            IsReceived = blueSaleOfStock.Received,
        //            SourceID = blueSaleOfStock.SourceID,
        //            IsAllocatedDistribution = blueSaleOfStock.AllocatedDistribution,
        //            DealID = dealID,
        //            UnderlyingFundID = Globals.GetUnderlyingFundID(blueSaleOfStock.Fund)
        //        };
        //        using (PepperContext context = new PepperContext()) {
        //            getSecuritySale = context.SecuritySales.Where(ss => ss.FundID == securitySale.FundID
        //                            && ss.SecurityID == securitySale.SecurityID
        //                            && ss.SecurityTypeID == securitySale.SecurityTypeID
        //                //&& EntityFunctions.Truncate(ss.SaleAmount, 2) == EntityFunctions.Truncate(securitySale.SaleAmount, 2)
        //                //&& EntityFunctions.Truncate(ss.SellPrice, 2) == EntityFunctions.Truncate(securitySale.SellPrice, 2)
        //                //&& EntityFunctions.Truncate((ss.Fees ?? 0), 2) == EntityFunctions.Truncate((securitySale.Fees ?? 0), 2)
        //                            && ss.EntityID == securitySale.EntityID
        //                            && EntityFunctions.TruncateTime(ss.SellDate) == EntityFunctions.TruncateTime(securitySale.SellDate)
        //                            && EntityFunctions.TruncateTime((ss.SettleDate ?? minDate)) == EntityFunctions.TruncateTime((securitySale.SettleDate ?? minDate))
        //                //&& (ss.BrokerID ?? 0) == (securitySale.BrokerID ?? 0)
        //                            && (ss.SourceID ?? 0) == (securitySale.SourceID ?? 0)
        //                    ).FirstOrDefault();
        //        }
        //    } catch (Exception ex) {
        //        Util.WriteError("GetSecuritySale Exception: " + ex.Message);
        //    }
        //    return getSecuritySale;
        //}

        //private static DealUnderlyingDirect GetDealUnderlyingDirect(int sourceID) {
        //    DealUnderlyingDirect dealUnderlyingDirect = null;
        //    try {
        //        C5_11tblDealOriginationDirects blueDirect = null;
        //        int fundID = 0;
        //        int securityID = 0;
        //        int securityTypeID = (int)Pepper.Models.CodeFirst.Enums.SecurityType.Equity;
        //        int dealID = 0;
        //        decimal numberOfShares = 0;
        //        using (BlueEntities blueEntity = new BlueEntities()) {
        //            blueDirect = (from dd in blueEntity.C5_11tblDealOriginationDirects
        //                          where dd.TransactionID == sourceID
        //                          select dd).FirstOrDefault();
        //        }
        //        if (blueDirect == null) {
        //            blueDirect = (from dd in Globals.C5_11tblDealOriginationDirects
        //                          where dd.TransactionID == sourceID
        //                          select dd).FirstOrDefault();
        //        }
        //        if (blueDirect != null) {
        //            fundID = (Globals.GetFundID(blueDirect.AmberbrookFundNo) ?? 0);
        //            securityID = (Globals.GetSecurityID(blueDirect.StockSymbol) ?? 0);
        //            dealID = (Globals.GetDealID((blueDirect.DealNo ?? 0), fundID) ?? 0);
        //            numberOfShares = (decimal)blueDirect.NShares;
        //            using (PepperContext context = new PepperContext()) {
        //                dealUnderlyingDirect = (from direct in context.DealUnderlyingDirects
        //                                        join deal in context.Deals on direct.DealID equals deal.DealID
        //                                        where deal.FundID == fundID
        //                                                           && direct.SecurityID == securityID
        //                                                           && direct.SecurityTypeID == securityTypeID
        //                                                           && direct.DealID == dealID
        //                                                           && EntityFunctions.Truncate((direct.NumberOfShares ?? 0), 2) == EntityFunctions.Truncate(numberOfShares, 2)
        //                                        select direct).FirstOrDefault();
        //            }
        //            return dealUnderlyingDirect;
        //        }
        //    } catch (Exception ex) {
        //        Util.WriteError("GetDealUnderlyingDirect Exception: " + ex.Message);
        //    }
        //    return dealUnderlyingDirect;
        //}

        //private static UnderlyingFundStockDistributionLineItem GetUnderlyingFundStockDistributionLineItem(int sourceID) {
        //    UnderlyingFundStockDistributionLineItem underlyingFundStockDistributionLineItem = null;
        //    try {
        //        C1_15tblDistToAmberbrookStock blueStockDistribution = null;
        //        int fundID = 0;
        //        int securityID = 0;
        //        int securityTypeID = (int)Pepper.Models.CodeFirst.Enums.SecurityType.Equity;
        //        int dealID = 0;
        //        int underlyingFundID = 0;
        //        decimal numberOfShares = 0;
        //        decimal fmv = 0;
        //        DateTime minDate = Convert.ToDateTime("01/01/1900");
        //        using (BlueEntities blueEntity = new BlueEntities()) {
        //            blueStockDistribution = (from sd in blueEntity.C1_15tblDistToAmberbrookStock
        //                                     where sd.TransactionID == sourceID
        //                                     select sd).FirstOrDefault();
        //        }
        //        if (blueStockDistribution == null) {
        //            blueStockDistribution = (from sd in Globals.C1_15tblDistToAmberbrookStock
        //                                     where sd.TransactionID == sourceID
        //                                     select sd).FirstOrDefault();
        //        }
        //        if (blueStockDistribution != null) {
        //            fundID = (Globals.GetFundID(blueStockDistribution.AmberbrookFundNo) ?? 0);
        //            securityID = (Globals.GetSecurityID(blueStockDistribution.StockSymbol) ?? 0);
        //            dealID = (Globals.GetDealID(blueStockDistribution.AmberbrookDealNo, fundID) ?? 0);
        //            underlyingFundID = (Globals.GetUnderlyingFundID(blueStockDistribution.Fund) ?? 0);
        //            numberOfShares = (decimal)blueStockDistribution.NumberofShares;
        //            fmv = (decimal)blueStockDistribution.Proceeds;
        //            using (PepperContext context = new PepperContext()) {
        //                underlyingFundStockDistributionLineItem = (from ufsd in context.UnderlyingFundStockDistributions
        //                                                           join ufsditem in context.UnderlyingFundStockDistributionLineItems on ufsd.UnderlyingFundStockDistributionID equals ufsditem.UnderlyingFundStockDistributionID
        //                                                           where ufsd.FundID == fundID
        //                                                           && ufsd.SecurityID == securityID
        //                                                           && ufsd.SecurityTypeID == securityTypeID
        //                                                           && ufsditem.DealID == dealID
        //                                                           && ufsditem.UnderlyingFundID == underlyingFundID
        //                                                           && EntityFunctions.TruncateTime((ufsd.NoticeDate ?? minDate)) == EntityFunctions.TruncateTime((blueStockDistribution.NoticeDate ?? minDate))
        //                                                           && EntityFunctions.Truncate((ufsd.NumberOfShares ?? 0), 2) == EntityFunctions.Truncate(numberOfShares, 2)
        //                                                           && EntityFunctions.Truncate((ufsd.FMV ?? 0), 2) == EntityFunctions.Truncate(fmv, 2)
        //                                                           && EntityFunctions.TruncateTime((ufsd.DistributionDate ?? minDate)) == EntityFunctions.TruncateTime(blueStockDistribution.EffectiveDate)
        //                                                           select ufsditem).FirstOrDefault();
        //            }
        //            return underlyingFundStockDistributionLineItem;
        //        }
        //    } catch (Exception ex) {
        //        Util.WriteError("GetUnderlyingFundStockDistributionLineItem Exception: " + ex.Message);
        //    }
        //    return underlyingFundStockDistributionLineItem;
        //}

	}
}

