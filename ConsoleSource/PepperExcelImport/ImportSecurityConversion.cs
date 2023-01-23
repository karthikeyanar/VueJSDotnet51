using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Pepper.Models.CodeFirst;
using System.Data.Objects;
using Pepper.Framework.Validation;


namespace PepperExcelImport {
	class ImportSecurityConversion {
		public static void Import() {
			try {

				List<SecurityConversionDetail> securiyConvesionDetails = null;
				using (PepperContext context = new PepperContext()) {
					securiyConvesionDetails = context.SecurityConversionDetails.ToList();
				}
				foreach (var secConvDetail in securiyConvesionDetails) {

					SecurityConversion securityConversion = null;
					using (PepperContext context = new PepperContext()) {
						securityConversion = context.SecurityConversions.Where(q => q.SecurityConversionID == secConvDetail.SecurityConversionID).FirstOrDefault();
					}

					if (secConvDetail.OldSecurityConversionTypeID == (int)Pepper.Models.CodeFirst.Enums.SecurityConversionType.DealUnderlyingDirect) {
						DealUnderlyingDirect oldDud = null;
						DealUnderlyingDirect newDud = null;
						using (PepperContext context = new PepperContext()) {
							oldDud = (from item in context.DealUnderlyingDirects
									  where item.DealUnderlyingDirectID == secConvDetail.OldSecurityConversionSourceID
									  select item).FirstOrDefault();

							newDud = (from item in context.DealUnderlyingDirects
									  where item.DealUnderlyingDirectID == secConvDetail.NewSecurityConversionSourceID
									  select item).FirstOrDefault();
						}
						if (oldDud != null) {
							Util.WriteNewEntry("Old Deal Underlying Direct Exist:" + oldDud.DealUnderlyingDirectID);
						} else {
							Util.WriteError("Old Deal Underlying Direct Not Exist:" + secConvDetail.SecurityConversionDetailID);
						}
						if (newDud != null) {
							Util.WriteNewEntry("New Deal Underlying Direct Exist:" + newDud.DealUnderlyingDirectID);
						} else {
							Util.WriteError("New Deal Underlying Direct Not Exist:");
						}
						if (oldDud != null && newDud == null) {
							oldDud.RecordDate = securityConversion.ConversionDate;
							oldDud.SecurityTypeID = securityConversion.NewSecurityTypeID;
							oldDud.SecurityID = securityConversion.NewSecurityID;
							oldDud.IsActive = true;

							oldDud.RecordDate = securityConversion.ConversionDate;

							oldDud.NumberOfShares = secConvDetail.NewNumberOfShares;
							oldDud.PurchasePrice = (secConvDetail.NewPurchasePrice ?? 0);
							oldDud.FMV = secConvDetail.NewFMV;
							oldDud.IsSecurityConversionDetail = true;

							oldDud.DealUnderlyingDirectID = 0;

							oldDud.Save();

							Util.WriteNewEntry("Create new deal underlying direct :" + oldDud.DealUnderlyingDirectID);
							secConvDetail.NewSecurityConversionSourceID = oldDud.DealUnderlyingDirectID;
						}
					} else {
						UnderlyingFundStockDistributionLineItem oldUfsdItem = null;
						UnderlyingFundStockDistribution oldUfsd = null;
						UnderlyingFundStockDistributionLineItem newUfsdItem = null;
						UnderlyingFundStockDistribution newUfsd = null;
						using (PepperContext context = new PepperContext()) {
							oldUfsdItem = (from item in context.UnderlyingFundStockDistributionLineItems
										   where item.UnderlyingFundStockDistributionLineItemID == secConvDetail.OldSecurityConversionSourceID
										   select item).FirstOrDefault();

							if (oldUfsdItem != null) {

								oldUfsd = (from item in context.UnderlyingFundStockDistributions
										   where item.UnderlyingFundStockDistributionID == oldUfsdItem.UnderlyingFundStockDistributionID
										   select item).FirstOrDefault();
							}

							newUfsdItem = (from item in context.UnderlyingFundStockDistributionLineItems
										   where item.UnderlyingFundStockDistributionLineItemID == secConvDetail.NewSecurityConversionSourceID
										   select item).FirstOrDefault();

							if (newUfsdItem != null) {

								newUfsd = (from item in context.UnderlyingFundStockDistributions
										   where item.UnderlyingFundStockDistributionID == newUfsdItem.UnderlyingFundStockDistributionID
										   select item).FirstOrDefault();
							}
						}
						if (oldUfsdItem != null) {
							Util.WriteNewEntry("Old UnderlyingFundStockDistributionLineItems Exist:" + oldUfsdItem.UnderlyingFundStockDistributionLineItemID);
						} else {
							Util.WriteError("Old UnderlyingFundStockDistributionLineItems Not Exist:" + secConvDetail.SecurityConversionDetailID);
						}
						if (newUfsdItem != null) {
							Util.WriteNewEntry("New UnderlyingFundStockDistributionLineItems Exist:" + newUfsdItem.UnderlyingFundStockDistributionLineItemID);
						} else {
							Util.WriteError("New UnderlyingFundStockDistributionLineItems Not Exist:");
						}
						if (oldUfsdItem != null && newUfsdItem == null) {

							oldUfsd.UnderlyingFundStockDistributionID = 0;
							oldUfsd.SecurityTypeID = securityConversion.NewSecurityTypeID;
							oldUfsd.SecurityID = securityConversion.NewSecurityID;
							oldUfsd.DistributionDate = securityConversion.ConversionDate;
							oldUfsd.NoticeDate = securityConversion.ConversionDate;

							oldUfsd.NumberOfShares = secConvDetail.NewNumberOfShares;
							oldUfsd.FMV = secConvDetail.NewFMV;

							oldUfsd.Save();

							Util.WriteNewEntry("New UnderlyingFundStockDistribution :" + oldUfsd.UnderlyingFundStockDistributionID);

							oldUfsdItem.UnderlyingFundStockDistributionID = oldUfsd.UnderlyingFundStockDistributionID;
							oldUfsdItem.UnderlyingFundStockDistributionLineItemID = 0;
							oldUfsdItem.NumberOfShares = secConvDetail.NewNumberOfShares;
							oldUfsdItem.FMV = (oldUfsdItem.NumberOfShares ?? 0) * (secConvDetail.NewPurchasePrice ?? 0);
							oldUfsdItem.IsActive = true;
							oldUfsdItem.IsSecurityConversionDetail = true;

							oldUfsdItem.Save();

							Util.WriteNewEntry("Create new UnderlyingFundStockDistributionLineItems :" + oldUfsdItem.UnderlyingFundStockDistributionLineItemID);

							secConvDetail.NewSecurityConversionSourceID = oldUfsdItem.UnderlyingFundStockDistributionLineItemID;
						}
					}
					secConvDetail.Save();
					Util.WriteNewEntry("SecurityConversion Detail Update :" + secConvDetail.SecurityConversionDetailID);
				}
			} catch (Exception ex) {
				Util.WriteError("SecurityConversion Exception: " + ex.Message);
			}
		}

	}
}

