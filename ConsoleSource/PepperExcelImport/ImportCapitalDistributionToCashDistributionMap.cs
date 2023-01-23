using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Pepper.Models.CodeFirst;
using System.Data.Objects;
using Pepper.Framework.Validation;

namespace PepperExcelImport {
	class ImportCapitalDistributionToCashDistributionMap {

		public static void Import() {

			Globals.Import_2_10();
			Globals.Import_6_30();
			Globals.Import_1_10();

			int fundID = 0;
			int underlyingFundID = 0;
			int dealID = 0;
			decimal amountDistributed = 0;
			DateTime minDate = Convert.ToDateTime("01/01/1900");
			CashDistribution cashDistribution = null;
			CapitalDistribution capitalDistribution = null;
			int i = 2;
			int logID = 0;
			try {
				foreach (var ufCD in Globals.C1_10tblDistToAmberbrookCash) {
					i++;
					if (ufCD.DistributionID > 0) {
						fundID = (Globals.GetFundID(ufCD.AmberbrookFundNo) ?? 0);
						underlyingFundID = (Globals.GetUnderlyingFundID(ufCD.Fund) ?? 0);
						dealID = (Globals.GetDealID(ufCD.AmberbrookDealNo, fundID) ?? 0);
						amountDistributed = (decimal)ufCD.Proceeds;
						cashDistribution = null;
						capitalDistribution = null;
						logID = 0;
						using (PepperContext context = new PepperContext()) {
							logID = (Globals.GetImportLogID("UnderlyingFundCashDistribution", ufCD.TransactionID.ToString()) ?? 0);
							if (logID > 0) {
								cashDistribution = (from cd in context.CashDistributions
													where cd.CashDistributionID == logID
													select cd).FirstOrDefault();
							} else {
								cashDistribution = (from ufcd in context.UnderlyingFundCashDistributions
													join cd in context.CashDistributions on ufcd.UnderlyingFundCashDistributionID equals cd.UnderlyingFundCashDistributionID
													where ufcd.UnderlyingFundID == underlyingFundID
													&& cd.DealID == dealID
													&& EntityFunctions.Truncate(cd.Amount, 2) == EntityFunctions.Truncate(amountDistributed, 2)
													&& EntityFunctions.TruncateTime(ufcd.NoticeDate) == EntityFunctions.TruncateTime((ufCD.NoticeDate ?? minDate))
													&& EntityFunctions.TruncateTime(ufcd.ReceivedDate) == EntityFunctions.TruncateTime(ufCD.EffectiveDate)
													select cd).FirstOrDefault();
							}
						}
						if (cashDistribution != null) {

							Globals.ImportLog("CashDistribution", cashDistribution.CashDistributionID, ufCD.TransactionID.ToString());

							var blueCapitalDistribution = (from blueCd in Globals.C2_10tblDistFromAmberbrookCash where blueCd.TransactionID == ufCD.DistributionID select blueCd).FirstOrDefault();
							if (blueCapitalDistribution != null) {

								capitalDistribution = null;
								logID = 0;
								using (PepperContext context = new PepperContext()) {
									logID = (Globals.GetImportLogID("CapitalDistribution", ufCD.TransactionID.ToString()) ?? 0);
									if (logID > 0) {
										capitalDistribution = (from cd in context.CapitalDistributions
															   where cd.CapitalDistributionID == logID
															   select cd).FirstOrDefault();
									} else {
										capitalDistribution = (from item in context.CapitalDistributions
															   where item.FundID == fundID
															   && EntityFunctions.TruncateTime(item.CapitalDistributionDate) == EntityFunctions.TruncateTime(blueCapitalDistribution.NoticeDate)
															   && EntityFunctions.TruncateTime(item.CapitalDistributionDueDate) == EntityFunctions.TruncateTime(blueCapitalDistribution.EffectiveDate)
															   && EntityFunctions.Truncate(item.DistributionAmount, 2) == EntityFunctions.Truncate((decimal)blueCapitalDistribution.TotalCashDistribution, 2)
															   select item).FirstOrDefault();
									}
								}
								if (capitalDistribution != null) {
									Globals.ImportLog("CapitalDistribution", capitalDistribution.CapitalDistributionID, blueCapitalDistribution.TransactionID.ToString());
								}
							}
						}
						if (cashDistribution == null) {
							Util.WriteError("ImportCapitalDistributionToCashDistributionMap Cash Distribution Not Exist Row : " + i);
						}
						if (capitalDistribution == null) {
							Util.WriteError("ImportCapitalDistributionToCashDistributionMap Capital Distribution Not Exist Row : " + i);
						}
						if (cashDistribution != null && capitalDistribution != null) {
							CapitalDistributionSourceMapping map = null;
							using (PepperContext context = new PepperContext()) {
								map = context.CapitalDistributionSourceMappings.Where(m => m.CapitalDistributionID == capitalDistribution.CapitalDistributionID
								 && m.CapitalDistributionSourceID == cashDistribution.CashDistributionID
								 && m.CapitalDistributionSourceTypeID == (int)Pepper.Models.CodeFirst.Enums.CapitalDistributionSourceType.CashDistribution
								 ).FirstOrDefault();
							}
							if (map == null) {
								map = new CapitalDistributionSourceMapping {
									CapitalDistributionSourceID = cashDistribution.CashDistributionID
								,
									CapitalDistributionID = capitalDistribution.CapitalDistributionID
								,
									CapitalDistributionSourceTypeID = (int)Pepper.Models.CodeFirst.Enums.CapitalDistributionSourceType.CashDistribution
								};
								map.Save();
								Util.WriteNewEntry("New CashDistributionToCapitalDistributionMappings Row " + i);
							} else {
								Util.WriteError("ImportCapitalDistributionToCashDistributionMap Map already exist : " + map.CapitalDistributionSourceMappingID);
							}
						}
					} else {
						Util.WriteError("ImportCapitalDistributionToCashDistributionMap Distribution ID not exist row : " + i);
					}
				}
			} catch (Exception ex) {
				Util.WriteError("ImportCapitalDistributionToCashDistributionMap Exception Error : " + ex.Message);
			}
		}
	}
}

