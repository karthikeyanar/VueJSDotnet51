using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Pepper.Models.CodeFirst;
using System.Data.Objects;
using Pepper.Framework.Validation;

namespace PepperExcelImport {
	class UpdateSecurityConversionChecking {

		public static void Import() {
			List<SecurityConversion> securityConversions;
			using (PepperContext context = new PepperContext()) {
				securityConversions = context.SecurityConversions.ToList();
				DealUnderlyingDirect dud = null;
				UnderlyingFundStockDistributionLineItem ufsditem = null;
				DirectDistributionLineItem dirDisItem = null;
				foreach (var secConv in securityConversions) {
					List<SecurityConversionDetail> securityConvesionDetails = null;
					securityConvesionDetails = context.SecurityConversionDetails.Where(q => q.SecurityConversionID == secConv.SecurityConversionID).ToList();
					foreach (var secDet in securityConvesionDetails) {
						int deleteID = 0;
						Pepper.Models.CodeFirst.Enums.SecurityConversionType oldctype = (Pepper.Models.CodeFirst.Enums.SecurityConversionType)secDet.OldSecurityConversionTypeID;
						Pepper.Models.CodeFirst.Enums.SecurityConversionType newctype = (Pepper.Models.CodeFirst.Enums.SecurityConversionType)secDet.NewSecurityConversionTypeID;

						dud = null;
						ufsditem = null;
						dirDisItem = null;
						switch (oldctype) {
							case Pepper.Models.CodeFirst.Enums.SecurityConversionType.DealUnderlyingDirect:
								dud = context.DealUnderlyingDirects.Where(q => q.DealUnderlyingDirectID == secDet.OldSecurityConversionSourceID).FirstOrDefault();
								if (dud == null) {
									//Util.WriteError("Security Conversion Detail OLD DUD ID = " + secDet.SecurityConversionDetailID);
									Util.WriteError(secDet.SecurityConversionDetailID + ",");
									deleteID = secDet.SecurityConversionDetailID;
								}
								break;
							case Pepper.Models.CodeFirst.Enums.SecurityConversionType.UnderlyingFundStockDistributionLineItem:
								ufsditem = context.UnderlyingFundStockDistributionLineItems.Where(q => q.UnderlyingFundStockDistributionLineItemID == secDet.OldSecurityConversionSourceID).FirstOrDefault();
								if (ufsditem == null) {
									//Util.WriteError("Security Conversion Detail OLD UFSDITEM ID = " + secDet.SecurityConversionDetailID);
									Util.WriteError(secDet.SecurityConversionDetailID + ",");
									deleteID = secDet.SecurityConversionDetailID;
								}
								break;
							case Pepper.Models.CodeFirst.Enums.SecurityConversionType.DirectDistributionLineItem:
								dirDisItem = context.DirectDistributionLineItems.Where(q => q.DirectDistributionLineItemID == secDet.OldSecurityConversionSourceID).FirstOrDefault();
								if (dirDisItem == null) {
									//Util.WriteError("Security Conversion Detail OLD DIRDIS ID = " + secDet.SecurityConversionDetailID);
									Util.WriteError(secDet.SecurityConversionDetailID + ",");
									deleteID = secDet.SecurityConversionDetailID;

								}
								break;
						}
						dud = null;
						ufsditem = null;
						dirDisItem = null;
						switch (newctype) {
							case Pepper.Models.CodeFirst.Enums.SecurityConversionType.DealUnderlyingDirect:
								dud = context.DealUnderlyingDirects.Where(q => q.DealUnderlyingDirectID == secDet.NewSecurityConversionSourceID).FirstOrDefault();
								if (dud == null) {
									//Util.WriteError("Security Conversion Detail NEW DUD ID = " + secDet.SecurityConversionDetailID);
									Util.WriteError(secDet.SecurityConversionDetailID + ",");
									deleteID = secDet.SecurityConversionDetailID;
								}
								break;
							case Pepper.Models.CodeFirst.Enums.SecurityConversionType.UnderlyingFundStockDistributionLineItem:
								ufsditem = context.UnderlyingFundStockDistributionLineItems.Where(q => q.UnderlyingFundStockDistributionLineItemID == secDet.NewSecurityConversionSourceID).FirstOrDefault();
								if (ufsditem == null) {
									//Util.WriteError("Security Conversion Detail NEW UFSDITEM ID = " + secDet.SecurityConversionDetailID);
									Util.WriteError(secDet.SecurityConversionDetailID + ",");
									deleteID = secDet.SecurityConversionDetailID;
								}
								break;
							case Pepper.Models.CodeFirst.Enums.SecurityConversionType.DirectDistributionLineItem:
								dirDisItem = context.DirectDistributionLineItems.Where(q => q.DirectDistributionLineItemID == secDet.NewSecurityConversionSourceID).FirstOrDefault();
								if (dirDisItem == null) {
									//Util.WriteError("Security Conversion Detail NEW DIRDIS ID = " + secDet.SecurityConversionDetailID);
									Util.WriteError(secDet.SecurityConversionDetailID + ",");
									deleteID = secDet.SecurityConversionDetailID;
								}
								break;
						}
						if (deleteID > 0) {
							context.SecurityConversionDetails.Remove(secDet);
						}
						List<SecurityLot> conversionSecurityLots = null;
						conversionSecurityLots = (from lot in context.SecurityLots
												  where lot.SecurityAcquisitionTypeID == (int)Pepper.Models.CodeFirst.Enums.SecurityAcquisitionType.SecurityConversionDetail
												  && lot.SecurityAcquisitionID == deleteID
												  select lot).ToList();
						foreach (var securityLot in conversionSecurityLots) {
							if (securityLot != null) {
								int securityDisbursementID = 0;
								List<SecurityDisbursementLineItem> securityDisbursementLineItems = securityLot.SecurityDisbursementLineItems.ToList();
								foreach (var item in securityDisbursementLineItems) {
									securityDisbursementID = item.SecurityDisbursementID;
									context.SecurityDisbursementLineItems.Remove(item);
								}
								List<SecurityLotHistory> securityLotHistories = securityLot.SecurityLotHistories.ToList();
								foreach (var history in securityLotHistories) {
									context.SecurityLotHistories.Remove(history);
								}
								context.SecurityLots.Remove(securityLot);
								SecurityDisbursement securityDisbursement = context.SecurityDisbursements.Where(s => s.SecurityDisbursementID == securityDisbursementID).FirstOrDefault();
								if (securityDisbursement != null) {
									if (securityDisbursement.SecurityDisbursementLineItems.Count() == 0) {
										context.SecurityDisbursements.Remove(securityDisbursement);
									}
								}
							}
						}
					}
				}
				context.SaveChanges();
				securityConversions = (from secConversion in context.SecurityConversions
										   where secConversion.SecurityConversionDetails.Count() == 0
										   select secConversion).ToList();
				foreach (var secConv in securityConversions) {
					if (secConv.SecurityConversionDetails.Count() == 0) {
						context.SecurityConversions.Remove(secConv);
					}
				}
				context.SaveChanges();
				Util.WriteError("Success");
			}
		}
	}
}

