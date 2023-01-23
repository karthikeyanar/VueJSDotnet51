using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Pepper.Models.CodeFirst;
using System.Net;
using System.Data.Objects;


namespace PepperExcelImport {
	class SecurityLotReEntry {
		//public static void ImportSecurityLot() {
		//    try {
		//        List<DealUnderlyingDirect> dealUnderlyingDirects;
		//        List<UnderlyingFundStockDistributionLineItem> stockItems;
		//        List<SecurityConversionDetail> securityConversionDetails;

		//        using (PepperContext context = new PepperContext()) {
		//            dealUnderlyingDirects = context.DealUnderlyingDirects
		//                .Where(d => (d.IsSecurityConversionDetail ?? false) == false && d.Deal.EntityID == Globals.DefaultEntityID)
		//                .ToList();
		//            stockItems = context.UnderlyingFundStockDistributionLineItems
		//                .Where(d => (d.IsSecurityConversionDetail ?? false) == false && d.Deal.EntityID == Globals.DefaultEntityID)
		//                .ToList();
		//            securityConversionDetails = context
		//                                    .SecurityConversionDetails
		//                                    .ToList();
		//        }
		//        int i = 0;
		//        Util.Log("Total Deal Underlying Direct : " + dealUnderlyingDirects.Count());
		//        foreach (var direct in dealUnderlyingDirects) {
		//            direct.Save();
		//            i++;
		//            Util.Log("Deal Underlying Direct : " + i);
		//        }
		//        i = 0;
		//        Util.Log("Total UnderlyingFundStockDistributionLineItem  : " + stockItems.Count());
		//        foreach (var item in stockItems) {
		//            item.Save();
		//            i++;
		//            Util.Log("UnderlyingFundStockDistributionLineItem : " + i);
		//        }
		//        i = 0;
		//        Util.Log("Total SecurityConversionDetails  : " + securityConversionDetails.Count());
		//        foreach (var item in securityConversionDetails) {
		//            item.Save();
		//            i++;
		//            Util.Log("SecurityConversionDetail : " + i);
		//        }
		//    } catch (Exception ex) {
		//        Util.WriteError("ImportSecurityLot Exception: " + ex.Message);
		//    }
		//}

		//public static void Before_SecuritySplit_SecuritySales() {
		//    try {
		//        List<EquitySplit> equitySplits;
		//        using (PepperContext context = new PepperContext()) {
		//            equitySplits = (from eqsplit in context.EquitySplits
		//                            where eqsplit.Equity.EntityID == Globals.DefaultEntityID
		//                            && eqsplit.SplitDate.Year != 1900
		//                            && EntityFunctions.Truncate((eqsplit.SplitFactor ?? 0), 0) != 1
		//                            orderby eqsplit.SplitDate
		//                            select eqsplit).ToList();
		//        }
		//        int i = 0;
		//        List<SecuritySale> securitySales;
		//        List<SecurityDistribution> securityDistributions;
		//        foreach (var es in equitySplits) {
		//            securitySales = null;
		//            securityDistributions = null;
		//            using (PepperContext context = new PepperContext()) {
		//                securitySales = (from ss in context.SecuritySales
		//                                 where ss.SecurityID == es.EquityID
		//                                 && ss.SecurityTypeID == (int)Pepper.Models.CodeFirst.Enums.SecurityType.Equity
		//                                 && EntityFunctions.TruncateTime(ss.SellDate) < es.SplitDate
		//                                 orderby ss.SellDate select ss).ToList();
		//                securityDistributions = (from sd in context.SecurityDistributions
		//                                         where sd.SecurityID == es.EquityID
		//                                  && sd.SecurityTypeID == (int)Pepper.Models.CodeFirst.Enums.SecurityType.Equity
		//                                  && EntityFunctions.TruncateTime(sd.SecurityDistributionDate) < es.SplitDate
		//                                         orderby sd.SecurityDistributionDate select sd).ToList();
		//            }
		//            if (securitySales != null) {
		//                i = 0;
		//                foreach (var securitySale in securitySales) {
		//                    i++;
		//                    Util.Log("Before_SecuritySplit_SecuritySales Security Sale : " + i);
		//                    try {
		//                        securitySale.Save();
		//                    } catch (Exception ex) {
		//                        Util.WriteError("Before_SecuritySplit_SecuritySales Security sale : " + ex.Message);
		//                    }
		//                }
		//            }
		//            if (securityDistributions != null) {
		//                i = 0;
		//                foreach (var securityDistribution in securityDistributions) {
		//                    i++;
		//                    Util.Log("Before_SecuritySplit_SecuritySales Security Distribution : " + i);
		//                    try {
		//                        securityDistribution.Save();
		//                    } catch (Exception ex) {
		//                        Util.WriteError("Before_SecuritySplit_SecuritySales Security Distribution: " + ex.Message);
		//                    }
		//                }
		//            }
		//        }
		//    } catch (Exception ex) {
		//        Util.WriteError("Before_SecuritySplit_SecuritySales Exception: " + ex.Message);
		//    }
		//}

		//public static void EquitySplit_Init() {
		//    try {
		//        List<EquitySplit> equitySplits;
		//        using (PepperContext context = new PepperContext()) {
		//            equitySplits = (from eqsplit in context.EquitySplits
		//                            where eqsplit.Equity.EntityID == Globals.DefaultEntityID
		//                            && eqsplit.SplitDate.Year != 1900
		//                            && EntityFunctions.Truncate((eqsplit.SplitFactor ?? 0), 0) != 1
		//                            orderby eqsplit.SplitDate
		//                            select eqsplit).ToList();
		//        }
		//        foreach (var es in equitySplits) {
		//            try {
		//                es.Save();
		//                Util.WriteNewEntry("Security Split Init:" + es.EquiteSplitID);
		//            } catch (Exception ex) {
		//                Util.WriteError("ReEntrySecurityLog Save Equity Split: " + ex.Message);
		//            }
		//        }

		//    } catch (Exception ex) {
		//        Util.WriteError("ReEntrySecurityLog Exception: " + ex.Message);
		//    }
		//}

		public static void ReEntrySecurityLog() {
			// Security Sale is not null
			List<SecuritySale> securitySales;
			DateTime targetDate = Convert.ToDateTime("07/21/2013");
			using (PepperContext context = new PepperContext()) {
				securitySales = context.SecuritySales.Where(ss => ss.SourceID != null
				&& EntityFunctions.TruncateTime(ss.CreatedDate) > targetDate
				).OrderBy(ss => ss.SellDate).ToList();
			}

			foreach (var securitySale in securitySales) {
				Sale_SecuritySale(securitySale);
			}

			// Security Sale is null
			using (PepperContext context = new PepperContext()) {
				securitySales = context.SecuritySales
					.Where(ss => ss.SourceID == null
					&& EntityFunctions.TruncateTime(ss.CreatedDate) > targetDate
					).OrderBy(ss => ss.SellDate).ToList();
			}

			foreach (var securitySale in securitySales) {
				Sale_SecuritySale(securitySale);
			}

			//// Security Distribution is not null
			//List<SecurityDistribution> securityDistributions;
			//using (PepperContext context = new PepperContext()) {
			//    securityDistributions = context.SecurityDistributions.Where(sd => sd.SourceID != null).OrderBy(sd => sd.SecurityDistributionDate).ToList();
			//}

			//foreach (var securityDistribution in securityDistributions) {
			//    Sale_SecurityDistribution(securityDistribution);
			//}

			//// Security Distribution is null
			//using (PepperContext context = new PepperContext()) {
			//    securityDistributions = context.SecurityDistributions.Where(sd => sd.SourceID == null).OrderBy(sd => sd.SecurityDistributionDate).ToList();
			//}

			//foreach (var securityDistribution in securityDistributions) {
			//    Sale_SecurityDistribution(securityDistribution);
			//}

		}

		//public static void CheckMissingRecords() {
		//    // Security Sale is not null
		//    List<SecuritySale> securitySales;
		//    using (PepperContext context = new PepperContext()) {
		//        securitySales = (from ss in context.SecuritySales
		//                         join equity in context.Equities on ss.SecurityID equals equity.EquityID
		//                         where equity.Symbol == "Ancestry.com_COMMON"
		//                         orderby ss.SellDate
		//                         select ss).ToList();
		//    }

		//    foreach (var securitySale in securitySales) {
		//        Sale_SecuritySale(securitySale);
		//    }
		//}

		private static void Sale_SecuritySale(SecuritySale securitySale) {
			SecurityDisbursement securityDisbursement = null;
			using (PepperContext context = new PepperContext()) {
				securityDisbursement = (from disbursement in context.SecurityDisbursements
										where disbursement.SecurityDisbursementSourceID == securitySale.SecuritySaleID
										&& disbursement.SecurityDisbursementTypeID == (int)Pepper.Models.CodeFirst.Enums.SecurityDisbursementType.SecuritySale
										select disbursement).FirstOrDefault();
			}
			if (securityDisbursement == null) {
				try {
					securitySale.Save();
					Util.WriteNewEntry("Sale_SecuritySale : " + securitySale.SecuritySaleID);
				} catch (Exception ex) {
					Util.WriteError("Sale_SecuritySale exception : " + ex.Message);
				}
			} else {
				Util.WriteError("Already sale:" + securitySale.SecuritySaleID);
			}
		}

		//private static void Sale_SecurityDistribution(SecurityDistribution securityDistribution) {
		//    SecurityDisbursement securityDisbursement = null;
		//    using (PepperContext context = new PepperContext()) {
		//        securityDisbursement = (from disbursement in context.SecurityDisbursements
		//                                where disbursement.SecurityDisbursementSourceID == securityDistribution.SecurityDistributionID
		//                                && disbursement.SecurityDisbursementTypeID == (int)Pepper.Models.CodeFirst.Enums.SecurityDisbursementType.SecurityDistribution
		//                                select disbursement).FirstOrDefault();
		//    }
		//    if (securityDisbursement == null) {
		//        try {
		//            securityDistribution.Save();
		//            Util.WriteNewEntry("Sale_SecurityDistribution : " + securityDistribution.SecurityDistributionID);
		//        } catch (Exception ex) {
		//            Util.WriteError("Sale_SecurityDistribution Exception: " + ex.Message);
		//        }
		//    } else {
		//        Util.WriteError("Already sale:" + securityDistribution.SecurityDistributionID);
		//    }
		//}

		//private static void GetUnderlyingFundStockDistribution_DealUnderlyingDirect(SecuritySale securitySale
		//    , ref UnderlyingFundStockDistributionLineItem underlyingFundStockDistributionLineItem
		//    , ref DealUnderlyingDirect dealUnderlyingDirect) {
		//    using (PepperContext context = new PepperContext()) {
		//        if (securitySale.SourceID != null) {
		//            if (securitySale.SourceID > 0) {
		//                underlyingFundStockDistributionLineItem = (from m in context.SecuritySaleSourceMappings
		//                                                           join ufsditem in context.UnderlyingFundStockDistributionLineItems on m.SecuritySaleSourceID equals ufsditem.UnderlyingFundStockDistributionLineItemID
		//                                                           where m.SecuritySaleID == securitySale.SecuritySaleID
		//                                                           && m.SecuritySaleSourceTypeID == (int)Pepper.Models.CodeFirst.Enums.SecuritySaleSourceType.UnderlyingFundStockDistributionLineItem
		//                                                           select ufsditem).FirstOrDefault();
		//            } else {
		//                dealUnderlyingDirect = (from m in context.SecuritySaleSourceMappings
		//                                        join dd in context.DealUnderlyingDirects on m.SecuritySaleSourceID equals dd.DealUnderlyingDirectID
		//                                        where m.SecuritySaleID == securitySale.SecuritySaleID
		//                                        && m.SecuritySaleSourceTypeID == (int)Pepper.Models.CodeFirst.Enums.SecuritySaleSourceType.DealUnderlyingDirect
		//                                        select dd).FirstOrDefault();
		//            }
		//        }
		//    }
		//}

		//private static void GetUnderlyingFundStockDistribution_DealUnderlyingDirect(SecurityDistribution securityDistribution
		//    , ref UnderlyingFundStockDistributionLineItem underlyingFundStockDistributionLineItem
		//    , ref DealUnderlyingDirect dealUnderlyingDirect) {
		//    using (PepperContext context = new PepperContext()) {
		//        if (securityDistribution.SourceID != null) {
		//            if (securityDistribution.SourceID > 0) {
		//                underlyingFundStockDistributionLineItem = (from m in context.SecurityDistributionSourceMappings
		//                                                           join ufsditem in context.UnderlyingFundStockDistributionLineItems on m.SecurityDistributionSourceID equals ufsditem.UnderlyingFundStockDistributionLineItemID
		//                                                           where m.SecurityDistributionID == securityDistribution.SecurityDistributionID
		//                                                           && m.SecurityDistributionSourceTypeID == (int)Pepper.Models.CodeFirst.Enums.SecurityDistributionSourceType.UnderlyingFundStockDistributionLineItem
		//                                                           select ufsditem).FirstOrDefault();
		//            } else {
		//                dealUnderlyingDirect = (from m in context.SecurityDistributionSourceMappings
		//                                        join dd in context.DealUnderlyingDirects on m.SecurityDistributionSourceID equals dd.DealUnderlyingDirectID
		//                                        where m.SecurityDistributionID == securityDistribution.SecurityDistributionID
		//                                        && m.SecurityDistributionSourceTypeID == (int)Pepper.Models.CodeFirst.Enums.SecurityDistributionSourceType.DealUnderlyingDirect
		//                                        select dd).FirstOrDefault();
		//            }
		//        }
		//    }
		//}

		//public static void SaveSecurityLot(UnderlyingFundStockDistributionLineItem underlyingFundStockDistributionLineItem
		//    , DealUnderlyingDirect dealUnderlyingDirect
		//    , DateTime sellDate
		//    , int fundID
		//    , int securityTypeID
		//    , int securityID
		//    , decimal numberOfShares
		//    , int securityDisbursementSourceID
		//    , int securityDisbursementTypeID) {

		//    List<SecurityLot> securityLots;
		//    EquitySplit equitySplit = null;
		//    using (PepperContext context = new PepperContext()) {
		//        equitySplit = (from es in context.EquitySplits
		//                       where es.EquityID == securityID
		//                       && EntityFunctions.TruncateTime(es.SplitDate) <= EntityFunctions.TruncateTime(sellDate)
		//                       orderby es.EquiteSplitID descending
		//                       select es).FirstOrDefault();
		//    }

		//    if (equitySplit != null) {
		//        //if(equitySplit.SplitFactor > 1){
		//        // check split action
		//        int count = 0;
		//        using (PepperContext context = new PepperContext()) {
		//            count = (from securityLot in context.SecurityLots
		//                     join ufsditem in context.UnderlyingFundStockDistributionLineItems on securityLot.SecurityAcquisitionID equals ufsditem.UnderlyingFundStockDistributionLineItemID
		//                     orderby ufsditem.UnderlyingFundStockDistribution.DistributionDate
		//                     where securityLot.FundID == fundID
		//                     && securityLot.SecurityTypeID == securityTypeID
		//                     && securityLot.SecurityID == securityID
		//                     && securityLot.NumberOfSharesUnsold > 0
		//                     && securityLot.SecurityAcquisitionTypeID == (int)Pepper.Models.CodeFirst.Enums.SecurityAcquisitionType.UnderlyingFundStockDistributionLineItem
		//                     && EntityFunctions.TruncateTime(ufsditem.UnderlyingFundStockDistribution.DistributionDate) >= EntityFunctions.TruncateTime(equitySplit.SplitDate)
		//                     select securityLot)
		//                            .Union(
		//                            (from securityLot in context.SecurityLots
		//                             join dd in context.DealUnderlyingDirects on securityLot.SecurityAcquisitionID equals dd.DealUnderlyingDirectID
		//                             orderby dd.PurchaseDate
		//                             where securityLot.FundID == fundID
		//                             && securityLot.SecurityTypeID == securityTypeID
		//                             && securityLot.SecurityID == securityID
		//                             && securityLot.NumberOfSharesUnsold > 0
		//                             && securityLot.SecurityAcquisitionTypeID == (int)Pepper.Models.CodeFirst.Enums.SecurityAcquisitionType.DealUnderlyingDirect
		//                             && EntityFunctions.TruncateTime(dd.PurchaseDate) >= EntityFunctions.TruncateTime(equitySplit.SplitDate)
		//                             select securityLot)
		//                            ).Count();

		//        }
		//        if (count == 0) {
		//            using (PepperContext context = new PepperContext()) {
		//                securityLots = (from sl in context.SecurityLots
		//                                where sl.SecurityID == securityID
		//                                && sl.SecurityTypeID == securityTypeID
		//                                select sl).ToList();
		//            }
		//            foreach (var lot in securityLots) {
		//                //DealUnderlyingDirect newdealUnderlyingDirect = new DealUnderlyingDirect();
		//                //newdealUnderlyingDirect.DealUnderlyingDirectID = 0;
		//                //newdealUnderlyingDirect.NumberOfShares = lot.NumberOfSharesUnsold * (equitySplit.SplitFactor ?? 0);
		//                //newdealUnderlyingDirect.IsActive = true;
		//                lot.NumberOfSharesUnsold = lot.NumberOfSharesUnsold * (equitySplit.SplitFactor ?? 0);
		//                lot.Save();
		//            }
		//        }
		//        //}
		//    }

		//    securityLots = null;

		//    SecurityDisbursement securityDisbursement;
		//    SecurityDisbursementLineItem securityDisbursementLineItem;

		//    //Get all security lots
		//    securityDisbursement = new SecurityDisbursement();
		//    securityDisbursement.NumberOfShares = numberOfShares;
		//    securityDisbursement.SecurityDisbursementSourceID = securityDisbursementSourceID;
		//    securityDisbursement.SecurityDisbursementTypeID = securityDisbursementTypeID;
		//    securityDisbursement.CreatedBy = Globals.CurrentUser.UserID;
		//    securityDisbursement.CreatedDate = DateTime.Now;
		//    securityDisbursement.Save();


		//    decimal sellQuantity;
		//    using (PepperContext context = new PepperContext()) {
		//        if (underlyingFundStockDistributionLineItem != null) {
		//            securityLots = (from securityLot in context.SecurityLots
		//                            join ufsditem in context.UnderlyingFundStockDistributionLineItems on securityLot.SecurityAcquisitionID equals ufsditem.UnderlyingFundStockDistributionLineItemID
		//                            where
		//                            securityLot.SecurityAcquisitionTypeID == (int)Pepper.Models.CodeFirst.Enums.SecurityAcquisitionType.UnderlyingFundStockDistributionLineItem
		//                            && ufsditem.UnderlyingFundStockDistributionLineItemID == underlyingFundStockDistributionLineItem.UnderlyingFundStockDistributionLineItemID
		//                            select securityLot).ToList();
		//        } else if (dealUnderlyingDirect != null) {
		//            securityLots = (from securityLot in context.SecurityLots
		//                            join dd in context.DealUnderlyingDirects on securityLot.SecurityAcquisitionID equals dd.DealUnderlyingDirectID
		//                            where
		//                            securityLot.SecurityAcquisitionTypeID == (int)Pepper.Models.CodeFirst.Enums.SecurityAcquisitionType.DealUnderlyingDirect
		//                            && dd.DealUnderlyingDirectID == dealUnderlyingDirect.DealUnderlyingDirectID
		//                            select securityLot).ToList();
		//        } else {
		//            securityLots = (from securityLot in context.SecurityLots
		//                            join ufsditem in context.UnderlyingFundStockDistributionLineItems on securityLot.SecurityAcquisitionID equals ufsditem.UnderlyingFundStockDistributionLineItemID
		//                            orderby ufsditem.UnderlyingFundStockDistribution.DistributionDate
		//                            where securityLot.FundID == fundID
		//                            && securityLot.SecurityTypeID == securityTypeID
		//                            && securityLot.SecurityID == securityID
		//                            && securityLot.NumberOfSharesUnsold > 0
		//                                //&& securityLot.IsActive == true
		//                            && securityLot.SecurityAcquisitionTypeID == (int)Pepper.Models.CodeFirst.Enums.SecurityAcquisitionType.UnderlyingFundStockDistributionLineItem
		//                            //&& EntityFunctions.TruncateTime(ufsditem.UnderlyingFundStockDistribution.DistributionDate) < EntityFunctions.TruncateTime(securitySale.SellDate)
		//                            select securityLot)
		//                            .Union(
		//                            (from securityLot in context.SecurityLots
		//                             join dd in context.DealUnderlyingDirects on securityLot.SecurityAcquisitionID equals dd.DealUnderlyingDirectID
		//                             orderby dd.PurchaseDate
		//                             where securityLot.FundID == fundID
		//                             && securityLot.SecurityTypeID == securityTypeID
		//                             && securityLot.SecurityID == securityID
		//                             && securityLot.NumberOfSharesUnsold > 0
		//                                 // && securityLot.IsActive == true
		//                             && securityLot.SecurityAcquisitionTypeID == (int)Pepper.Models.CodeFirst.Enums.SecurityAcquisitionType.DealUnderlyingDirect
		//                             //&& EntityFunctions.TruncateTime(dd.PurchaseDate) < EntityFunctions.TruncateTime(securitySale.SellDate)
		//                             select securityLot)
		//                            )
		//                            .ToList();
		//        }
		//    }
		//    sellQuantity = 0;
		//    foreach (SecurityLot securityLot in securityLots) {
		//        if (numberOfShares > 0) {
		//            if (securityLot.NumberOfSharesUnsold >= numberOfShares) {
		//                sellQuantity = numberOfShares;
		//                numberOfShares = 0;
		//            } else {
		//                numberOfShares = numberOfShares - securityLot.NumberOfSharesUnsold;
		//                sellQuantity = securityLot.NumberOfSharesUnsold;
		//            }

		//            securityDisbursementLineItem = new SecurityDisbursementLineItem();
		//            securityDisbursementLineItem.SecurityDisbursementID = securityDisbursement.SecurityDisbursementID;
		//            securityDisbursementLineItem.SecurityLotNumber = securityLot.SecurityLotNumber;
		//            securityDisbursementLineItem.SellQuantity = sellQuantity;
		//            securityDisbursementLineItem.Save();

		//            securityLot.NumberOfSharesUnsold = securityLot.NumberOfSharesUnsold - sellQuantity;
		//            securityLot.Save();
		//        }
		//    }
		//}

	}
}
