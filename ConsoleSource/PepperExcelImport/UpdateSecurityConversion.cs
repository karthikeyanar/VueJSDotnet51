using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Pepper.Models.CodeFirst;
using System.Data.Objects;
using Pepper.Framework.Validation;

namespace PepperExcelImport {
	class UpdateSecurityConversionDetail {

		public static void Import() {
			List<SecurityConversion> securityConversions;
			using (PepperContext context = new PepperContext()) {
				DateTime date = Convert.ToDateTime("2013-06-05 13:20:05.703");
				securityConversions = context.SecurityConversions
				.Where(q => q.SecurityConversionID == 54)
				.ToList();
			}
			foreach (var secConv in securityConversions) {
				List<SecurityConversionDetail> securityConvesionDetails = null;
				using (PepperContext context = new PepperContext()) {
					securityConvesionDetails = context.SecurityConversionDetails.Where(q => q.SecurityConversionID == secConv.SecurityConversionID).ToList();
				}
				foreach (var secDet in securityConvesionDetails) {
					decimal newNumberOfShares = decimal.Round((secDet.OldNumberOfShares ?? 0) * (secConv.SplitFactor ?? 0), 0);
					decimal diff = newNumberOfShares - (secDet.NewNumberOfShares ?? 0);
					if (newNumberOfShares != decimal.Round((secDet.NewNumberOfShares ?? 0), 0)) {
						Util.WriteError("Wrong new number of shares : diff=" +  diff + " ID=" + secConv.SecurityConversionID + " Detail ID=" + secDet.SecurityConversionDetailID);

						secDet.NewNumberOfShares = (secDet.OldNumberOfShares ?? 0) * (secConv.SplitFactor ?? 0);
						secDet.NewPurchasePrice = (secDet.OldFMV ?? 0) / (secDet.NewNumberOfShares ?? 0);
						secDet.NewFMV  = (secDet.NewNumberOfShares ?? 0) * (secDet.NewPurchasePrice ?? 0);

						secDet.Save();
					}
				}
			}
		}

	}
}

