using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Pepper.Models.CodeFirst;
using System.Data.Objects;
using Pepper.Framework.Validation;
using Pepper.Framework.Extensions;
using Pepper.Framework.Authentication;

namespace PepperExcelImport {
	class ReclassifyUnderlyingFund {

		public static void Import() {
			List<string> underlyingFunds = new List<string>();
			underlyingFunds.Add("Acme Paging");
			underlyingFunds.Add("CLS Associates");
			underlyingFunds.Add("Evergreen Broadcasting");
			underlyingFunds.Add("Net Edge Systems, Inc");
			underlyingFunds.Add("Qstar Technoligies Inc");
			underlyingFunds.Add("Visix Software Inc");
			underlyingFunds.Add("VTC Inc");
			underlyingFunds.Add("Winterbrook Corp Jr. Sub Note");

			foreach (var ufname in underlyingFunds) {
				List<CashDistribution> cashDistributions = new List<CashDistribution>();
				using (PepperContext context = new PepperContext()) {
					cashDistributions = (from cd in context.CashDistributions
										 join uf in context.UnderlyingFunds.EntityFilter() on cd.UnderlyingFundID equals uf.UnderlyingFundID
										 where uf.FundName == ufname
										 && cd.UnderlyingFundCashDistributionID != null
										 select cd).ToList();
				}
				foreach (var cd in cashDistributions) {
					UnderlyingFundCashDistribution underlyingFundCashDistribution = null;
					Issuer issuer = null;
					Equity equity = null;
					string issuerName = ufname;
					if(ufname=="Net Edge Systems, Inc"){
						issuerName = "NetEdge Systems, Inc.";
					}
					if (ufname == "Qstar Technoligies Inc") {
						issuerName = "Qstar Technologies, Inc.";
					}
					if (ufname == "Visix Software Inc") {
						issuerName = "Visix Software, Inc.";
					}
					if (ufname == "VTC Inc") {
						issuerName = "VTC, Inc.";
					}
					if (ufname == "Winterbrook Corp Jr. Sub Note") {
						issuerName = "Winterbrook Corp Jr.";
					}
					using (PepperContext context = new PepperContext()) {
						underlyingFundCashDistribution = (from ufcd in context.UnderlyingFundCashDistributions
														  where ufcd.UnderlyingFundCashDistributionID == cd.UnderlyingFundCashDistributionID
														  select ufcd).FirstOrDefault();
						
						issuer = (from iss in context.Issuers
								  where iss.Name == issuerName
								  select iss).FirstOrDefault();
						equity = (from eq in context.Equities
								  join iss in context.Issuers.EntityFilter() on eq.IssuerID equals iss.IssuerID
								  where iss.Name == issuerName
								  select eq).FirstOrDefault();
					}
					if (issuer == null) {
						Util.WriteError("Issuer is null UFNAME=" + ufname);
					}
					if (equity == null) {
						Util.WriteError("Equity is null UFNAME=" + ufname);
					}
					if (underlyingFundCashDistribution != null && issuer != null && equity != null) {
						UnderlyingDirectDividendDistribution udd = new UnderlyingDirectDividendDistribution {
							Amount = cd.Amount,
							CreatedBy = cd.CreatedBy,
							CreatedDate = cd.CreatedDate,
							LastUpdatedBy = cd.LastUpdatedBy,
							LastUpdatedDate = cd.LastUpdatedDate,
							DistributionDate = cd.DistributionDate,
							FundID = underlyingFundCashDistribution.FundID,
							ReceivedDate = underlyingFundCashDistribution.ReceivedDate,
							SecurityID = equity.EquityID,
							SecurityTypeID = (int)Pepper.Models.CodeFirst.Enums.SecurityType.Equity,
							//UnderlyingFundID = cd.UnderlyingFundID,
							IsPostRecordDateTransaction = false,
						};
						IEnumerable<ErrorInfo> errorInfo = udd.Save();
						if (errorInfo == null) {
							Util.WriteNewEntry("UnderlyingDirectDividendDistribution Save ID=" + udd.UnderlyingDirectDividendDistributionID);
							DividendDistribution dd = new DividendDistribution {
								Amount = cd.Amount,
								CashDistributionTypeID = cd.CashDistributionTypeID,
								ChequeNumber = cd.ChequeNumber,
								CreatedBy = cd.CreatedBy,
								CreatedDate = cd.CreatedDate,
								DealID = cd.DealID,
								DistributionDate = cd.DistributionDate,
								IsAllocatedDistribution = cd.IsAllocatedDistribution,
								IsReconciled = cd.IsReconciled,
								LastUpdatedBy = cd.LastUpdatedBy,
								LastUpdatedDate = cd.LastUpdatedDate,
								PaidON = cd.PaidON,
								SecurityID = udd.SecurityID,
								SecurityTypeID = udd.SecurityTypeID,
								UnderlyingDirectDividendDistributionID = udd.UnderlyingDirectDividendDistributionID,
								ReconciliationMethod = cd.ReconciliationMethod,
							};
							errorInfo = dd.Save();
							if (errorInfo == null) {
								Util.WriteNewEntry("DividendDistribution Save ID=" + dd.DividendDistributionID);
							} else {
								Util.WriteError("DividendDistribution Error=" + ValidationHelper.GetErrorInfo(errorInfo) + " UFNAME=" + ufname);
							}
						} else {
							Util.WriteError("UnderlyingDirectDividendDistribution Error=" + ValidationHelper.GetErrorInfo(errorInfo) + " UFNAME=" + ufname);
						}
					}
				}
			}
		}
	}
}

