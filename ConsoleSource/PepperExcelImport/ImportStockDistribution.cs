using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Pepper.Models.CodeFirst;
using System.Data.Objects;
using Pepper.Framework.Validation;

namespace PepperExcelImport {
	class ImportStockDistribution {

		public static void Import() {

			string tableName = "1-15Delta";
			PagingDataTable dt = Globals.GetExcelDataTable(tableName);

			int transactionID;
			DateTime noticeDate;
			string fundNo;
			int dealNo;
			string underlyingFundName;
			DateTime effectiveDate;
			decimal amountDistributed;
			string stockName;
			string symbol;
			decimal numberOfShares;
			decimal multiple;
			decimal numberOfSharesA;
			decimal perShareCostBasis;
			DateTime purchaseDate;
			string broker;
			bool isUnusedCapital;
			bool isReceived;
			string notes;

			int fundID;
			int underlyingFundID;
			int dealID;
			int brokerID;
			int securityID;
			int securityTypeID = (int)Pepper.Models.CodeFirst.Enums.SecurityType.Equity;
			DateTime minDate = Convert.ToDateTime("01/01/1900");
			UnderlyingFundStockDistribution underlyingFundStockDistribution = null;
			UnderlyingFundStockDistributionLineItem underlyingFundStockDistributionLineItem = null;

			foreach (DataRow row in dt.Rows) {
				transactionID = DataTypeHelper.ToInt32(DataTypeHelper.ToString(row["ID"]));
				noticeDate = DataTypeHelper.ToFromOADate(DataTypeHelper.ToString(row["Notice Date"]));
				fundNo = DataTypeHelper.ToString(row["AMB #"]);
				dealNo = DataTypeHelper.ToInt32(DataTypeHelper.ToString(row["Deal Number"]));
				underlyingFundName = DataTypeHelper.ToString(row["Fund"]);
				effectiveDate = DataTypeHelper.ToFromOADate(DataTypeHelper.ToString(row["Effective Date"]));
				amountDistributed = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["Amount Distributed"]));
				stockName = DataTypeHelper.ToString(row["Stock Name"]);
				symbol = DataTypeHelper.ToString(row["Stock Symbol or Series"]);
				numberOfShares = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["Number of Shares Received"]));
				multiple = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["Multiple"]));
				numberOfSharesA = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["NumberofSharesA"]));
				perShareCostBasis = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["Per Share Cost Basis"]));
				purchaseDate = DataTypeHelper.ToFromOADate(DataTypeHelper.ToString(row["Purchase Date"]));
				broker = DataTypeHelper.ToString(row["Broker"]);
				isUnusedCapital = DataTypeHelper.CheckBoolean(DataTypeHelper.ToString(row["UnusedCapital"]));
				isReceived = DataTypeHelper.CheckBoolean(DataTypeHelper.ToString(row["Confrim Received?"]));
				notes = DataTypeHelper.ToString(row["Notes"]);
				if (notes == "0") { notes = ""; }

				fundID = (Globals.GetFundID(fundNo) ?? 0);
				underlyingFundID = (Globals.GetUnderlyingFundID(underlyingFundName) ?? 0);
				dealID = (Globals.GetDealID(dealNo, fundID) ?? 0);
				brokerID = (Globals.GetBrokerID(broker) ?? 0);
				securityID = (Globals.GetSecurityID(symbol) ?? 0);

				underlyingFundStockDistribution = null;
				underlyingFundStockDistributionLineItem = null;
				using (PepperContext context = new PepperContext()) {
					underlyingFundStockDistribution = (from ufsd in context.UnderlyingFundStockDistributions
													   join item in context.UnderlyingFundStockDistributionLineItems on ufsd.UnderlyingFundStockDistributionID equals item.UnderlyingFundStockDistributionID
													   join fund in context.Funds on ufsd.FundID equals fund.FundID
													   where ufsd.FundID == fundID
													   && item.DealID == dealID
													   && ufsd.UnderlyingFundID == underlyingFundID
													   && ufsd.SecurityID == securityID
													   && ufsd.SecurityTypeID == securityTypeID
													   && EntityFunctions.Truncate((ufsd.NumberOfShares ?? 0), 2) == EntityFunctions.Truncate(numberOfShares, 2)
														&& EntityFunctions.Truncate((ufsd.FMV ?? 0), 2) == EntityFunctions.Truncate(amountDistributed, 2)
													   && EntityFunctions.TruncateTime((ufsd.NoticeDate ?? minDate)) == EntityFunctions.TruncateTime(noticeDate)
													   && EntityFunctions.TruncateTime((ufsd.DistributionDate ?? minDate)) == EntityFunctions.TruncateTime(effectiveDate)
													   //&& EntityFunctions.TruncateTime((ufsd.TaxCostDate ?? minDate)) == EntityFunctions.TruncateTime(purchaseDate)
													   select ufsd).FirstOrDefault();
					if (underlyingFundStockDistribution != null) {
						underlyingFundStockDistributionLineItem = (from item in context.UnderlyingFundStockDistributionLineItems
																   where item.UnderlyingFundStockDistributionID == underlyingFundStockDistribution.UnderlyingFundStockDistributionID
																   select item).FirstOrDefault();
					}
				}

				if (underlyingFundStockDistribution != null) {
					Util.WriteError("UnderlyingFundStockDistribution already exist: TransactionID : " + transactionID + " UFSD ID : " + underlyingFundStockDistribution.UnderlyingFundStockDistributionID);
				} else {
					Util.WriteNewEntry("UnderlyingFundStockDistribution does not exist:" + transactionID);
					underlyingFundStockDistribution = new UnderlyingFundStockDistribution {
						CreatedBy = Globals.CurrentUser.UserID,
						CreatedDate = DateTime.Now,
					};
					underlyingFundStockDistributionLineItem = new UnderlyingFundStockDistributionLineItem {
						CreatedBy = Globals.CurrentUser.UserID,
						CreatedDate = DateTime.Now
					};
					underlyingFundStockDistributionLineItem.IsActive = true;
					underlyingFundStockDistributionLineItem.IsSecurityConversionDetail = false;
				}
				if (brokerID > 0)
					underlyingFundStockDistribution.BrokerID = brokerID;

				underlyingFundStockDistribution.DistributionDate = effectiveDate;
				underlyingFundStockDistribution.FMV = amountDistributed;
				underlyingFundStockDistribution.FundID = fundID;
				underlyingFundStockDistribution.IsReceived = isReceived;
				underlyingFundStockDistribution.LastUpdatedBy = Globals.CurrentUser.UserID;
				underlyingFundStockDistribution.LastUpdatedDate = DateTime.Now;
				underlyingFundStockDistribution.Multiple = multiple;
				underlyingFundStockDistribution.Notes = notes;
				underlyingFundStockDistribution.NoticeDate = noticeDate;
				underlyingFundStockDistribution.NumberOfShares = numberOfShares;
				underlyingFundStockDistribution.NumberOfSharesA = numberOfSharesA;
				underlyingFundStockDistribution.PurchasePrice = amountDistributed / numberOfShares;
				underlyingFundStockDistribution.SecurityID = securityID;
				underlyingFundStockDistribution.SecurityTypeID = securityTypeID;
				underlyingFundStockDistribution.TaxCostBase = perShareCostBasis;
				underlyingFundStockDistribution.TaxCostDate = purchaseDate;
				underlyingFundStockDistribution.UnderlyingFundID = underlyingFundID;
				IEnumerable<ErrorInfo> errorInfo = underlyingFundStockDistribution.Save();
				if (errorInfo != null) {
					Util.WriteError("UnderlyingFundStockDistribution Save Error:" + ValidationHelper.GetErrorInfo(errorInfo));
				} else {
					Util.WriteNewEntry("UnderlyingFundStockDistribution Updated TransactionID : " + transactionID + " ID: " + underlyingFundStockDistribution.UnderlyingFundStockDistributionID);
					underlyingFundStockDistributionLineItem.DealID = dealID;
					underlyingFundStockDistributionLineItem.FMV = amountDistributed;

					underlyingFundStockDistributionLineItem.LastUpdatedBy = Globals.CurrentUser.UserID;
					underlyingFundStockDistributionLineItem.LastUpdatedDate = DateTime.Now;
					underlyingFundStockDistributionLineItem.NumberOfShares = numberOfShares;
					underlyingFundStockDistributionLineItem.UnderlyingFundID = underlyingFundID;
					underlyingFundStockDistributionLineItem.UnderlyingFundStockDistributionID = underlyingFundStockDistribution.UnderlyingFundStockDistributionID;
					underlyingFundStockDistributionLineItem.UnusedCapital = isUnusedCapital;
					errorInfo = underlyingFundStockDistributionLineItem.Save();
					if (errorInfo != null)
						Util.WriteError("UnderlyingFundStockDistribution Save Error:" + ValidationHelper.GetErrorInfo(errorInfo));
					else
						Util.WriteNewEntry("UnderlyingFundStockDistributionLineItem Updated TransactionID : " + transactionID + " ID: " + underlyingFundStockDistributionLineItem.UnderlyingFundStockDistributionLineItemID);
				}
			}
		}
	}
}
