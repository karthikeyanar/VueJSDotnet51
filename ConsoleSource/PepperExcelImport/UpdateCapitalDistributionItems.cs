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
	class UpdateCapitalDistributionItem {

		public static void Import() {
			List<CapitalDistribution> capitalDistributions;
			using (PepperContext context = new PepperContext()) {
				capitalDistributions = (from cd in context.CapitalDistributions
										join fund in context.Funds.EntityFilter() on cd.FundID equals fund.FundID
										select cd).ToList();
			}
			DateTime minDate = Convert.ToDateTime("01/01/1900");
			foreach (var distribution in capitalDistributions) {
				 
				// Attempt to create cash distribution.

				//if (distribution.IsManual == false) {
					List<CapitalDistributionLineItem> items = null;

					using (PepperContext context = new PepperContext()) {
						items = context.CapitalDistributionLineItems.Where(q => q.CapitalDistributionID == distribution.CapitalDistributionID).ToList();
					}

					List<InvestorFund> investorFunds = null;

					using (PepperContext context = new PepperContext()) {
						investorFunds = context.InvestorFunds.Where(q => q.FundID == distribution.FundID).ToList();
					}


					foreach (var item in items) {
						// Attempt to create cash distribution of each investor.
						InvestorFund investorFund = investorFunds.Where(q => q.InvestorID == item.InvestorID).FirstOrDefault();
						// Find non managing member total commitment.
						decimal nonManagingMemberTotalCommitment = investorFunds.Where(fund => fund.InvestorTypeID == (int)Pepper.Models.CodeFirst.Enums.InvestorType.NonManaging).Sum(fund => fund.TotalCommitment);
						// Find managing member total commitment.
						decimal managingMemberTotalCommitment = investorFunds.Where(fund => fund.InvestorTypeID == (int)Pepper.Models.CodeFirst.Enums.InvestorType.Managing).Sum(fund => fund.TotalCommitment);
						// Find total commitment.
						decimal totalCommitment = nonManagingMemberTotalCommitment + managingMemberTotalCommitment;

						if (investorFund != null) {

							item.CapitalReturn = decimal.Multiply((distribution.CapitalReturn ?? 0),
																	decimal.Divide(investorFund.TotalCommitment, totalCommitment)
																	);

							item.PreferredReturn = decimal.Multiply((distribution.PreferredReturn ?? 0),
																	decimal.Divide(investorFund.TotalCommitment, totalCommitment)
																	);

							// Non ManagingMember investor type only
							if (investorFund.InvestorTypeID == (int)Pepper.Models.CodeFirst.Enums.InvestorType.NonManaging) {
								item.ReturnManagementFees = decimal.Multiply((distribution.ReturnManagementFees ?? 0),
																			 decimal.Divide(investorFund.TotalCommitment, nonManagingMemberTotalCommitment)
																			);
							}

							item.ReturnFundExpenses = decimal.Multiply((distribution.ReturnFundExpenses ?? 0),
																	decimal.Divide(investorFund.TotalCommitment, totalCommitment)
																	);

							// ManagingMember investor type only
							if (investorFund.InvestorTypeID == (int)Pepper.Models.CodeFirst.Enums.InvestorType.Managing) {
								item.PreferredCatchUp = decimal.Multiply((distribution.PreferredCatchUp ?? 0),
																	decimal.Divide(investorFund.TotalCommitment, managingMemberTotalCommitment)
																	);
								// distribution.PreferredCatchUp;
							}

							// ManagingMember investor type only
							if (investorFund.InvestorTypeID == (int)Pepper.Models.CodeFirst.Enums.InvestorType.Managing) {
								item.Profits = decimal.Multiply((distribution.Profits ?? 0),
																	decimal.Divide(investorFund.TotalCommitment, managingMemberTotalCommitment)
																	);

								//distribution.Profits;
							}

							item.LPProfits = decimal.Multiply((distribution.LPProfits ?? 0),
															decimal.Divide(investorFund.TotalCommitment, totalCommitment)
															);


							// Calculate distribution amount of each investor.
							item.DistributionAmount = (item.CapitalReturn ?? 0)
														+ (item.PreferredReturn ?? 0)
														+ (item.ReturnManagementFees ?? 0)
														+ (item.ReturnFundExpenses ?? 0)
														+ (item.PreferredCatchUp ?? 0)
														+ (item.Profits ?? 0)
														+ (item.LPProfits ?? 0)
														;

							item.Save();

							Util.WriteNewEntry("Capital distribution item updated = " + item.CapitalDistributionLineItemID);
						} else {
							Util.WriteError("Investor fund not exit = " + item.CapitalDistributionLineItemID);
						}
					}
				//} else {
				//	Util.WriteError("Is Manual = " + distribution.IsManual + " ID = " + distribution.CapitalDistributionID);
				//}
			}
		}
	}
}

