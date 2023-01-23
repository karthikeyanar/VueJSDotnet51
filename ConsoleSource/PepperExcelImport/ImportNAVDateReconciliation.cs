using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Pepper.Models.CodeFirst;
using System.Data.Objects;
using Pepper.Framework.Validation;


namespace PepperExcelImport {
	class ImportNAVDateReconciliation {

		public static void Import() {
			UnderlyingFundNAV nav = null;

			IEnumerable<ErrorInfo> errorInfo = null;
			int i = 1;

			string tableName = "NAVDateReconciliation";

			PagingDataTable dt = Globals.GetExcelDataTable(tableName);

			int? fundID = 0;
			int? dealID = 0;
			int underlyingFundID;
			DateTime minDate = Convert.ToDateTime("01/01/1900");

			string fund;
			string investment;
			int dealNumber;
			string deal;
			decimal fundNAV;
			DateTime oldFundNAVDate;
			DateTime correctFundNAVDate;
			DateTime oldEffectiveDate;
			DateTime correctEffectiveDate;


			foreach (DataRow row in dt.Rows) {
				fund = row.GetValue("Fund");
				investment = row.GetValue("Investment");
				dealNumber = DataTypeHelper.ToInt32(row.GetValue("DealNumber"));
				deal = row.GetValue("Deal");
				fundNAV = DataTypeHelper.ToDecimal(row.GetValue("FundNAV"));
				oldFundNAVDate = DataTypeHelper.ToFromOADate(row.GetValue("OldFundNAVDate"));
				correctFundNAVDate = DataTypeHelper.ToFromOADate(row.GetValue("CorrectFundNAVDate"));
				oldEffectiveDate = DataTypeHelper.ToFromOADate(row.GetValue("OldEffectiveDate"));
				correctEffectiveDate = DataTypeHelper.ToFromOADate(row.GetValue("CorrectEffectiveDate"));


				fundID = Globals.GetPepperFundID(fund);
				dealID = Globals.GetDealID(dealNumber, (fundID ?? 0));
				underlyingFundID = (Globals.GetUnderlyingFundID(investment) ?? 0);


				i++;
				using (PepperContext pepperContext = new PepperContext()) {
					nav = (from q in pepperContext.UnderlyingFundNAVs
						   where q.FundID == fundID
						   && q.DealID == dealID
						   && q.UnderlyingFundID == underlyingFundID
						   && EntityFunctions.Truncate(q.FundNAV, 0) == EntityFunctions.Truncate(fundNAV, 0)
						   && EntityFunctions.TruncateTime((q.UpdateDate ?? minDate)) == EntityFunctions.TruncateTime(oldEffectiveDate)
						   && EntityFunctions.TruncateTime(q.FundNAVDate) == EntityFunctions.TruncateTime(oldFundNAVDate)
						   select q).FirstOrDefault();
				}
				if (nav == null) {
					Util.WriteError("ImportNAVDateReconciliation row : " + i + " UnderlyingFundNAV does not exist");
				} else {
					//nav.DealID = (dealID ?? 0);
					//nav.FundID = (fundID ?? 0);
					//nav.UnderlyingFundID = underlyingFundID;
					//nav.FundNAV = fundNAV;
					nav.FundNAVDate = correctFundNAVDate;
					nav.UpdateDate = correctEffectiveDate;
					nav.LastUpdatedBy = Globals.CurrentUser.UserID;
					nav.LastUpdatedDate = DateTime.Now;
					errorInfo = nav.Save();
					if (errorInfo != null) {
						Util.WriteError("ImportNAVDateReconciliation row : " + i + " Errors: " + ValidationHelper.GetErrorInfo(errorInfo));
					} else {
						Util.WriteNewEntry("ImportNAVDateReconciliation row : " + i);
					}
				}
			}
		}
	}
}

