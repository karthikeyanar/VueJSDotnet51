using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Pepper.Models.CodeFirst;
using System.Data.Objects;
using Pepper.Framework.Validation;


namespace PepperExcelImport {
	//class ImportUnderlyingFundNAVReport {

	//    private static List<C5_15tblNAVReport> C5_15tblNAVReport = new List<C5_15tblNAVReport>();

	//    public static void Import() {
	//        Import_5_15();

	//        UnderlyingFundNAVReport navReport;
	//        int? fundID = 0;
	//        int? dealID = 0;
	//        int underlyingFundID;
	//        DateTime minDate = Convert.ToDateTime("01/01/1900");
	//        IEnumerable<ErrorInfo> errorInfo;
	//        int i = 2;
	//        foreach (var blueNAV in C5_15tblNAVReport) {
	//            i++;
	//            fundID = Globals.GetFundID(blueNAV.AmberbrookFundNo);
	//            dealID = Globals.GetDealID(blueNAV.AmberbrookDealNo, (fundID ?? 0));
	//            underlyingFundID = (Globals.GetUnderlyingFundID(blueNAV.Fund) ?? 0);

	//            using (PepperContext pepperContext = new PepperContext()) {

	//                int logID = (Globals.GetImportLogID("UnderlyingFundNAVReport", blueNAV.Id.ToString()) ?? 0);

	//                if (logID > 0) {
	//                    navReport = (from nav in pepperContext.UnderlyingFundNAVReports
	//                                 where nav.UnderlyingFundNAVReportID == logID
	//                                 select nav).FirstOrDefault();
	//                } else {

	//                    IQueryable<UnderlyingFundNAVReport> query = (from nav in pepperContext.UnderlyingFundNAVReports
	//                                                                 where nav.FundID == fundID
	//                                                                 && nav.DealID == dealID
	//                                                                    && nav.UnderlyingFundID == underlyingFundID
	//                                                                 select nav);

	//                    if ((i >= 5 && i <= 7)
	//                       || (i >= 9 && i <= 16)
	//                       || (i >= 21 && i <= 25 && i != 22)
	//                       || i == 28) {
	//                        query = query.Where(q => EntityFunctions.TruncateTime(q.FundNAVDate) == EntityFunctions.TruncateTime(blueNAV.Date));
	//                    }

	//                    if ((i >= 17 && i <= 20)) {
	//                        query = query.Where(q => EntityFunctions.TruncateTime((q.ReceivedDate ?? minDate)) == EntityFunctions.TruncateTime((blueNAV.Received ?? minDate)));
	//                    }

	//                    if (i == 22) {
	//                        //query = query.Where(q => EntityFunctions.TruncateTime((q.ReceivedDate ?? minDate)) == EntityFunctions.TruncateTime((blueNAV.Received ?? minDate)));
	//                        navReport = (from nav in query
	//                                     orderby nav.UnderlyingFundNAVReportID descending
	//                                     select nav).FirstOrDefault();
	//                    } else {
	//                        navReport = query.FirstOrDefault();
	//                    }
	//                }
	//            }
	//            if (i > 29) {
	//                navReport = new UnderlyingFundNAVReport();
	//                navReport.CreatedBy = Globals.CurrentUser.UserID;
	//                navReport.CreatedDate = DateTime.Now;
	//                Util.WriteNewEntry("UnderlyingFundNAVReport not exist row : " + i);
	//            } else {
	//                if (navReport == null) {
	//                    navReport = new UnderlyingFundNAVReport();
	//                    navReport.CreatedBy = Globals.CurrentUser.UserID;
	//                    navReport.CreatedDate = DateTime.Now;
	//                    Util.WriteNewEntry("UnderlyingFundNAVReport not exist row : " + i);
	//                } else {
	//                    Util.WriteError("UnderlyingFundNAVReport already exist row : " + i);
	//                }
	//            }

	//            navReport.DealID = (dealID ?? 0);
	//            navReport.FundID = (fundID ?? 0);
	//            navReport.FundNAV = blueNAV.NAV;
	//            navReport.FundNAVDate = blueNAV.Date;
	//            navReport.Status = blueNAV.Status;
	//            navReport.ReceivedDate = blueNAV.Received;
	//            navReport.UnderlyingFundID = underlyingFundID;
	//            navReport.LastUpdatedBy = Globals.CurrentUser.UserID;
	//            navReport.LastUpdatedDate = DateTime.Now;

	//            errorInfo = navReport.Save();

	//            if (errorInfo != null) {
	//                Util.WriteError("ImportUnderlyingFundNAVReport row : " + i + " Errors: " + ValidationHelper.GetErrorInfo(errorInfo));
	//            } else {
	//                Util.WriteNewEntry("ImportUnderlyingFundNAVReport row : " + i);
	//                Globals.ImportLog("UnderlyingFundNAVReport", navReport.UnderlyingFundNAVReportID, blueNAV.Id.ToString());
	//            }
	//        }
	//    }

	//    public static void Import_5_15() {

	//        string tableName = "5-15Delta";

	//        PagingDataTable dt = Globals.GetExcelDataTable(tableName);

	//        int transactionID;
	//        DateTime receivedDate;
	//        DateTime reportDate;
	//        string fundNo;
	//        int dealNo;
	//        string underlyingFundName;
	//        decimal? nav;
	//        string status;

	//        foreach (DataRow row in dt.Rows) {
	//            transactionID = DataTypeHelper.ToInt32(Convert.ToString(row["Id"]));
	//            fundNo = DataTypeHelper.ToString(row["AMB #"]);
	//            dealNo = DataTypeHelper.ToInt32(DataTypeHelper.ToString(row["AmberbrookDealNo"]));
	//            receivedDate = DataTypeHelper.ToFromOADate(DataTypeHelper.ToString(row["Received"]));
	//            reportDate = DataTypeHelper.ToFromOADate(DataTypeHelper.ToString(row["Report Date"]));
	//            underlyingFundName = DataTypeHelper.ToString(row["Fund"]);
	//            nav = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["NAV"]));
	//            status = DataTypeHelper.ToString(row["Status"]);

	//            if (status == "0")
	//                status = string.Empty;

	//            C5_15tblNAVReport.Add(new C5_15tblNAVReport {
	//                AmberbrookDealNo = dealNo,
	//                AmberbrookFundNo = fundNo,
	//                Date = reportDate,
	//                Received = receivedDate,
	//                Fund = underlyingFundName,
	//                NAV = (decimal)nav,
	//                Status = status,
	//                Id = transactionID,
	//            });
	//        }
	//    }
	//}
}

