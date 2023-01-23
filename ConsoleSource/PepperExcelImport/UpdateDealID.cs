using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Pepper.Models.CodeFirst;
using System.Data.Objects;
using Pepper.Framework.Validation;

namespace PepperExcelImport {
	class UpdateDealID {

		public static void Import() {
			List<UnderlyingFundNAV> navs;
			DateTime dt = Convert.ToDateTime("09/10/2013");
			using (PepperContext context = new PepperContext()) {
				navs = context.UnderlyingFundNAVs.Where(q => EntityFunctions.TruncateTime(q.CreatedDate) == dt).ToList();
			}
			foreach (var nav in navs) {
				List<DealUnderlyingFund> dufs = null;
				using (PepperContext context = new PepperContext()) {
					dufs = context.DealUnderlyingFunds.Where(q => q.UnderlyingFundID == nav.UnderlyingFundID && q.Deal.FundID == nav.FundID).ToList();
				}
				foreach (var duf in dufs) {
					UnderlyingFundNAV newNAV = new UnderlyingFundNAV {
						CreatedBy = Globals.CurrentUser.UserID,
						CreatedDate = DateTime.Now,
						DealID = duf.DealID,
						UpdateDate = nav.UpdateDate,
						FundID = nav.FundID,
						FundNAV = nav.FundNAV,
						FundNAVDate = nav.FundNAVDate,
						Status = nav.Status,
						UnderlyingFundID = nav.UnderlyingFundID,
					};
					newNAV.Save();
					Util.WriteNewEntry("New Underlying Fund NAV : " + newNAV.UnderlyingFundNAVID);
				}
				using (PepperContext context = new PepperContext()) {
					UnderlyingFundNAV underlyingFundNAV = context.UnderlyingFundNAVs.Where(fundNAV => fundNAV.UnderlyingFundNAVID == nav.UnderlyingFundNAVID).FirstOrDefault();
					int underlyingFundId = 0;
					if (underlyingFundNAV != null) {
						underlyingFundId = underlyingFundNAV.UnderlyingFundID;
						List<UnderlyingFundNAVHistory> underlyingFundNAVHistories = underlyingFundNAV.UnderlyingFundNAVHistories.ToList();
						foreach (var navHistory in underlyingFundNAVHistories) {
							context.UnderlyingFundNAVHistories.Remove(navHistory);
						}
						context.UnderlyingFundNAVs.Remove(underlyingFundNAV);
						context.SaveChanges();
						Util.WriteError("Delete Underlying Fund NAV : " + nav.UnderlyingFundNAVID);
					}
				}
			}
		}

	}
}

