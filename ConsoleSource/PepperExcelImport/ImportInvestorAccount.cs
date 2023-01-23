using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Pepper.Models.CodeFirst;
using System.Data.Objects;
using Pepper.Framework.Validation;


namespace PepperExcelImport {
	class ImportInvestorAccount {

		private static List<C7_20tblLPPaymentInstructions> C7_20tblLPPaymentInstructions = new List<C7_20tblLPPaymentInstructions>();

		public static void Import() {

			Import_7_20();

			IEnumerable<ErrorInfo> errorInfo;
			int investorID = 0;
			InvestorAccount account = null;
			int i = 2;
			foreach (var investor in C7_20tblLPPaymentInstructions) {
				i++;
				investorID = (Globals.GetInvestorID(investor.FullName) ?? 0);
				using (PepperContext context = new PepperContext()) {
					account = (from invacc in context.InvestorAccounts
							   where invacc.InvestorID == investorID
							   select invacc).FirstOrDefault();
				}
				if (account == null) {
					account = new InvestorAccount();
					account.CreatedBy = Globals.CurrentUser.UserID;
					account.CreatedDate = DateTime.Now;
					Util.WriteNewEntry("New investor account row: " + i);
				} else {
					Util.WriteWarning("Investor account already exist row: " + i);
				}
				if (!string.IsNullOrEmpty(investor.ABANumber)) {
					account.Routing = Convert.ToInt32(investor.ABANumber.Trim().Replace(" ", string.Empty).Replace("-", string.Empty)).ToString();
				}
				account.Account = investor.Accountof;
				account.AccountNumberCash = investor.AccountNumber;
				account.AccountOf = investor.Accountof;
				account.Attention = investor.Attn;
				account.BankName = investor.Bank;
				account.Reference = investor.Reference;
				account.EntityID = Globals.DefaultEntityID;
				account.IsPrimary = false;
				account.LastUpdatedBy = Globals.CurrentUser.UserID;
				account.LastUpdatedDate = DateTime.Now;
				account.Comments = investor.Comments;
				errorInfo = account.Save();
				if (errorInfo != null) {
					Util.WriteError("Investor account update error row : " + i + " Error : " + ValidationHelper.GetErrorInfo(errorInfo));
				} else {
					Util.WriteNewEntry("Investor account updated row : " + i + " id : " + account.InvestorAccountID);
				}
			}
		}

		public static void Import_7_20() {

			string tableName = "7-20Delta";

			PagingDataTable dt = Globals.GetExcelDataTable(tableName);

			string fullName;
			string nameidentifier;
			string bank;
			string ABA;
			string accountOf;
			string accountNo;
			string reference;
			string attn;
			string comments;


			foreach (DataRow row in dt.Rows) {
				fullName = DataTypeHelper.ToString(row["FullName"]);
				nameidentifier = DataTypeHelper.ToString(row["Nameidentifier"]);
				bank = DataTypeHelper.ToString(row["Bank"]);
				ABA = DataTypeHelper.ToString(row["ABA #"]);
				accountOf = DataTypeHelper.ToString(row["Account of"]);
				accountNo = DataTypeHelper.ToString(row["Account #"]);
				reference = DataTypeHelper.ToString(row["Reference"]);
				attn = DataTypeHelper.ToString(row["Attn"]);
				comments = DataTypeHelper.ToString(row["Comments"]);

				C7_20tblLPPaymentInstructions.Add(new C7_20tblLPPaymentInstructions {
					ABANumber = ABA,
					AccountNumber = accountNo,
					Accountof = accountOf,
					Attn = attn,
					Bank = bank,
					Comments = comments,
					FullName = fullName,
					Nameidentifier = nameidentifier,
					Reference = reference,
				});
			}
		}
	}
}

