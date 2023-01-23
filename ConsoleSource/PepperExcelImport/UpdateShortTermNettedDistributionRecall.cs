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
	class UpdateShortTermNettedDistributionRecall {

		public static void Import() {
			//List<CashDistribution> cashDistributions = null;
			//using (PepperContext context = new PepperContext()) {
			//    cashDistributions = (from item in context.CashDistributions
			//                         join ufcd in context.UnderlyingFundCashDistributions on item.UnderlyingFundCashDistributionID equals ufcd.UnderlyingFundCashDistributionID
			//                         join deal in context.Deals.EntityFilter() on item.DealID equals deal.DealID
			//                         where item.CashDistributionTypeID == (int)Pepper.Models.CodeFirst.Enums.CashDistributionType.ShortTermNettedDistribution
			//                         && item.UnderlyingFundCashDistributionID != null
			//                         orderby item.CashDistributionTypeID
			//                         select item).ToList();
			//}
			int total = 0;
			int index = 0;
			//total = cashDistributions.Count();
			//foreach (var item in cashDistributions) {
			//    index++;
			//    item.Save();
			//    Util.WriteNewEntry("CashDistribution Update: " + item.CashDistributionID + " Total=" + total + " Row=" + index);
			//}

			List<DividendDistribution> dividendDistributions = null;
			using (PepperContext context = new PepperContext()) {
				dividendDistributions = (from item in context.DividendDistributions
										 join ufcd in context.UnderlyingDirectDividendDistributions on item.UnderlyingDirectDividendDistributionID equals ufcd.UnderlyingDirectDividendDistributionID
										 join deal in context.Deals.EntityFilter() on item.DealID equals deal.DealID
										 where  item.UnderlyingDirectDividendDistributionID != null
										 orderby item.CashDistributionTypeID
										 select item).ToList();
			}
			total = 0;
			index = 0;
			total = dividendDistributions.Count();
			foreach (var item in dividendDistributions) {
				index++;
				item.Save();
				Util.WriteNewEntry("DividendDistribution Update: " + item.DividendDistributionID + " Total=" + total + " Row=" + index);
			}
		}
	}
}

