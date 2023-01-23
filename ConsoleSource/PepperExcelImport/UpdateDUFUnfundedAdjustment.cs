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
	class UpdateDUFUnfundedAdjustment {

		public static void Import() {
			string tableName = "DUF";

			PagingDataTable dt = Globals.GetExcelDataTable(tableName);

			string AMD;
			int dealNo;
			string uffund;
			decimal inCorrect;
			decimal correct;

			DealUnderlyingFund dealUnderlyingFund = null;

			List<int> ignoreIDs = new List<int>();
			int rowNumber = 0;
			foreach (DataRow row in dt.Rows) {
				AMD = DataTypeHelper.ToString(row["AMB"]);
				dealNo = DataTypeHelper.ToInt32(DataTypeHelper.ToString(row["Deal No."]));
				uffund = DataTypeHelper.ToString(row["Fund"]);
				inCorrect = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["Incorrect"]));
				correct = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["Correct"]));

				dealUnderlyingFund = null;
				using (PepperContext context = new PepperContext()) {
					rowNumber++;
					dealUnderlyingFund = (from duf in context.DealUnderlyingFunds
										  join deal in context.Deals.EntityFilter() on duf.DealID equals deal.DealID
										  join fund in context.Funds.EntityFilter() on deal.FundID equals fund.FundID
										  join uf in context.UnderlyingFunds on duf.UnderlyingFundID equals uf.UnderlyingFundID
										  where deal.DealNumber == dealNo
										  && fund.FundName == AMD
										  && uf.FundName == uffund
										  select duf).FirstOrDefault();
				}
				if (dealUnderlyingFund != null) {
					dealUnderlyingFund.UnfundedAmount = correct;
					dealUnderlyingFund.Save();
					ignoreIDs.Add(dealUnderlyingFund.DealUnderlyingFundID);
					Util.WriteNewEntry("Deal Underlying Fund Update Excel=" + dealUnderlyingFund.DealUnderlyingFundID + " Row=" + rowNumber + " AMD=" + AMD + " Fund=" + uffund + " DealNo=" + dealNo);
				} else {
					Util.WriteError("Deal Underlying Fund Not Exist Row=" + rowNumber + " AMD=" + AMD + " Fund=" + uffund + " DealNo=" + dealNo);
				}
			}
		}
	}
}

