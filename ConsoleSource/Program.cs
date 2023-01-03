using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using System.IO;
using System.Configuration;
using System.Data;
using Pepper.Framework.Authentication;
using System.Threading;
using Pepper.Framework.Helpers;
//using Pepper.Controllers.Deal;
using Pepper.Framework.Extensions;
using System.Data.Objects;
using Pepper.Models.CodeFirst;
using Pepper.Models.SecurityLot;
using Pepper.Models.DealUnderlyingFundAdjustment;
using System.Data.SqlClient;
using System.Collections.ObjectModel;
using System.Collections;
using Microsoft.WindowsAzure.Storage.Blob;
using Microsoft.WindowsAzure.Storage;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml;
using DocumentFormat.OpenXml.Spreadsheet;
using Dapper;
using System.Text.RegularExpressions;
using Google.Apis.Auth.OAuth2;
using Google.Apis.Util.Store;
using Google.Apis.Sheets.v4;
using Google.Apis.Services;
using Google.Apis.Sheets.v4.Data;
using DocumentFormat.OpenXml.Drawing.Charts;
using System.Security.Policy;
using CsvHelper;
using Pepper.Models.CodeFirst.Enums;

namespace PepperExcelImport {

	public class PrincipalProvider:IUserProvider {
		private const string entityKey = "CurrentEntity";
		private const string user = "CurrentUser";
		public User CurrentUser {
			get {
				PepperPrincipal principal = Thread.CurrentPrincipal as PepperPrincipal;
				if(principal != null) {
					return principal.CurrentUser;
				}
				return null;
			}
			set {
				PepperPrincipal principal = Thread.CurrentPrincipal as PepperPrincipal;
				if(principal == null) {
					principal = new PepperPrincipal();
					Thread.CurrentPrincipal = principal;
				}
				principal.CurrentUser = value;
			}
		}
		public Entity CurrentEntity {
			get {
				PepperPrincipal principal = Thread.CurrentPrincipal as PepperPrincipal;
				if(principal != null) {
					return principal.CurrentEntity;
				}
				return null;
			}
			set {
				PepperPrincipal principal = Thread.CurrentPrincipal as PepperPrincipal;
				if(principal == null) {
					principal = new PepperPrincipal();
					Thread.CurrentPrincipal = principal;
				}
				principal.CurrentEntity = value;
			}
		}

		public int CurrentAuditLogTraceID {
			get {
				return 0;
			}
			set {
			}
		}
	}

	public class XIRRData {
		public DateTime Date { get; set; }
		public decimal Value { get; set; }
	}

	class Program {
        static string[] Scopes = { SheetsService.Scope.Spreadsheets, SheetsService.Scope.Drive, SheetsService.Scope.DriveFile };
        static string ApplicationName = "Google Sheets API .NET Quickstart";
        private static string _googleSheetId = "";

        static void Main(string[] args) {
			//try {
			//Authentication.UserProvider = new PrincipalProvider();
			//EntityHelper.Initialize();

			//Import_Partnersg_Entity.Import_Partnersg_Institution();
			//Import_Partnersg_Entity.Import_Partnersg_InstitutionManagedFund();
			//Import_Partnersg_Entity.Import_Partnersg_InstitutionPortfolioFunds();
			//Import_Partnersg_Entity.Import_Partnersg_InstitutionContats();
			//Import_Partnersg_Entity.Import_Partnersg_Pipeline();

			//Authentication.UserProvider = new PrincipalProvider();
			//List<DealUnderlyingFund> dufs;
			//using(PepperContext context = new PepperContext()) {
			//    dufs = (from q in context.DealUnderlyingFunds
			//                   select q).ToList();
			//}
			//int total = dufs.Count();
			//int i = 0;
			//DealUnderlyingFundAdjustmentEngine engine = new DealUnderlyingFundAdjustmentEngine();
			//foreach(var duf in dufs) {
			//    engine.ReCalculateDealUnderlyingFundAdjustment(duf.DealUnderlyingFundID);
			//    i += 1;
			//    //Console.WriteLine(i + " of " + total);
			//}

			//List<XIRRData> xirrs = new List<XIRRData>();
			//xirrs.Add(new PepperExcelImport.XIRRData { Date = Convert.ToDateTime("09/30/2018"),Value = (decimal)-3440.00 });
			//xirrs.Add(new PepperExcelImport.XIRRData { Date = Convert.ToDateTime("03/31/2019"),Value = (decimal)-570 });
			//xirrs.Add(new PepperExcelImport.XIRRData { Date = Convert.ToDateTime("08/07/2020"),Value = (decimal)2004555.63 });
			//xirrs.Add(new PepperExcelImport.XIRRData { Date = Convert.ToDateTime("08/24/2020"),Value = (decimal)32764.89 });
			//xirrs.Add(new PepperExcelImport.XIRRData { Date = Convert.ToDateTime("06/30/2021"),Value = (decimal)1748410.01 });

			//List<double> values = (from q in xirrs
			//					   select (double)q.Value).ToList();
			//List<DateTime> dates = (from q in xirrs
			//						select q.Date).ToList();
			//double xirr = Excel.FinancialFunctions.Financial.XIrr(values,dates);

			//Import_Dividend_EP_Entity.Import();

			//ImportPepperPipeline.ImportGP();
			//ImportPepperPipeline.ImportPipelineNotes();
			//ImportPepperPipeline.ImportManageFund();
			ImportDealUnderlyingDirect.Import();
			//GoogleSheetXIRR();

            Console.WriteLine("Press any key to continue........");
			Console.ReadLine();
		}

		private static void GoogleSheetXIRR()
		{
            string rootPath = System.Configuration.ConfigurationManager.AppSettings["RootPath"];
            string credentialPath = System.IO.Path.Combine(rootPath, "credentials.json");
            UserCredential credential;

            using (var stream =
                new FileStream(credentialPath, FileMode.Open, FileAccess.Read))
            {
                // The file token.json stores the user's access and refresh tokens, and is created
                // automatically when the authorization flow completes for the first time.
                string credPath = System.IO.Path.Combine(rootPath, "token.json");
                credential = GoogleWebAuthorizationBroker.AuthorizeAsync(
                    GoogleClientSecrets.Load(stream).Secrets,
                    Scopes,
                    "user",
                    CancellationToken.None,
                    new FileDataStore(credPath, true)).Result;
                Helper.Log("Credential file saved to: " + credPath);
            }

            // Create Google Sheets API service.
            var service = new SheetsService(new BaseClientService.Initializer()
            {
                HttpClientInitializer = credential,
                ApplicationName = ApplicationName,
            });

			CheckFinanceGoogleSheet(service);
            //CheckXIRRGoogleSheet(service);
        }

		private static void CheckXIRRGoogleSheet(SheetsService service)
		{
			string sql = CommonHelper.GetResource("PepperExcelImport.SQL.dm_asset_core_irr.sql");
            List<GoogleXIRRPoints> points = new List<GoogleXIRRPoints>();
            using (SqlConnection connection = new SqlConnection(ConfigHelper.ConnectionString))
            {
                points = connection.Query<GoogleXIRRPoints>(sql).ToList();
            }
			//GoogleSheetXIRR googleSheetXIRR = new GoogleSheetXIRR(service, "1MSCZNG9G2g_0DKol_m2D5bzw2s1C_BXLrOHwUVDPFSg", points);
			decimal xirr = 0;
			//xirr = googleSheetXIRR.CalculateXIRR();
            List<double> values = (from q in points
                                   select (double)q.Value).ToList();
            List<DateTime> dates = (from q in points
                                    select q.Date).ToList();
            try
			{
                xirr = (decimal)Excel.FinancialFunctions.Financial.XIrr(values, dates);
                //xirr = Pepper.Models.XIRR.CalculationWrapper.XIRR(cashFlows,6);
                //xirr = Pepper.Framework.Helpers.XIRRHelper.XIRR(cashFlows);
            }
            catch { xirr = 0; }
            Console.WriteLine(xirr);
        }

        private static void CheckFinanceGoogleSheet(SheetsService service)
        {
			string sql = "";
			List<int> years = new List<int>
			{
				2017,2018,2019,2020,2021,2022
			};
			foreach (int year in years) {
				DateTime asofdate = Convert.ToDateTime("12/31/" + year);
				sql = CommonHelper.GetResource("PepperExcelImport.SQL.dm_asset_core_irr.sql");
                List<GoogleXIRRPoints> points = new List<GoogleXIRRPoints>();
				using (SqlConnection connection = new SqlConnection(ConfigHelper.ConnectionString))
				{
					sql = sql.Replace("--{{SET_PARAMS}}", string.Format("set @todate='{0}'", asofdate));
					points = connection.Query<GoogleXIRRPoints>(sql).ToList();
				}
				List<string> symbols = (from q in points
										select q.Symbol).Distinct().ToList();
				if (symbols.Count > 0)
				{
					GoogleSheetFinance googleSheetFinance = new GoogleSheetFinance(service
						, "1MSCZNG9G2g_0DKol_m2D5bzw2s1C_BXLrOHwUVDPFSg"
						, symbols
						, asofdate);
					googleSheetFinance.CalculatePrice();
				}
			}
        }

  //      private static void DuplicateUnderlyingFundClean()
		//{ 
		//	CalculateCapitalCallExpenses();
  //          //Console.WriteLine("Press any key to continue........");
		//	Console.ReadLine();
		//}

		private static void CalculateCapitalCallExpenses()
		{
            string currentDirectory = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);
            string excelFileName = "CapitalCallExpenses.csv";
            string filePath = Path.Combine(currentDirectory, excelFileName);
			string csvData = "";
         
			//int slapStart = 1000;
			//List<int> slaps = new List<int>();
			//for(int i = 0; i < 10000; i++)
			//{
			//	slapStart += 50;
   //             slaps.Add(slapStart);
			//}


            // Start Underlying Fund Import
            using (TextReader reader = System.IO.File.OpenText(filePath))
            {
                int i;
                CSVHeaderHelper csvHeader = new CSVHeaderHelper();
                CsvReader csv = null;
                csv = new CsvReader(reader);
                i = 0;
                while (csv.Read())
                {
                    i += 1;
                    if (i == 1)
                    {
                        int j;
                        for (j = 0; j < 100; j++)
                        {
                            try
                            {
                                csvHeader.Headers.Add(new CSVHeader { Name = csv[j], Index = j });
                            }
                            catch
                            {
                                break;
                            }
                        }
						csvData += "Date,Open,Close,Actual,Result";
                        csvData += Environment.NewLine;
                    }
                    else
                    {
                        string date = csv[csvHeader.GetIndex("Date")].Trim();
                        decimal open = DataTypeHelper.ToDecimal(csv[csvHeader.GetIndex("Open")].Trim());
                        decimal close = DataTypeHelper.ToDecimal(csv[csvHeader.GetIndex("Close")].Trim());
                        decimal v = ((close - open) / close) * 100;
						List<decimal> list = new List<decimal> { v };
                        decimal result = CapitalCallCalculate(list);

						csvData += date + "," + open + "," + close + "," + v + "," + result + Environment.NewLine;
                    }
                }
            }
            filePath = Path.Combine(currentDirectory, "Calculate_CapitalCall.csv");
			System.IO.File.WriteAllText(filePath,csvData);
        }

		private static decimal CapitalCallCalculate(List<decimal> list)
		{
			decimal totalCapitalCall = 580000;
			decimal strike = 18800;

			decimal currentPrice = 80; 
			decimal expenses = (decimal)0.3;
			int lotsize = 50;
			decimal result = 0;
            decimal cashdistbuy = (lotsize * currentPrice);
			decimal invPercentage = decimal.Divide(((totalCapitalCall - cashdistbuy) - totalCapitalCall),totalCapitalCall) * 100;
			Console.WriteLine("Inv%=" + invPercentage);
            foreach (decimal v in list)
			{
				decimal spot = (strike + ((strike * v) * (decimal)0.01));
				decimal sellprice = (strike - spot);
                decimal capitalcall = ((totalCapitalCall - cashdistbuy) * v) * (decimal)0.01;
				decimal cashsell = (lotsize * sellprice);
				decimal expenseAmount = ((cashdistbuy + cashsell) * expenses) * (decimal)0.01;
                cashsell = (lotsize * (sellprice - currentPrice));
                if (cashsell <= 0)
				{
					cashsell = cashdistbuy * -1;
				}
				decimal final = (totalCapitalCall + capitalcall + cashsell) - expenseAmount;
				decimal p = (decimal.Divide((final - totalCapitalCall), totalCapitalCall) * 100);
                result += p;
                //Console.Write("v=" + v + " | " +  decimal.Round(p,4) + " | " + result + Environment.NewLine);
			}
			return result;
		}

		//private static void DuplicateUnderlyingFundClean()
		//{
		//	List<string> tables;
		//	string sql = "select TABLE_NAME from INFORMATION_SCHEMA.columns where  COLUMN_NAME in ('UnderlyingFundID') " + Environment.NewLine +
		//				" and TABLE_NAME not like '%dm_vw%' and TABLE_NAME not in ('UnderlyingFund','InvestmentCostReport','DistributionReport')" + Environment.NewLine +
		//				"";
		//	using (SqlConnection connection = new SqlConnection(ConfigHelper.ConnectionString))
		//	{
		//		tables = connection.Query<string>(sql).ToList();
		//	}
		//	tables.Add("AttributeAllocation");
		//	sql = "select * from ( " + Environment.NewLine +
		//					" select uf.EntityID,uf.FundName,count(*) as cnt from underlyingfund uf" + Environment.NewLine +
		//					" group by uf.EntityID,uf.FundName" + Environment.NewLine +
		//					" ) as tbl where tbl.cnt > 1 " + Environment.NewLine;
		//	List<UnderlyingFund> underlyingFunds;
		//	using (SqlConnection connection = new SqlConnection(ConfigHelper.ConnectionString))
		//	{
		//		underlyingFunds = connection.Query<UnderlyingFund>(sql).ToList();
		//	}
		//	foreach(var uf in underlyingFunds)
		//	{
		//		List<UnderlyingFund> tempRows;
		//		sql = "select uf.* from UnderlyingFund uf where uf.EntityID = @EntityID and uf.FundName = @FundName order by UnderlyingFundID";
		//		using (SqlConnection connection = new SqlConnection(ConfigHelper.ConnectionString))
		//		{
		//			tempRows = connection.Query<UnderlyingFund>(sql, new
		//			{
		//				EntityID = uf.EntityID,
		//				FundName = uf.FundName
		//			}).ToList();
		//		}
		//		if (tempRows.Count > 0)
		//		{
		//			int firstUnderlyingFundID = tempRows[0].UnderlyingFundID;
		//			//Console.WriteLine("FundName=" + uf.FundName + ",Count=" + tempRows.Count);
		//			foreach (var tr in tempRows)
		//			{
		//				if (tr.UnderlyingFundID != firstUnderlyingFundID)
		//				{
		//					bool isExist = false;
		//					int? cnt = 0;
		//					foreach (string tableName in tables)
		//					{
		//						sql = "select isnull(count(*),0) as cnt from " + tableName + " where UnderlyingFundID=@UnderlyingFundID";
		//						if(tableName == "AttributeAllocation")
		//						{
		//							sql = "select isnull(count(*),0) as cnt from " + tableName + " where EntityID = @EntityID " + Environment.NewLine +
		//									" and AttributeImplementationTypeID = 1" +
		//									" and AttributeImplementationID = @UnderlyingFundID" + Environment.NewLine +
		//									"";
		//						}
		//						cnt = 0;
		//						using (SqlConnection connection = new SqlConnection(ConfigHelper.ConnectionString))
		//						{
		//							cnt = (int)connection.ExecuteScalar(sql, new
		//							{
		//								EntityID = tr.EntityID,
		//								UnderlyingFundID = tr.UnderlyingFundID
		//							});
		//							if ((cnt ?? 0) > 0)
		//							{
		//								isExist = true;
		//								////Console.WriteLine("Tablename=" + tableName + ",FundName=" + tr.FundName + ",UnderlyingFundID=" + tr.UnderlyingFundID);
		//								sql = "update " + tableName + " set UnderlyingFundID = @FirstUnderlyingFundID where UnderlyingFundID = @UnderlyingFundID";
		//								if (tableName == "AttributeAllocation")
		//								{
		//									sql = "update " + tableName + " set AttributeImplementationID = @FirstUnderlyingFundID where EntityID = @EntityID and AttributeImplementationTypeID = 1 and AttributeImplementationID = @UnderlyingFundID";
		//								}
		//								connection.Execute(sql, new {
		//									EntityID = tr.EntityID,
		//									FirstUnderlyingFundID = firstUnderlyingFundID,
		//									UnderlyingFundID = tr.UnderlyingFundID 
		//								});
		//							}
		//						}
		//					}
		//					//Console.WriteLine("FundName=" + tr.FundName + ",UnderlyingFundID=" + tr.UnderlyingFundID + ",isExist=" + isExist);
		//					if (isExist == false)
		//					{
		//						sql = "update underlyingfund set FundName=@FundName,IsArchive = @IsArchive where UnderlyingFundID=@UnderlyingFundID";
		//						using (SqlConnection connection = new SqlConnection(ConfigHelper.ConnectionString))
		//						{
		//							connection.Execute(sql, new
		//							{
		//								IsArchive = true,
		//								UnderlyingFundID = tr.UnderlyingFundID,
		//								FundName = tr.FundName + "~" + (new Random()).Next(10, 100).ToString()
		//							});
		//						}
		//					}
		//				}
		//			}
		//		}
		//	}
		//}

		private static void CompareFES() {
			dynamic deals;
			string sql = string.Format("select * from deal where fundid={0}",102);
			using(SqlConnection connection = new SqlConnection(SqlConfigHelper.ConnectionString)) {
				deals = connection.Query(sql,new {
				}).ToList();
			}
			string sqlPath = System.Configuration.ConfigurationManager.AppSettings["SQLPath"];
			int total = deals.Count;
			int index = 0;
			foreach(var d in deals) {
				index += 1;
				//Console.WriteLine(index + " of " + total);
				sql = System.IO.File.ReadAllText(System.IO.Path.Combine(sqlPath,"f1.sql"));
				sql = sql.Replace("{FUNDID}",d.FundID.ToString());
				sql = sql.Replace("{DEALID}",d.DealID.ToString());
				dynamic f1;
				using(SqlConnection connection = new SqlConnection(SqlConfigHelper.ConnectionString)) {
					f1 = connection.Query(sql,new {
					}).ToList();
				}
				sql = System.IO.File.ReadAllText(System.IO.Path.Combine(sqlPath,"f2.sql"));
				sql = sql.Replace("{FUNDID}",d.FundID.ToString());
				sql = sql.Replace("{DEALID}",d.DealID.ToString());
				dynamic f2;
				using(SqlConnection connection = new SqlConnection(SqlConfigHelper.ConnectionString)) {
					f2 = connection.Query(sql,new {
					}).ToList();
				}
				if(d.DealID.ToString()== "2588") {
					string s = string.Empty;
				}
				for(int i = 0;i < f1.Count;i++) {
					dynamic row = null;
					dynamic row2 = null;
					row = f1[i];
					try {
						row2 = f2[i];
					} catch { }
					//if(row.Name != "Reference Date") {
						if(row2 != null) {
							if(row.Name != row2.Name) {
								Helper.Log("DealID=" + d.DealID.ToString() + ",Name=" + row.Name + ", v1=" + row.Name.ToString() + " ,v2=" + row2.Name.ToString(),"CompareFES_Name_Conflict_" + d.DealID.ToString() + "_");
							} else if(row.Value != row2.Value) {
								decimal diff = 0;
								decimal v1 = DataTypeHelper.ToDecimal(row.Value.ToString());
								decimal v2 = DataTypeHelper.ToDecimal(row2.Value.ToString());
								bool isChange = false;
								if(v1 != 0 || v2 != 0) {
									if(v1 > v2) {
										diff = v1 - v2;
									} else if(v2 > v1) {
										diff = v2 - v1;
									}
									if(diff > (decimal)0.01) {
										isChange = true;
									}
								} else {
									isChange = true;
								}
								if(isChange) {
									Helper.Log("DealID=" + d.DealID.ToString() + ",Name=" + row.Name + ", v1=" + row.Value.ToString() + " ,v2=" + row2.Value.ToString() + " ,Diff=" + diff.ToString(),"CompareFES_" + d.DealID.ToString() + "_");
								}
							}
						} else {
							Helper.Log("DealID=" + d.DealID.ToString() + ",Name=" + row.Name + ", v1=" + row.Name.ToString(),"CompareFES_Not_Exist_" + d.DealID.ToString() + "_");
						}
					//}
				} 
			}
		}

		private static void CreateGoogleSheet() {

			List<XIRRData> xirrs = new List<XIRRData>();
			xirrs.Add(new PepperExcelImport.XIRRData { Date = Convert.ToDateTime("09/30/2018"),Value = (decimal)-3440.00 });
			xirrs.Add(new PepperExcelImport.XIRRData { Date = Convert.ToDateTime("03/31/2019"),Value = (decimal)-570 });
			xirrs.Add(new PepperExcelImport.XIRRData { Date = Convert.ToDateTime("08/07/2020"),Value = (decimal)2004555.63 });
			xirrs.Add(new PepperExcelImport.XIRRData { Date = Convert.ToDateTime("08/24/2020"),Value = (decimal)32764.89 });
			xirrs.Add(new PepperExcelImport.XIRRData { Date = Convert.ToDateTime("06/30/2021"),Value = (decimal)1748410.01 });

			string sheetName = new Random().Next(100,100000).ToString() + "_XIRR_Calc";

			string rootPath = System.Configuration.ConfigurationManager.AppSettings["RootPath"];
			string credentialPath = System.IO.Path.Combine(rootPath,"credentials.json");
			string[] Scopes = { SheetsService.Scope.Spreadsheets,SheetsService.Scope.Drive };
			string ApplicationName = "Google Sheets API .NET Quickstart";
			//_googleSheetId = System.Configuration.ConfigurationManager.AppSettings["googlesheetid"];
			UserCredential credential;

			using(var stream =
				new FileStream(credentialPath,FileMode.Open,FileAccess.Read)) {
				// The file token.json stores the user's access and refresh tokens, and is created
				// automatically when the authorization flow completes for the first time.
				string credPath = System.IO.Path.Combine(rootPath,"token.json");
				credential = GoogleWebAuthorizationBroker.AuthorizeAsync(
					GoogleClientSecrets.Load(stream).Secrets,
					Scopes,
					"user",
					CancellationToken.None,
					new FileDataStore(credPath,true)).Result;
				//WriteLog("Credential file saved to: " + credPath);
			}

			// Create Google Sheets API service.
			var service = new SheetsService(new BaseClientService.Initializer() {
				HttpClientInitializer = credential,
				ApplicationName = ApplicationName,
			});

			Spreadsheet body = new Spreadsheet();
			body.Properties = new SpreadsheetProperties();
			body.Properties.Title = sheetName;

			// Add Temp Sheet
			body.Sheets = new List<Google.Apis.Sheets.v4.Data.Sheet>();


			Google.Apis.Sheets.v4.Data.Sheet sheet = new Google.Apis.Sheets.v4.Data.Sheet();
			sheet.Properties = new Google.Apis.Sheets.v4.Data.SheetProperties();
			sheet.Properties.Title = "Sheet1";
			sheet.Properties.GridProperties = new GridProperties();
			int columnCount = 2;
			int rowCount = xirrs.Count() + 1;
			sheet.Properties.GridProperties.ColumnCount = columnCount;
			sheet.Properties.GridProperties.RowCount = rowCount;
			//sheet.Properties.GridProperties.FrozenRowCount = 1;

			sheet.Data = new List<Google.Apis.Sheets.v4.Data.GridData>();
			Google.Apis.Sheets.v4.Data.GridData gd = new Google.Apis.Sheets.v4.Data.GridData();

			List<RowData> rows = new List<RowData>();
			RowData row = null;
			CellData cellData = null;

			foreach(var xi in xirrs) {
				row = new RowData {
					Values = new List<CellData>()
				};

				cellData = new CellData();
				cellData.UserEnteredValue = new ExtendedValue { StringValue = xi.Date.ToString("MM/dd/yyyy") };
				cellData.UserEnteredFormat = new Google.Apis.Sheets.v4.Data.CellFormat {
					TextFormat = new TextFormat { },
				};
				row.Values.Add(cellData);

				cellData = new CellData();
				cellData.UserEnteredValue = new ExtendedValue { NumberValue = (double)xi.Value };
				cellData.UserEnteredFormat = new Google.Apis.Sheets.v4.Data.CellFormat {
					TextFormat = new TextFormat { },
				};
				row.Values.Add(cellData);
				rows.Add(row);
			}

			row = new RowData {
				Values = new List<CellData>()
			};

			string text = string.Format("=XIRR(B{0}:B{1},A{2}:A{3})",1,xirrs.Count(),1,xirrs.Count());

			cellData = new CellData();
			cellData.UserEnteredValue = new ExtendedValue { FormulaValue = text };
			cellData.UserEnteredFormat = new Google.Apis.Sheets.v4.Data.CellFormat {
				TextFormat = new TextFormat { },
			};
			row.Values.Add(cellData);

			cellData = new CellData();
			cellData.UserEnteredValue = new ExtendedValue { StringValue = "" };
			cellData.UserEnteredFormat = new Google.Apis.Sheets.v4.Data.CellFormat {
				TextFormat = new TextFormat { },
			};
			row.Values.Add(cellData);
			rows.Add(row);

			gd.RowData = rows;
			sheet.Data.Add(gd);
			body.Sheets.Add(sheet);


			SpreadsheetsResource.CreateRequest request = new SpreadsheetsResource.CreateRequest(service,body);

			var response = request.Execute();

			string googleSheetID = response.SpreadsheetId;

			String range = "Sheet1!A" + (xirrs.Count() + 1);
			SpreadsheetsResource.ValuesResource.GetRequest readRequest = service.Spreadsheets.Values.Get(googleSheetID,range);
			ValueRange readResponse = readRequest.Execute();
			IList<IList<Object>> values = readResponse.Values;
			if(values != null && values.Count > 0) {
				foreach(var readRow in values) {
					//Console.WriteLine("{0}",readRow[0]);
				}
			}

		}

		private static void UpdateXIRRByQuater() {
			string sql = "select dealid from deal where entityid = @entityId order by dealnumber asc";
			List<int> deals;
			using(SqlConnection connection = new SqlConnection(SqlConfigHelper.ConnectionString)) {
				deals = connection.Query<int>(sql,new {
					entityId = 9
				}).ToList();
			}
			List<DateTime> dates = new List<DateTime>();
			int startYear = 2018;
			int count = (DateTime.Now.Year - startYear) + 1;
			List<string> days = new List<string> { "03/31/","06/30/","09/30/","12/31/" };
			for(int i = 0;i < count;i++) {
				for(int j = 0;j < days.Count;j++) {
					string st = days[j] + (startYear + i);
					dates.Add(Convert.ToDateTime(st));
				}
			}
			int total = deals.Count();
			int index = 0;
			foreach(int id in deals) {
				for(int i = 0;i < dates.Count();i++) {
					////Console.WriteLine("dealid=" + id + ",date=" + dates[i]);
					if(dates[i].ToString("MM/dd/yyyy") == "12/31/2016") {
						string s = string.Empty;
					}
					CalculateXIRRDataMart(id,dates[i]);
				}
				index += 1;
				//Console.WriteLine(index + " of " + total + " dealid=" + id);
			}
		}

		private static double CalculateXIRRDataMart(int dealId,DateTime? asOfDate) {
			double xirr = 0;
			DateTime minDate = Convert.ToDateTime("01/01/1900");
			string sql = " exec [PROC_CALC_XIRR_Values_dm_deal_xirr] @dealId,@asOfDate; " + Environment.NewLine +
						"";
			if(asOfDate.Value.ToString("MM/dd/yyyy") == "12/31/2016") {
				string s = string.Empty;
			}
			using(SqlConnection connection = new SqlConnection(SqlConfigHelper.ConnectionString)) {
				List<Pepper.Models.XIRR.XIRRCashFlow> list = connection.Query<Pepper.Models.XIRR.XIRRCashFlow>(sql,new {
					dealId = dealId,asOfDate = (asOfDate.HasValue ? asOfDate.Value.Date : minDate)
				}).ToList();
				List<double> values = (from q in list
									   select (double)(q.Payment ?? 0)).ToList();
				List<DateTime> dates = (from q in list
										select (q.PayDate ?? minDate)).ToList();
				//List<CashItem> cashFlows = (from q in list
				//							select new CashItem {
				//								Amount = (double)(q.Payment ?? 0),
				//								Date = (q.PayDate ?? minDate),
				//							}).ToList();

				//List<Pepper.Models.XIRR.CashFlowDates> cashFlows = (from q in list
				//													select new Pepper.Models.XIRR.CashFlowDates {
				//														Amount = (double)(q.Payment ?? 0),
				//														Date = (q.PayDate ?? minDate),
				//													}).ToList();
				//List <Pepper.Models.XIRR.CashFlowDates> cashFlows = new List<Models.XIRR.CashFlowDates>();
				//foreach(var row in list) {

				//	cashFlows.Add(new Models.XIRR.CashFlowDates {
				//		Amount = DataTypeHelper.ToDecimal(row.Payment),
				//		Date = DataTypeHelper.ToDateTime(row.PayDate)
				//	});
				//}



				try {
					//xirr = Pepper.Framework.Helpers.XIRRHelper.XIRR(cashFlows);
					xirr = Excel.FinancialFunctions.Financial.XIrr(values,dates);
					//xirr = Pepper.Models.XIRR.CalculationWrapper.XIRR(cashFlows,6);
				} catch { xirr = 0; }
				//Console.WriteLine("dealid=" + dealId + ",asofdate=" + (asOfDate.HasValue ? asOfDate.Value.Date : minDate).ToString("MM/dd/yyyy") + ",xirr=" + xirr);
				sql = "delete from dm_deal_xirr where dealid = @dealid and xirrdate = @asOfDate";
				connection.Execute(sql,new {
					dealId = dealId,asOfDate = (asOfDate.HasValue ? asOfDate.Value.Date : minDate)
				});
				sql = "insert into dm_deal_xirr(DealID,XIRRDate,XIRR,LastUpdatedDate) values (@dealId,@asOfDate,@xirr,getdate())";
				if(xirr > (double)100000) {
					xirr = 0;
				}
				connection.Execute(sql,new {
					dealId = dealId,asOfDate = (asOfDate.HasValue ? asOfDate.Value.Date : minDate),xirr = xirr
				});
			}
			return xirr;
		}

		public static string GetExcelColumnName(int columnIndex) {
			//  Convert a zero-based column index into an Excel column reference  (A, B, C.. Y, Y, AA, AB, AC... AY, AZ, B1, B2..)
			//
			//  eg  GetExcelColumnName(0) should return "A"
			//      GetExcelColumnName(1) should return "B"
			//      GetExcelColumnName(25) should return "Z"
			//      GetExcelColumnName(26) should return "AA"
			//      GetExcelColumnName(27) should return "AB"
			//      ..etc..
			//
			if(columnIndex < 26)
				return ((char)('A' + columnIndex)).ToString();

			char firstChar = (char)('A' + (columnIndex / 26) - 1);
			char secondChar = (char)('A' + (columnIndex % 26));

			return string.Format("{0}{1}",firstChar,secondChar);
		}

		/*
		private static void CreateXIRR2() {
			string fileName = "";
			fileName = "E:\\Downloads\\XIRR.xlsx";
			if(System.IO.File.Exists(fileName) == true) {
				List<XIRRData> xirrs = new List<XIRRData>();
				xirrs.Add(new PepperExcelImport.XIRRData { Date = Convert.ToDateTime("09/30/2018"),Value = (decimal)-3440.00 });
				xirrs.Add(new PepperExcelImport.XIRRData { Date = Convert.ToDateTime("03/31/2019"),Value = (decimal)-570 });
				xirrs.Add(new PepperExcelImport.XIRRData { Date = Convert.ToDateTime("08/07/2020"),Value = (decimal)2004555.63 });
				xirrs.Add(new PepperExcelImport.XIRRData { Date = Convert.ToDateTime("08/24/2020"),Value = (decimal)32764.89 });
				xirrs.Add(new PepperExcelImport.XIRRData { Date = Convert.ToDateTime("06/30/2021"),Value = (decimal)1748410.01 });
				List<OpenXMLCellValue> cellValues = new List<OpenXMLCellValue>();
				uint index = 0;
				foreach(var row in xirrs) {
					index += 1;
					cellValues.Add(new OpenXMLCellValue {
						RowIndex = index,
						ColumnName = "A",
						CellDataType = CellValues.Date,
						Value = row.Date.ToString("MM/dd/yyyy")
					});
					cellValues.Add(new OpenXMLCellValue {
						RowIndex = index,
						ColumnName = "B",
						CellDataType = CellValues.Number,
						Value = row.Value.ToString()
					});
				}
				OpenXMLWindowsApp.Update(fileName,
									"Sheet1",1,
									cellValues,1,false,null);
			}
			if(System.IO.File.Exists(fileName) == true) {
				using(SpreadsheetDocument spreadSheet = SpreadsheetDocument.Open(fileName,true)) {
					spreadSheet.WorkbookPart.Workbook.CalculationProperties.CalculationMode = CalculateModeValues.Auto;
					spreadSheet.WorkbookPart.Workbook.CalculationProperties.ForceFullCalculation = true;
					spreadSheet.WorkbookPart.Workbook.CalculationProperties.FullCalculationOnLoad = true;
					spreadSheet.WorkbookPart.Workbook.Save();
				}
			}
			if(System.IO.File.Exists(fileName) == true) {
				using(SpreadsheetDocument myWorkbook = SpreadsheetDocument.Open(fileName,false)) {


					//Access the main Workbook part, which contains data
					WorkbookPart workbookPart = myWorkbook.WorkbookPart;
					WorksheetPart worksheetPart = null;
					List<Sheet> sheets = workbookPart.Workbook.Descendants<Sheet>().ToList();
					foreach(var ss in sheets) {
						worksheetPart = (WorksheetPart)workbookPart.GetPartById(ss.Id);
						SharedStringTablePart stringTablePart = workbookPart.SharedStringTablePart;
						if(worksheetPart != null) {
							string relationshipId = sheets.First().Id.Value;
							Worksheet workSheet = worksheetPart.Worksheet;
							SheetData sheetData = workSheet.GetFirstChild<SheetData>();
							IEnumerable<Row> rows = sheetData.Descendants<Row>();
							if(rows.ToArray().Count() > 0) {
								foreach(Row row in rows) {
									foreach(Cell thecurrentcell in row.Descendants<Cell>()) {
										string result = string.Empty;
										if(thecurrentcell != null) {

											if(thecurrentcell.CellFormula != null) {
												result = thecurrentcell.CellValue.InnerText;
											} else {
												result = thecurrentcell.InnerText;
											}

										}
									}
								}
							}
						}
					}
				}
			}
		}

		private static void CreateXIRR() {
			string fileName = "E:\\XIRR.xlsx";
			if(System.IO.File.Exists(fileName) == true) {
				System.IO.File.Delete(fileName);
			}
			using(SpreadsheetDocument document = SpreadsheetDocument.Create(fileName,SpreadsheetDocumentType.Workbook)) {
				WorkbookPart workbookPart = document.AddWorkbookPart();
				////  If we don't add a "WorkbookStylesPart", OLEDB will refuse to connect to this .xlsx file !
				//WorkbookStylesPart workbookStylesPart = document.WorkbookPart.AddNewPart<WorkbookStylesPart>("rIdStyles");
				////Stylesheet stylesheet = new Stylesheet();
				//workbookStylesPart.Stylesheet = GenerateStyleSheet();  

				workbookPart.Workbook = new Workbook();

				WorksheetPart worksheetPart = workbookPart.AddNewPart<WorksheetPart>();

				worksheetPart.Worksheet = new Worksheet();

				Sheets sheets = workbookPart.Workbook.AppendChild(new Sheets());

				Sheet sheet = new Sheet() { Id = workbookPart.GetIdOfPart(worksheetPart),SheetId = (UInt32)1,Name = "Sheet1" };

				sheets.Append(sheet);

				workbookPart.Workbook.Save();


				SheetData sheetData = worksheetPart.Worksheet.AppendChild(new SheetData());
				//Columns columns = new Columns();
				// Constructing header
				Row row = new Row();
				int colIndex = -1;

				int numberOfColumns = 2;
				string[] excelColumnNames = new string[numberOfColumns];
				for(int n = 0;n < numberOfColumns;n++)
					excelColumnNames[n] = GetExcelColumnName(n);

				Cell cell;

				colIndex += 1;
				cell = new Cell { CellValue = new CellValue("Value"),DataType = CellValues.String };
				cell.CellReference = excelColumnNames[colIndex] + "1";
				row.Append(cell);

				colIndex += 1;
				cell = new Cell { CellValue = new CellValue("Date"),DataType = CellValues.String };
				cell.CellReference = excelColumnNames[colIndex] + "1";
				row.Append(cell);

				//worksheetPart.Worksheet.Append(columns);

				// Insert the header row to the Sheet Data
				sheetData.AppendChild(row);

				List<XIRRData> xirrs = new List<XIRRData>();
				xirrs.Add(new PepperExcelImport.XIRRData { Date = Convert.ToDateTime("09/30/2018"),Value = (decimal)-3440.00 });
				xirrs.Add(new PepperExcelImport.XIRRData { Date = Convert.ToDateTime("03/31/2019"),Value = (decimal)-570 });
				xirrs.Add(new PepperExcelImport.XIRRData { Date = Convert.ToDateTime("08/07/2020"),Value = (decimal)2004555.63 });
				xirrs.Add(new PepperExcelImport.XIRRData { Date = Convert.ToDateTime("08/24/2020"),Value = (decimal)32764.89 });
				xirrs.Add(new PepperExcelImport.XIRRData { Date = Convert.ToDateTime("06/30/2021"),Value = (decimal)1748410.01 });

				int rowIndex = 1;
				foreach(var dataRow in xirrs) {
					rowIndex += 1;
					row = new Row();

					colIndex = -1;

					colIndex += 1;
					cell = new Cell { CellValue = new CellValue(dataRow.Value.ToString()),DataType = CellValues.Number };
					cell.CellReference = excelColumnNames[colIndex] + rowIndex.ToString();
					row.Append(cell);

					colIndex += 1;
					cell = new Cell { CellValue = new CellValue(dataRow.Date.ToString("MM/dd/yyyy")),DataType = CellValues.String };
					cell.CellReference = excelColumnNames[colIndex] + rowIndex.ToString();
					row.Append(cell);

					sheetData.AppendChild(row);
				}

				row = new Row();

				colIndex = -1;

				string text = string.Format("XIRR(A{0}:A{1},B{2}:B{3})",2,rowIndex,2,rowIndex);

				rowIndex += 1;
				colIndex += 1;
				cell = new Cell { CellValue = new CellValue(""),DataType = CellValues.Number };
				cell.CellFormula = new CellFormula { CalculateCell = true,Text = text };
				cell.CellReference = excelColumnNames[colIndex] + rowIndex.ToString();
				row.Append(cell);
				sheetData.AppendChild(row);

				//Cell formulaCell = InsertCellInWorksheet("A",(uint)rowIndex,worksheetPart);
				//formulaCell.DataType = new EnumValue<CellValues>(CellValues.Number);
				//formulaCell.CellFormula = new CellFormula(text);

				worksheetPart.Worksheet.Save();

			}
			if(System.IO.File.Exists(fileName) == true) {
				using(SpreadsheetDocument myWorkbook = SpreadsheetDocument.Open(fileName,false)) {
					//Access the main Workbook part, which contains data
					WorkbookPart workbookPart = myWorkbook.WorkbookPart;
					WorksheetPart worksheetPart = null;
					List<Sheet> sheets = workbookPart.Workbook.Descendants<Sheet>().ToList();
					foreach(var ss in sheets) {
						worksheetPart = (WorksheetPart)workbookPart.GetPartById(ss.Id);
						SharedStringTablePart stringTablePart = workbookPart.SharedStringTablePart;
						if(worksheetPart != null) {
							string relationshipId = sheets.First().Id.Value;
							Worksheet workSheet = worksheetPart.Worksheet;
							SheetData sheetData = workSheet.GetFirstChild<SheetData>();
							IEnumerable<Row> rows = sheetData.Descendants<Row>();
							if(rows.ToArray().Count() > 0) {
								foreach(Row row in rows) {
									foreach(Cell thecurrentcell in row.Descendants<Cell>()) {
										string result = string.Empty;
										if(thecurrentcell != null) {

											if(thecurrentcell.CellFormula != null) {
												result = thecurrentcell.CellValue.InnerText;
											} else {
												result = thecurrentcell.InnerText;
											}

										}
									}
								}
							}
						}
					}
				}
			}
		}
		*/

		//private static void CreatePipelineMemberActionCards() {
		//    using (PepperContext context = new PepperContext())
		//    {
		//        List<Pepper.Models.CodeFirst.PipelineMemberAction> actions = (from q in context.PipelineMemberActions where q.Notes != "" select q).ToList();
		//        int total = actions.Count;
		//        int i = 0;
		//        foreach (Pepper.Models.CodeFirst.PipelineMemberAction act in actions)
		//        {
		//            Card card = new Card
		//            {
		//                 Notes = act.Notes,
		//                 EntityID = act.EntityID,
		//                 CreatedBy = act.CreatedBy,
		//                 CreatedDate = act.CreatedDate,
		//                 LastUpdatedBy = act.LastUpdatedBy,
		//                 LastUpdatedDate = act.LastUpdatedDate,
		//            };
		//            context.Cards.Add(card);
		//            context.SaveChanges();
		//            PipelineMemberActionCard newActionCard = new PipelineMemberActionCard
		//            {
		//                  CardID = card.CardID,
		//                   PipelineMemberActionID = act.PipelineMemberActionID,
		//            };
		//            context.PipelineMemberActionCards.Add(newActionCard);
		//            context.SaveChanges();
		//            i += 1;
		//            //Console.WriteLine(i + " of " + total);
		//        }
		//    }
		//}

		private static void UpdateFilePath() {
			using(PepperContext context = new PepperContext()) {
				List<Pepper.Models.CodeFirst.File> files;
				files = (from q in context.Files where q.FileName.Contains("%5C") select q).ToList();
				int total = files.Count;
				int i = 0;
				foreach(Pepper.Models.CodeFirst.File fle in files) {
					i += 1;
					//Console.WriteLine(i + " of " + total);
					string fullName = System.IO.Path.Combine(fle.FilePath,fle.FileName);
					//Console.WriteLine("Original FullName=" + fullName);
					fullName = fullName.Replace("%5C","\\");
					string fileName = System.IO.Path.GetFileName(fullName);
					string filePath = fullName.Replace(fileName,"");
					filePath = filePath.Replace("\\","/");
					fle.FilePath = filePath;
					fle.FileName = fileName;
					//Console.WriteLine("FullName=" + fullName);
					//Console.WriteLine("filePath=" + filePath);
					//Console.WriteLine("fileName=" + fileName);
					context.Entry(fle).State = System.Data.Entity.EntityState.Modified;
					context.SaveChanges();
				}
			}
		}

		private static void CashDistributionUpdate() {
			List<CashDistribution> cashDistributions;
			using(PepperContext context = new PepperContext()) {
				cashDistributions = (from q in context.CashDistributions
									 where q.CashDistributionTypeID == (int)Pepper.Models.CodeFirst.Enums.CashDistributionType.ShortTermNettedDistribution_Deemed
									 || q.CashDistributionTypeID == (int)Pepper.Models.CodeFirst.Enums.CashDistributionType.ShortTermNettedDistribution_Stock
									 || q.CashDistributionTypeID == (int)Pepper.Models.CodeFirst.Enums.CashDistributionType.ShortTermNettedDistribution_Cash
									 select q).ToList();
			}
			int total = cashDistributions.Count();
			int i = 0;
			foreach(var cd in cashDistributions) {
				Deal deal;
				using(PepperContext context = new PepperContext()) {
					deal = (from q in context.Deals
							where q.DealID == cd.DealID
							select q).FirstOrDefault();
				}
				Authentication.CurrentEntity = new Entity { EntityID = deal.EntityID };
				Authentication.CurrentUser = new User { UserID = cd.CreatedBy };
				Authentication.CurrentUser.IsWrite = true;
				cd.Save();
				i += 1;
				//Console.WriteLine(i + " of " + total);
			}
		}

		//Backup
		//try {
		//Authentication.UserProvider = new PrincipalProvider();
		//EntityHelper.Initialize();

		//UnderlyingFundGPHolding ufHolding = new UnderlyingFundGPHolding();
		//InstitutionUnderlyingFundPortfolio portfolio = new InstitutionUnderlyingFundPortfolio();

		//List<UnderlyingFundGPHolding> holdings;
		//using(PepperContext context = new PepperContext()) {
		//    holdings = (from q in context.UnderlyingFundGPHoldings
		//                select q).ToList();
		//}
		//int totalCount = holdings.Count();
		//int i = 0;
		//foreach(var h in holdings) {
		//    i += 1;
		//    portfolio.UpdateFromUnderlyingFundGPHolding(h);
		//    //Console.WriteLine(i + " of " + totalCount);
		//}

		//List<InstitutionUnderlyingFundPortfolio> porfolios;
		//using(PepperContext context = new PepperContext()) {
		//    porfolios = (from q in context.InstitutionUnderlyingFundPortfolios
		//                 select q).ToList();
		//}
		//totalCount = porfolios.Count();
		//i = 0;
		//foreach(var p in porfolios) {
		//    i += 1;
		//    ufHolding.UpdateFromInstitutionUnderlyingFundPortfolio(p);
		//    //Console.WriteLine(i + " of " + totalCount);
		//}

		//CalcualteDiscountNAV();

		//SendAccountCreateEmail();

		//ImporBrantSteetLP.ImportUnderlyingFund();
		//try {
		//string currentDirectory = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);
		//string excelFileName = "2-6 digit_2017_Codes.xlsx";
		//string filePath = Path.Combine(currentDirectory,excelFileName);
		//Globals.ConnectExcel(currentDirectory,excelFileName);
		//Globals.ConnectExcel(filePath);
		//DeleteDeal();
		//ImporBrantSteetLP.ImportInstitution();
		//ExcelExport.ExportUnderlyingFundsCSV(9);
		//ImporBrantSteetLP.DeleteInstitution();
		//ImporUnderlyingDirectLastPrice.Calculate();
		//DeleteDuplicateAuditLogs();
		//ImporBrantSteetInstitutionPorfolio.Import();
		//ImporBrantSteetLP.ImportInstitution_2019_05_15_HFM();
		//ImporBrantSteetLP.ImportInstitution_2019_05_15_HFM_Contact();
		//ImporBrantSteetLP.ImportInstitution_2019_05_15_LP_FoHFs();
		//ImporBrantSteetLP.ImportInstitution_2019_05_15_LP_FoHFs_Contact();

		//} catch (Exception ex) {
		//    Util.WriteError("Main ex=" + ex.Message);
		//    if (ex.InnerException != null) {
		//        Util.WriteError("Main ex.InnerException=" + ex.InnerException.Message);
		//    }
		//}


		//private static void CalcualteDiscountNAV() {
		//    List<DealUnderlyingFund> dufs;
		//    List<Deal> deals;
		//    using(PepperContext context = new PepperContext()) {
		//        deals = (from q in context.Deals
		//                 select q).ToList();
		//        dufs = (from q in context.DealUnderlyingFunds
		//                join deal in context.Deals on q.DealID equals deal.DealID
		//                //where deal.EntityID == 9
		//                orderby deal.EntityID
		//                select q).ToList();

		//        int total = dufs.Count();
		//        int i = 0;
		//        foreach(var duf in dufs) {
		//            i += 1;
		//            var deal = (from q in deals
		//                        where q.DealID == duf.DealID
		//                        select q).FirstOrDefault();

		//            decimal? totalCapitalCall = 0;
		//            decimal? totalCashDistribution = 0;
		//            DateTime minDate = Convert.ToDateTime("01/01/1900");
		//            Pepper.Models.CodeFirst.Enums.DiscountNAVStatus discountNAVStatus = Pepper.Models.CodeFirst.Enums.DiscountNAVStatus.NONE;
		//            if((duf.DiscountNAVStatusID ?? 0) > 0) {
		//                discountNAVStatus = (Pepper.Models.CodeFirst.Enums.DiscountNAVStatus)duf.DiscountNAVStatusID;
		//            }

		//            UnderlyingFundNAV underlyingFundNAV = null;


		//            if(discountNAVStatus != Pepper.Models.CodeFirst.Enums.DiscountNAVStatus.Manual) {
		//                if((duf.DealClosingID ?? 0) > 0) {

		//                    DealClosing dealClosing = context.DealClosings.Where(q => q.DealClosingID == duf.DealClosingID).FirstOrDefault();

		//                    if(dealClosing != null) {

		//                        bool isIgnoreCapitalCallAndDistributions = false;

		//                        UnderlyingFundNAV beforeUnderlyingFundNAV = (from nav in context.UnderlyingFundNAVs
		//                                                                     where nav.UnderlyingFundID == duf.UnderlyingFundID
		//                                                                     && nav.DealID == duf.DealID
		//                                                                     && System.Data.Entity.DbFunctions.TruncateTime(nav.FundNAVDate) < System.Data.Entity.DbFunctions.TruncateTime(dealClosing.CloseDate)
		//                                                                     && (nav.UnderlyingFundSaleLineItemID ?? 0) <= 0
		//                                                                     orderby nav.FundNAVDate ascending, nav.IsEstimatedNAV ascending, nav.UnderlyingFundNAVID ascending
		//                                                                     select nav).FirstOrDefault();

		//                        UnderlyingFundNAV afterUnderlyingFundNAV = (from nav in context.UnderlyingFundNAVs
		//                                                                    where nav.UnderlyingFundID == duf.UnderlyingFundID
		//                                                                    && nav.DealID == duf.DealID
		//                                                                    && System.Data.Entity.DbFunctions.TruncateTime(nav.FundNAVDate) >= System.Data.Entity.DbFunctions.TruncateTime(dealClosing.CloseDate)
		//                                                                    && (nav.UnderlyingFundSaleLineItemID ?? 0) <= 0
		//                                                                    orderby nav.FundNAVDate ascending, nav.IsEstimatedNAV ascending, nav.UnderlyingFundNAVID ascending
		//                                                                    select nav).FirstOrDefault();

		//                        if(beforeUnderlyingFundNAV == null && afterUnderlyingFundNAV != null) {
		//                            underlyingFundNAV = afterUnderlyingFundNAV;
		//                        } else if(afterUnderlyingFundNAV == null && beforeUnderlyingFundNAV != null) {
		//                            underlyingFundNAV = beforeUnderlyingFundNAV;
		//                            isIgnoreCapitalCallAndDistributions = true;
		//                        } else if(afterUnderlyingFundNAV != null && beforeUnderlyingFundNAV != null) {
		//                            TimeSpan afterTimeSpan = (afterUnderlyingFundNAV.FundNAVDate.Date - dealClosing.CloseDate.Date);
		//                            TimeSpan beforeTimeSpan = (dealClosing.CloseDate.Date - beforeUnderlyingFundNAV.FundNAVDate.Date);
		//                            if(beforeTimeSpan.TotalDays == afterTimeSpan.TotalDays) {
		//                                underlyingFundNAV = afterUnderlyingFundNAV;
		//                            } else if(afterTimeSpan.TotalDays < beforeTimeSpan.TotalDays) {
		//                                underlyingFundNAV = afterUnderlyingFundNAV;
		//                            } else if(beforeTimeSpan.TotalDays < afterTimeSpan.TotalDays) {
		//                                underlyingFundNAV = beforeUnderlyingFundNAV;
		//                                isIgnoreCapitalCallAndDistributions = true;
		//                            }
		//                        }

		//                        if(underlyingFundNAV != null && isIgnoreCapitalCallAndDistributions == false) {

		//                            IQueryable<UnderlyingFundCapitalCallLineItem> ufCCQuery = context.UnderlyingFundCapitalCallLineItems
		//                                .Where(lineItem => lineItem.UnderlyingFundID == duf.UnderlyingFundID
		//                                && lineItem.DealID == duf.DealID
		//                                && lineItem.UnderlyingFundCapitalCallID != null);

		//                            if(dealClosing.CloseDate.Date <= underlyingFundNAV.FundNAVDate.Date) {
		//                                ufCCQuery = (from lineItem in ufCCQuery
		//                                             where
		//                                             System.Data.Entity.DbFunctions.TruncateTime((lineItem.ReceivedDate ?? minDate)) >= System.Data.Entity.DbFunctions.TruncateTime(dealClosing.CloseDate)
		//                                             && System.Data.Entity.DbFunctions.TruncateTime((lineItem.ReceivedDate ?? minDate)) <= System.Data.Entity.DbFunctions.TruncateTime(underlyingFundNAV.FundNAVDate)
		//                                             select lineItem);
		//                            } else {
		//                                ufCCQuery = (from lineItem in ufCCQuery
		//                                             where
		//                                             System.Data.Entity.DbFunctions.TruncateTime((lineItem.ReceivedDate ?? minDate)) >= System.Data.Entity.DbFunctions.TruncateTime(underlyingFundNAV.FundNAVDate)
		//                                             && System.Data.Entity.DbFunctions.TruncateTime((lineItem.ReceivedDate ?? minDate)) <= System.Data.Entity.DbFunctions.TruncateTime(dealClosing.CloseDate)
		//                                             select lineItem);
		//                            }

		//                            if(ufCCQuery.Count() > 0)
		//                                totalCapitalCall = ufCCQuery.Sum(lineItem => lineItem.TotalAmount);
		//                            else
		//                                totalCapitalCall = 0;

		//                            IQueryable<CashDistribution> ufCDQuery = context.CashDistributions
		//                                .Where(cashDistribution => cashDistribution.UnderlyingFundID == duf.UnderlyingFundID
		//                                && cashDistribution.DealID == duf.DealID
		//                                && cashDistribution.UnderlyingFundCashDistributionID != null
		//                                &&
		//                                (cashDistribution.CashDistributionTypeID == (int)Pepper.Models.CodeFirst.Enums.CashDistributionType.ShortTermNettedDistribution
		//                                || cashDistribution.CashDistributionTypeID == (int)Pepper.Models.CodeFirst.Enums.CashDistributionType.RegularDistribution
		//                                //|| cashDistribution.CashDistributionTypeID == (int)Pepper.Models.CodeFirst.Enums.CashDistributionType.RedemptionDistribution
		//                                )
		//                                );

		//                            if(dealClosing.CloseDate.Date <= underlyingFundNAV.FundNAVDate.Date) {
		//                                ufCDQuery = (from cashDistribution in ufCDQuery
		//                                             where
		//                                             System.Data.Entity.DbFunctions.TruncateTime((cashDistribution.UnderlyingFundCashDistribution.ReceivedDate ?? minDate)) >= System.Data.Entity.DbFunctions.TruncateTime(dealClosing.CloseDate)
		//                                             && System.Data.Entity.DbFunctions.TruncateTime((cashDistribution.UnderlyingFundCashDistribution.ReceivedDate ?? minDate)) <= System.Data.Entity.DbFunctions.TruncateTime(underlyingFundNAV.FundNAVDate)
		//                                             select cashDistribution);
		//                            } else {
		//                                ufCDQuery = (from cashDistribution in ufCDQuery
		//                                             where
		//                                             System.Data.Entity.DbFunctions.TruncateTime((cashDistribution.UnderlyingFundCashDistribution.ReceivedDate ?? minDate)) >= System.Data.Entity.DbFunctions.TruncateTime(underlyingFundNAV.FundNAVDate)
		//                                             && System.Data.Entity.DbFunctions.TruncateTime((cashDistribution.UnderlyingFundCashDistribution.ReceivedDate ?? minDate)) <= System.Data.Entity.DbFunctions.TruncateTime(dealClosing.CloseDate)
		//                                             select cashDistribution);
		//                            }

		//                            if(ufCDQuery.Count() > 0)
		//                                totalCashDistribution = ufCDQuery.Sum(cashDistribution => cashDistribution.Amount);
		//                            else
		//                                totalCashDistribution = 0;
		//                        }
		//                    }
		//                }
		//            }
		//            // End Calcualte Discount NAV //


		//            //if(discountNAVStatus != Pepper.Models.CodeFirst.Enums.DiscountNAVStatus.Manual
		//            //    && discountNAVStatus != Pepper.Models.CodeFirst.Enums.DiscountNAVStatus.Accepted) {
		//            //    // Update discount nav
		//            //    if(underlyingFundNAV != null) {
		//            //        duf.DiscountNAV = (underlyingFundNAV.FundNAV ?? 0) - ((totalCapitalCall ?? 0) - (totalCashDistribution ?? 0));
		//            //        duf.DiscountNAVStatusID = (int)Pepper.Models.CodeFirst.Enums.DiscountNAVStatus.NotAccepted;
		//            //        duf.DiscountNAVDate = underlyingFundNAV.FundNAVDate;
		//            //    } else {
		//            //        duf.DiscountNAV = duf.OriginalAdjustedNAV;
		//            //        duf.DiscountNAVStatusID = (int)Pepper.Models.CodeFirst.Enums.DiscountNAVStatus.NONE;
		//            //        duf.DiscountNAVDate = duf.RecordDate;
		//            //    }
		//            //}

		//            duf.DiscountNAVUnderlyingFundNAVID = 0;
		//            if(underlyingFundNAV != null) {
		//                duf.DiscountNAVUnderlyingFundNAVID = underlyingFundNAV.UnderlyingFundNAVID;
		//            }
		//            duf.DiscountNAVCapitalCall = totalCapitalCall;
		//            duf.DiscountNAVCashDistribution = totalCashDistribution;

		//            //if((duf.DiscountNAVStatusID ?? 0) <= 0) {
		//            //    duf.DiscountNAVStatusID = (int)Pepper.Models.CodeFirst.Enums.DiscountNAVStatus.NONE;
		//            //}

		//            string sql = string.Format("update dealunderlyingfund set DiscountNAVUnderlyingFundNAVID={0},DiscountNAVCapitalCall='{1}',DiscountNAVCashDistribution='{2}' where DealUnderlyingFundID={3}",
		//                (duf.DiscountNAVUnderlyingFundNAVID ?? 0),
		//                (duf.DiscountNAVCapitalCall ?? 0),
		//                (duf.DiscountNAVCashDistribution ?? 0),
		//                duf.DealUnderlyingFundID);

		//            context.Database.ExecuteSqlCommand(sql);

		//            //context.Entry(duf).State = System.Data.Entity.EntityState.Modified;
		//            //context.SaveChanges();

		//            //Console.WriteLine("EntityID=" + deal.EntityID + " " + i + " of " + total);
		//        }
		//    }
		//}

		//private static void UploadFileToAzure() {
		//    string uploadFileName = string.Empty;

		//    CloudBlobContainer blobContainer = GetBlobContainer();
		//    CloudBlockBlob blob = blobContainer.GetBlockBlobReference(uploadFileName);
		//    //CloudBlob blob=blobContainer.GetBlobReference(uploadFileName);
		//    blob.DeleteIfExists();

		//    // Upload a file from the local system to the blob.
		//    blob.UploadFromStream(uploadFile.InputStream);  // File from emulated storage.

		//    string blobURL = blob.Uri.ToString();
		//    string blobFileName = Path.GetFileName(blobURL);
		//    blobURL = blobURL.Replace(blobFileName,"");
		//    uploadFileModel = new UploadFileModel { FileName = blobFileName,FilePath = blobURL,Size = uploadFile.ContentLength };
		//}

		private static CloudBlobContainer GetBlobContainer() {

			string connectionString = ConfigurationManager.AppSettings["AzureBlobStorageConnectionString"];
			string blogContainerName = ConfigurationManager.AppSettings["AzureBlobStorageContainer"];

			// start windows azure file upload.
			// Variables for the cloud storage objects.
			CloudStorageAccount cloudStorageAccount;
			CloudBlobClient blobClient;
			CloudBlobContainer blobContainer;
			BlobContainerPermissions containerPermissions;

			// Use the emulatedstorage account.
			cloudStorageAccount = CloudStorageAccount.DevelopmentStorageAccount;

			// If you want to use Windows Azure cloud storage account, use the following
			// code (after uncommenting) instead of the code above.
			cloudStorageAccount = CloudStorageAccount.Parse(connectionString);

			// Create the blob client, which provides
			// authenticated access to the Blob service.
			blobClient = cloudStorageAccount.CreateCloudBlobClient();

			// Get the container reference.
			blobContainer = blobClient.GetContainerReference(blogContainerName);
			// Create the container if it does not exist.
			blobContainer.CreateIfNotExists();

			// Set permissions on the container.
			containerPermissions = new BlobContainerPermissions();
			// This sample sets the container to have public blobs. Your application
			// needs may be different. See the documentation for BlobContainerPermissions
			// for more information about blob container permissions.
			containerPermissions.PublicAccess = BlobContainerPublicAccessType.Blob;
			blobContainer.SetPermissions(containerPermissions);

			return blobContainer;
		}

		//private static void SendAccountCreateEmail() {
		//    int entityID = 13;
		//    int actionCodeID = 6;
		//    ActionCode actionCode = null;
		//    using(PepperContext context = new PepperContext()) {
		//        actionCode = (from q in context.ActionCodes where q.ActionCodeID == actionCodeID select q).FirstOrDefault();
		//    }
		//    ForgotPassword accCreateEmail = new ForgotPassword(entityID,actionCode);
		//    accCreateEmail.Send();
		//}


		private static void DeleteDuplicateAuditLogs() {
			string sql = "select * from ( " + Environment.NewLine +
						" select MIN(al.AuditLogID) as AuditLogID,al.EntityID,al.AuditLogSourceID,al.PepperTablePKID,al.AuditLogTypeID,al.AuditEntries,al.AuditLogUserID,FORMAT(AuditLogDate,'MM/dd/yyyy HH:mm') as [Date],count(*) as cnt from AuditLog al " + Environment.NewLine +
						" group by al.EntityID,al.AuditLogSourceID,al.PepperTablePKID,al.AuditLogTypeID,al.AuditEntries,al.AuditLogUserID,FORMAT(AuditLogDate,'MM/dd/yyyy HH:mm') " + Environment.NewLine +
						" ) as tbl where cnt > 1" + Environment.NewLine +
						" order by AuditLogSourceID,PepperTablePKID,cnt desc";
			int auditLogSourceID = 0;
			int pepperTablePKID = 0;
            System.Data.DataTable dt = new System.Data.DataTable();
			using(SqlConnection connection = new SqlConnection(ConfigHelper.ConnectionString)) {
				SqlCommand command = new SqlCommand(sql,connection);
				connection.Open();
				using(SqlDataReader dr = command.ExecuteReader()) {
					dt.Load(dr);
				}
			}
			int i = 0;
			foreach(DataRow dr in dt.Rows) {
				i += 1;
				auditLogSourceID = DataTypeHelper.ToInt32(dr["AuditLogSourceID"].ToString());
				pepperTablePKID = DataTypeHelper.ToInt32(dr["PepperTablePKID"].ToString());
				DeleteDuplicateAuditLogs(auditLogSourceID,pepperTablePKID,dt.Rows.Count,i);
			}
		}

		private static void DeleteDuplicateAuditLogs(int auditLogSourceID,int pepperTablePKID,int dataTableCount,int index) {
			int cnt = 0;
			string sql = string.Format("select * from ( " + Environment.NewLine +
						" select MIN(al.AuditLogID) as AuditLogID,al.EntityID,al.AuditLogSourceID,al.PepperTablePKID,al.AuditLogTypeID,al.AuditEntries,al.AuditLogUserID,FORMAT(AuditLogDate,'MM/dd/yyyy HH:mm') as [Date],count(*) as cnt from AuditLog al " + Environment.NewLine +
						" where al.AuditLogSourceID = {0} and al.PepperTablePKID = {1} " + Environment.NewLine +
						" group by al.EntityID,al.AuditLogSourceID,al.PepperTablePKID,al.AuditLogTypeID,al.AuditEntries,al.AuditLogUserID,FORMAT(AuditLogDate,'MM/dd/yyyy HH:mm') " + Environment.NewLine +
						" ) as tbl where cnt > 1" + Environment.NewLine +
						" order by AuditLogSourceID,PepperTablePKID,cnt desc",auditLogSourceID,pepperTablePKID);
			int totalCount = 0;
			using(SqlConnection connection = new SqlConnection(ConfigHelper.ConnectionString)) {

				SqlCommand command = new SqlCommand(sql,connection);
				connection.Open();
				using(SqlDataReader dr = command.ExecuteReader()) {
					// Call Read before accessing data. 
					cnt = 0;
					while(dr.Read()) {
						cnt += 1;
						auditLogSourceID = DataTypeHelper.ToInt32(dr["AuditLogSourceID"].ToString());
						pepperTablePKID = DataTypeHelper.ToInt32(dr["PepperTablePKID"].ToString());
						totalCount = DataTypeHelper.ToInt32(dr["cnt"].ToString());
						break;
					}
					// Call Close when done reading.
					dr.Close();
				}
			}
			if(totalCount > 1) {
				sql = string.Format("delete from AuditLog where AuditLogID in ( " + Environment.NewLine +
									   " select AuditLogID from(" + Environment.NewLine +
									   " select MIN(al.AuditLogID) as AuditLogID,al.EntityID,al.AuditLogSourceID,al.PepperTablePKID,al.AuditLogTypeID,al.AuditEntries,al.AuditLogUserID,FORMAT(AuditLogDate,'MM/dd/yyyy HH:mm') as [Date],count(*) as cnt from AuditLog al" + Environment.NewLine +
									   " where al.AuditLogSourceID = {0} and al.PepperTablePKID = {1} " + Environment.NewLine +
									   " group by al.EntityID,al.AuditLogSourceID,al.PepperTablePKID,al.AuditLogTypeID,al.AuditEntries,al.AuditLogUserID,FORMAT(AuditLogDate,'MM/dd/yyyy HH:mm')" + Environment.NewLine +
									   " ) as tbl where cnt > 1)" + Environment.NewLine +
									   "",auditLogSourceID,pepperTablePKID);
				using(SqlConnection connection = new SqlConnection(ConfigHelper.ConnectionString)) {
					SqlCommand command = new SqlCommand(sql,connection);
					connection.Open();
					command.ExecuteNonQuery();
					//Console.WriteLine("Delete auditLogSourceID=" + auditLogSourceID + ",pepperTablePKID=" + pepperTablePKID + ",totalCount=" + totalCount + "," + index + " of " + dataTableCount);
				}
				if(cnt > 0) {
					DeleteDuplicateAuditLogs(auditLogSourceID,pepperTablePKID,dataTableCount,index);
				}
			}
		}

		private static void UpdateUnderlyingFundIDs() {
			int i = 0;
			using(PepperContext context = new PepperContext()) {
				List<UnderlyingFund> underlyingFunds = (from q in context.UnderlyingFunds
														select q).ToList();
				foreach(var uf in underlyingFunds) {
					i += 1;
					if((uf.InvestmentTypeID ?? 0) <= 0) {
						var invType = (from q in context.InvestmentTypes
									   where q.Investment == "NA"
									   && (q.EntityID == 1 || q.EntityID == uf.EntityID)
									   select q).FirstOrDefault();
						if(invType == null) {
							invType = new InvestmentType {
								CreatedBy = Authentication.CurrentUser.UserID,
								CreatedDate = DateTime.Now,
								EntityID = 1,
								Enabled = true,
								Investment = "NA",
								RecordTypeID = (int)Pepper.Models.CodeFirst.Enums.RecordType.All,
							};
							context.InvestmentTypes.Add(invType);
							context.SaveChanges();
						}
						if(invType != null) {
							uf.InvestmentTypeID = invType.InvestmentTypeID;
						}
					}
					if((uf.IncorporationLocationID ?? 0) <= 0) {
						var type = (from q in context.IncorporationLocations
									where q.Name == "NA"
								   && (q.EntityID == 1 || q.EntityID == uf.EntityID)
									select q).FirstOrDefault();
						if(type == null) {
							type = new IncorporationLocation {
								CreatedBy = Authentication.CurrentUser.UserID,
								CreatedDate = DateTime.Now,
								EntityID = 1,
								Enabled = true,
								Name = "NA",
							};
							context.IncorporationLocations.Add(type);
							context.SaveChanges();
						}
						if(type != null) {
							uf.IncorporationLocationID = type.IncorporationLocationID;
						}
					}
					if((uf.VehicleTypeID ?? 0) <= 0) {
						var type = (from q in context.VehicleTypes
									where q.Vehicle == "NA"
								   && (q.EntityID == 1 || q.EntityID == uf.EntityID)
									select q).FirstOrDefault();
						if(type == null) {
							type = new VehicleType {
								CreatedBy = Authentication.CurrentUser.UserID,
								CreatedDate = DateTime.Now,
								EntityID = 1,
								Enabled = true,
								Vehicle = "NA",
								RecordTypeID = (int)Pepper.Models.CodeFirst.Enums.RecordType.All,
							};
							context.VehicleTypes.Add(type);
							context.SaveChanges();
						}
						if(type != null) {
							uf.VehicleTypeID = type.VehicleTypeID;
						}
					}
					if((uf.FundRaisingTypeID ?? 0) <= 0) {
						var type = (from q in context.FundRaisingTypes
									where q.FundRaisingTypeName == "NA"
								   && (q.EntityID == 1 || q.EntityID == uf.EntityID)
									select q).FirstOrDefault();
						if(type == null) {
							type = new FundRaisingType {
								CreatedBy = Authentication.CurrentUser.UserID,
								CreatedDate = DateTime.Now,
								EntityID = 1,
								Enabled = true,
								FundRaisingTypeName = "NA",
							};
							context.FundRaisingTypes.Add(type);
							context.SaveChanges();
						}
						if(type != null) {
							uf.FundRaisingTypeID = type.FundRaisingTypeID;
						}
					}
					if((uf.ReportingFrequencyID ?? 0) <= 0) {
						var type = (from q in context.ReportingFrequencies
									where q.ReportingFrequency1 == "NA"
									&& (q.EntityID == 1 || q.EntityID == uf.EntityID)
									select q).FirstOrDefault();
						if(type == null) {
							type = new ReportingFrequency {
								CreatedBy = Authentication.CurrentUser.UserID,
								CreatedDate = DateTime.Now,
								EntityID = 1,
								Enabled = true,
								ReportingFrequency1 = "NA",
							};
							context.ReportingFrequencies.Add(type);
							context.SaveChanges();
						}
						if(type != null) {
							uf.ReportingFrequencyID = type.ReportingFrequencyID;
						}
					}
					if((uf.ReportingTypeID ?? 0) <= 0) {
						var type = (from q in context.ReportingTypes
									where q.Reporting == "NA"
									&& (q.EntityID == 1 || q.EntityID == uf.EntityID)
									select q).FirstOrDefault();
						if(type == null) {
							type = new ReportingType {
								CreatedBy = Authentication.CurrentUser.UserID,
								CreatedDate = DateTime.Now,
								EntityID = 1,
								Enabled = true,
								Reporting = "NA",
							};
							context.ReportingTypes.Add(type);
							context.SaveChanges();
						}
						if(type != null) {
							uf.ReportingTypeID = type.ReportingTypeID;
						}
					}
					context.Entry(uf).State = System.Data.Entity.EntityState.Modified;
					context.SaveChanges();
					//Console.WriteLine("i=" + i + ",total=" + underlyingFunds.Count());
				}
			}
		}

		public static void SQLChecking() {
			Hashtable htable = new Hashtable();
			htable.Add("Account1","Account");
			htable.Add("AppStoreAppConfiguration1","AppStoreAppConfiguration");
			htable.Add("AppStoreEntityAppConfiguration1","AppStoreEntityAppConfiguration");
			htable.Add("Currency1","Currency");
			htable.Add("Industry1","Industry");
			htable.Add("FixedIncomeType1","FixedIncomeType");
			htable.Add("ReportingFrequency1","ReportingFrequency");
			htable.Add("SaleProcessType1","SaleProcessType");
			htable.Add("SellerType1","SellerType");
			htable.Add("SourcingChannelType1","SourcingChannelType");
			htable.Add("TaxStructure1","TaxStructure");

			/* SQL Page Helper  */
			Assembly myAssembly = typeof(Pepper.Models.CodeFirst.ENTITY).GetTypeInfo().Assembly;
			Type[] typelist = GetTypesInNamespace(myAssembly,"Pepper.Models.CodeFirst");
			bool isNotMappedClass = false;
			for(int i = 0;i < typelist.Length;i++) {
				isNotMappedClass = false;
				if(typelist[i].CustomAttributes != null) {
					var arr = typelist[i].CustomAttributes.ToArray();
					for(int j = 0;j < arr.Count();j++) {
						if(arr[j].AttributeType.Name.Contains("NotMapped")) {
							isNotMappedClass = true;
							break;
						}
					}
				}
				if(typelist[i].Name.EndsWith("Map") == false
					&& typelist[i].Name.EndsWith("MD") == false
					&& typelist[i].Name.Contains("<>c") == false
					&& isNotMappedClass == false
					) {
					//Console.WriteLine(typelist[i].Name);
					Type type = myAssembly.GetType(typelist[i].FullName);
					CheckTable(typelist[i].Name,type,htable);
				}
			}
			/* End SQL Page Helper */
		}

		private static Type[] GetTypesInNamespace(Assembly assembly,string nameSpace) {
			return
			  assembly.GetTypes()
					  .Where(t => String.Equals(t.Namespace,nameSpace,StringComparison.Ordinal))
					  .ToArray();
		}

		private static void CheckTable(string tableName,Type type,Hashtable htable) {


			string sql = "";
			//try {
			System.Reflection.PropertyInfo[] properties = type.GetProperties();
			string columns = "";
			bool isSkip = false;
			foreach(var p in properties) {
				isSkip = false;
				if(p.CanRead == false || p.CanWrite == false) {
					isSkip = true;
				}
				if(p.PropertyType.FullName.Contains("Pepper.Models") == true) {
					isSkip = true;
				}
				if(p.GetMethod.Attributes.ToString().Contains("Private")) {
					isSkip = true;
				}
				if(isSkip == false) {
					if(p.CustomAttributes.Count() > 0) {
						if(p.CustomAttributes.ToArray()[0].AttributeType.ToString().Contains("NotMapped") == true) {
							isSkip = true;
						}
					}
				}
				if(isSkip == false) {
					string name = p.Name;
					if(htable.ContainsKey(p.Name) == true) {
						name = htable[p.Name].ToString();
					}
					columns += string.Format("\nt.[{0}],",name);
				}
			}
			if(string.IsNullOrEmpty(columns) == false) {
				columns = columns.Substring(0,columns.Length - 1);
			}
			if(string.IsNullOrEmpty(columns) == false) {
				columns = columns.Replace("\n",Environment.NewLine);
				sql = string.Format("select top 1 {0} " + Environment.NewLine + " from [{1}] t ",columns,tableName);

				using(SqlConnection connection = new SqlConnection(ConfigHelper.ConnectionString)) {
					SqlCommand command = new SqlCommand(sql,connection);
					connection.Open();
					using(SqlDataReader reader = command.ExecuteReader()) {
						// Call Read before accessing data. 
						int cnt = 0;
						while(reader.Read()) {
							cnt += 1;
							break;
						}
						// Call Close when done reading.
						reader.Close();
					}
				}

				//} catch (Exception ex) {
				//Console.WriteLine(sql);
				// //Console.WriteLine(tableName + " :: " + ex.Message);
				//}
			}
		}

		public static class ConfigHelper {

			public static string ConnectionString {
				get {
					return System.Configuration.ConfigurationManager.ConnectionStrings["PepperContext"].ToString();
				}
			}
		}

		//private static void UpdatePrice() {
		//    UnderlyingDirectLastPrice[] prices;
		//    using (PepperContext context = new PepperContext()) {
		//        prices = (from q in context.UnderlyingDirectLastPrices
		//                  join eq in context.Equities on q.SecurityID equals eq.EquityID
		//                  where eq.Symbol == ""
		//                  orderby q.LastPriceDate ascending
		//                  select q).ToArray();
		//    }
		//    for (int i = 0;i < prices.Count();i++) {
		//        if (prices[i].UnderlyingDirectLastPriceID == 3724) {
		//            string s = string.Empty;
		//        }
		//        //List<UnderlyingDirectLastPrice> maxPrices = new List<UnderlyingDirectLastPrice>();
		//        List<UnderlyingDirectLastPrice> minPrices = new List<UnderlyingDirectLastPrice>();
		//        decimal lp = (prices[i].LastPrice ?? 0);
		//        for (int j = i - 1;j >= 0;j--) {
		//            if ((prices[j].LastPrice ?? 0) < lp) {
		//                lp = (prices[j].LastPrice ?? 0);
		//                if (prices[i].UnderlyingDirectLastPriceID == 3724) {
		//                    //Console.WriteLine("lp=" + lp);
		//                }
		//                minPrices.Add(prices[j]);
		//            } else {
		//                //  maxPrices.Add(prices[j]);
		//            }
		//        }
		//        //minPrices = (from q in minPrices orderby q.LastPrice select q).ToList();
		//        // maxPrices = (from q in maxPrices orderby q.LastPrice descending select q).ToList();
		//        if (prices[i].UnderlyingDirectLastPriceID == 3724) {
		//            int cnt = 3;
		//            if (minPrices.Count() < 3) {
		//                cnt = minPrices.Count();
		//            }
		//            for (int z = 0;z < minPrices.Count();z++) {
		//                //Console.WriteLine(minPrices[z].LastPriceDate.ToString("yyyy-MM-dd") + "," + minPrices[z].LastPrice);
		//            }
		//            string s = string.Empty;
		//        }
		//    }
		//}

		private static void DeleteDeal() {
			Deal d = new Deal();
			List<Deal> deals = null;
			using(PepperContext context = new PepperContext()) {
				deals = (from q in context.Deals
						 select q).ToList();
			}
			int total = deals.Count();
			for(int i = 0;i < deals.Count();i++) {
				d.DeleteDeal(deals[i].DealID);
				//Console.WriteLine((i + 1).ToString() + " of " + total.ToString());
			}
		}

		/*
		private static void UpdateUnderlyingFundSaleExpectedAmount() {
			using(PepperContext context = new PepperContext()) {
				DateTime minDate = Convert.ToDateTime("01/01/1900");
				//List<int> ids = new List<int> { 72,73,75 };
				List<UnderlyingFundSaleLineItem> items = (from q in context.UnderlyingFundSaleLineItems
														  join deal in context.Deals on q.DealID equals deal.DealID
														  //where ids.Contains(q.UnderlyingFundSaleLineItemID) == true
														  orderby q.UnderlyingFundSaleLineItemID ascending
														  select q).ToList();
				foreach(var item in items) {
					Deal deal = (from q in context.Deals
								 where q.DealID == item.DealID
								 select q).FirstOrDefault();
					Authentication.CurrentEntity = new Entity { EntityID = deal.EntityID };
					Authentication.CurrentUser = new User { UserID = deal.CreatedBy };
					Authentication.CurrentUser.IsWrite = true;

					//Console.WriteLine("item id=" + item.UnderlyingFundSaleLineItemID);
					UnderlyingFundSale underlyingFundSale = (from q in context.UnderlyingFundSales
															 where q.UnderlyingFundSaleID == item.UnderlyingFundSaleID
															 select q).FirstOrDefault();
					if(underlyingFundSale != null) {
						decimal oldExpectedUnfundedAmount = 0;
						DealUnderlyingFundAdjustment itemAdjustment = (from q in context.DealUnderlyingFundAdjustments
																	   where q.DealUnderlyingFundAdjustmentReasonID == (int)Pepper.Models.CodeFirst.Enums.DealUnderlyingFundAdjustmentReason.UnderlyingFundSaleLineItem
																	   && q.DealUnderlyingFundAdjustmentReasonSourceID == item.UnderlyingFundSaleLineItemID
																	   select q).FirstOrDefault();
						int itemAdjustmentID = 0;
						if(itemAdjustment != null) {
							itemAdjustmentID = itemAdjustment.DealUnderlyingFundAdjustmentID;
						}
						List<DealUnderlyingFundAdjustment> adjustments = (from q in context.DealUnderlyingFundAdjustments
																		  join duf in context.DealUnderlyingFunds on q.DealUnderlyingFundID equals duf.DealUnderlyingFundID
																		  where duf.DealID == item.DealID
																		  && duf.UnderlyingFundID == underlyingFundSale.UnderlyingFundID
																		  && System.Data.Entity.DbFunctions.TruncateTime((q.EffectiveDate ?? minDate)) <= System.Data.Entity.DbFunctions.TruncateTime((underlyingFundSale.RecordDate ?? minDate))
																		  && q.DealUnderlyingFundAdjustmentID != itemAdjustmentID
																		  orderby q.UnfundedAmountDate descending, q.ManagerAdjustmentDate descending, q.EffectiveDate descending, q.DealUnderlyingFundAdjustmentID descending
																		  select q).ToList();

						DealUnderlyingFundAdjustment adjustment = (from q in adjustments
																   where q.DealUnderlyingFundAdjustmentID != itemAdjustmentID
																   orderby q.UnfundedAmountDate descending, q.ManagerAdjustmentDate descending, q.EffectiveDate descending, q.DealUnderlyingFundAdjustmentID descending
																   select q).FirstOrDefault();

						if(adjustment != null) {
							oldExpectedUnfundedAmount = (adjustment.CurrentExpectedUnfundedAmount ?? 0);
						}
						if(oldExpectedUnfundedAmount > 0) {
							item.ExpectedUnfundedAmount = DataTypeHelper.SafeDivision(oldExpectedUnfundedAmount,item.CommitmentBeforeSale) * item.SoldCommitment;
						} else {
							item.ExpectedUnfundedAmount = 0;
						}
						context.Entry(item).State = System.Data.Entity.EntityState.Modified;
						context.SaveChanges();
					}
				}
			}
		}

		private static void UpdateCapitalCallsAndUnderlyingFundSales() {
			// List<UnderlyingFundCapitalCallLineItem> underlyingFundCapitalCallLineItems = null;
			int total = 0;
			List<UnderlyingFundSaleLineItem> underlyingFundSaleLineitems = null;
			//List<int> ids = new List<int> { 72,73,75 };
			using(PepperContext context = new PepperContext()) {
				//underlyingFundCapitalCallLineItems = (from q in context.UnderlyingFundCapitalCallLineItems
				//                                      select q).ToList();
				underlyingFundSaleLineitems = (from q in context.UnderlyingFundSaleLineItems
											   //where ids.Contains(q.UnderlyingFundSaleLineItemID) == true
											   select q).ToList();
			}
			//foreach(UnderlyingFundCapitalCallLineItem row in underlyingFundCapitalCallLineItems) {
			//    Deal deal = null;
			//    using(PepperContext context = new PepperContext()) {
			//        deal = (from q in context.Deals
			//                where q.DealID == row.DealID
			//                select q).FirstOrDefault();
			//        Authentication.CurrentEntity = new Entity { EntityID = deal.EntityID };
			//        Authentication.CurrentUser = new User { UserID = deal.CreatedBy };
			//    }
			//    row.Save();
			//    //Console.WriteLine("Update capital call=" + row.UnderlyingFundCapitalCallLineItemID);
			//}
			total = underlyingFundSaleLineitems.Count();
			int index = 0;
			foreach(UnderlyingFundSaleLineItem row in underlyingFundSaleLineitems) {
				index += 1;
				Deal deal = null;
				using(PepperContext context = new PepperContext()) {
					deal = (from q in context.Deals
							where q.DealID == row.DealID
							select q).FirstOrDefault();
					Authentication.CurrentEntity = new Entity { EntityID = deal.EntityID };
					Authentication.CurrentUser = new User { UserID = deal.CreatedBy };
					Authentication.CurrentUser.IsWrite = true;
				}
				row.Save();
				//Console.WriteLine("Update sale=" + row.UnderlyingFundSaleLineItemID + ",index=" + index + ",Total=" + total);
			}
		}

		private static void DeleteManualTransactions() {
			string currentDirectory = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);
			string excelFileName = "Tobedeleted-STND-Manual.xlsx";
			string filePath = Path.Combine(currentDirectory,excelFileName);
			Globals.ConnectExcel(currentDirectory,excelFileName);
			DeleteManualTransactions(excelFileName);
		}

		public static void DeleteManualTransactions(string fileName) {
			string tableName = "Sheet1";
			PagingDataTable dt = Globals.GetExcelDataTable(tableName);
			int index = 1;
			string fundName = string.Empty;
			int dealNumber = 0;
			string dealName = string.Empty;
			string underlyingFundName = string.Empty;
			string direct = string.Empty;
			string symbol = string.Empty;
			string transactionType = string.Empty;
			decimal amount = 0;
			DateTime date;
			DateTime paidOn;
			bool isReconciled;
			string payReceived;
			bool isAvailableForCapitalDistribution;

			List<string> fundNames = new List<string>();
			foreach(DataRow row in dt.Rows) {
				index += 1;
				//Console.WriteLine("row=" + index);

				fundName = DataTypeHelper.ToString(row["FundName"]).Trim();
				if(fundNames.Contains(fundName) == false) {
					fundNames.Add(fundName);
				}
				dealNumber = (int)DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["DealNumber"]).Trim());
				dealName = DataTypeHelper.ToString(row["DealName"]).Trim();
				underlyingFundName = DataTypeHelper.ToString(row["UnderlyingFund"]).Trim();
				direct = DataTypeHelper.ToString(row["Direct"]).Trim();
				symbol = DataTypeHelper.ToString(row["Symbol"]).Trim();
				transactionType = DataTypeHelper.ToString(row["TransactionType"]).Trim();
				amount = DataTypeHelper.ToDecimal(DataTypeHelper.ToString(row["Amount"]).Trim());
				date = DataTypeHelper.ToFromOADate(DataTypeHelper.ToString(row["Date"]).Trim());
				paidOn = DataTypeHelper.ToFromOADate(DataTypeHelper.ToString(row["PaidOn"]).Trim());
				isReconciled = DataTypeHelper.ToBoolean(DataTypeHelper.ToString(row["Reconciled"]).Trim());
				payReceived = DataTypeHelper.ToString(row["Pay/Receive"]).Trim();
				isAvailableForCapitalDistribution = DataTypeHelper.ToBoolean(DataTypeHelper.ToString(row["Available For Capital Distribution"]).Trim());

				int entityID = 2;
				using(PepperContext context = new PepperContext()) {
					Fund fund = (from q in context.Funds where q.EntityID == entityID && q.FundName == fundName select q).FirstOrDefault();
					Deal deal = (from q in context.Deals where q.EntityID == entityID && q.DealNumber == dealNumber && q.DealName == dealName select q).FirstOrDefault();
					UnderlyingFund underlyingFund = null;
					if(string.IsNullOrEmpty(underlyingFundName) == false) {
						underlyingFund = (from q in context.UnderlyingFunds where q.EntityID == entityID && q.FundName == underlyingFundName select q).FirstOrDefault();
					}
					Issuer issuer = null;
					if(string.IsNullOrEmpty(direct) == false) {
						issuer = (from q in context.Issuers where q.EntityID == entityID && q.Name == direct select q).FirstOrDefault();
					}
					Equity equity = null;
					if(string.IsNullOrEmpty(symbol) == false) {
						equity = (from q in context.Equities where q.EntityID == entityID && q.Symbol == symbol select q).FirstOrDefault();
					}

					IQueryable<FundExpense> query = (from q in context.FundExpenses
													 where q.FundID == fund.FundID
													 && q.DealID == deal.DealID
													 select q);
					if(underlyingFund != null) {
						query = (from q in query where q.UnderlyingFundID == underlyingFund.UnderlyingFundID select q);
					}
					if(equity != null) {
						query = (from q in query where q.SecurityTypeID == (int)Pepper.Models.CodeFirst.Enums.SecurityType.Equity && q.SecurityID == equity.EquityID select q);
					}
					query = (from q in query
							 join ftype in context.FundExpenseTypes on q.FundExpenseTypeID equals ftype.FundExpenseTypeID
							 where System.Data.Entity.DbFunctions.Truncate(q.Amount,2) == System.Data.Entity.DbFunctions.Truncate(amount,2)
							 && ftype.Name == transactionType
							 && System.Data.Entity.DbFunctions.TruncateTime(q.Date) == System.Data.Entity.DbFunctions.TruncateTime(date)
							 && System.Data.Entity.DbFunctions.TruncateTime(q.PaidOn) == System.Data.Entity.DbFunctions.TruncateTime(paidOn)
							 && (q.IsReconciled ?? false) == isReconciled
							 && (q.IsReceived ?? false) == (payReceived == "Received" ? true : false)
							 && (q.IsAvailableCapitalDistribution ?? false) == isAvailableForCapitalDistribution
							 select q);

					FundExpense fundExpense = query.FirstOrDefault();
					if(fundExpense != null) {
						//Console.WriteLine("Exist=true");
						//context.FundExpenses.Remove(fundExpense);
						//context.SaveChanges();
						string sql = string.Format("delete from fundexpense where fundexpenseid={0}",fundExpense.FundExpenseID);
						context.Database.ExecuteSqlCommand(sql);
						Util.WriteNewEntry("Row=" + index + ",Delete Fund Expense=" + fundExpense.FundExpenseID);
					} else {
						Util.WriteError("Row=" + index);
					}
				}
			}
		}

		private void UpdateDeal() {
			List<DealUnderlyingFund> rows;
			List<Deal> deals;
			using(PepperContext context = new PepperContext()) {
				rows = context.DealUnderlyingFunds.ToList();
				deals = context.Deals.ToList();
			}
			int total = rows.Count();
			int i = 0;
			foreach(var row in rows) {
				var deal = (from q in deals where q.DealID == row.DealID select q).FirstOrDefault();
				Authentication.CurrentEntity = new Entity { EntityID = deal.EntityID };
				Authentication.CurrentUser = new User { UserID = (row.CreatedBy ?? 0) };
				row.Save();
				i += 1;
				//Console.WriteLine("Total=" + total + ",i=" + i);
			}

		}

		//public static void UpdateFilePath()
		//{
		//    List<Pepper.Models.CodeFirst.File> files;
		//    using (PepperContext context = new PepperContext())
		//    {
		//        files = (from q in context.Files select q).ToList();
		//    }
		//    int total = files.Count();
		//    int index = 0;
		//    foreach (var file in files)
		//    {
		//        index += 1;
		//        if (file.FilePath.StartsWith("Files\\"))
		//        {
		//            file.FilePath = file.FilePath.Replace("Files\\", "");
		//            file.FilePath = "https://onpepperprodstorage.blob.core.windows.net/files/" + file.FilePath;
		//            file.FilePath = file.FilePath.Replace("\\", "/");
		//            if (file.FilePath.EndsWith("/") == false)
		//            {
		//                file.FilePath = file.FilePath + "/";
		//            }
		//            file.Save();
		//        }
		//        //Console.WriteLine("Files Total=" + total + ",Index=" + index);
		//    }
		//}

		public static void UpdateAdjustments() {
			try {
				Authentication.UserProvider = new PrincipalProvider();
				EntityHelper.Initialize();
				List<DealUnderlyingFund> dealUnderlyingFunds = null;
				List<UnderlyingFundCapitalCallLineItem> items = null;
				List<Deal> deals = null;
				//DealUnderlyingFundAdjustmentEngine engine = new DealUnderlyingFundAdjustmentEngine();
				using(PepperContext context = new PepperContext()) {
					deals = (from q in context.Deals
							 select q).ToList();
					dealUnderlyingFunds = (from q in context.DealUnderlyingFunds
										   select q).ToList();
					items = (from q in context.UnderlyingFundCapitalCallLineItems
							 join deal in context.Deals on q.DealID equals deal.DealID
							 where (q.UnderlyingFundCapitalCallID ?? 0) > 0
							 && deal.EntityID == 100002
							 select q).ToList();
				}
				int total = dealUnderlyingFunds.Count();
				int index = 0;
				//foreach (var row in dealUnderlyingFunds)
				//{
				//    var deal = (from q in deals where q.DealID == row.DealID select q).FirstOrDefault();
				//    Authentication.CurrentEntity = new Entity { EntityID = deal.EntityID };
				//    Authentication.CurrentUser = new User { UserID = (row.CreatedBy ?? 0) };
				//    row.Save();
				//    index += 1;
				//    //Console.WriteLine("DealUnderlyingFunds Total=" + total + ",Index=" + index);
				//}
				total = items.Count();
				index = 0;
				foreach(var row in items) {
					var deal = (from q in deals where q.DealID == row.DealID select q).FirstOrDefault();
					Authentication.CurrentEntity = new Entity { EntityID = deal.EntityID };
					Authentication.CurrentUser = new User { UserID = row.CreatedBy };
					row.Save();
					index += 1;
					//Console.WriteLine("Items Total=" + total + ",Index=" + index);
				}
			} catch(Exception ex) {
				//Console.WriteLine("Ex=" + ex.Message);
				if(ex.InnerException != null) {
					//Console.WriteLine("ex.InnerException=" + ex.InnerException.Message);
				}
			}
		}

		/*
		public static void UpdateUnfundedAdjustments()
		{
			List<DealUnderlyingFundAdjustment> adjustments = null;
			//DealUnderlyingFundAdjustmentEngine engine = new DealUnderlyingFundAdjustmentEngine();
			using (PepperContext context = new PepperContext())
			{
				adjustments = (from adj in context.DealUnderlyingFundAdjustments
							   where
							   (adj.DealUnderlyingFundAdjustmentReasonID == (int)Pepper.Models.CodeFirst.Enums.DealUnderlyingFundAdjustmentReason.ManagerAdjustment
							   || adj.DealUnderlyingFundAdjustmentReasonID == (int)Pepper.Models.CodeFirst.Enums.DealUnderlyingFundAdjustmentReason.GPAdjustment
							   )
							   orderby adj.DealUnderlyingFundAdjustmentID
							   select adj).ToList();
			}
			int total = adjustments.Count();
			int index = 0;
			foreach (var adj in adjustments)
			{
				adj.Save();
				index += 1;
				//Console.WriteLine("Total=" + total + ",Index=" + index);
			}
		}
		*/

		/*
		public static void StrategiesDefaultEntityToAll()
		{
			using (PepperContext context = new PepperContext())
			{
				var defaultStrategies = (from q in context.Strategies
										 where q.EntityID == 1
										 select q).ToList();
				var entities = (from q in context.ENTITies
								where q.EntityID != 1
								select q).ToList();
				foreach (var defaultInd in defaultStrategies)
				{
					foreach (var entity in entities)
					{
						int userID = 0;
						var defaultUser = (from q in context.USERs
										   where q.EntityID == entity.EntityID
										   && q.IsAdmin == true
										   orderby q.UserID ascending
										   select q).FirstOrDefault();
						if (defaultUser == null)
						{
							defaultUser = (from q in context.USERs
										   where q.EntityID == entity.EntityID
										   orderby q.UserID ascending
										   select q).FirstOrDefault();
						}
						if (defaultUser != null)
						{
							userID = defaultUser.UserID;
						}
						else
						{
							userID = defaultInd.CreatedBy;
						}
						Strategy row = (from q in context.Strategies
										where q.EntityID == entity.EntityID
										&& q.StrategyName == defaultInd.StrategyName
										select q).FirstOrDefault();
						if (row == null)
						{
							row = new Strategy
							{
								CreatedBy = userID,
								CreatedDate = defaultInd.CreatedDate,
								LastUpdatedBy = userID,
								LastUpdatedDate = defaultInd.LastUpdatedDate,
								EntityID = entity.EntityID,
								StrategyName = defaultInd.StrategyName,
								StrategyAllocationTypeID = defaultInd.StrategyAllocationTypeID,
								Enabled = true,
							};
							context.Strategies.Add(row);
							context.SaveChanges();
							//Console.WriteLine("New strategy=" + defaultInd.StrategyName + ",Entity=" + entity.EntityID);
						}
						if (row != null)
						{
							if (row.StrategyID > 0)
							{
								List<StrategyAllocation> allocations = (from q in context.StrategyAllocations
																		join uf in context.UnderlyingFunds on q.StrategyImplementationID equals uf.UnderlyingFundID 
																		where q.StrategyID == defaultInd.StrategyID
																		&& uf.EntityID == entity.EntityID
																		&& q.StrategyImplementationTypeID == (int)Pepper.Models.CodeFirst.Enums.StrategyImplementationType.UnderlyingFund
																		select q).ToList();
								foreach (var updateRow in allocations)
								{
									updateRow.StrategyID = row.StrategyID;
									context.Entry(updateRow).State = System.Data.Entity.EntityState.Modified;
									//Console.WriteLine("Update alloaction=" + updateRow.StrategyAllocationID + ",Strategy=" + defaultInd.StrategyName + ",Completed");
									context.SaveChanges();
								}
								allocations = (from q in context.StrategyAllocations
										join uf in context.Loans on q.StrategyImplementationID equals uf.LoanID
										where q.StrategyID == defaultInd.StrategyID
										&& uf.EntityID == entity.EntityID
										&& q.StrategyImplementationTypeID == (int)Pepper.Models.CodeFirst.Enums.StrategyImplementationType.Loan
										select q).ToList();
								foreach (var updateRow in allocations)
								{
									updateRow.StrategyID = row.StrategyID;
									context.Entry(updateRow).State = System.Data.Entity.EntityState.Modified;
									//Console.WriteLine("Update alloaction=" + updateRow.StrategyAllocationID + ",Strategy=" + defaultInd.StrategyName + ",Completed");
									context.SaveChanges();
								}
								allocations = (from q in context.StrategyAllocations
											   join uf in context.FixedIncomes on q.StrategyImplementationID equals uf.FixedIncomeID
											   where q.StrategyID == defaultInd.StrategyID
											   && uf.EntityID == entity.EntityID
											   && q.StrategyImplementationTypeID == (int)Pepper.Models.CodeFirst.Enums.StrategyImplementationType.FixedIncome
											   select q).ToList();
								foreach (var updateRow in allocations)
								{
									updateRow.StrategyID = row.StrategyID;
									context.Entry(updateRow).State = System.Data.Entity.EntityState.Modified;
									//Console.WriteLine("Update alloaction=" + updateRow.StrategyAllocationID + ",Strategy=" + defaultInd.StrategyName + ",Completed");
									context.SaveChanges();
								}
								allocations = (from q in context.StrategyAllocations
											   join uf in context.Equities on q.StrategyImplementationID equals uf.EquityID
											   where q.StrategyID == defaultInd.StrategyID
											   && uf.EntityID == entity.EntityID
											   && q.StrategyImplementationTypeID == (int)Pepper.Models.CodeFirst.Enums.StrategyImplementationType.Equity
											   select q).ToList();
								foreach (var updateRow in allocations)
								{
									updateRow.StrategyID = row.StrategyID;
									context.Entry(updateRow).State = System.Data.Entity.EntityState.Modified;
									//Console.WriteLine("Update alloaction=" + updateRow.StrategyAllocationID + ",Strategy=" + defaultInd.StrategyName + ",Completed");
									context.SaveChanges();
								}
								allocations = (from q in context.StrategyAllocations
											   join uf in context.Deals on q.StrategyImplementationID equals uf.DealID
											   where q.StrategyID == defaultInd.StrategyID
											   && uf.EntityID == entity.EntityID
											   && q.StrategyImplementationTypeID == (int)Pepper.Models.CodeFirst.Enums.StrategyImplementationType.Deal
											   select q).ToList();
								foreach (var updateRow in allocations)
								{
									updateRow.StrategyID = row.StrategyID;
									context.Entry(updateRow).State = System.Data.Entity.EntityState.Modified;
									//Console.WriteLine("Update alloaction=" + updateRow.StrategyAllocationID + ",Strategy=" + defaultInd.StrategyName + ",Completed");
									context.SaveChanges();
								}
								List<Equity> equities = (from q in context.Equities
														 where q.StrategyID == defaultInd.StrategyID
														 && q.EntityID == entity.EntityID
														 select q).ToList();
								foreach (var updateRow in equities)
								{
									updateRow.StrategyID = row.StrategyID;
									context.Entry(updateRow).State = System.Data.Entity.EntityState.Modified;
									//Console.WriteLine("Update equity=" + updateRow.Symbol + ",Strategy=" + defaultInd.StrategyName + ",Completed");
									context.SaveChanges();
								}
								List<FixedIncome> fixedIncomes = (from q in context.FixedIncomes
																  where q.StrategyID == defaultInd.StrategyID
																  && q.EntityID == entity.EntityID
																  select q).ToList();
								foreach (var updateRow in fixedIncomes)
								{
									updateRow.StrategyID = row.StrategyID;
									context.Entry(updateRow).State = System.Data.Entity.EntityState.Modified;
									//Console.WriteLine("Update fixed income=" + updateRow.Symbol + ",Strategy=" + defaultInd.StrategyName + ",Completed");
									context.SaveChanges();
								}
								List<PortfolioAsset> portfolioAssets = (from q in context.PortfolioAssets
																		where q.StrategyID == defaultInd.StrategyID
																		&& q.EntityID == entity.EntityID
																		select q).ToList();
								foreach (var updateRow in portfolioAssets)
								{
									updateRow.StrategyID = row.StrategyID;
									context.Entry(updateRow).State = System.Data.Entity.EntityState.Modified;
									//Console.WriteLine("Update fixed income=" + updateRow.PortfolioAssetID + ",Strategy=" + defaultInd.StrategyName + ",Completed");
									context.SaveChanges();
								}
								List<Loan> loans = (from q in context.Loans
													where q.StrategyID == defaultInd.StrategyID
													&& q.EntityID == entity.EntityID
													select q).ToList();
								foreach (var updateRow in loans)
								{
									updateRow.StrategyID = row.StrategyID;
									context.Entry(updateRow).State = System.Data.Entity.EntityState.Modified;
									//Console.WriteLine("Update loan=" + updateRow.LoanID + ",Strategy=" + defaultInd.StrategyName + ",Completed");
									context.SaveChanges();
								}
							}
						}
						//Console.WriteLine("Convert strategy=" + defaultInd.StrategyName + ",Completed");
					}
				}
			}
		}

		public static void IndustriesDefaultEntityToAll()
		{
			using (PepperContext context = new PepperContext())
			{
				var defaultIndustries = (from q in context.Industries
										 where q.EntityID == 1
										 select q).ToList();
				var entities = (from q in context.ENTITies
								where q.EntityID != 1
								select q).ToList();
				foreach (var defaultInd in defaultIndustries)
				{
					foreach (var entity in entities)
					{
						int userID = 0;
						var defaultUser = (from q in context.USERs
										   where q.EntityID == entity.EntityID
										   && q.IsAdmin == true
										   orderby q.UserID ascending
										   select q).FirstOrDefault();
						if (defaultUser == null)
						{
							defaultUser = (from q in context.USERs
										   where q.EntityID == entity.EntityID
										   orderby q.UserID ascending
										   select q).FirstOrDefault();
						}
						if (defaultUser != null)
						{
							userID = defaultUser.UserID;
						}
						else
						{
							userID = defaultInd.CreatedBy;
						}
						Industry row = (from q in context.Industries
										where q.EntityID == entity.EntityID
										&& q.Industry1 == defaultInd.Industry1
										select q).FirstOrDefault();
						if (row == null)
						{
							row = new Industry
							{
								CreatedBy = userID,
								CreatedDate = defaultInd.CreatedDate,
								LastUpdatedBy = userID,
								LastUpdatedDate = defaultInd.LastUpdatedDate,
								EntityID = entity.EntityID,
								Industry1 = defaultInd.Industry1,
								Enabled = true,
							};
							context.Industries.Add(row);
							context.SaveChanges();
							//Console.WriteLine("New industry=" + defaultInd.Industry1 + ",Entity=" + entity.EntityID);
						}
						if (row != null)
						{
							if (row.IndustryID > 0)
							{
								List<UnderlyingFund> underlyingFunds = (from q in context.UnderlyingFunds
																		where q.IndustryID == defaultInd.IndustryID
																		&& q.EntityID == entity.EntityID
																		select q).ToList();
								foreach (var updateRow in underlyingFunds)
								{
									updateRow.IndustryID = row.IndustryID;
									context.Entry(updateRow).State = System.Data.Entity.EntityState.Modified;
									//Console.WriteLine("Update underlying fund=" + updateRow.FundName + ",Industry=" + defaultInd.Industry1 + ",Completed");
									context.SaveChanges();
								}
								List<Company> companies = (from q in context.Companies
														   where q.IndustryID == defaultInd.IndustryID
														   && q.EntityID == entity.EntityID
														   select q).ToList();
								foreach (var updateRow in companies)
								{
									updateRow.IndustryID = row.IndustryID;
									context.Entry(updateRow).State = System.Data.Entity.EntityState.Modified;
									//Console.WriteLine("Update company=" + updateRow.CompanyName + ",Industry=" + defaultInd.Industry1 + ",Completed");
									context.SaveChanges();
								}
								List<Equity> equities = (from q in context.Equities
														 where q.IndustryID == defaultInd.IndustryID
														 && q.EntityID == entity.EntityID
														 select q).ToList();
								foreach (var updateRow in equities)
								{
									updateRow.IndustryID = row.IndustryID;
									context.Entry(updateRow).State = System.Data.Entity.EntityState.Modified;
									//Console.WriteLine("Update equity=" + updateRow.Symbol + ",Industry=" + defaultInd.Industry1 + ",Completed");
									context.SaveChanges();
								}
								List<FixedIncome> fixedIncomes = (from q in context.FixedIncomes
														 where q.IndustryID == defaultInd.IndustryID
														 && q.EntityID == entity.EntityID
														 select q).ToList();
								foreach (var updateRow in fixedIncomes)
								{
									updateRow.IndustryID = row.IndustryID;
									context.Entry(updateRow).State = System.Data.Entity.EntityState.Modified;
									//Console.WriteLine("Update fixed income=" + updateRow.Symbol + ",Industry=" + defaultInd.Industry1 + ",Completed");
									context.SaveChanges();
								}
								List<PortfolioAsset> portfolioAssets = (from q in context.PortfolioAssets
																  where q.IndustryID == defaultInd.IndustryID
																  && q.EntityID == entity.EntityID
																  select q).ToList();
								foreach (var updateRow in portfolioAssets)
								{
									updateRow.IndustryID = row.IndustryID;
									context.Entry(updateRow).State = System.Data.Entity.EntityState.Modified;
									//Console.WriteLine("Update fixed income=" + updateRow.PortfolioAssetID + ",Industry=" + defaultInd.Industry1 + ",Completed");
									context.SaveChanges();
								}
								List<Loan> loans = (from q in context.Loans
																		where q.IndustryID == defaultInd.IndustryID
																		&& q.EntityID == entity.EntityID
																		select q).ToList();
								foreach (var updateRow in loans)
								{
									updateRow.IndustryID = row.IndustryID;
									context.Entry(updateRow).State = System.Data.Entity.EntityState.Modified;
									//Console.WriteLine("Update loan=" + updateRow.LoanID + ",Industry=" + defaultInd.Industry1 + ",Completed");
									context.SaveChanges();
								}
							}
						}
						//Console.WriteLine("Convert industry=" + defaultInd.Industry1 + ",Completed");
					}
				}
			}
		}

		public static void GeographisDefaultEntityToAll()
		{
			using (PepperContext context = new PepperContext())
			{
				var defaultGeographies = (from q in context.Geographies
										  where q.EntityID == 1
										  select q).ToList();
				var entities = (from q in context.ENTITies
								where q.EntityID != 1
								select q).ToList();
				foreach (var defaultGeo in defaultGeographies)
				{
					foreach (var entity in entities)
					{
						int userID = 0;
						var defaultUser = (from q in context.USERs
										   where q.EntityID == entity.EntityID
										   && q.IsAdmin == true
										   orderby q.UserID ascending
										   select q).FirstOrDefault();
						if (defaultUser == null)
						{
							defaultUser = (from q in context.USERs
										   where q.EntityID == entity.EntityID
										   orderby q.UserID ascending
										   select q).FirstOrDefault();
						}
						if (defaultUser != null)
						{
							userID = defaultUser.UserID;
						}
						else
						{
							userID = defaultGeo.CreatedBy;
						}
						Geography row = (from q in context.Geographies
										 where q.EntityID == entity.EntityID
										 && q.Geography1 == defaultGeo.Geography1
										 select q).FirstOrDefault();
						if (row == null)
						{
							row = new Geography
							{
								CreatedBy = userID,
								CreatedDate = defaultGeo.CreatedDate,
								LastUpdatedBy = userID,
								LastUpdatedDate = defaultGeo.LastUpdatedDate,
								EntityID = entity.EntityID,
								Geography1 = defaultGeo.Geography1,
								Enabled = true,
							};
							context.Geographies.Add(row);
							context.SaveChanges();
							//Console.WriteLine("New geography=" + defaultGeo.Geography1 + ",Entity=" + entity.EntityID);
						}
						if (row != null)
						{
							if (row.GeographyID > 0)
							{
								List<UnderlyingFund> underlyingFunds = (from q in context.UnderlyingFunds
																		where q.GeographyID == defaultGeo.GeographyID
																		&& q.EntityID == entity.EntityID
																		select q).ToList();
								foreach (var updateRow in underlyingFunds)
								{
									updateRow.GeographyID = row.GeographyID;
									context.Entry(updateRow).State = System.Data.Entity.EntityState.Modified;
									//Console.WriteLine("Update underlying fund=" + updateRow.FundName + ",Geography=" + defaultGeo.Geography1 + ",Completed");
									context.SaveChanges();
								}
								List<Company> companies = (from q in context.Companies
														   where q.GeographyID == defaultGeo.GeographyID
														   && q.EntityID == entity.EntityID
														   select q).ToList();
								foreach (var updateRow in companies)
								{
									updateRow.GeographyID = row.GeographyID;
									context.Entry(updateRow).State = System.Data.Entity.EntityState.Modified;
									//Console.WriteLine("Update company=" + updateRow.CompanyName + ",Geography=" + defaultGeo.Geography1 + ",Completed");
									context.SaveChanges();
								}
								List<GeographyAllocation> geoAllocations = (from q in context.GeographyAllocations
																			join uf in context.UnderlyingFunds on q.GeographyImplementationID equals uf.UnderlyingFundID
																			where q.GeographyID == defaultGeo.GeographyID
																			&& q.GeographyImplementationTypeID == (int)Pepper.Models.CodeFirst.Enums.GeographyImplementationType.UnderlyingFund
																			&& uf.EntityID == entity.EntityID
																			select q).ToList();
								foreach (var updateRow in geoAllocations)
								{
									updateRow.GeographyID = row.GeographyID;
									context.Entry(updateRow).State = System.Data.Entity.EntityState.Modified;
									//Console.WriteLine("Update Geoalloaction=" + updateRow.GeographyAllocationID + ",Geography=" + defaultGeo.Geography1 + ",Completed");
									context.SaveChanges();
								}
							}
						}
						//Console.WriteLine("Convert geography=" + defaultGeo.Geography1 + ",Completed");
					}
				}
			}
		}

		public static void UpdateDealDetailReport()
		{
			List<DealUnderlyingFundReport> dufs;
			List<DealSecurityReport> dudSecurities;
			List<DealDetail> dealDetails;
			using (PepperContext context = new PepperContext())
			{
				dufs = (from q in context.DealUnderlyingFundReports
						where q.DealID > 0
						select q).ToList();
				dudSecurities = (from q in context.DealSecurityReports
								 where q.DealID > 0
								 select q).ToList();
				dealDetails = (from q in context.DealDetails
							   where q.DealID > 0
							   select q).ToList();
			}
			string sql = "";
			foreach (var row in dufs)
			{
				sql = string.Format("exec PROC_UpdateDealUnderlyingFund {0},{1};", row.DealID, row.UnderlyingFundID);
				ExecuteSQL(sql);
				//Console.WriteLine("DealID=" + row.DealID + ";UnderlyingFundID=" + row.UnderlyingFundID);
			}
			foreach (var row in dudSecurities)
			{
				sql = string.Format("exec PROC_UpdateDealUnderlyingDirect {0},{1},{2};", row.DealID, row.SecurityTypeID, row.SecurityID);
				ExecuteSQL(sql);
				//Console.WriteLine("DealID=" + row.DealID + ";SecurityTypeID=" + row.SecurityTypeID + ";SecurityID=" + row.SecurityID);
			}
			foreach (var row in dealDetails)
			{
				sql = string.Format("exec PROC_UpdateDealDetail {0};", row.DealID);
				ExecuteSQL(sql);
				//Console.WriteLine("DealID=" + row.DealID);
			}
		}

		public static void ExecuteSQL(string sql)
		{
			using (PepperContext context = new PepperContext())
			{
				context.Database.ExecuteSqlCommand(sql);
			}
		}

		public static void Deal_Strategies_Start()
		{
			string currentDirectory = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);
			string excelFileName = "Deal_Strategies.xlsx";
			string filePath = Path.Combine(currentDirectory, excelFileName);
			Globals.ConnectExcel(currentDirectory, excelFileName);
			Globals.ConnectExcel(filePath);
			ProductionImport.Deal_Strategies(excelFileName);
		}

		*/

		//static void Main(string[] args)
		//{
		//    UpdateDealDetailReport();
		//    ////try {
		//    //Authentication.UserProvider = new PrincipalProvider();
		//    //EntityHelper.Initialize();

		//    //using (PepperContext context = new PepperContext())
		//    //{
		//    //    List<FXConversionRate> rates = (from q in context.FXConversionRates
		//    //                                    where (q.IsDefault ?? false) == false
		//    //                                    select q).ToList();
		//    //    foreach (var rate in rates)
		//    //    {
		//    //        List<FXTransaction> transactions = (from q in context.FXTransactions
		//    //                                            where q.FXConversionRateID == rate.FXConversionRateID
		//    //                                            select q).ToList();
		//    //        foreach (var transaction in transactions)
		//    //        {
		//    //            var type = (Pepper.Models.CodeFirst.Enums.FXTransactionSourceType)transaction.FXTransactionSourceTypeID;
		//    //            int underlyingFundId = 0;
		//    //            int securityId = 0;
		//    //            int securityTypeId = 0;
		//    //            switch (type)
		//    //            {
		//    //                case Pepper.Models.CodeFirst.Enums.FXTransactionSourceType.DealUnderlyingFund:
		//    //                    var duf = (from q in context.DealUnderlyingFunds
		//    //                               where q.DealUnderlyingFundID == transaction.FXTransactionSourceID
		//    //                               select q).FirstOrDefault();
		//    //                    if (duf != null)
		//    //                    {
		//    //                        underlyingFundId = duf.UnderlyingFundID;
		//    //                    }
		//    //                    break;
		//    //                case Pepper.Models.CodeFirst.Enums.FXTransactionSourceType.DealUnderlyingDirect:
		//    //                    var dud = (from q in context.DealUnderlyingDirects
		//    //                               where q.DealUnderlyingDirectID == transaction.FXTransactionSourceID
		//    //                               select q).FirstOrDefault();
		//    //                    if (dud != null)
		//    //                    {
		//    //                        securityTypeId = dud.SecurityTypeID;
		//    //                        securityId = dud.SecurityID;
		//    //                    }
		//    //                    break;
		//    //                case Pepper.Models.CodeFirst.Enums.FXTransactionSourceType.UnderlyingFundCapitalCall:
		//    //                    var ufcc = (from q in context.UnderlyingFundCapitalCalls
		//    //                                where q.UnderlyingFundCapitalCallID == transaction.FXTransactionSourceID
		//    //                                select q).FirstOrDefault();
		//    //                    if (ufcc != null)
		//    //                    {
		//    //                        underlyingFundId = ufcc.UnderlyingFundID;
		//    //                    }
		//    //                    break;
		//    //                case Pepper.Models.CodeFirst.Enums.FXTransactionSourceType.UnderlyingFundCapitalCallLineItem:
		//    //                    var ufccitem = (from q in context.UnderlyingFundCapitalCallLineItems
		//    //                                    where q.UnderlyingFundCapitalCallLineItemID == transaction.FXTransactionSourceID
		//    //                                    select q).FirstOrDefault();
		//    //                    if (ufccitem != null)
		//    //                    {
		//    //                        underlyingFundId = ufccitem.UnderlyingFundID;
		//    //                    }
		//    //                    break;
		//    //                case Pepper.Models.CodeFirst.Enums.FXTransactionSourceType.UnderlyingFundCashDistribution:
		//    //                    var ufcd = (from q in context.UnderlyingFundCashDistributions
		//    //                                where q.UnderlyingFundCashDistributionID == transaction.FXTransactionSourceID
		//    //                                select q).FirstOrDefault();
		//    //                    if (ufcd != null)
		//    //                    {
		//    //                        underlyingFundId = ufcd.UnderlyingFundID;
		//    //                    }
		//    //                    break;
		//    //                case Pepper.Models.CodeFirst.Enums.FXTransactionSourceType.UnderlyingFundCashDistributionLineItem:
		//    //                    var ufcditem = (from q in context.CashDistributions
		//    //                                    where q.CashDistributionID == transaction.FXTransactionSourceID
		//    //                                    select q).FirstOrDefault();
		//    //                    if (ufcditem != null)
		//    //                    {
		//    //                        underlyingFundId = ufcditem.UnderlyingFundID;
		//    //                    }
		//    //                    break;
		//    //                case Pepper.Models.CodeFirst.Enums.FXTransactionSourceType.UnderlyingFundNAV:
		//    //                    var nav = (from q in context.UnderlyingFundNAVs
		//    //                               where q.UnderlyingFundNAVID == transaction.FXTransactionSourceID
		//    //                               select q).FirstOrDefault();
		//    //                    if (nav != null)
		//    //                    {
		//    //                        underlyingFundId = nav.UnderlyingFundID;
		//    //                    }
		//    //                    break;
		//    //            }
		//    //            if (underlyingFundId > 0)
		//    //            {
		//    //                UnderlyingFund uf = (from q in context.UnderlyingFunds
		//    //                                     where q.UnderlyingFundID == underlyingFundId
		//    //                                     select q).FirstOrDefault();
		//    //                if (uf != null)
		//    //                {
		//    //                    if ((uf.CurrencyID ?? 0) > 0)
		//    //                    {
		//    //                        rate.SourceCurrencyID = (uf.CurrencyID ?? 0);
		//    //                        context.Entry(rate).State = System.Data.Entity.EntityState.Modified;
		//    //                        context.SaveChanges();
		//    //                    }
		//    //                }
		//    //            }
		//    //            else if (securityTypeId > 0 && securityId > 0)
		//    //            {
		//    //                var securityType = (Pepper.Models.CodeFirst.Enums.SecurityType)securityTypeId;
		//    //                switch (securityType)
		//    //                {
		//    //                    case Pepper.Models.CodeFirst.Enums.SecurityType.Equity:
		//    //                        Equity equity = (from q in context.Equities
		//    //                                         where q.EquityID == securityId
		//    //                                         select q).FirstOrDefault();
		//    //                        if (equity != null)
		//    //                        {
		//    //                            if ((equity.CurrencyID ?? 0) > 0)
		//    //                            {
		//    //                                rate.SourceCurrencyID = (equity.CurrencyID ?? 0);
		//    //                                context.Entry(rate).State = System.Data.Entity.EntityState.Modified;
		//    //                                context.SaveChanges();
		//    //                            }
		//    //                        }
		//    //                        break;
		//    //                    case Pepper.Models.CodeFirst.Enums.SecurityType.FixedIncome:
		//    //                        FixedIncome fi = (from q in context.FixedIncomes
		//    //                                          where q.FixedIncomeID == securityId
		//    //                                          select q).FirstOrDefault();
		//    //                        if (fi != null)
		//    //                        {
		//    //                            if ((fi.CurrencyID ?? 0) > 0)
		//    //                            {
		//    //                                rate.SourceCurrencyID = (fi.CurrencyID ?? 0);
		//    //                                context.Entry(rate).State = System.Data.Entity.EntityState.Modified;
		//    //                                context.SaveChanges();
		//    //                            }
		//    //                        }
		//    //                        break;
		//    //                }
		//    //            }
		//    //        }
		//    //        //Console.WriteLine("Completed Rate=" + rate.FXConversionRateID);
		//    //    }
		//    //}

		//    //} catch(Exception ex) {
		//    //    Util.WriteError("Main ex=" + ex.Message);
		//    //    if(ex.InnerException != null) {
		//    //        Util.WriteError("Main InnerException=" + ex.InnerException.Message);
		//    //    }
		//    //}

		//    //Console.WriteLine("Press any key to continue........");
		//    Console.ReadLine();
		//}

		//public static void SwapSortOrder(string sourceMenuName,string destMenuName) {
		//    using(PepperContext context = new PepperContext()) {
		//        Menu sourceMenu = (from q in context.Menus where q.DisplayName == sourceMenuName select q).FirstOrDefault();
		//        Menu destMenu = (from q in context.Menus where q.DisplayName == destMenuName select q).FirstOrDefault();
		//        if(sourceMenu != null && destMenu != null) {
		//            List<ENTITY> entities = (from q in context.ENTITies select q).ToList();
		//            foreach(var ent in entities) {
		//                EntityMenu sourceEntityMenu = (from q in context.EntityMenus
		//                                               where q.EntityID == ent.EntityID
		//                                               && q.MenuID == sourceMenu.MenuID
		//                                               select q).FirstOrDefault();
		//                EntityMenu destEntityMenu = (from q in context.EntityMenus
		//                                               where q.EntityID == ent.EntityID
		//                                               && q.MenuID == destMenu.MenuID
		//                                               select q).FirstOrDefault();
		//                if(sourceEntityMenu != null && destEntityMenu != null) {
		//                    if(sourceEntityMenu.SortOrder < destEntityMenu.SortOrder) {
		//                        int sourEntitySortOrder = sourceEntityMenu.SortOrder;
		//                        sourceEntityMenu.SortOrder = destEntityMenu.SortOrder;
		//                        destEntityMenu.SortOrder = sourEntitySortOrder;
		//                        context.Entry(sourceEntityMenu).State = System.Data.Entity.EntityState.Modified;
		//                        context.Entry(destEntityMenu).State = System.Data.Entity.EntityState.Modified;
		//                        context.SaveChanges();
		//                        //Console.WriteLine("Completed Entity=" + ent.EntityName);
		//                    }
		//                }
		//            }
		//        } else {
		//            if(sourceMenu == null) {
		//                //Console.WriteLine("Source Menu Does not exist");
		//            }
		//            if(destMenu == null) {
		//                //Console.WriteLine("Dest Menu Does not exist");
		//            }
		//        }
		//    }
		//}

		//public static void DEEP_BLUE_MK_Deal_Start() {
		//    string currentDirectory = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);
		//    string excelFileName = "Deal Template - Catch Up Period - For PULAK.xlsx";
		//    string filePath = Path.Combine(currentDirectory,excelFileName);
		//    Globals.ConnectExcel(currentDirectory,excelFileName);
		//    Globals.ConnectExcel(filePath);
		//    ProductionImport.DEEP_BLUE_MK_Deal_Start(excelFileName);
		//}

		//public static void DEEP_BLUE_MK_UnderlyingFund_Start() {
		//    string currentDirectory = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);
		//    string excelFileName = "UnderlyingFundImportExcel.xlsx";
		//    string filePath = Path.Combine(currentDirectory,excelFileName);
		//    Globals.ConnectExcel(currentDirectory,excelFileName);
		//    Globals.ConnectExcel(filePath);
		//    ProductionImport.DEEP_BLUE_MK_UnderlyingFund_Start();
		//}

		//public static void UnderyingFundsCOMMENTsforPulak_Start() {
		//    string currentDirectory = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);
		//    string excelFileName = "Production_Server_UnderyingFunds CATCH UP FOR PULAK.xlsx";
		//    string filePath = Path.Combine(currentDirectory,excelFileName);
		//    Globals.ConnectExcel(currentDirectory,excelFileName);
		//    Globals.ConnectExcel(filePath);
		//    ProductionImport.UnderyingFundsCOMMENTsforPulak_Start(excelFileName);
		//}

		//public static void MergeUnderlyingFund(string fromUnderlyingFundName,string toUnderlyingFundName) {
		//    int sourceID = 0;
		//    int destID = 0;
		//    try {
		//        using(PepperContext context = new PepperContext()) {
		//            sourceID = (from q in context.UnderlyingFunds where q.FundName == fromUnderlyingFundName select q.UnderlyingFundID).FirstOrDefault();
		//            destID = (from q in context.UnderlyingFunds where q.FundName == toUnderlyingFundName select q.UnderlyingFundID).FirstOrDefault();
		//        }
		//    } catch { }
		//    if((sourceID > 0 && destID > 0) && (sourceID != destID)) {
		//        string sql = "select table_name from information_schema.columns where column_name = 'UnderlyingFundID' and table_name != 'UnderlyingFund' order by table_name asc";
		//        List<TempTableName> tableNames;
		//        using(PepperContext context = new PepperContext()) {
		//            tableNames = context.Database.SqlQuery<TempTableName>(sql).ToList();
		//        }
		//        foreach(var tbl in tableNames) {
		//            sql = string.Format("update {0} set UnderlyingFundID = {1} where UnderlyingFundID = {2}",tbl.table_name,destID,sourceID);
		//            using(PepperContext context = new PepperContext()) {
		//                context.Database.ExecuteSqlCommand(sql);
		//                //Console.WriteLine("Merge UnderlyingFund Success TableName=" + tbl.table_name);
		//            }
		//        }
		//        using(PepperContext context = new PepperContext()) {
		//            sql = string.Format("delete from underlyingfund where UnderlyingFundID = {0}",sourceID);
		//            context.Database.ExecuteSqlCommand(sql);
		//            //Console.WriteLine("Delete UnderlyingFund fromUnderlyingFundName=" + fromUnderlyingFundName + ",SourceID=" + sourceID);
		//        }
		//    }
		//}

		//public static void AMB_III_QA_Start() {
		//    string currentDirectory = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);
		//    string excelFileName = "AMB_III_QA.xlsx";
		//    string filePath = Path.Combine(currentDirectory,excelFileName);
		//    Globals.ConnectExcel(currentDirectory,excelFileName);
		//    Globals.ConnectExcel(filePath);
		//    ProductionImport.AMB_III_QA_Start();
		//}

		//public static void AMB_IV_QA_Start() {
		//    string currentDirectory = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);
		//    string excelFileName = "AMB_IV_QA.xlsx";
		//    string filePath = Path.Combine(currentDirectory,excelFileName);
		//    Globals.ConnectExcel(currentDirectory,excelFileName);
		//    Globals.ConnectExcel(filePath);
		//    ProductionImport.AMB_IV_QA_Start();
		//}


		//public static void AMB_V_QA_Start() {
		//    string currentDirectory = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);
		//    string excelFileName = "AMB_V_QA.xlsx";
		//    string filePath = Path.Combine(currentDirectory,excelFileName);
		//    Globals.ConnectExcel(currentDirectory,excelFileName);
		//    Globals.ConnectExcel(filePath);
		//    ProductionImport.AMB_V_QA_Start();
		//}

		//public static void AMB_VI_QA_Start() {
		//    string currentDirectory = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);
		//    string excelFileName = "AMB_VI_QA.xlsx";
		//    string filePath = Path.Combine(currentDirectory,excelFileName);
		//    Globals.ConnectExcel(currentDirectory,excelFileName);
		//    Globals.ConnectExcel(filePath);
		//    ProductionImport.AMB_VI_QA_Start();
		//}

		//public static void DealExcelStart2() {
		//    string currentDirectory = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);
		//    string excelFileName = "ImportDeal2.xlsx";
		//    string filePath = Path.Combine(currentDirectory,excelFileName);
		//    Globals.ConnectExcel(currentDirectory,excelFileName);
		//    Globals.ConnectExcel(filePath);
		//    ImportDeal2.Start();
		//}

		//public static void UnderlyingFundExcelStart() {
		//    string currentDirectory = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);
		//    string excelFileName = "UnderlyingFundImportExcel.xlsx";
		//    string filePath = Path.Combine(currentDirectory,excelFileName);
		//    Globals.ConnectExcel(currentDirectory,excelFileName);
		//    Globals.ConnectExcel(filePath);
		//    ImportUnderlyingFund.Start();
		//}

		//public class EmailUtil {

		//    public static bool SendEmail(
		//       string toAddress
		//       ,string emailSubject
		//       ,string emailBody) {

		//        bool isSend = false;

		//        try {
		//            var message = new IdentityMessage {
		//                Destination = toAddress,
		//                Body = emailBody,
		//                Subject = emailSubject,
		//            };
		//            var myMessage = new SendGridMessage();
		//            myMessage.AddTo(message.Destination);
		//            myMessage.From = new System.Net.Mail.MailAddress(
		//                                ConfigurationManager.AppSettings["mailFromEmail"],ConfigurationManager.AppSettings["mailFromName"]);
		//            myMessage.Subject = message.Subject;
		//            myMessage.Text = message.Body;
		//            myMessage.Html = message.Body;

		//            var credentials = new NetworkCredential(
		//                       ConfigurationManager.AppSettings["mailAccount"],
		//                       ConfigurationManager.AppSettings["mailPassword"]
		//                       );

		//            // Create a Web transport for sending email.
		//            var transportWeb = new Web(credentials);

		//            // Send the email.
		//            if (transportWeb != null) {
		//                transportWeb.DeliverAsync(myMessage);
		//            }
		//        } catch (Exception ex) {
		//            string errorMessage = "Email Send Exception:" + ex.Message + Environment.NewLine;
		//            if (ex.InnerException != null) {
		//                errorMessage = "Email Send INNER Exception :" + ex.InnerException.Message + Environment.NewLine;
		//            }
		//            Helper.Log(errorMessage,"SMTP_Exception_MAIL_LOG");
		//        } finally {
		//            Helper.Log("**************** Mail Send End ***********************","SMTP_MAIL_LOG");
		//        }
		//        return isSend;
		//    }

		//    public static bool Old_BackUp_SendEmail(
		//        string fromAddress
		//        ,string toName
		//        ,string toAddress
		//        ,string emailSubject
		//        ,string emailBody) {

		//        bool isSend = false;
		//        MailMessage msg = new MailMessage();
		//        string randomNumber = string.Empty;

		//        string smtpServerName = ConfigurationManager.AppSettings["SMTP_SERVER_NAME"];
		//        string smtpFromName = ConfigurationManager.AppSettings["SMTP_FROM_NAME"];
		//        string smtpUserName = ConfigurationManager.AppSettings["SMTP_USER_NAME"];
		//        string smtpPassword = ConfigurationManager.AppSettings["SMTP_PASSWORD"];
		//        string smtpSSL = ConfigurationManager.AppSettings["SMTP_IS_SSL"];
		//        int smtpServerPort = DataTypeHelper.ToInt32(ConfigurationManager.AppSettings["SMTP_PORT"]);
		//        try {

		//            Helper.Log("**************** Mail Send Start ***********************","SMTP_MAIL_LOG_" + randomNumber);

		//            msg.From = new MailAddress(fromAddress.Trim(),smtpFromName);

		//            msg.To.Add(new MailAddress(toAddress.Trim(),toName));

		//            msg.CC.Add(new MailAddress(fromAddress.Trim(),smtpFromName));

		//            // Set to high priority
		//            msg.Priority = MailPriority.High;

		//            msg.Subject = emailSubject;
		//            msg.Body = emailBody;
		//            // In order for the mail client to interpret message
		//            // body correctly, we mark the body as HTML
		//            // because we set the body to HTML contents.
		//            msg.IsBodyHtml = true;

		//            // Connecting to the server and configuring it
		//            SmtpClient client = new SmtpClient();
		//            client.Host = smtpServerName; // "smtp.gmail.com";
		//            client.Port = smtpServerPort; // (smtpSetting.port ?? 0); // 578;

		//            if (smtpSSL == "true") {
		//                client.EnableSsl = true;
		//            }
		//            // The server requires user's credentials
		//            // not the default credentials
		//            client.UseDefaultCredentials = true;
		//            //Helper.Log("client.UseDefaultCredentials=" + client.UseDefaultCredentials);
		//            // Provide your credentials
		//            client.Credentials = new System.Net.NetworkCredential(smtpUserName,smtpPassword);
		//            client.DeliveryMethod = SmtpDeliveryMethod.Network;

		//            // Use SendAsync to send the message asynchronously

		//            if (msg.From != null) {
		//                Helper.Log("From Email=" + msg.From.Address + ",DisplayName=" + msg.From.DisplayName,"SMTP_MAIL_LOG_" + randomNumber);
		//            }
		//            if (msg.To != null) {
		//                foreach (var email in msg.To) {
		//                    Helper.Log("To Email=" + email.Address + ",DisplayName=" + email.DisplayName,"SMTP_MAIL_LOG_" + randomNumber);
		//                }
		//            }
		//            if (msg.CC != null) {
		//                foreach (var email in msg.CC) {
		//                    Helper.Log("CC Email=" + email.Address + ",DisplayName=" + email.DisplayName,"SMTP_MAIL_LOG_" + randomNumber);
		//                }
		//            }
		//            if (msg.Bcc != null) {
		//                foreach (var email in msg.Bcc) {
		//                    Helper.Log("BCCEMAIL Email=" + email.Address + ",DisplayName=" + email.DisplayName,"SMTP_MAIL_LOG_" + randomNumber);
		//                }
		//            }
		//            Helper.Log("SUBJECT=" + msg.Subject,"SMTP_MAIL_LOG_" + randomNumber);

		//            Helper.Log("client.Host=" + client.Host,"SMTP_MAIL_LOG_" + randomNumber);
		//            Helper.Log("client.Port=" + client.Port,"SMTP_MAIL_LOG_" + randomNumber);
		//            Helper.Log("this.ServerUserName=" + smtpUserName,"SMTP_MAIL_LOG_" + randomNumber);
		//            Helper.Log("this.IsLocal=" + Helper.IsLocal,"SMTP_MAIL_LOG_" + randomNumber);
		//            Helper.Log("client.EnableSsl=" + client.EnableSsl,"SMTP_MAIL_LOG_" + randomNumber);

		//            //if (Helper.IsLocal == true) {
		//            //    Helper.WriteEmail(msg.Body);
		//            //} else {
		//            client.Send(msg);
		//            //}
		//            Helper.Log("Email Send Complete","SMTP_MAIL_LOG_" + randomNumber);
		//            isSend = true;
		//        } catch (Exception ex) {
		//            string errorMessage = "Email Send Exception:" + ex.Message + Environment.NewLine;
		//            if (ex.InnerException != null) {
		//                errorMessage = "Email Send INNER Exception :" + ex.InnerException.Message + Environment.NewLine;
		//            }
		//            Helper.Log(errorMessage,"SMTP_Exception_MAIL_LOG_" + randomNumber);
		//        } finally {
		//            Helper.Log("**************** Mail Send End ***********************","SMTP_MAIL_LOG_" + randomNumber);
		//            msg.Dispose();
		//        }
		//        return isSend;
		//    }
		//}
	}

	//public class StockSaleLotHistoryModel {

	//    public int? LotNumber { get; set; }

	//    public string Fund { get; set; }

	//    public string Issuer { get; set; }

	//    public string Symbol { get; set; }

	//    public decimal? SellQuantity { get; set; }

	//    public int SecuritySaleID { get; set; }

	//    public int? DealID { get; set; }

	//    public int? DealNumber { get; set; }

	//    public string DealName { get; set; }


	//}

	//public class TempTableName {
	//    public string table_name { get; set; }
	//}


	public class OpenXMLCellValue {
		public uint RowIndex { get; set; }
		public string ColumnName { get; set; }
		public DocumentFormat.OpenXml.Spreadsheet.CellValues CellDataType { get; set; }
		public string Value { get; set; }
		public bool IsIgnore { get; set; }
		public string HorizontalAlign { get; set; }
		public string VerticalAlign { get; set; }
		public bool IsFormula { get; set; }
		public bool IsNoSetting { get; set; }
	}

	public class OpenXMLImageValue {
		public string FullFileName { get; set; }
		public int ColOffset { get; set; }
		public int RowOffset { get; set; }
		public int ColNumber { get; set; }
		public int RowNumber { get; set; }
	}

	//public class OpenXMLWindowsApp {

	//	// Retrieve the value of a cell, given a file name, sheet name, 
	//	// and address name.
	//	public static string GetCellValue(string fileName,
	//		string sheetName,
	//		string addressName) {
	//		string value = null;

	//		// Open the spreadsheet document for read-only access.
	//		using(SpreadsheetDocument document =
	//			SpreadsheetDocument.Open(fileName,false)) {
	//			// Retrieve a reference to the workbook part.
	//			WorkbookPart wbPart = document.WorkbookPart;

	//			// Find the sheet with the supplied name, and then use that 
	//			// Sheet object to retrieve a reference to the first worksheet.
	//			Sheet theSheet = wbPart.Workbook.Descendants<Sheet>().
	//			  Where(s => s.Name == sheetName).FirstOrDefault();

	//			// Throw an exception if there is no sheet.
	//			if(theSheet == null) {
	//				throw new ArgumentException("sheetName");
	//			}

	//			// Retrieve a reference to the worksheet part.
	//			WorksheetPart wsPart =
	//				(WorksheetPart)(wbPart.GetPartById(theSheet.Id));

	//			// Use its Worksheet property to get a reference to the cell 
	//			// whose address matches the address you supplied.
	//			Cell theCell = wsPart.Worksheet.Descendants<Cell>().
	//			  Where(c => c.CellReference == addressName).FirstOrDefault();

	//			// If the cell does not exist, return an empty string.
	//			if(theCell.InnerText.Length > 0) {
	//				value = theCell.InnerText;

	//				// If the cell represents an integer number, you are done. 
	//				// For dates, this code returns the serialized value that 
	//				// represents the date. The code handles strings and 
	//				// Booleans individually. For shared strings, the code 
	//				// looks up the corresponding value in the shared string 
	//				// table. For Booleans, the code converts the value into 
	//				// the words TRUE or FALSE.
	//				if(theCell.DataType != null) {
	//					switch(theCell.DataType.Value) {
	//						case CellValues.SharedString:

	//							// For shared strings, look up the value in the
	//							// shared strings table.
	//							var stringTable =
	//								wbPart.GetPartsOfType<SharedStringTablePart>()
	//								.FirstOrDefault();

	//							// If the shared string table is missing, something 
	//							// is wrong. Return the index that is in
	//							// the cell. Otherwise, look up the correct text in 
	//							// the table.
	//							if(stringTable != null) {
	//								value =
	//									stringTable.SharedStringTable
	//									.ElementAt(int.Parse(value)).InnerText;
	//							}
	//							break;

	//						case CellValues.Boolean:
	//							switch(value) {
	//								case "0":
	//									value = "FALSE";
	//									break;
	//								default:
	//									value = "TRUE";
	//									break;
	//							}
	//							break;
	//					}
	//				}
	//			}
	//		}
	//		return value;
	//	}

	//	// Retrieve the value of a cell, given a file name, sheet name, 
	//	// and address name.
	//	public static string GetCellValue(WorkbookPart wbPart,
	//		string sheetName,
	//		string addressName) {
	//		string value = null;
	//		try {
	//			// Open the spreadsheet document for read-only access.
	//			// using (SpreadsheetDocument document =
	//			//    SpreadsheetDocument.Open(fileName, false)) {
	//			// Retrieve a reference to the workbook part.
	//			// WorkbookPart wbPart = document.WorkbookPart;

	//			// Find the sheet with the supplied name, and then use that 
	//			// Sheet object to retrieve a reference to the first worksheet.
	//			Sheet theSheet = wbPart.Workbook.Descendants<Sheet>().
	//			  Where(s => s.Name == sheetName).FirstOrDefault();

	//			// Throw an exception if there is no sheet.
	//			if(theSheet == null) {
	//				throw new ArgumentException("sheetName");
	//			}

	//			// Retrieve a reference to the worksheet part.
	//			WorksheetPart wsPart =
	//				(WorksheetPart)(wbPart.GetPartById(theSheet.Id));

	//			// Use its Worksheet property to get a reference to the cell 
	//			// whose address matches the address you supplied.
	//			Cell theCell = wsPart.Worksheet.Descendants<Cell>().
	//			  Where(c => c.CellReference == addressName).FirstOrDefault();

	//			// If the cell does not exist, return an empty string.
	//			if(theCell.InnerText.Length > 0) {
	//				value = theCell.InnerText;

	//				// If the cell represents an integer number, you are done. 
	//				// For dates, this code returns the serialized value that 
	//				// represents the date. The code handles strings and 
	//				// Booleans individually. For shared strings, the code 
	//				// looks up the corresponding value in the shared string 
	//				// table. For Booleans, the code converts the value into 
	//				// the words TRUE or FALSE.
	//				if(theCell.DataType != null) {
	//					switch(theCell.DataType.Value) {
	//						case CellValues.SharedString:

	//							// For shared strings, look up the value in the
	//							// shared strings table.
	//							var stringTable =
	//								wbPart.GetPartsOfType<SharedStringTablePart>()
	//								.FirstOrDefault();

	//							// If the shared string table is missing, something 
	//							// is wrong. Return the index that is in
	//							// the cell. Otherwise, look up the correct text in 
	//							// the table.
	//							if(stringTable != null) {
	//								value =
	//									stringTable.SharedStringTable
	//									.ElementAt(int.Parse(value)).InnerText;
	//							}
	//							break;

	//						case CellValues.Boolean:
	//							switch(value) {
	//								case "0":
	//									value = "FALSE";
	//									break;
	//								default:
	//									value = "TRUE";
	//									break;
	//							}
	//							break;
	//					}
	//				}
	//			}
	//			//}
	//		} catch { }
	//		return value;
	//	}

	//	public static void Update(string fileName,string sheetName,
	//		uint startRowIndex,
	//		List<OpenXMLCellValue> cellValues,
	//		uint totalRowIndex,
	//		bool isIgnoreFormulaCalculation,
	//		List<OpenXMLImageValue> imageValues) {
	//		// Open the document for editing.

	//		using(SpreadsheetDocument spreadSheet = SpreadsheetDocument.Open(fileName,true)) {

	//			WorksheetPart worksheetPart = GetWorksheetPartByName(spreadSheet,sheetName);

	//			if(worksheetPart != null) {
	//				// Create Styles and Insert into Workbook

	//				WorkbookStylesPart stylesPart = spreadSheet.WorkbookPart.WorkbookStylesPart; //.AddNewPart<WorkbookStylesPart>();
	//																							 //Stylesheet styles = new CustomStylesheet();
	//																							 //styles.Save(stylesPart);

	//				Stylesheet styleSheet = stylesPart.Stylesheet;

	//				Row startRow = GetRow(worksheetPart.Worksheet,startRowIndex);

	//				Row row = null;
	//				if(worksheetPart != null && startRow != null) {
	//					List<Cell> startRowCells = (from q in startRow.Elements<Cell>()
	//												select q).ToList();

	//					string columnName = "";
	//					uint maxRowIndex = 0;
	//					uint originalMaxRowIndex = 0;
	//					if(cellValues.Count > 0) {
	//						maxRowIndex = (from q in cellValues
	//									   where q.IsIgnore == false
	//									   select q.RowIndex).Max();
	//					}

	//					originalMaxRowIndex = maxRowIndex;
	//					uint diffRows = 0;
	//					if(totalRowIndex <= 0) {
	//						totalRowIndex = startRowIndex + 1;
	//					}
	//					diffRows = (totalRowIndex - startRowIndex);
	//					maxRowIndex = maxRowIndex + diffRows;

	//					uint z;
	//					int j;
	//					for(z = 1;z <= maxRowIndex;z++) {
	//						// OpenXMLCellValue cellValue = cellValues[i];
	//						//row = GetRow(worksheetPart.Worksheet,z);
	//						//if(totalRowIndex > 0 && z == totalRowIndex) {
	//						row = InsertRow(z,worksheetPart,new Row { RowIndex = z },false);
	//						totalRowIndex = z + 1;
	//						//}
	//						//if(row != null) {
	//						//	for(j = 0;j < startRowCells.Count();j++) {
	//						//		Cell startRowcell = startRowCells[j];
	//						//		columnName = "";
	//						//		Cell cell = null;
	//						//		if(startRowcell.CellReference != null) {
	//						//			columnName = GetColumnName(startRowcell.CellReference.Value);
	//						//			cell = GetCell(worksheetPart.Worksheet,columnName,row);
	//						//			if(cell != null) {
	//						//				row.RemoveChild(cell);
	//						//			}
	//						//			if(startRowcell.CellFormula != null) {
	//						//				startRowcell.CellFormula.CalculateCell = true;
	//						//			}
	//						//			Cell cloneCell = (Cell)startRowcell.Clone();
	//						//			if(cloneCell != null) {
	//						//				cloneCell.CellReference = new StringValue { Value = columnName + z };
	//						//			}
	//						//			row.AppendChild(cloneCell);
	//						//			if(z > originalMaxRowIndex) {
	//						//				cell = GetCell(worksheetPart.Worksheet,columnName,row);
	//						//				cell.CellValue = new CellValue("");
	//						//				if(cell.CellFormula != null) {
	//						//					cell.CellFormula.Text = "";
	//						//				}
	//						//			}
	//						//		}

	//						//	}
	//						//}
	//					}

	//					int i = 0;
	//					for(i = 0;i < cellValues.Count;i++) {
	//						OpenXMLCellValue cellValue = cellValues[i];

	//						if(cellValue.IsNoSetting == true) {
	//							foreach(var c in startRowCells) {
	//								columnName = GetColumnName(c.CellReference.Value);
	//								if(cellValue.ColumnName == columnName) {
	//									string originalCellValue = GetCellValue(spreadSheet.WorkbookPart,sheetName,c.CellReference.InnerText);
	//									cellValue.Value = originalCellValue;
	//									//cellValue.CellDataType = c.DataType;
	//								}
	//							}
	//						}

	//						row = GetRow(worksheetPart.Worksheet,cellValue.RowIndex);
	//						if(row != null) {
	//							Cell cell = GetCell(worksheetPart.Worksheet,cellValue.ColumnName,row);
	//							if(cell == null) {
	//								cell = new Cell();
	//								cell.CellReference = new StringValue { Value = cellValue.ColumnName + cellValue.RowIndex };

	//								if(row != null) {
	//									row.AppendChild(cell);
	//								}
	//							}
	//							if(cell != null) {
	//								if(cellValue.IsFormula == false) {
	//									string v = cellValue.Value;
	//									if(cellValue.CellDataType == CellValues.Number) {
	//										if(string.IsNullOrEmpty(v) == true) {
	//											v = "0";
	//										}
	//									}
	//									cell.CellValue = new CellValue(cellValue.Value);
	//									cell.DataType = new EnumValue<CellValues>(cellValue.CellDataType);
	//								} else {
	//									cell.CellFormula = new CellFormula { Text = cellValue.Value,CalculateCell = true };
	//									cell.CellFormula.Text = cellValue.Value;
	//									cell.DataType = new EnumValue<CellValues>(CellValues.Number);
	//								}

	//								string horizontalAlign = cellValue.HorizontalAlign;
	//								string verticalAlign = cellValue.VerticalAlign;


	//								var alignment = new Alignment { };
	//								if(string.IsNullOrEmpty(horizontalAlign) == false) {

	//									switch(horizontalAlign) {
	//										case "center":
	//											alignment.Horizontal = HorizontalAlignmentValues.Center;
	//											break;
	//										case "left":
	//											alignment.Horizontal = HorizontalAlignmentValues.Left;
	//											break;
	//										case "right":
	//											alignment.Horizontal = HorizontalAlignmentValues.Right;
	//											break;
	//									}

	//								}
	//								if(string.IsNullOrEmpty(verticalAlign) == false) {

	//									switch(verticalAlign) {
	//										case "center":
	//											alignment.Vertical = VerticalAlignmentValues.Center;
	//											break;
	//										case "top":
	//											alignment.Vertical = VerticalAlignmentValues.Top;
	//											break;
	//										case "bottom":
	//											alignment.Vertical = VerticalAlignmentValues.Bottom;
	//											break;
	//									}

	//								}
	//								if(string.IsNullOrEmpty(horizontalAlign) == false ||
	//									string.IsNullOrEmpty(verticalAlign) == false) {
	//									DocumentFormat.OpenXml.Spreadsheet.CellFormat cellFormat = new DocumentFormat.OpenXml.Spreadsheet.CellFormat();

	//									cellFormat.Alignment = alignment;
	//									styleSheet.CellFormats.Append(cellFormat);
	//									UInt32Value result = styleSheet.CellFormats.Count;
	//									styleSheet.CellFormats.Count++;

	//									cell.StyleIndex = result;
	//								}
	//							}
	//						}
	//					}

	//					List<uint> rowIndexList = (from q in cellValues
	//											   where q.IsIgnore == false
	//											   select q.RowIndex).Distinct().ToList();
	//					rowIndexList = (from q in rowIndexList
	//									orderby q
	//									select q).ToList();

	//					row = GetRow(worksheetPart.Worksheet,maxRowIndex + 1);
	//					if(row != null) {
	//						Cell cell = GetCell(worksheetPart.Worksheet,"A",row);
	//						string replaceFormula = string.Format("XIRR(B{0}:B{1},A{2}:C{3})",1,maxRowIndex,1,maxRowIndex);
	//						cell.CellValue.Remove();
	//						cell.CellFormula = new CellFormula { Text = replaceFormula,CalculateCell = true };
	//						cell.DataType = new EnumValue<CellValues>(CellValues.Number);
	//					}
	//					//if(isIgnoreFormulaCalculation == false) {
	//					//	foreach(uint rowIndex in rowIndexList) {
	//					//		row = GetRow(worksheetPart.Worksheet,rowIndex);
	//					//		if(row != null) {
	//					//			i = 0;
	//					//			for(i = 0;i < startRowCells.Count();i++) {
	//					//				Cell cell = startRowCells[i];
	//					//				if(cell.CellReference != null) {
	//					//					if(cell.CellFormula != null) {
	//					//						string originalFormula = cell.CellFormula.Text;
	//					//						string replaceFormula = GetUpdatedFormulaToNewRow(originalFormula,rowIndex);
	//					//						string formulaColumn = GetColumnName(cell.CellReference.Value);
	//					//						Cell formulaCell = GetCell(worksheetPart.Worksheet,formulaColumn,row);
	//					//						if(formulaCell != null) {
	//					//							formulaCell.CellValue = new CellValue("0");
	//					//							formulaCell.CellFormula = new CellFormula { Text = replaceFormula,CalculateCell = true };
	//					//							formulaCell.DataType = new EnumValue<CellValues>(CellValues.Number);
	//					//						}
	//					//					}
	//					//				}
	//					//			}
	//					//		}
	//					//	}
	//					//}
	//					// Save the worksheet.
	//					worksheetPart.Worksheet.Save();
	//				}
	//			}
	//		}
	//	}

	//	public static string GetUpdatedFormulaToNewRow(string formula,uint newRow) {
	//		return Regex.Replace(formula,@"[A-Za-z]+\d+",delegate (Match match) {
	//			//Calculate the new row for this cell in the formula by the given offset
	//			uint oldRow = GetRowIndex(match.Value);
	//			string col = GetColumnName(match.Value);
	//			//uint newRow = oldRow + offset;

	//			//Create the new reference for this cell
	//			string newRef = col + newRow;
	//			return newRef;
	//		});
	//	}

	//	public static void UpdateCell(string fileName,string sheetName,uint rowIndex,string columnName,DocumentFormat.OpenXml.Spreadsheet.CellValues cellDataType,string value) {
	//		// Open the document for editing.
	//		using(SpreadsheetDocument spreadSheet = SpreadsheetDocument.Open(fileName,true)) {
	//			WorksheetPart worksheetPart = GetWorksheetPartByName(spreadSheet,sheetName);

	//			if(worksheetPart != null) {
	//				Cell cell = GetCell(worksheetPart.Worksheet,columnName,rowIndex);
	//				if(cell == null) {
	//					cell = new Cell();
	//					cell.CellReference = new StringValue { Value = columnName + rowIndex };
	//					Row row = GetRow(worksheetPart.Worksheet,rowIndex);
	//					if(row != null) {
	//						row.AppendChild(cell);
	//					}
	//				}
	//				cell.CellValue = new CellValue(value);
	//				cell.DataType = new EnumValue<CellValues>(cellDataType);
	//				// Save the worksheet.
	//				worksheetPart.Worksheet.Save();
	//			}
	//		}
	//	}

	//	public static void UpdateCell(string fileName,string sheetName,List<OpenXMLCellValue> cellValues) {
	//		// Open the document for editing.
	//		using(SpreadsheetDocument spreadSheet = SpreadsheetDocument.Open(fileName,true)) {
	//			WorksheetPart worksheetPart = GetWorksheetPartByName(spreadSheet,sheetName);

	//			if(worksheetPart != null) {
	//				foreach(var field in cellValues) {
	//					Row row = worksheetPart.Worksheet.GetFirstChild<SheetData>().Elements<Row>().Where(r => r.RowIndex == field.RowIndex).FirstOrDefault();
	//					if(row != null) {
	//						Cell cell = GetCell(worksheetPart.Worksheet,field.ColumnName,row);
	//						if(cell != null) {
	//							cell.CellValue = new CellValue(field.Value);
	//							cell.DataType = new EnumValue<CellValues>(field.CellDataType);
	//						}
	//					}
	//				}
	//				// Save the worksheet.
	//				worksheetPart.Worksheet.Save();
	//			}
	//		}
	//	}

	//	private static WorksheetPart GetWorksheetPartByName(SpreadsheetDocument document,string sheetName) {
	//		IEnumerable<Sheet> sheets = document.WorkbookPart.Workbook.GetFirstChild<Sheets>().Elements<Sheet>().Where(s => s.Name == sheetName);

	//		if(sheets.Count() == 0) {
	//			// The specified worksheet does not exist.
	//			return null;
	//		}

	//		string relationshipId = sheets.First().Id.Value;
	//		WorksheetPart worksheetPart = (WorksheetPart)document.WorkbookPart.GetPartById(relationshipId);
	//		return worksheetPart;

	//	}

	//	// Given a worksheet, a column name, and a row index, 
	//	// gets the cell at the specified column and 
	//	private static Cell GetCell(Worksheet worksheet,string columnName,Row row) {
	//		if(row == null)
	//			return null;

	//		var cells = (from q in row.Elements<Cell>()
	//					 where q.CellReference != null
	//					 select q).ToList();

	//		Cell cell = null;
	//		int i;
	//		for(i = 0;i < cells.Count();i++) {
	//			if(cells[i].CellReference != null) {
	//				if(string.Compare(cells[i].CellReference.Value,columnName + row.RowIndex,true) == 0) {
	//					cell = cells[i];
	//				}
	//			}
	//		}
	//		return cell;
	//		//return row.Elements<Cell>().Where(c =>  string.Compare(c.CellReference.Value, columnName + rowIndex, true) == 0).FirstOrDefault();
	//	}

	//	// Given a worksheet, a column name, and a row index, 
	//	// gets the cell at the specified column and 
	//	private static Cell GetCell(Worksheet worksheet,string columnName,uint rowIndex) {
	//		Row row = GetRow(worksheet,rowIndex);

	//		if(row == null)
	//			return null;

	//		return GetCell(worksheet,columnName,row.RowIndex);
	//	}

	//	// Given a worksheet and a row index, return the row.
	//	private static Row GetRow(Worksheet worksheet,uint rowIndex) {
	//		Row row = worksheet.GetFirstChild<SheetData>().Elements<Row>().Where(r => r.RowIndex == rowIndex).FirstOrDefault();
	//		if(row == null) {
	//			SheetData sheetData = worksheet.GetFirstChild<SheetData>();
	//			Row lastRow = sheetData.Elements<Row>().LastOrDefault();
	//			if(lastRow != null) {
	//				//sheetData.InsertAfter(new Row() { RowIndex = (lastRow.RowIndex + 1) }, lastRow);
	//				//Row cloneRow = (Row)lastRow.Clone();
	//				//cloneRow.RowIndex = rowIndex;
	//				//sheetData.InsertAfter(cloneRow,lastRow);
	//				sheetData.InsertAfter(new Row() { RowIndex = rowIndex },lastRow);
	//			} else {
	//				sheetData.Append(new Row() { RowIndex = 0 });
	//			}
	//			row = worksheet.GetFirstChild<SheetData>().Elements<Row>().Where(r => r.RowIndex == rowIndex).FirstOrDefault();
	//		}
	//		return row;
	//	}

	//	/// <summary>
	//	/// Inserts a new row at the desired index. If one already exists, then it is
	//	/// returned. If an insertRow is provided, then it is inserted into the desired
	//	/// rowIndex
	//	/// </summary>
	//	/// <param name="rowIndex">Row Index</param>
	//	/// <param name="worksheetPart">Worksheet Part</param>
	//	/// <param name="insertRow">Row to insert</param>
	//	/// <param name="isLastRow">Optional parameter - True, you can guarantee that this row is the last row (not replacing an existing last row) in the sheet to insert; false it is not</param>
	//	/// <returns>Inserted Row</returns>
	//	public static Row InsertRow(uint rowIndex,WorksheetPart worksheetPart,Row insertRow,bool isNewLastRow = false) {
	//		Worksheet worksheet = worksheetPart.Worksheet;
	//		SheetData sheetData = worksheet.GetFirstChild<SheetData>();

	//		Row retRow = !isNewLastRow ? sheetData.Elements<Row>().FirstOrDefault(r => r.RowIndex == rowIndex) : null;

	//		// If the worksheet does not contain a row with the specified row index, insert one.
	//		if(retRow != null) {
	//			// if retRow is not null and we are inserting a new row, then move all existing rows down.
	//			if(insertRow != null) {
	//				UpdateRowIndexes(worksheetPart,rowIndex,false);
	//				UpdateMergedCellReferences(worksheetPart,rowIndex,false);
	//				UpdateHyperlinkReferences(worksheetPart,rowIndex,false);

	//				// actually insert the new row into the sheet
	//				retRow = sheetData.InsertBefore(insertRow,retRow);  // at this point, retRow still points to the row that had the insert rowIndex

	//				string curIndex = retRow.RowIndex.ToString();
	//				string newIndex = rowIndex.ToString();

	//				foreach(Cell cell in retRow.Elements<Cell>()) {
	//					// Update the references for the rows cells.
	//					cell.CellReference = new StringValue(cell.CellReference.Value.Replace(curIndex,newIndex));
	//				}

	//				// Update the row index.
	//				retRow.RowIndex = rowIndex;
	//			}
	//		} else {
	//			// Row doesn't exist yet, shifting not needed.
	//			// Rows must be in sequential order according to RowIndex. Determine where to insert the new row.
	//			Row refRow = !isNewLastRow ? sheetData.Elements<Row>().FirstOrDefault(row => row.RowIndex > rowIndex) : null;

	//			// use the insert row if it exists
	//			retRow = insertRow ?? new Row() { RowIndex = rowIndex };

	//			IEnumerable<Cell> cellsInRow = retRow.Elements<Cell>();

	//			if(cellsInRow.Any()) {
	//				string curIndex = retRow.RowIndex.ToString();
	//				string newIndex = rowIndex.ToString();

	//				foreach(Cell cell in cellsInRow) {
	//					// Update the references for the rows cells.
	//					cell.CellReference = new StringValue(cell.CellReference.Value.Replace(curIndex,newIndex));
	//				}

	//				// Update the row index.
	//				retRow.RowIndex = rowIndex;
	//			}

	//			sheetData.InsertBefore(retRow,refRow);
	//		}

	//		return retRow;
	//	}

	//	/// <summary>
	//	/// Updates all of the Row indexes and the child Cells' CellReferences whenever
	//	/// a row is inserted or deleted.
	//	/// </summary>
	//	/// <param name="worksheetPart">Worksheet Part</param>
	//	/// <param name="rowIndex">Row Index being inserted or deleted</param>
	//	/// <param name="isDeletedRow">True if row was deleted, otherwise false</param>
	//	private static void UpdateRowIndexes(WorksheetPart worksheetPart,uint rowIndex,bool isDeletedRow) {
	//		// Get all the rows in the worksheet with equal or higher row index values than the one being inserted/deleted for reindexing.
	//		IEnumerable<Row> rows = worksheetPart.Worksheet.Descendants<Row>().Where(r => r.RowIndex.Value >= rowIndex);

	//		foreach(Row row in rows) {
	//			uint newIndex = (isDeletedRow ? row.RowIndex - 1 : row.RowIndex + 1);
	//			string curRowIndex = row.RowIndex.ToString();
	//			string newRowIndex = newIndex.ToString();

	//			foreach(Cell cell in row.Elements<Cell>()) {
	//				// Update the references for the rows cells.
	//				cell.CellReference = new StringValue(cell.CellReference.Value.Replace(curRowIndex,newRowIndex));
	//			}

	//			// Update the row index.
	//			row.RowIndex = newIndex;
	//		}
	//	}

	//	/// <summary>
	//	/// Updates the MergedCelss reference whenever a new row is inserted or deleted. It will simply take the
	//	/// row index and either increment or decrement the cell row index in the merged cell reference based on
	//	/// if the row was inserted or deleted.
	//	/// </summary>
	//	/// <param name="worksheetPart">Worksheet Part</param>
	//	/// <param name="rowIndex">Row Index being inserted or deleted</param>
	//	/// <param name="isDeletedRow">True if row was deleted, otherwise false</param>
	//	private static void UpdateMergedCellReferences(WorksheetPart worksheetPart,uint rowIndex,bool isDeletedRow) {
	//		if(worksheetPart.Worksheet.Elements<MergeCells>().Count() > 0) {
	//			MergeCells mergeCells = worksheetPart.Worksheet.Elements<MergeCells>().FirstOrDefault();

	//			if(mergeCells != null) {
	//				// Grab all the merged cells that have a merge cell row index reference equal to or greater than the row index passed in
	//				List<MergeCell> mergeCellsList = mergeCells.Elements<MergeCell>().Where(r => r.Reference.HasValue)
	//																				 .Where(r => GetRowIndex(r.Reference.Value.Split(':').ElementAt(0)) >= rowIndex ||
	//																							 GetRowIndex(r.Reference.Value.Split(':').ElementAt(1)) >= rowIndex).ToList();

	//				// Need to remove all merged cells that have a matching rowIndex when the row is deleted
	//				if(isDeletedRow) {
	//					List<MergeCell> mergeCellsToDelete = mergeCellsList.Where(r => GetRowIndex(r.Reference.Value.Split(':').ElementAt(0)) == rowIndex ||
	//																				   GetRowIndex(r.Reference.Value.Split(':').ElementAt(1)) == rowIndex).ToList();

	//					// Delete all the matching merged cells
	//					foreach(MergeCell cellToDelete in mergeCellsToDelete) {
	//						cellToDelete.Remove();
	//					}

	//					// Update the list to contain all merged cells greater than the deleted row index
	//					mergeCellsList = mergeCells.Elements<MergeCell>().Where(r => r.Reference.HasValue)
	//																	 .Where(r => GetRowIndex(r.Reference.Value.Split(':').ElementAt(0)) > rowIndex ||
	//																				 GetRowIndex(r.Reference.Value.Split(':').ElementAt(1)) > rowIndex).ToList();
	//				}

	//				// Either increment or decrement the row index on the merged cell reference
	//				foreach(MergeCell mergeCell in mergeCellsList) {
	//					string[] cellReference = mergeCell.Reference.Value.Split(':');

	//					if(GetRowIndex(cellReference.ElementAt(0)) >= rowIndex) {
	//						string columnName = GetColumnName(cellReference.ElementAt(0));
	//						cellReference[0] = isDeletedRow ? columnName + (GetRowIndex(cellReference.ElementAt(0)) - 1).ToString() : IncrementCellReference(cellReference.ElementAt(0),CellReferencePartEnum.Row);
	//					}

	//					if(GetRowIndex(cellReference.ElementAt(1)) >= rowIndex) {
	//						string columnName = GetColumnName(cellReference.ElementAt(1));
	//						cellReference[1] = isDeletedRow ? columnName + (GetRowIndex(cellReference.ElementAt(1)) - 1).ToString() : IncrementCellReference(cellReference.ElementAt(1),CellReferencePartEnum.Row);
	//					}

	//					mergeCell.Reference = new StringValue(cellReference[0] + ":" + cellReference[1]);
	//				}
	//			}
	//		}
	//	}

	//	/// <summary>
	//	/// Updates all hyperlinks in the worksheet when a row is inserted or deleted.
	//	/// </summary>
	//	/// <param name="worksheetPart">Worksheet Part</param>
	//	/// <param name="rowIndex">Row Index being inserted or deleted</param>
	//	/// <param name="isDeletedRow">True if row was deleted, otherwise false</param>
	//	private static void UpdateHyperlinkReferences(WorksheetPart worksheetPart,uint rowIndex,bool isDeletedRow) {
	//		Hyperlinks hyperlinks = worksheetPart.Worksheet.Elements<Hyperlinks>().FirstOrDefault();

	//		if(hyperlinks != null) {
	//			Match hyperlinkRowIndexMatch;
	//			uint hyperlinkRowIndex;

	//			foreach(Hyperlink hyperlink in hyperlinks.Elements<Hyperlink>()) {
	//				hyperlinkRowIndexMatch = Regex.Match(hyperlink.Reference.Value,"[0-9]+");
	//				if(hyperlinkRowIndexMatch.Success && uint.TryParse(hyperlinkRowIndexMatch.Value,out hyperlinkRowIndex) && hyperlinkRowIndex >= rowIndex) {
	//					// if being deleted, hyperlink needs to be removed or moved up
	//					if(isDeletedRow) {
	//						// if hyperlink is on the row being removed, remove it
	//						if(hyperlinkRowIndex == rowIndex) {
	//							hyperlink.Remove();
	//						}
	//						// else hyperlink needs to be moved up a row
	//						else {
	//							hyperlink.Reference.Value = hyperlink.Reference.Value.Replace(hyperlinkRowIndexMatch.Value,(hyperlinkRowIndex - 1).ToString());

	//						}
	//					}
	//					// else row is being inserted, move hyperlink down
	//					else {
	//						hyperlink.Reference.Value = hyperlink.Reference.Value.Replace(hyperlinkRowIndexMatch.Value,(hyperlinkRowIndex + 1).ToString());
	//					}
	//				}
	//			}

	//			// Remove the hyperlinks collection if none remain
	//			if(hyperlinks.Elements<Hyperlink>().Count() == 0) {
	//				hyperlinks.Remove();
	//			}
	//		}
	//	}

	//	/// <summary>
	//	/// Given a cell name, parses the specified cell to get the row index.
	//	/// </summary>
	//	/// <param name="cellReference">Address of the cell (ie. B2)</param>
	//	/// <returns>Row Index (ie. 2)</returns>
	//	public static uint GetRowIndex(string cellReference) {
	//		// Create a regular expression to match the row index portion the cell name.
	//		Regex regex = new Regex(@"\d+");
	//		Match match = regex.Match(cellReference);

	//		return uint.Parse(match.Value);
	//	}

	//	/// <summary>
	//	/// Given a cell name, parses the specified cell to get the column name.
	//	/// </summary>
	//	/// <param name="cellReference">Address of the cell (ie. B2)</param>
	//	/// <returns>Column name (ie. A2)</returns>
	//	private static string GetColumnName(string cellName) {
	//		// Create a regular expression to match the column name portion of the cell name.
	//		Regex regex = new Regex("[A-Za-z]+");
	//		Match match = regex.Match(cellName);

	//		return match.Value;
	//	}
	//	public enum CellReferencePartEnum {
	//		None,
	//		Column,
	//		Row,
	//		Both
	//	}
	//	private static List<char> Letters = new List<char>() { 'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',' ' };

	//	/// <summary>
	//	/// Increments the reference of a given cell.  This reference comes from the CellReference property
	//	/// on a Cell.
	//	/// </summary>
	//	/// <param name="reference">reference string</param>
	//	/// <param name="cellRefPart">indicates what is to be incremented</param>
	//	/// <returns></returns>
	//	public static string IncrementCellReference(string reference,CellReferencePartEnum cellRefPart) {
	//		string newReference = reference;

	//		if(cellRefPart != CellReferencePartEnum.None && !String.IsNullOrEmpty(reference)) {
	//			string[] parts = Regex.Split(reference,"([A-Z]+)");

	//			if(cellRefPart == CellReferencePartEnum.Column || cellRefPart == CellReferencePartEnum.Both) {
	//				List<char> col = parts[1].ToCharArray().ToList();
	//				bool needsIncrement = true;
	//				int index = col.Count - 1;

	//				do {
	//					// increment the last letter
	//					col[index] = Letters[Letters.IndexOf(col[index]) + 1];

	//					// if it is the last letter, then we need to roll it over to 'A'
	//					if(col[index] == Letters[Letters.Count - 1]) {
	//						col[index] = Letters[0];
	//					} else {
	//						needsIncrement = false;
	//					}

	//				} while(needsIncrement && --index >= 0);

	//				// If true, then we need to add another letter to the mix. Initial value was something like "ZZ"
	//				if(needsIncrement) {
	//					col.Add(Letters[0]);
	//				}

	//				parts[1] = new String(col.ToArray());
	//			}

	//			if(cellRefPart == CellReferencePartEnum.Row || cellRefPart == CellReferencePartEnum.Both) {
	//				// Increment the row number. A reference is invalid without this componenet, so we assume it will always be present.
	//				parts[2] = (int.Parse(parts[2]) + 1).ToString();
	//			}

	//			newReference = parts[1] + parts[2];
	//		}

	//		return newReference;
	//	}

	//	private static Row InsertBefore(Worksheet worksheet,uint rowIndex) {
	//		Row newRow = null;
	//		Row row = worksheet.GetFirstChild<SheetData>().Elements<Row>().Where(r => r.RowIndex == rowIndex).FirstOrDefault();
	//		if(row != null) {
	//			SheetData sheetData = worksheet.GetFirstChild<SheetData>();
	//			newRow = new Row() { RowIndex = rowIndex };
	//			worksheet.InsertBefore(newRow,row);
	//		}
	//		return newRow;
	//	}
	//}
}
