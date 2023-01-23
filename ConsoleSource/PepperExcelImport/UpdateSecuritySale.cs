using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Pepper.Models.CodeFirst;
using System.Data.Objects;
using Pepper.Framework.Validation;
using Pepper.Framework.Extensions;

namespace PepperExcelImport {
	class UpdateSecuritySaleToSecurityLot {

		public static void Import() {
			/*
			Import_Symbol("TSRA");
			Import_Symbol("ADBL");
			Import_Symbol("WIFI");
			Import_Symbol("BMY");
			Import_Symbol("CY");
			Import_Symbol("DDUP");
			Import_Symbol("Hyperchip_C");
			Import_Symbol("IXYS");
			Import_Symbol("MDDS");
			Import_Symbol("PTUS");
			Import_Symbol("RAPT_common");
			Import_Symbol("SDLI");
			Import_Symbol("VMSI");
			Import_Symbol("VIAN");
			
			Import_Symbol("GB");
			Import_Symbol("3Par");
			Import_Symbol("JDSU");
			Import_Symbol("EXQNF");
			Import_Symbol("DVIN");
			Import_Symbol("CSCO");
			Import_Symbol("Giftcert.com_common");
			Import_Symbol("GDT");
			Import_Symbol("BFPT");
			Import_Symbol("CCRD");
			Import_Symbol("DGIT");
			Import_Symbol("TNDM");
			
			Import_Symbol("ALKD");
			Import_Symbol("WPI");
			Import_Symbol("BMY");
			
			Import_Symbol("SBSW");
			Import_Symbol("EwVe");
			Import_Symbol("Aegis_B2");
			Import_Symbol("Commvault_CC");
			Import_Symbol("Commvault_common");
			
			Import_Symbol("MZINGA_Note");
			Import_Symbol("MZINGA_A");
			 */

			//Import_Symbol("BNTL");
		}

        //public static void Update_Security_Conversion_IsActive() {
        //    List<SecurityConversionDetail> securityConversionDetails = null;
        //    using (PepperContext context = new PepperContext()) {
        //        securityConversionDetails = (from det in context.SecurityConversionDetails
        //                                     join conv in context.SecurityConversions on det.SecurityConversionID equals conv.SecurityConversionID
        //                                     select det).ToList();
        //    }
        //    foreach (var conv in securityConversionDetails) {
        //        bool isUpdate = false;
        //        if (conv.NewSecurityConversionTypeID == (int)Pepper.Models.CodeFirst.Enums.SecurityConversionType.DealUnderlyingDirect) {
        //            DealUnderlyingDirect dud = null;
        //            using (PepperContext context = new PepperContext()) {
        //                dud = (from item in context.DealUnderlyingDirects
        //                       where item.DealUnderlyingDirectID == conv.NewSecurityConversionSourceID
        //                       select item).FirstOrDefault();
        //            }
        //            if (dud != null) {
        //                if (dud.IsActive == false) {
        //                    isUpdate = true;
        //                }
        //                conv.IsActive = dud.IsActive;
        //            } else {
        //                Util.WriteNewEntry("Security Conversion Deal underlying direct not exist " + conv.SecurityConversionDetailID);
        //            }
        //        } else if (conv.NewSecurityConversionTypeID == (int)Pepper.Models.CodeFirst.Enums.SecurityConversionType.UnderlyingFundStockDistributionLineItem) {
        //            UnderlyingFundStockDistributionLineItem ufsd = null;
        //            using (PepperContext context = new PepperContext()) {
        //                ufsd = (from item in context.UnderlyingFundStockDistributionLineItems
        //                        where item.UnderlyingFundStockDistributionLineItemID == conv.NewSecurityConversionSourceID
        //                        select item).FirstOrDefault();
        //            }
        //            if (ufsd != null) {
        //                if (ufsd.IsActive == false) {
        //                    isUpdate = true;
        //                }
        //                conv.IsActive = ufsd.IsActive;
        //            } else {
        //                Util.WriteNewEntry("Security Conversion UFSD not exist " + conv.SecurityConversionDetailID);
        //            }
        //        }
        //        if (isUpdate) {
        //            Util.WriteNewEntry("Security Conversion De activate = " + conv.SecurityConversionDetailID);
        //            conv.Save();
        //        } else {
        //            Util.WriteNewEntry("Security Conversion No activate " + conv.SecurityConversionDetailID);
        //        }
        //    }
        //}

        //public static void Import_Symbol(string symbol, bool isSale = true) {
        //    List<SecuritySale> securitySales = null;
        //    List<SecurityDistribution> securityDistrbutions = null;
        //    List<SecurityLot> securityLots = null;
        //    List<SecurityLotHistory> securityLotHistories = null;
        //    List<DealUnderlyingDirect> dealUnderlyingDirects = null;

        //    List<UnderlyingFundStockDistributionLineItem> underlyingFundStockDistributionLineItems = null;
        //    List<SecurityConversionDetail> newSecurityConversionDetails = null;
        //    List<SecurityConversionDetail> oldSecurityConversionDetails = null;

        //    List<DirectDistributionLineItem> directDistributionLineItems = null;

        //    List<EquitySplit> equitySplits = null;
        //    using (PepperContext context = new PepperContext()) {
        //        securitySales = (from ss in context.SecuritySales
        //                         join equity in context.Equities.EntityFilter() on ss.SecurityID equals equity.EquityID
        //                         where equity.Symbol == symbol
        //                         orderby ss.SellDate, ss.SecuritySaleID
        //                         select ss).ToList();
        //        foreach (var secSale in securitySales) {

        //            securityLotHistories = null;
        //            securityLotHistories = (from history in context.SecurityLotHistories
        //                                    join securityLot in context.SecurityLots on history.SecurityLotNumber equals securityLot.SecurityLotNumber
        //                                    join equity in context.Equities.EntityFilter() on securityLot.SecurityID equals equity.EquityID
        //                                    where history.SecurityLotHistoryReason == (int)Pepper.Models.CodeFirst.Enums.SecurityLotHistoryReason.SaleOfSecurity
        //                                    && history.SecurityLotHistoryReasonID == secSale.SecuritySaleID
        //                                    select history).ToList();
        //            foreach (var history in securityLotHistories) {
        //                context.SecurityLotHistories.Remove(history);
        //            }

        //            var securityDisbursements = (from secDis in context.SecurityDisbursements
        //                                         where secDis.SecurityDisbursementTypeID == (int)Pepper.Models.CodeFirst.Enums.SecurityDisbursementType.SecuritySale
        //                                         && secDis.SecurityDisbursementSourceID == secSale.SecuritySaleID
        //                                         select secDis).ToList();
        //            foreach (var secDis in securityDisbursements) {
        //                var securityDisbursementLineItems = secDis.SecurityDisbursementLineItems.ToList();
        //                foreach (var securityDisbursementLineItem in securityDisbursementLineItems) {
        //                    Util.WriteNewEntry("Security Sale securityDisbursementLineItem remove id = " + securityDisbursementLineItem.SecurityDisbursementLineItemID);
        //                    context.SecurityDisbursementLineItems.Remove(securityDisbursementLineItem);
        //                }
        //                Util.WriteNewEntry("Security Sale SecurityDisbursements remove id = " + secDis.SecurityDisbursementID);
        //                context.SecurityDisbursements.Remove(secDis);
        //            }
        //        }
        //        context.SaveChanges();
        //        Util.WriteNewEntry("Security Sale SecurityDisbursements remove all");

        //        securityDistrbutions = (from secDis in context.SecurityDistributions
        //                                join equity in context.Equities.EntityFilter() on secDis.SecurityID equals equity.EquityID
        //                                where equity.Symbol == symbol
        //                                orderby secDis.SecurityDistributionDate, secDis.SecurityDistributionID
        //                                select secDis).ToList();
        //        foreach (var sd in securityDistrbutions) {

        //            securityLotHistories = null;
        //            securityLotHistories = (from history in context.SecurityLotHistories
        //                                    join securityLot in context.SecurityLots on history.SecurityLotNumber equals securityLot.SecurityLotNumber
        //                                    join equity in context.Equities.EntityFilter() on securityLot.SecurityID equals equity.EquityID
        //                                    where history.SecurityLotHistoryReason == (int)Pepper.Models.CodeFirst.Enums.SecurityLotHistoryReason.SecurityDistribution
        //                                    && history.SecurityLotHistoryReasonID == sd.SecurityDistributionID
        //                                    select history).ToList();
        //            foreach (var history in securityLotHistories) {
        //                context.SecurityLotHistories.Remove(history);
        //            }

        //            var securityDisbursements = (from secDis in context.SecurityDisbursements
        //                                         where secDis.SecurityDisbursementTypeID == (int)Pepper.Models.CodeFirst.Enums.SecurityDisbursementType.SecurityDistribution
        //                                         && secDis.SecurityDisbursementSourceID == sd.SecurityDistributionID
        //                                         select secDis).ToList();
        //            foreach (var secDis in securityDisbursements) {
        //                var securityDisbursementLineItems = secDis.SecurityDisbursementLineItems.ToList();
        //                foreach (var securityDisbursementLineItem in securityDisbursementLineItems) {
        //                    Util.WriteNewEntry("Security Distribution securityDisbursementLineItem remove id = " + securityDisbursementLineItem.SecurityDisbursementLineItemID);
        //                    context.SecurityDisbursementLineItems.Remove(securityDisbursementLineItem);
        //                }
        //                Util.WriteNewEntry("Security Distribution SecurityDisbursements remove id = " + secDis.SecurityDisbursementID);
        //                context.SecurityDisbursements.Remove(secDis);
        //            }


        //        }
        //        context.SaveChanges();
        //        Util.WriteNewEntry("Security Distribution SecurityDisbursements remove all");

        //        securityLots = (from securityLot in context.SecurityLots
        //                        join equity in context.Equities.EntityFilter() on securityLot.SecurityID equals equity.EquityID
        //                        where equity.Symbol == symbol
        //                        select securityLot).ToList();

        //        foreach (var securityLot in securityLots) {
        //            var securityDisbursementLineItems = securityLot.SecurityDisbursementLineItems.ToList();
        //            foreach (var securityDisbursementLineItem in securityDisbursementLineItems) {
        //                Util.WriteNewEntry("Security Lot securityDisbursementLineItem remove id = " + securityDisbursementLineItem.SecurityDisbursementLineItemID);
        //                context.SecurityDisbursementLineItems.Remove(securityDisbursementLineItem);
        //            }
        //            securityLotHistories = null;
        //            securityLotHistories = securityLot.SecurityLotHistories.ToList();
        //            foreach (var history in securityLotHistories) {
        //                Util.WriteNewEntry("Security Lot histroy remove id = " + history.SecurityLotHistoryID);
        //                context.SecurityLotHistories.Remove(history);
        //            }
        //            Util.WriteNewEntry("Security Lot remove id = " + securityLot.SecurityLotNumber);
        //            context.SecurityLots.Remove(securityLot);
        //        }

        //        context.SaveChanges();
        //        Util.WriteNewEntry("Security Lots remove all");

        //        dealUnderlyingDirects = (from direct in context.DealUnderlyingDirects
        //                                 join equity in context.Equities.EntityFilter() on direct.SecurityID equals equity.EquityID
        //                                 where equity.Symbol == symbol
        //                                 orderby direct.RecordDate, direct.DealUnderlyingDirectID
        //                                 select direct).ToList();

        //        underlyingFundStockDistributionLineItems = (from item in context.UnderlyingFundStockDistributionLineItems
        //                                                    join ufsd in context.UnderlyingFundStockDistributions on item.UnderlyingFundStockDistributionID equals ufsd.UnderlyingFundStockDistributionID
        //                                                    join equity in context.Equities.EntityFilter() on ufsd.SecurityID equals equity.EquityID
        //                                                    where equity.Symbol == symbol
        //                                                    orderby ufsd.DistributionDate, ufsd.UnderlyingFundStockDistributionID
        //                                                    select item).ToList();

        //        directDistributionLineItems = (from directItem in context.DirectDistributionLineItems
        //                                       join direct in context.DirectDistributions on directItem.DirectDistributionID equals direct.DirectDistributionID
        //                                       join equity in context.Equities.EntityFilter() on direct.SecurityID equals equity.EquityID
        //                                       where equity.Symbol == symbol
        //                                       orderby direct.DistributionDate, direct.DirectDistributionID
        //                                       select directItem).ToList();

        //        newSecurityConversionDetails = (from det in context.SecurityConversionDetails
        //                                        join conv in context.SecurityConversions on det.SecurityConversionID equals conv.SecurityConversionID
        //                                        join equity in context.Equities.EntityFilter() on conv.NewSecurityID equals equity.EquityID
        //                                        where equity.Symbol == symbol
        //                                        orderby conv.ConversionDate, det.SecurityConversionDetailID
        //                                        select det).ToList();

        //        oldSecurityConversionDetails = (from det in context.SecurityConversionDetails
        //                                        join conv in context.SecurityConversions on det.SecurityConversionID equals conv.SecurityConversionID
        //                                        join equity in context.Equities.EntityFilter() on conv.OldSecurityID equals equity.EquityID
        //                                        where equity.Symbol == symbol
        //                                        orderby conv.ConversionDate, det.SecurityConversionDetailID
        //                                        select det).ToList();

        //        equitySplits = (from es in context.EquitySplits
        //                        join equity in context.Equities.EntityFilter() on es.EquityID equals equity.EquityID
        //                        where equity.Symbol == symbol
        //                        orderby es.SplitDate
        //                        select es).ToList();
        //    }
        //    List<int> securityDetIds = new List<int>();
        //    foreach (var det in oldSecurityConversionDetails) {
        //        if (det.IsActive == false) {
        //            det.IsActive = true;
        //            securityDetIds.Add(det.SecurityConversionDetailID);
        //        }
        //        det.Save();
        //        Util.WriteNewEntry("Update old security conversion detail id = " + det.SecurityConversionDetailID);
        //    }
        //    foreach (var det in newSecurityConversionDetails) {
        //        if (det.IsActive == false) {
        //            det.IsActive = true;
        //            securityDetIds.Add(det.SecurityConversionDetailID);
        //        }
        //        det.Save();
        //        Util.WriteNewEntry("Update new security conversion detail id = " + det.SecurityConversionDetailID);
        //    }
        //    List<int> dudids = new List<int>();
        //    foreach (var item in dealUnderlyingDirects) {
        //        if (item.IsActive == false) {
        //            item.IsActive = true;
        //            dudids.Add(item.DealUnderlyingDirectID);
        //        }
        //        item.Save();
        //        Util.WriteNewEntry("Update deal underlying direct id = " + item.DealUnderlyingDirectID);
        //    }
        //    List<int> ufsditemids = new List<int>();
        //    foreach (var item in underlyingFundStockDistributionLineItems) {
        //        if (item.IsActive == false) {
        //            item.IsActive = true;
        //            ufsditemids.Add(item.UnderlyingFundStockDistributionLineItemID);
        //        }
        //        item.Save();
        //        Util.WriteNewEntry("Update underlying fund stock distribution line items id = " + item.UnderlyingFundStockDistributionLineItemID);
        //    }

        //    List<int> ddlineitemids = new List<int>();
        //    foreach (var item in directDistributionLineItems) {
        //        if (item.IsActive == false) {
        //            item.IsActive = true;
        //            ddlineitemids.Add(item.DirectDistributionLineItemID);
        //        }
        //        item.Save();
        //        Util.WriteNewEntry("Update direct distribution line items id = " + item.DirectDistributionLineItemID);
        //    }
        //    if (isSale) {
        //        Util.WriteNewEntry(" -------------- Start Sales ------------------------ " + symbol);
        //        int esSplitCount = 0;
        //        foreach (var es in equitySplits) {
        //            using (PepperContext context = new PepperContext()) {
        //                esSplitCount = (from history in context.SecurityLotHistories
        //                                where history.SecurityLotHistoryReason == (int)Pepper.Models.CodeFirst.Enums.SecurityLotHistoryReason.SecuritySplit
        //                                && history.SecurityLotHistoryReasonID == es.EquiteSplitID
        //                                select history.SecurityLotHistoryID).Count();
        //            }
        //            if (esSplitCount == 0) {
        //                if (es.SplitDate.Year > 1900) {
        //                    List<SecuritySale> beforeSecuritySales = securitySales.Where(q => q.SellDate < es.SplitDate).ToList();
        //                    List<SecurityDistribution> beforeSecurityDistrbutions = securityDistrbutions.Where(q => q.SecurityDistributionDate < es.SplitDate).ToList();
        //                    Util.WriteNewEntry("Before Security Sales = " + beforeSecuritySales.Count);
        //                    Util.WriteNewEntry("Before Security Distributions = " + beforeSecurityDistrbutions.Count);
        //                    Sales(beforeSecuritySales, beforeSecurityDistrbutions, symbol);
        //                    es.SplitSecurityLot();
        //                    Util.WriteNewEntry("Split id = " + es.EquiteSplitID);
        //                }
        //            } else {
        //                Util.WriteNewEntry("Already Split id = " + es.EquiteSplitID);
        //            }
        //        }
        //        foreach (var es in equitySplits) {
        //            using (PepperContext context = new PepperContext()) {
        //                esSplitCount = (from history in context.SecurityLotHistories
        //                                where history.SecurityLotHistoryReason == (int)Pepper.Models.CodeFirst.Enums.SecurityLotHistoryReason.SecuritySplit
        //                                && history.SecurityLotHistoryReasonID == es.EquiteSplitID
        //                                select history.SecurityLotHistoryID).Count();
        //            }
        //            if (esSplitCount == 0) {
        //                if (es.SplitDate.Year > 1900) {
        //                    List<SecuritySale> afterSecuritySales = securitySales.Where(q => q.SellDate > es.SplitDate).ToList();
        //                    List<SecurityDistribution> afterSecurityDistrbutions = securityDistrbutions.Where(q => q.SecurityDistributionDate > es.SplitDate).ToList();
        //                    Util.WriteNewEntry("After Security Sales = " + afterSecuritySales.Count);
        //                    Util.WriteNewEntry("After Security Distributions = " + afterSecurityDistrbutions.Count);
        //                    Sales(afterSecuritySales, afterSecurityDistrbutions, symbol);
        //                    es.SplitSecurityLot();
        //                    Util.WriteNewEntry("Split Sale id = " + es.EquiteSplitID);
        //                }
        //            } else {
        //                Util.WriteNewEntry("Already Split id = " + es.EquiteSplitID);
        //            }
        //        }
        //        Sales(securitySales, securityDistrbutions, symbol);
        //        List<UnderlyingFundStockDistributionLineItem> ufsditems = null;
        //        List<DealUnderlyingDirect> duds = null;
        //        List<SecurityConversionDetail> secDets = null;
        //        List<DirectDistributionLineItem> ddlineItems = null;
        //        using (PepperContext context = new PepperContext()) {
        //            ufsditems = (from item in context.UnderlyingFundStockDistributionLineItems
        //                         where ufsditemids.Contains(item.UnderlyingFundStockDistributionLineItemID) == true
        //                         select item).ToList();
        //            duds = (from item in context.DealUnderlyingDirects
        //                    where dudids.Contains(item.DealUnderlyingDirectID) == true
        //                    select item).ToList();
        //            secDets = (from item in context.SecurityConversionDetails
        //                       where securityDetIds.Contains(item.SecurityConversionDetailID) == true
        //                       select item).ToList();
        //            ddlineItems = (from item in context.DirectDistributionLineItems
        //                         where ddlineitemids.Contains(item.DirectDistributionLineItemID) == true
        //                         select item).ToList();
        //        }
        //        foreach (var item in ufsditems) {
        //            item.IsActive = false;
        //            item.Save();
        //            Util.WriteNewEntry("UFSD Item de activate id = " + item.UnderlyingFundStockDistributionLineItemID);
        //        }
        //        foreach (var item in ddlineItems) {
        //            item.IsActive = false;
        //            item.Save();
        //            Util.WriteNewEntry("DDLINEITEM Item de activate id = " + item.DirectDistributionLineItemID);
        //        }
        //        foreach (var item in duds) {
        //            item.IsActive = false;
        //            item.Save();
        //            Util.WriteNewEntry("DUD Item de activate id = " + item.DealUnderlyingDirectID);
        //        }
        //        foreach (var item in secDets) {
        //            item.IsActive = false;
        //            item.Save();
        //            Util.WriteNewEntry("Security Conversion Item de activate id = " + item.SecurityConversionDetailID);
        //        }
        //    }
        //}

        //private static void Sales(List<SecuritySale> securitySales, List<SecurityDistribution> securityDistrbutions, string symbol) {
        //    List<SecurityLot> securityLots = null;
        //    foreach (var sale in securitySales) {

        //        int securityLotCount = 0;
        //        using (PepperContext context = new PepperContext()) {
        //            securityLotCount = (from history in context.SecurityLotHistories
        //                                where history.SecurityLotHistoryReason == (int)Pepper.Models.CodeFirst.Enums.SecurityLotHistoryReason.SaleOfSecurity
        //                                && history.SecurityLotHistoryReasonID == sale.SecuritySaleID
        //                                select history.SecurityLotHistoryID).Count();
        //        }
        //        if (securityLotCount == 0) {

        //            IEnumerable<ErrorInfo> errors = ValidationHelper.Validate(sale);
        //            //bool isNew = (sale.SecuritySaleID == 0);
        //            //if (isNew) {
        //            securityLots = sale.GetAvailableShares(sale.SecurityTypeID, sale.SecurityID, sale.FundID, sale.SellDate, sale.DealID);
        //            decimal totalShares = decimal.Round(securityLots.Sum(q => q.NumberOfSharesUnsold), 4);
        //            if (errors == null) {
        //                errors = new List<ErrorInfo>();
        //            }
        //            List<ErrorInfo> errorList = (List<ErrorInfo>)errors;
        //            if (totalShares < sale.LotNumberOfSharesSold) {
        //                errorList.Add(new ErrorInfo { PropertyName = "SellQuantity", ErrorMessage = string.Format("Only {0} shares available", totalShares) });
        //            }
        //            //}
        //            if (errors.Any()) {
        //                //Util.WriteNewEntry("Sale Error ID = " + sale.SecuritySaleID + " Error = " + ValidationHelper.GetErrorInfo(errors));
        //                Util.WriteError("Security Sale id " + sale.SecuritySaleID + "," + symbol);
        //            } else {
        //                Util.WriteNewEntry("Security Sale Shares Exist = " + sale.SecuritySaleID + " No Error ");
        //                sale.SaleSecurityLot();
        //                //if ((sale.DealID ?? 0) == 0) {
        //                //    sale.UpdateDealID();
        //                //}
        //            }
        //        } else {
        //            Util.WriteNewEntry("Already security sale id = " + sale.SecuritySaleID);
        //        }
        //        //sale.Save();
        //        //if (isNew) {
        //        //}
        //    }

        //    foreach (var secDis in securityDistrbutions) {
        //        int securityLotCount = 0;
        //        using (PepperContext context = new PepperContext()) {
        //            securityLotCount = (from history in context.SecurityLotHistories
        //                                where history.SecurityLotHistoryReason == (int)Pepper.Models.CodeFirst.Enums.SecurityLotHistoryReason.SecurityDistribution
        //                                && history.SecurityLotHistoryReasonID == secDis.SecurityDistributionID
        //                                select history.SecurityLotHistoryID).Count();
        //        }
        //        if (securityLotCount == 0) {
        //            IEnumerable<ErrorInfo> errors = ValidationHelper.Validate(secDis);
        //            //bool isNew = (sale.SecuritySaleID == 0);
        //            //if (isNew) {
        //            securityLots = secDis.GetAvailableShares(secDis.SecurityTypeID, secDis.SecurityID, secDis.FundID, secDis.SecurityDistributionDate, secDis.DealID);
        //            decimal totalShares = decimal.Round(securityLots.Sum(q => q.NumberOfSharesUnsold), 2);
        //            if (errors == null) {
        //                errors = new List<ErrorInfo>();
        //            }
        //            List<ErrorInfo> errorList = (List<ErrorInfo>)errors;
        //            if (totalShares < secDis.LotNumberOfSharesSold) {
        //                errorList.Add(new ErrorInfo { PropertyName = "SellQuantity", ErrorMessage = string.Format("Only {0} shares available", totalShares) });
        //            }
        //            //}
        //            if (errors.Any()) {
        //                //Util.WriteNewEntry("Sale Error ID = " + sale.SecuritySaleID + " Error = " + ValidationHelper.GetErrorInfo(errors));
        //                Util.WriteError("Security Distribution Sale id " + secDis.SecurityDistributionID + "," + symbol);
        //            } else {
        //                Util.WriteNewEntry("Security Distribution Sale Shares Exist = " + secDis.SecurityDistributionID + " No Error ");
        //            }
        //            secDis.SaleSecurityLot();
        //            //sale.Save();
        //            //if (isNew) {
        //        } else {
        //            Util.WriteNewEntry("Already security distribution sale id = " + secDis.SecurityDistributionID);
        //        }
        //        //}
        //    }
        //}

		/*
		public static void Import() {
			List<UnderlyingFundStockDistributionLineItem> items = null;
			List<int> ufsdids = new List<int>();
			ufsdids.Add(5948);
			ufsdids.Add(5950);
			UnderlyingFundStockDistribution ufsd = null;
			using (PepperContext context = new PepperContext()) {
				items = (from item in context.UnderlyingFundStockDistributionLineItems
						 where ufsdids.Contains(item.UnderlyingFundStockDistributionLineItemID)
						 select item).ToList();
			}
			foreach (var item in items) {
				using (PepperContext context = new PepperContext()) {
					ufsd = (from sd in context.UnderlyingFundStockDistributions
							where sd.UnderlyingFundStockDistributionID == item.UnderlyingFundStockDistributionID
							select sd).FirstOrDefault();
				}
				if (ufsd != null) {
					ufsd.DistributionDate = Convert.ToDateTime("09/11/2000");
					ufsd.NoticeDate = Convert.ToDateTime("09/11/2000");
					ufsd.Save();
					Util.WriteNewEntry("Update unerlying fund stock distribution = " + ufsd.UnderlyingFundStockDistributionID);
				}
				item.IsActive = true;
				item.Save();
				Util.WriteNewEntry("Update unerlying fund stock distribution line item = " + item.UnderlyingFundStockDistributionLineItemID);
			}
			List<SecuritySale> securitySales;
			List<int> dealIds = new List<int>();
			dealIds.Add(1384);
			List<int> securityIds = new List<int>();
			securityIds.Add(2776);
			List<int> fundIds = new List<int>();
			fundIds.Add(41);
			List<int> brokerIds = new List<int>();
			brokerIds.Add(2);
			List<int> securitySaleIds = new List<int>();
			using (PepperContext context = new PepperContext()) {
				securitySaleIds = (from secdis in context.SecurityDisbursements
								   where secdis.SecurityDisbursementTypeID == (int)Pepper.Models.CodeFirst.Enums.SecurityDisbursementType.SecuritySale
								   select secdis.SecurityDisbursementSourceID).ToList();
				securitySales = (from ss in context.SecuritySales
								 where dealIds.Contains((ss.DealID ?? 0))
								 && securityIds.Contains(ss.SecurityID)
								 && fundIds.Contains(ss.FundID)
									 //&& brokerIds.Contains((ss.BrokerID ?? 0))
								 && securitySaleIds.Contains(ss.SecuritySaleID) == false
								 orderby ss.SellDate
								 select ss).ToList();
			}
			foreach (var sale in securitySales) {
				IEnumerable<ErrorInfo> errors = ValidationHelper.Validate(sale);
				//bool isNew = (sale.SecuritySaleID == 0);
				//if (isNew) {
				List<SecurityLot> securityLots = sale.GetAvailableShares(sale.SecurityTypeID, sale.SecurityID, sale.FundID, sale.SellDate);
				decimal totalShares = decimal.Round(securityLots.Sum(q => q.NumberOfSharesUnsold), 2);
				if (errors == null) {
					errors = new List<ErrorInfo>();
				}
				List<ErrorInfo> errorList = (List<ErrorInfo>)errors;
				if (totalShares < sale.LotNumberOfSharesSold) {
					errorList.Add(new ErrorInfo { PropertyName = "SellQuantity", ErrorMessage = string.Format("Only {0} shares available", totalShares) });
				}
				//}
				if (errors.Any()) {
					//Util.WriteNewEntry("Sale Error ID = " + sale.SecuritySaleID + " Error = " + ValidationHelper.GetErrorInfo(errors));
					Util.WriteNewEntry(sale.SecuritySaleID + ",");
				} else {
					Util.WriteNewEntry("Sale Shares Exist = " + sale.SecuritySaleID + " No Error ");
				}
				//sale.Save();
				//if (isNew) {
				sale.SaleSecurityLot();
				if ((sale.DealID ?? 0) == 0) {
					sale.UpdateDealID();
				}
				//}
			}
		}
		 * */

	}
}





