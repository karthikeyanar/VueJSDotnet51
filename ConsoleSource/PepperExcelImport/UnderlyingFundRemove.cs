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
	class UnderlyingFundRemove {

		public static void Import() {
			//string tableName = "UnderlyingFund";

			//PagingDataTable dt = Globals.GetExcelDataTable(tableName);

			//string uffundname;

			List<string> underlyingFunds = new List<string>();
            underlyingFunds.Add("CIGNA Mezzanine Partners III, L.P.");

			UnderlyingFund underlyingFund = null;

			int rowNumber = 0;
			foreach (string uffundname in underlyingFunds) {
				//uffundname = DataTypeHelper.ToString(row["UnderlyingFund"]);
				try {
					underlyingFund = null;
					DealUnderlyingFundAdjustment dealUnderlyingFundAdjustment = null;
					using (PepperContext context = new PepperContext()) {
						rowNumber++;
						underlyingFund = (from uf in context.UnderlyingFunds.EntityFilter()
										  where uf.FundName == uffundname
										  select uf).FirstOrDefault();
						if (underlyingFund != null) {
							List<FundExpense> fundExpenses = underlyingFund.FundExpenses.ToList();
							foreach (var fexpense in fundExpenses) {
								fexpense.UnderlyingFundID = null;
								//Util.WriteError("Remove fundExpenses = " + uffundname);
							}
							List<SecurityDistribution> securityDistributions = underlyingFund.SecurityDistributions.ToList();
							foreach (var securityDistribution in securityDistributions) {
								securityDistribution.UnderlyingFundID = null;
								//Util.WriteError("Remove securityDistributions = " + uffundname);
							}
							List<SecuritySale> securitySales = underlyingFund.SecuritySales.ToList();
							foreach (var securitySale in securitySales) {
								securitySale.UnderlyingFundID = null;
								//Util.WriteError("Remove securitySales = " + uffundname);
							}
							List<UnderlyingDirectDividendDistribution> underlyingDirectDividendDistributions = underlyingFund.UnderlyingDirectDividendDistributions.ToList();
							foreach (var underlyingDirectDividendDistribution in underlyingDirectDividendDistributions) {
								underlyingDirectDividendDistribution.UnderlyingFundID = null;
								//Util.WriteError("Remove underlyingDirectDividendDistributions = " + uffundname);
							}
							List<UnderlyingFundContact> underlyingFundContacts = underlyingFund.UnderlyingFundContacts.ToList();
							foreach (var underlyingFundContact in underlyingFundContacts) {
								underlyingFundContact.UnderlyingFundID = null;
								//Util.WriteError("Remove UnderlyingFundContacts = " + uffundname);
							}
							List<DealUnderlyingFund> dealUnderlyingFunds = underlyingFund.DealUnderlyingFunds.ToList();
							foreach (var dealUnderlyingFund in dealUnderlyingFunds) {
								List<DealUnderlyingFundAdjustment> dealUnderlyingFundAdjustments = dealUnderlyingFund.DealUnderlyingFundAdjustments.ToList();
								foreach (var adjustment in dealUnderlyingFundAdjustments) {
									context.DealUnderlyingFundAdjustments.Remove(adjustment);
								}
								context.DealUnderlyingFunds.Remove(dealUnderlyingFund);
								//Util.WriteError("Remove Deal Underlying Fund = " + uffundname);
							}
							List<CashDistribution> cashDistributions = underlyingFund.CashDistributions.ToList();
							foreach (var cashDistribution in cashDistributions) {
								// Delete deal underlying fund adjustment
								dealUnderlyingFundAdjustment = null;
								dealUnderlyingFundAdjustment = (from adj in context.DealUnderlyingFundAdjustments
																where adj.DealUnderlyingFundAdjustmentReasonID == (int)Pepper.Models.CodeFirst.Enums.DealUnderlyingFundAdjustmentReason.NettedDistribution
																&& adj.DealUnderlyingFundAdjustmentReasonSourceID == cashDistribution.CashDistributionID
																select adj).FirstOrDefault();
								if (dealUnderlyingFundAdjustment != null) {
									context.DealUnderlyingFundAdjustments.Remove(dealUnderlyingFundAdjustment);
								}
								context.CashDistributions.Remove(cashDistribution);
								//Util.WriteError("Remove CashDistribution = " + uffundname);
							}
							var underlyingFundCapitalCalls = underlyingFund.UnderlyingFundCapitalCalls.ToList();
							foreach (var underlyingFundCapitalCall in underlyingFundCapitalCalls) {
								var underlyingFundCapitalCallLineItems = underlyingFundCapitalCall.UnderlyingFundCapitalCallLineItems.ToList();
								foreach (var capitalCallLineItem in underlyingFundCapitalCallLineItems) {
									dealUnderlyingFundAdjustment = null;
									dealUnderlyingFundAdjustment = (from adj in context.DealUnderlyingFundAdjustments
																	where adj.DealUnderlyingFundAdjustmentReasonID == (int)Pepper.Models.CodeFirst.Enums.DealUnderlyingFundAdjustmentReason.CapitalCall
																	&& adj.DealUnderlyingFundAdjustmentReasonSourceID == capitalCallLineItem.UnderlyingFundCapitalCallLineItemID
																	select adj).FirstOrDefault();
									if (dealUnderlyingFundAdjustment != null) {
										context.DealUnderlyingFundAdjustments.Remove(dealUnderlyingFundAdjustment);
									}
									context.UnderlyingFundCapitalCallLineItems.Remove(capitalCallLineItem);
								}
								//Util.WriteError("Remove Deal UnderlyingFundCapitalCalls = " + uffundname);
								context.UnderlyingFundCapitalCalls.Remove(underlyingFundCapitalCall);
							}
							var underlyingFundCashDistributions = underlyingFund.UnderlyingFundCashDistributions.ToList();
							foreach (var underlyingFundCashDistribution in underlyingFundCashDistributions) {
								if (underlyingFundCashDistribution != null) {
									cashDistributions = underlyingFundCashDistribution.CashDistributions.ToList();
									foreach (var cashDistribution in cashDistributions) {
										// Delete deal underlying fund adjustment
										dealUnderlyingFundAdjustment = null;
										dealUnderlyingFundAdjustment = (from adj in context.DealUnderlyingFundAdjustments
																		where adj.DealUnderlyingFundAdjustmentReasonID == (int)Pepper.Models.CodeFirst.Enums.DealUnderlyingFundAdjustmentReason.NettedDistribution
																		&& adj.DealUnderlyingFundAdjustmentReasonSourceID == cashDistribution.CashDistributionID
																		select adj).FirstOrDefault();
										if (dealUnderlyingFundAdjustment != null) {
											context.DealUnderlyingFundAdjustments.Remove(dealUnderlyingFundAdjustment);
										}
										context.CashDistributions.Remove(cashDistribution);
									}
									//Util.WriteError("Remove Deal UnderlyingFundCashDistributions = " + uffundname);
									context.UnderlyingFundCashDistributions.Remove(underlyingFundCashDistribution);
								}
							}
							var underlyingFundDocuments = underlyingFund.UnderlyingFundDocuments.ToList();
							foreach (var underlyingFundDocument in underlyingFundDocuments) {
								Pepper.Models.CodeFirst.File documentfile = context.Files.EntityFilter().Where(file => file.FileID == underlyingFundDocument.FileID).FirstOrDefault();
								if (documentfile != null) {
									context.Files.Remove(documentfile);
								}
								context.UnderlyingFundDocuments.Remove(underlyingFundDocument);
								//Util.WriteError("Remove underlyingFundDocuments = " + uffundname);
							}
							var underlyingFundNAVs = underlyingFund.UnderlyingFundNAVs.ToList();
							foreach (var underlyingFundNAV in underlyingFundNAVs) {
								List<UnderlyingFundNAVHistory> underlyingFundNAVHistories = underlyingFundNAV.UnderlyingFundNAVHistories.ToList();
								foreach (var navHistory in underlyingFundNAVHistories) {
									context.UnderlyingFundNAVHistories.Remove(navHistory);
								}
								context.UnderlyingFundNAVs.Remove(underlyingFundNAV);
								//Util.WriteError("Remove UnderlyingFundNAVs = " + uffundname);
							}
							var underlyingFundStockDistributions = underlyingFund.UnderlyingFundStockDistributions.ToList();
							foreach (var ufsd in underlyingFundStockDistributions) {
								var underlyingFundStockDistributionLineItems = ufsd.UnderlyingFundStockDistributionLineItems.ToList();
								foreach (var underlyingFundStockDistributionLineItem in underlyingFundStockDistributionLineItems) {
									var securityConversionDetails = (from secConversionDetail in context.SecurityConversionDetails
																	 where (
																	 (secConversionDetail.NewSecurityConversionTypeID == (int)Pepper.Models.CodeFirst.Enums.SecurityConversionType.UnderlyingFundStockDistributionLineItem
																		 && secConversionDetail.NewSecurityConversionSourceID == underlyingFundStockDistributionLineItem.UnderlyingFundStockDistributionLineItemID
																	 ) ||
																	 (secConversionDetail.OldSecurityConversionTypeID == (int)Pepper.Models.CodeFirst.Enums.SecurityConversionType.UnderlyingFundStockDistributionLineItem
																		 && secConversionDetail.OldSecurityConversionSourceID == underlyingFundStockDistributionLineItem.UnderlyingFundStockDistributionLineItemID
																	 ))
																	 select secConversionDetail).ToList();
									foreach (var detail in securityConversionDetails) {
										var conversionSecurityLots = (from lot in context.SecurityLots
																	  where lot.SecurityAcquisitionTypeID == (int)Pepper.Models.CodeFirst.Enums.SecurityAcquisitionType.SecurityConversionDetail
																	  && lot.SecurityAcquisitionID == detail.SecurityConversionDetailID
																	  select lot).ToList();

										foreach (var securityLot in conversionSecurityLots) {
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
										context.SecurityConversionDetails.Remove(detail);
									}
									var securityLots = (from lot in context.SecurityLots
														where lot.SecurityAcquisitionTypeID == (int)Pepper.Models.CodeFirst.Enums.SecurityAcquisitionType.UnderlyingFundStockDistributionLineItem
														&& lot.SecurityAcquisitionID == underlyingFundStockDistributionLineItem.UnderlyingFundStockDistributionLineItemID
														select lot).ToList();
									foreach (var securityLot in securityLots) {
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
									context.UnderlyingFundStockDistributionLineItems.Remove(underlyingFundStockDistributionLineItem);
								}
								context.UnderlyingFundStockDistributions.Remove(ufsd);
								//Util.WriteError("Remove UnderlyingFundStockDistributions = " + uffundname);
							}
							context.UnderlyingFunds.Remove(underlyingFund);
							context.SaveChanges();
							Util.WriteNewEntry("UnderlyingFundRemove=" + uffundname);
						}
					}
				} catch (Exception ex) {
					Util.WriteError("UnderlyingFundRemove=" + uffundname + " Exception=" + ex.Message + (ex.InnerException != null ? ex.InnerException.InnerException.Message : ""));
				}
			}
		}
	}
}

