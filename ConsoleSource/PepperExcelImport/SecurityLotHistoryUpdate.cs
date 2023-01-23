using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Pepper.Models.CodeFirst;
using System.Data.Objects;
using Pepper.Framework.Validation;

namespace PepperExcelImport {
	class SecurityLotHistoryUpdate {



		public static void Import() {
			List<SecurityLotHistory> securityLotHistories;
			using (PepperContext context = new PepperContext()) {
				securityLotHistories = context.SecurityLotHistories.ToList();
			}
			SecurityLot securityLot = null;
			decimal splitFactor = 0;
			Pepper.Models.CodeFirst.Enums.SecurityLotHistoryReason reason;
			foreach (var history in securityLotHistories) {
				using (PepperContext context = new PepperContext()) {
					securityLot = context.SecurityLots.Where(q => q.SecurityLotNumber == history.SecurityLotNumber).FirstOrDefault();
				}
				if (securityLot != null) {
					splitFactor = 0;
					SecurityLotHistory lastHistory = null;
					using (PepperContext context = new PepperContext()) {
						lastHistory = (from h in context.SecurityLotHistories
									   where h.SecurityLotNumber == securityLot.SecurityLotNumber
									   && h.SecurityLotHistoryID < history.SecurityLotHistoryID
									   orderby h.SecurityLotHistoryID descending
									   select h).FirstOrDefault();
					}
					if (lastHistory != null) {
						reason = (Pepper.Models.CodeFirst.Enums.SecurityLotHistoryReason)lastHistory.SecurityLotHistoryReason;
						using (PepperContext context = new PepperContext()) {
							switch (reason) {
								case Pepper.Models.CodeFirst.Enums.SecurityLotHistoryReason.SecuritySplit:
									splitFactor = (from es in context.EquitySplits
												   where es.EquiteSplitID == lastHistory.SecurityLotHistoryReasonID
												   select (es.SplitFactor ?? 0)).FirstOrDefault();
									break;
								case Pepper.Models.CodeFirst.Enums.SecurityLotHistoryReason.SecurityConversionDetail:
									splitFactor = (from sc in context.SecurityConversionDetails
												   where sc.SecurityConversionDetailID == lastHistory.SecurityLotHistoryReasonID
												   select (sc.SecurityConversion.SplitFactor ?? 0)).FirstOrDefault();
									break;
							}
						}
						if (splitFactor > 0) {
							lastHistory.SplitFactor = splitFactor;
						} else {
							lastHistory.SplitFactor = null;
						}
						lastHistory.Save();
						Util.WriteNewEntry("Last history save : " + lastHistory.SecurityLotHistoryID);
						history.OldNumberOfSharesUnsold = lastHistory.NumberOfSharesUnsold;
						history.OldSharePrice = lastHistory.SharePrice;
						history.Save();
						Util.WriteNewEntry("History save : " + history.SecurityLotHistoryID);
					} else {
						reason = (Pepper.Models.CodeFirst.Enums.SecurityLotHistoryReason)history.SecurityLotHistoryReason;
						using (PepperContext context = new PepperContext()) {
							switch (reason) {
								case Pepper.Models.CodeFirst.Enums.SecurityLotHistoryReason.SecuritySplit:
									splitFactor = (from es in context.EquitySplits
												   where es.EquiteSplitID == history.SecurityLotHistoryReasonID
												   select (es.SplitFactor ?? 0)).FirstOrDefault();
									break;
								case Pepper.Models.CodeFirst.Enums.SecurityLotHistoryReason.SecurityConversionDetail:
									splitFactor = (from sc in context.SecurityConversionDetails
												   where sc.SecurityConversionDetailID == history.SecurityLotHistoryReasonID
												   select (sc.SecurityConversion.SplitFactor ?? 0)).FirstOrDefault();
									break;
							}
						}
						if (splitFactor > 0) {
							history.SplitFactor = splitFactor;
						} else {
							history.SplitFactor = null;
						}
						history.OldNumberOfSharesUnsold = history.NumberOfSharesUnsold;
						history.OldSharePrice = history.SharePrice;
						history.Save();
						Util.WriteNewEntry("History save : " + history.SecurityLotHistoryID);
					}
				}
			}
		}
	}
}

