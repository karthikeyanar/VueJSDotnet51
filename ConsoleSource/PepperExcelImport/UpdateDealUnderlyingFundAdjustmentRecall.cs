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
	class UpdateDealUnderlyingFundAdjustmentRecall {

		public static void Import() {
			List<DealUnderlyingFundAdjustment> dufAdjustments = null;
			using (PepperContext context = new PepperContext()) {
				dufAdjustments = (from item in context.DealUnderlyingFundAdjustments
								  join duf in context.DealUnderlyingFunds on item.DealUnderlyingFundID equals duf.DealUnderlyingFundID
								  join deal in context.Deals.EntityFilter() on duf.DealID equals deal.DealID
								  where item.DealUnderlyingFundAdjustmentReasonID == (int)Pepper.Models.CodeFirst.Enums.DealUnderlyingFundAdjustmentReason.Purchase
								  orderby item.DealUnderlyingFundAdjustmentID
								  select item).ToList();
			}
			int total = 0;
			int index = 0;
			total = dufAdjustments.Count();
			foreach (var item in dufAdjustments) {
				index++;
				item.Save();
				Util.WriteNewEntry("Adjustment Update: " + item.DealUnderlyingFundAdjustmentID + " Total=" + total + " Row=" + index);
			}
		}
	}
}

