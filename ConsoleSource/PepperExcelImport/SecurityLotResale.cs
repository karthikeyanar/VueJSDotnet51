using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Pepper.Models.CodeFirst;
using System.Data.Objects;
using Pepper.Framework.Validation;

namespace PepperExcelImport {
	class SecurityLotResale {

		private static int _SecurityID = 2567;

		public static void Import() {
			List<DealUnderlyingDirect> dealUnderlyingDirects;
			List<UnderlyingFundStockDistributionLineItem> stockItems;
			List<EquitySplit> equitySplits;
			using (PepperContext context = new PepperContext()) {
				dealUnderlyingDirects = context.DealUnderlyingDirects.Where(q => q.SecurityID == _SecurityID).ToList();
				stockItems = context.UnderlyingFundStockDistributionLineItems.Where(q => q.UnderlyingFundStockDistribution.SecurityID == _SecurityID).ToList();
				equitySplits = context.EquitySplits.Where(q => q.EquityID == _SecurityID && (q.SplitFactor ?? 0) > 0).OrderBy(q => q.SplitDate).ToList();
			}
			foreach (var item in dealUnderlyingDirects) {
				item.Save();
				Util.WriteNewEntry("Direct purchase : " + item.DealUnderlyingDirectID);
			}
			foreach (var item in stockItems) {
				item.Save();
				Util.WriteNewEntry("Stock purchase : " + item.UnderlyingFundStockDistributionLineItemID);
			}
			foreach (var item in equitySplits) {
				GoToSale(item.SplitDate);
				item.Save();
			}
			GoToSale(DateTime.Now);
		}

		private static bool CheckSale(int securityReasonID, int id) {
			using (PepperContext context = new PepperContext()) {
				IQueryable<SecurityLotHistory> query = (from history in context.SecurityLotHistories
														where history.SecurityLotHistoryReason == securityReasonID
														&& history.SecurityLotHistoryReasonID == id
														select history);
				return query.Count() > 0;
			}
		}

		private static void GoToSale(DateTime date) {
			List<Sale> sales;
			using (PepperContext context = new PepperContext()) {
				sales = (from ss in context.SecuritySales
						 where ss.SecurityID == _SecurityID
						 && EntityFunctions.TruncateTime(ss.SellDate) < EntityFunctions.TruncateTime(date)
						 select new Sale {
							 ID = ss.SecuritySaleID,
							 Date = ss.SellDate,
							 Type = "SecuritySale"
						 })
				.Union(
					(from sd in context.SecurityDistributions
					 where sd.SecurityID == _SecurityID
					  && EntityFunctions.TruncateTime(sd.SecurityDistributionDate) < EntityFunctions.TruncateTime(date)
					 select new Sale {
						 ID = sd.SecurityDistributionID,
						 Date = sd.SecurityDistributionDate,
						 Type = "SecurityDistribution",
					 })
				)
				.ToList();
			}
			sales = sales.OrderBy(q => q.Date).ToList();
			foreach (var sale in sales) {
				if (sale.Type == "SecuritySale") {
					SecuritySale securitySale = null;
					using (PepperContext context = new PepperContext()) {
						securitySale = context.SecuritySales.Where(q => q.SecuritySaleID == sale.ID).FirstOrDefault();
					}
					if (securitySale != null) {
						if (CheckSale((int)Pepper.Models.CodeFirst.Enums.SecurityLotHistoryReason.SaleOfSecurity, securitySale.SecuritySaleID) == false) {
							securitySale.Save();
							Util.WriteNewEntry("Security sale sale : " + securitySale.SecuritySaleID);
						} else {
							Util.WriteNewEntry("Security sale already sale : " + securitySale.SecuritySaleID);
						}

					}
				} else {
					SecurityDistribution securityDistribution = null;
					using (PepperContext context = new PepperContext()) {
						securityDistribution = context.SecurityDistributions.Where(q => q.SecurityDistributionID == sale.ID).FirstOrDefault();
					}
					if (securityDistribution != null) {
						if (CheckSale((int)Pepper.Models.CodeFirst.Enums.SecurityLotHistoryReason.SecurityDistribution, securityDistribution.SecurityDistributionID) == false) {
							securityDistribution.Save();
							Util.WriteNewEntry("Security distribution sale : " + securityDistribution.SecurityDistributionID);
						} else {
							Util.WriteNewEntry("Security distribution already sale : " + securityDistribution.SecurityDistributionID);
						}
					}
				}
			}
		}

		public class Sale {

			public int ID { get; set; }

			public DateTime Date { get; set; }

			public string Type { get; set; }
		}
	}
}

