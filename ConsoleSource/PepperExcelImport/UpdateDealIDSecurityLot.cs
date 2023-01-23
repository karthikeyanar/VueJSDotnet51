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
	class UpdateDealIDSecurityLot {

	public static void Import() {
        //List<SecuritySale> securitySales = null;
        //List<SecurityDistribution> securityDistributions = null;
        //List<UnderlyingFundStockDistributionLineItem> ufsdItems = null;
        //using (PepperContext context = new PepperContext()) {
        //    securitySales = (from ss in context.SecuritySales
        //                             join deal in context.Deals.EntityFilter() on ss.DealID equals deal.DealID
        //                             select ss).ToList();

        //    securityDistributions = (from ss in context.SecurityDistributions
        //                             join deal in context.Deals.EntityFilter() on ss.DealID equals deal.DealID
        //                             select ss).ToList();

        //    ufsdItems = (from ss in context.UnderlyingFundStockDistributionLineItems
        //                join deal in context.Deals.EntityFilter() on ss.DealID equals deal.DealID
        //                select ss).ToList();

        //    foreach (var dud in securitySales) {
        //        dud.LastUpdatedDate = DateTime.Now;
        //        Util.WriteNewEntry("SecuritySale update =" + dud.SecuritySaleID);
        //    }

        //    foreach (var dud in securityDistributions) {
        //        dud.LastUpdatedDate = DateTime.Now;
        //        Util.WriteNewEntry("securityDistributions update =" + dud.SecurityDistributionID);
        //    }

        //    foreach (var dud in ufsdItems) {
        //        dud.LastUpdatedDate = DateTime.Now;
        //        Util.WriteNewEntry("UnderlyingFundStockDistributionLineItem update =" + dud.UnderlyingFundStockDistributionLineItemID);
        //    }

        //    context.SaveChanges();

        //    //ufsdItems = (from ss in context.UnderlyingFundStockDistributionLineItems
        //    //            join deal in context.Deals.EntityFilter() on ss.DealID equals deal.DealID
        //    //            select ss).ToList();

        //    //foreach (var dud in ufsdItems) {
        //    //    dud.LastUpdatedDate = DateTime.Now;
        //    //    context.SaveChanges();
        //    //    Util.WriteNewEntry("UnderlyingFundStockDistributionLineItem update =" + dud.UnderlyingFundStockDistributionLineItemID);
        //    //}
        //}

	}

		/*
		public static void Import() {
			List<SecuritySale> securitySales = null;
			List<SecurityDistribution> securityDistribution = null;
			List<SecurityLot> securityLots = null;
			List<SecurityLotHistory> securityLotHistories = null;
			List<SecurityConversionDetail> securityConversionDetails = null;
			List<CashDistribution> stndistributions = null;
			using (PepperContext context = new PepperContext()) {

				securitySales = (from ss in context.SecuritySales
								 join fund in context.Funds.EntityFilter() on ss.FundID equals fund.FundID
								 where ss.DealID == null
								 select ss).ToList();

				securityDistribution = (from ss in context.SecurityDistributions
										join fund in context.Funds.EntityFilter() on ss.FundID equals fund.FundID
										where ss.DealID == null
										select ss).ToList();

				securityLots = (from ss in context.SecurityLots
								join fund in context.Funds.EntityFilter() on ss.FundID equals fund.FundID
								//where ss.DealID == null
								select ss).ToList();

				securityLotHistories = (from his in context.SecurityLotHistories
										join lot in context.SecurityLots on his.SecurityLotNumber equals lot.SecurityLotNumber
										join fund in context.Funds.EntityFilter() on lot.FundID equals fund.FundID
										where his.DealID == null
										select his).ToList();

				securityConversionDetails = (from det in context.SecurityConversionDetails
											 join conv in context.SecurityConversions on det.SecurityConversionID equals conv.SecurityConversionID
											 where det.DealID == null
											 select det).ToList();
				stndistributions = (from stnd in context.CashDistributions
									join deal in context.Deals.EntityFilter() on stnd.DealID equals deal.DealID
									where stnd.CashDistributionTypeID == (int)Pepper.Models.CodeFirst.Enums.CashDistributionType.ShortTermNettedDistribution
									select stnd).ToList();
				foreach (var ss in stndistributions) {
					ss.LastUpdatedDate = DateTime.Now;
					Util.WriteNewEntry("Update stndistributions =" + ss.CashDistributionID);
				}
				context.SaveChanges();
			}

			foreach (var ss in securitySales) {
				ss.UpdateDealID(ss.SecuritySaleID);
				Util.WriteNewEntry("Update security sale deal=" + ss.SecuritySaleID);
			}
			foreach (var ss in securityDistribution) {
				ss.UpdateDealID(ss.SecurityDistributionID);
				Util.WriteNewEntry("Update SecurityDistribution deal=" + ss.SecurityDistributionID);
			}
			foreach (var ss in securityConversionDetails) {
				ss.UpdateDealID(ss.SecurityConversionDetailID);
				Util.WriteNewEntry("Update SecurityConversionDetail deal=" + ss.SecurityConversionDetailID);
			}
			foreach (var ss in securityLots) {
				//ss.UpdateDealID(ss.SecurityLotNumber);
				ss.Save();
				Util.WriteNewEntry("Update SecurityLot deal=" + ss.SecurityLotNumber);
			}
			foreach (var ss in securityLotHistories) {
				ss.UpdateDealID(ss.SecurityLotHistoryID);
				Util.WriteNewEntry("Update SecurityLotHistory deal=" + ss.SecurityLotHistoryID);
			}
		}
		 */
	}
}

