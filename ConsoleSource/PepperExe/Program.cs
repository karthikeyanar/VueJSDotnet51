using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using System.IO;
using System.Configuration;
using System.Data;
using System.Threading;
using System.Data.Objects;
using System.Data.SqlClient;
using System.Collections.ObjectModel;
using System.Collections;
using Dapper;
using System.Text.RegularExpressions;
using System.Security.Policy;
using CsvHelper;
using Google.Apis.Auth.OAuth2;
using Google.Apis.Services;
using Google.Apis.Sheets.v4;
using Google.Apis.Sheets.v4.Data;
using Google.Apis.Util.Store;
using System.Data.Metadata.Edm;
using Google.Apis.Drive.v3;
using System.Security.Cryptography;
using System.Runtime.InteropServices.ComTypes;
using System.Net;
using static Microsoft.FSharp.Core.ByRefKinds;
using Newtonsoft.Json;

namespace PepperExe
{

    public class XIRRData
    {
        public DateTime Date { get; set; }
        public decimal Value { get; set; }
    }

    class Program
    {
        static string[] Scopes = { SheetsService.Scope.Spreadsheets, SheetsService.Scope.Drive, SheetsService.Scope.DriveFile };
        static string ApplicationName = "Google Sheets API .NET Quickstart";
        static string _ConnectionString = "";

        static void Main(string[] args)
        { 
            _ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["PepperContext"].ToString(); 
            bool isSkip = false; 
            if (args != null)
            {
                if (args.Length > 0)
                {
                    if (args[0] == "update")
                    {
                        UpdatePrice();
                        isSkip = true;
                    }
                    else if (args[0] == "update_index")
                    {
                        UpdateIndex();
                        isSkip = true;
                    }
                    else if (args[0] == "quarter_index")
                    {
                        UpdatePriceStart();
                        isSkip = true;
                    }
                    else if (args[0] == "update_screener_json")
                    {
                        UpdateScreener();
                        isSkip = true;
                    }
                    else if (args[0] == "update_screener")
                    {
                        UpdateScreenerUsingJSON();
                        isSkip = true;
                    }
                    else if (args[0] == "update_financial")
                    {
                        UpdateFinancial();
                        isSkip = true;
                    }
                    else if (args[0] == "update_financial_screener")
                    {
                        UpdateFinancial_Old();
                        isSkip = true;
                    }
                }
            }
            if (isSkip == false)
            {
                ImportDealUnderlyingDirect.Import();
                ImportDealUnderlyingDirect.ImportAllocation();
                ImportDealUnderlyingDirect.ImportAverage();
                ImportDealUnderlyingDirect.CalculateXIRR();
            }
            Console.WriteLine("Press any key to continue........");
            Console.ReadLine();
        }

        public static void UpdateUrl()
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["PepperContext"].ToString();
            string file = "C:\\Users\\KART\\Downloads\\Symbol-URL-URL.csv";
            string sql = "update dm_asset_core_symbol set TickerUrl=@url where Symbol=@symbol";
            using (TextReader reader = System.IO.File.OpenText(file))
            {
                CSVHeaderHelper csvHeader = new CSVHeaderHelper();
                CsvReader csv = null;
                csv = new CsvReader(reader);
                int i = 0;
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
                    }
                    else
                    {
                        string symbol = csv[csvHeader.GetIndex("Symbol")].Trim();
                        string url = csv[csvHeader.GetIndex("URL")].Trim();
                        using (SqlConnection connection = new SqlConnection(connectionString))
                        {
                            connection.Execute(sql, new
                            {
                                symbol = symbol,
                                url = url
                            });
                        }
                        Console.WriteLine(i);
                    }
                }
            }
        }

        public static void UpdatePrice()
        {
            string rootPath = System.Configuration.ConfigurationManager.AppSettings["RootPath"];
            string credentialPath = System.IO.Path.Combine(rootPath, "credentials.json");
            UserCredential credential;
            string googleSheetId = "";// System.Configuration.ConfigurationManager.AppSettings["googlesheetid"];
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

            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["PepperContext"].ToString();
            string sql = "select symbol from dm_asset_core_lot_share where NumberOfShares > 0 group by symbol order by symbol";
            List<string> symbols = new List<string>();
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                symbols = connection.Query<string>(sql).ToList();
            }

            string exchangeName = "NSE";


            // TODO: Assign values to desired properties of `requestBody`:
            Google.Apis.Sheets.v4.Data.Spreadsheet body = new Google.Apis.Sheets.v4.Data.Spreadsheet();

            body.Properties = new SpreadsheetProperties();
            body.Properties.Title = "GoogleFinanceCheck";

            // Add Temp Sheet
            body.Sheets = new List<Sheet>();

            Sheet sheet = new Sheet();
            sheet.Properties = new SheetProperties();
            sheet.Properties.Title = "Sheet1";
            sheet.Properties.GridProperties = new GridProperties();
            int columnCount = 3;
            int rowCount = symbols.Count() + 1;
            sheet.Properties.GridProperties.ColumnCount = columnCount;
            sheet.Properties.GridProperties.RowCount = rowCount;
            //sheet.Properties.GridProperties.FrozenRowCount = 1;

            sheet.Data = new List<Google.Apis.Sheets.v4.Data.GridData>();
            Google.Apis.Sheets.v4.Data.GridData gd = new Google.Apis.Sheets.v4.Data.GridData();
            List<RowData> rows = new List<RowData>();
            RowData row = null;
            row = new RowData
            {
                Values = new List<CellData>()
            };
            row.Values.Add(new CellData
            {
                UserEnteredValue = new ExtendedValue { StringValue = "Symbol" }
            });
            row.Values.Add(new CellData
            {
                UserEnteredValue = new ExtendedValue { StringValue = "Yesterday" }
            });
            row.Values.Add(new CellData
            {
                UserEnteredValue = new ExtendedValue { StringValue = "Today" }
            });
            rows.Add(row);

            int index = 1;
            string formula = "";
            foreach (string sym in symbols)
            {
                string symbol = sym;
                switch (symbol)
                {
                    case "NEWGEN-BE":
                        symbol = "NEWGEN";
                        break;
                }
                index += 1;
                row = new RowData
                {
                    Values = new List<CellData>()
                };
                row.Values.Add(new CellData
                {
                    UserEnteredValue = new ExtendedValue { StringValue = symbol }
                });
                //=INDEX(GoogleFinance("NASDAQ:GOOGL", "close", WORKDAY(TODAY(),-2)),2,2)
                formula = string.Format("=C{0} + (C{0} * GOOGLEFINANCE(\"{1}:\"&A{0},\"changepct\")) / 100", index, exchangeName);
                //formula = string.Format("=GOOGLEFINANCE(\"{0}{1}\",\"price\",{2},{3},\"DAILY\")", "=A1", startDate, endDate);
                row.Values.Add(new CellData
                {
                    UserEnteredValue = new ExtendedValue { FormulaValue = formula }
                });

                formula = string.Format("=GoogleFinance(\"{0}:{1}\", \"price\")", exchangeName, symbol);
                row.Values.Add(new CellData
                {
                    UserEnteredValue = new ExtendedValue { FormulaValue = formula }
                });
                rows.Add(row);
            }

            gd.RowData = rows;
            sheet.Data.Add(gd);
            body.Sheets.Add(sheet);

            SpreadsheetsResource.CreateRequest request = service.Spreadsheets.Create(body);

            // To execute asynchronously in an async method, replace `request.Execute()` as shown:
            Google.Apis.Sheets.v4.Data.Spreadsheet response = request.Execute();
            // Data.Spreadsheet response = await request.ExecuteAsync();
            //Helper.Log(JsonConvert.SerializeObject(response));
            googleSheetId = response.SpreadsheetId; //"1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms";


            Helper.Log("Sheet created");
            Thread.Sleep(5000);
            //System.Threading.Thread.Sleep((1000*10));
            // Read sheet
            // Define request parameters.
            string range = "A1:C10000";
            SpreadsheetsResource.ValuesResource.GetRequest readRequest = service.Spreadsheets.Values.Get(googleSheetId, range);
            // Prints the names and majors of students in a sample spreadsheet:
            // https://docs.google.com/spreadsheets/d/1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms/edit
            ValueRange valueResponse = readRequest.Execute();
            IList<IList<Object>> values = valueResponse.Values;
            if (values != null && values.Count > 0)
            {
                Helper.Log("Symbol,Yesterday,Today");
                foreach (var sv in values)
                {
                    string symbol = sv[0].ToString();
                    decimal yesterdayPrice;
                    decimal.TryParse(sv[1].ToString(), out yesterdayPrice);
                    decimal todayPrice;
                    decimal.TryParse(sv[2].ToString(), out todayPrice);
                    if (yesterdayPrice > 0)
                    {
                        ImportDealUnderlyingDirect.CreateAssetCore(symbol, DateTime.Now.Date.AddDays(-1), 0, yesterdayPrice, "0", "P");
                    }
                    if (todayPrice > 0)
                    {
                        ImportDealUnderlyingDirect.CreateAssetCore(symbol, DateTime.Now.Date, 0, todayPrice, "0", "P");
                    }
                    Helper.Log(symbol + "," + yesterdayPrice.ToString() + "," + todayPrice);
                }
            }
            else
            {
                Helper.Log("No data found.");
            }
            // Create the DriveService object
            DriveService driveservice = new DriveService(new BaseClientService.Initializer()
            {
                HttpClientInitializer = credential,
                ApplicationName = "AppName"
            });
            // Call the DriveService.Files.Delete method to delete the spreadsheet
            driveservice.Files.Delete(googleSheetId).Execute();
        }

        public static void UpdatePriceStart()
        {
            string rootPath = System.Configuration.ConfigurationManager.AppSettings["RootPath"];
            string credentialPath = System.IO.Path.Combine(rootPath, "credentials.json");
            UserCredential credential;
            string googleSheetId = "";// System.Configuration.ConfigurationManager.AppSettings["googlesheetid"];
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

            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["PepperContext"].ToString();
            string sql = "select tbl2.ToDate as Date,tbl2.Symbol,tbl2.cnt from (" + Environment.NewLine +
                        " select tbl.*,(select count(*) as cnt from dm_asset_core_lot lt where lt.Symbol = tbl.Symbol and lt.RecordDate = tbl.ToDate and lt.SharePrice > 0 and lt.LotType = 'P') as cnt" + Environment.NewLine +
                        " from (" + Environment.NewLine +
                        " select tp.FromDate,tp.ToDate,lot.Symbol from dm_time_period tp" + Environment.NewLine +
                        " left outer join  (select symbol from dm_asset_core_lot lot group by Symbol) lot on lot.Symbol != ''" + Environment.NewLine +
                        " where tp.FromDate > '2020-12-31' and tp.dm_time_period_type_id = 1" + Environment.NewLine +
                        " and tp.ToDate <= '2023-12-31'" + Environment.NewLine +
                        " group by tp.FromDate,tp.ToDate,lot.Symbol" + Environment.NewLine +
                        " ) as tbl " + Environment.NewLine +
                        " ) as tbl2 where tbl2.cnt < 1" + Environment.NewLine +
                        " order by tbl2.ToDate asc" + Environment.NewLine +
                        "";

            List<DealXIRRReportModel> symbols = new List<DealXIRRReportModel>();
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                symbols = connection.Query<DealXIRRReportModel>(sql).ToList();
            }

            foreach (var symbol in symbols)
            {
                Thread.Sleep(5000);
                UpdatePriceToDate(credential, service, symbol.Symbol, symbol.Date.Value.AddDays(-7), symbol.Date.Value);
                Console.Write("Completed enddate=" + symbol.Date.Value.ToString("dd/MMM/yyyy"));
            }
        }

        public static void UpdatePriceToDate(UserCredential credential, SheetsService service, string symbol, DateTime fromDate, DateTime toDate)
        {
            string rootPath = System.Configuration.ConfigurationManager.AppSettings["RootPath"];
            string credentialPath = System.IO.Path.Combine(rootPath, "credentials.json");
            string exchangeName = "NSE";
            // TODO: Assign values to desired properties of `requestBody`:
            Google.Apis.Sheets.v4.Data.Spreadsheet body = new Google.Apis.Sheets.v4.Data.Spreadsheet();

            body.Properties = new SpreadsheetProperties();
            body.Properties.Title = "GoogleFinanceCheck";

            // Add Temp Sheet
            body.Sheets = new List<Sheet>();

            Sheet sheet = new Sheet();
            sheet.Properties = new SheetProperties();
            sheet.Properties.Title = "Sheet1";
            sheet.Properties.GridProperties = new GridProperties();
            int columnCount = 3;
            int rowCount = 100;
            sheet.Properties.GridProperties.ColumnCount = columnCount;
            sheet.Properties.GridProperties.RowCount = rowCount;
            //sheet.Properties.GridProperties.FrozenRowCount = 1;

            sheet.Data = new List<Google.Apis.Sheets.v4.Data.GridData>();
            Google.Apis.Sheets.v4.Data.GridData gd = new Google.Apis.Sheets.v4.Data.GridData();
            List<RowData> rows = new List<RowData>();
            RowData row = null;
            row = new RowData
            {
                Values = new List<CellData>()
            };
            row.Values.Add(new CellData
            {
                UserEnteredValue = new ExtendedValue { StringValue = "Symbol" }
            });
            row.Values.Add(new CellData
            {
                UserEnteredValue = new ExtendedValue { StringValue = "Yesterday" }
            });
            row.Values.Add(new CellData
            {
                UserEnteredValue = new ExtendedValue { StringValue = "Today" }
            });
            rows.Add(row);

            int index = 1;
            string formula = "";

            index += 1;
            row = new RowData
            {
                Values = new List<CellData>()
            };
            string startDate = string.Format("DATE({0},{1},{2})", fromDate.Year, fromDate.Month, fromDate.Day);
            string endDate = string.Format("DATE({0},{1},{2})", toDate.Year, toDate.Month, toDate.Day);
            formula = string.Format("=GOOGLEFINANCE(\"{0}:{1}\",\"price\",{2},{3},\"DAILY\")", exchangeName, symbol, startDate, endDate);
            row.Values.Add(new CellData
            {
                UserEnteredValue = new ExtendedValue { FormulaValue = formula }
            });
            rows.Add(row);

            gd.RowData = rows;
            sheet.Data.Add(gd);
            body.Sheets.Add(sheet);

            SpreadsheetsResource.CreateRequest request = service.Spreadsheets.Create(body);

            // To execute asynchronously in an async method, replace `request.Execute()` as shown:
            Google.Apis.Sheets.v4.Data.Spreadsheet response = request.Execute();
            // Data.Spreadsheet response = await request.ExecuteAsync();
            //Helper.Log(JsonConvert.SerializeObject(response));
            string googleSheetId = response.SpreadsheetId; //"1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms";


            Helper.Log("Sheet created");
            Thread.Sleep(5000);
            //System.Threading.Thread.Sleep((1000*10));
            // Read sheet
            // Define request parameters.
            string range = "A1:C10000";
            SpreadsheetsResource.ValuesResource.GetRequest readRequest = service.Spreadsheets.Values.Get(googleSheetId, range);
            // Prints the names and majors of students in a sample spreadsheet:
            // https://docs.google.com/spreadsheets/d/1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms/edit
            ValueRange valueResponse = readRequest.Execute();
            IList<IList<Object>> values = valueResponse.Values;
            if (values != null && values.Count > 0)
            {
                //Helper.Log("Symbol,Date,Close");
                foreach (var sv in values)
                {
                    try
                    {
                        // Print columns A and E, which correspond to indices 0 and 4.
                        //WriteLog(string.Format("{0},{1},{2}",symbol,sv[0],sv[1]));
                        DateTime date;
                        DateTime.TryParse(sv[0].ToString(), out date);
                        decimal marketPrice;
                        decimal.TryParse(sv[1].ToString(), out marketPrice);
                        if (marketPrice > 0)
                        {
                            ImportDealUnderlyingDirect.CreateAssetCore(symbol, date, 0, marketPrice, "0", "P");
                            Helper.Log(date.ToString("dd/MMM/yyyy") + " - " + marketPrice);
                        }
                    }
                    catch { }
                }
            }
            else
            {
                Helper.Log("No data found.");
            }
            // Create the DriveService object
            DriveService driveservice = new DriveService(new BaseClientService.Initializer()
            {
                HttpClientInitializer = credential,
                ApplicationName = "AppName"
            });
            // Call the DriveService.Files.Delete method to delete the spreadsheet
            driveservice.Files.Delete(googleSheetId).Execute();
        }

        public static void UpdateIndex()
        {
            string formula = "";
            string qtyColumnName = "";
            string columnName = "";
            string rootPath = System.Configuration.ConfigurationManager.AppSettings["RootPath"];
            string credentialPath = System.IO.Path.Combine(rootPath, "credentials.json");
            UserCredential credential;
            string googleSheetId = "19fYfARVBLUM1lUqULYPTXbtDhpNaIKcXhl8q2fBsrOY"; //System.Configuration.ConfigurationManager.AppSettings["googlesheetid"];
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

            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["PepperContext"].ToString();
            string sql = "select 'All' as [Name],ls.* from dm_asset_core_lot_share ls" + Environment.NewLine +
                            "where ls.NumberOfShares > 0" + Environment.NewLine +
                            "";
            List<dm_asset_core_lot_share> symbols = new List<dm_asset_core_lot_share>();
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                symbols = connection.Query<dm_asset_core_lot_share>(sql).ToList();
            }

            string exchangeName = "NSE";
            List<string> categories = new List<string>();
            // (from q in symbols
            //select q.Name).Distinct().ToList();

            categories.Add("All");

            //categories = (from q in categories
            //              orderby q
            //              select q).ToList();

            // TODO: Assign values to desired properties of `requestBody`:
            Google.Apis.Sheets.v4.Data.Spreadsheet body = new Google.Apis.Sheets.v4.Data.Spreadsheet();

            body.Properties = new SpreadsheetProperties();
            body.Properties.Title = "Holding_Status_Auto";
            // Add Temp Sheet
            body.Sheets = new List<Sheet>();

            foreach (var category in categories)
            {

                Sheet sheet = new Sheet();
                sheet.Properties = new SheetProperties();
                sheet.Properties.Title = category;
                sheet.Properties.GridProperties = new GridProperties();
                int columnCount = 100;
                int rowCount = 200;
                sheet.Properties.GridProperties.ColumnCount = columnCount;
                sheet.Properties.GridProperties.RowCount = rowCount;
                //sheet.Properties.GridProperties.FrozenRowCount = 1;

                sheet.Data = new List<Google.Apis.Sheets.v4.Data.GridData>();
                Google.Apis.Sheets.v4.Data.GridData gd = new Google.Apis.Sheets.v4.Data.GridData();
                List<RowData> rows = new List<RowData>();
                RowData row = null;

                row = new RowData
                {
                    Values = new List<CellData>()
                };

                row.Values.Add(new CellData
                {
                    UserEnteredValue = new ExtendedValue { StringValue = "Category" }
                });
                row.Values.Add(new CellData
                {
                    UserEnteredValue = new ExtendedValue { StringValue = "Symbol" }
                });
                row.Values.Add(new CellData
                {
                    UserEnteredValue = new ExtendedValue { StringValue = "Qty" }
                });
                row.Values.Add(new CellData
                {
                    UserEnteredValue = new ExtendedValue { StringValue = "AvgPrice" }
                });
                row.Values.Add(new CellData
                {
                    UserEnteredValue = new ExtendedValue { StringValue = "Total" }
                });
                row.Values.Add(new CellData
                {
                    UserEnteredValue = new ExtendedValue { StringValue = "Yesterday" }
                });
                row.Values.Add(new CellData
                {
                    UserEnteredValue = new ExtendedValue { StringValue = "Today" }
                });
                row.Values.Add(new CellData
                {
                    UserEnteredValue = new ExtendedValue { StringValue = "Today Change" }
                });
                row.Values.Add(new CellData
                {
                    UserEnteredValue = new ExtendedValue { StringValue = "Total Change" }
                });
                row.Values.Add(new CellData
                {
                    UserEnteredValue = new ExtendedValue { StringValue = "PE" }
                });
                rows.Add(row);
                int maxRow = 0;
                List<int> rowsCounts = new List<int>();

                var list = (from q in symbols
                            where q.Name == category
                            select q).ToList();
                if (category == "All")
                {
                    list = (from q in symbols
                            select q).ToList();
                }
                rowsCounts.Add(list.Count);

                maxRow = (from q in rowsCounts select q).Max();

                bool isTotalAppend = false;
                bool isPercentageAppend = false;
                bool isNiftyAppend = false;
                for (int i = 0; i < 100; i++)
                {
                    row = new RowData
                    {
                        Values = new List<CellData>()
                    };

                    list = (from q in symbols
                            where q.Name == category
                            orderby (q.NumberOfShares * q.SharePrice) descending
                            select q).ToList();
                    if (category == "All")
                    {
                        list = (from q in symbols
                                orderby (q.NumberOfShares * q.SharePrice) descending
                                select q).ToList();
                    }

                    dm_asset_core_lot_share lirow = null;
                    try
                    {
                        lirow = list[i];
                    }
                    catch { }
                    if (lirow != null)
                    {
                        row.Values.Add(new CellData
                        {
                            UserEnteredValue = new ExtendedValue { StringValue = lirow.Name }
                        });
                        row.Values.Add(new CellData
                        {
                            UserEnteredValue = new ExtendedValue { StringValue = lirow.Symbol }
                        });
                        row.Values.Add(new CellData
                        {
                            UserEnteredValue = new ExtendedValue { NumberValue = (double)(lirow.NumberOfShares ?? 0) }
                        });
                        row.Values.Add(new CellData
                        {
                            UserEnteredValue = new ExtendedValue { NumberValue = (double)(lirow.SharePrice ?? 0) }
                        });
                        row.Values.Add(new CellData
                        {
                            UserEnteredValue = new ExtendedValue { NumberValue = (double)((lirow.NumberOfShares ?? 0) * (lirow.SharePrice ?? 0)) }
                        });
                        formula = string.Format("(GoogleFinance(\"{0}:{1}\", \"price\"))", exchangeName, lirow.Symbol, qtyColumnName, (i + 2));
                        qtyColumnName = GetExcelColumnName(row.Values.Count - 2);
                        columnName = GetExcelColumnName(row.Values.Count + 2);
                        formula = string.Format("={4}{5} * (" + formula + " / (1 + (GOOGLEFINANCE(\"{2}:{3}\",\"changepct\") / 100)))", columnName, (i + 2), exchangeName, lirow.Symbol, qtyColumnName, (i + 2));
                        //formula = string.Format("=GOOGLEFINANCE(\"{0}{1}\",\"price\",{2},{3},\"DAILY\")", "=A1", startDate, endDate);
                        row.Values.Add(new CellData
                        {
                            UserEnteredValue = new ExtendedValue { FormulaValue = formula }
                        });

                        formula = string.Format("={2}{3} * (GoogleFinance(\"{0}:{1}\", \"price\"))", exchangeName, lirow.Symbol, qtyColumnName, (i + 2));
                        row.Values.Add(new CellData
                        {
                            UserEnteredValue = new ExtendedValue { FormulaValue = formula }
                        });

                        string col1 = GetExcelColumnName(row.Values.Count - 1);
                        string col2 = GetExcelColumnName(row.Values.Count);
                        formula = string.Format("=(({0} - {1}) / {1}) * 100", col2 + (i + 2), col1 + (i + 2));
                        row.Values.Add(new CellData
                        {
                            UserEnteredValue = new ExtendedValue { FormulaValue = formula }
                        });

                        col1 = GetExcelColumnName(row.Values.Count - 1);
                        col2 = GetExcelColumnName(row.Values.Count - 3);
                        formula = string.Format("=(({0} - {1}) / {1}) * 100", col1 + (i + 2), col2 + (i + 2));
                        row.Values.Add(new CellData
                        {
                            UserEnteredValue = new ExtendedValue { FormulaValue = formula }
                        });
                        formula = string.Format("=GOOGLEFINANCE(\"{0}:{1}\",\"pe\")", exchangeName, lirow.Symbol);
                        row.Values.Add(new CellData
                        {
                            UserEnteredValue = new ExtendedValue { FormulaValue = formula }
                        });
                    }

                    if (i > maxRow)
                    {
                        if (row.Values.Count <= 0 && isTotalAppend == false)
                        {
                            for (int k = 1; k <= 4; k++)
                            {
                                string desc = "";
                                if (k == 4)
                                {
                                    desc = "Total";
                                }
                                row.Values.Add(new CellData
                                {
                                    UserEnteredValue = new ExtendedValue { StringValue = desc }
                                });
                            }
                            columnName = GetExcelColumnName(row.Values.Count + 1);
                            formula = string.Format("=SUM({0}2:{0}{1})", columnName, (i + 1));
                            row.Values.Add(new CellData
                            {
                                UserEnteredValue = new ExtendedValue { FormulaValue = formula }
                            });
                            columnName = GetExcelColumnName(row.Values.Count + 1);
                            formula = string.Format("=SUM({0}2:{0}{1})", columnName, (i + 1));
                            row.Values.Add(new CellData
                            {
                                UserEnteredValue = new ExtendedValue { FormulaValue = formula }
                            });
                            columnName = GetExcelColumnName(row.Values.Count + 1);
                            formula = string.Format("=SUM({0}2:{0}{1})", columnName, (i + 1));
                            row.Values.Add(new CellData
                            {
                                UserEnteredValue = new ExtendedValue { FormulaValue = formula }
                            });
                            row.Values.Add(new CellData
                            {
                                UserEnteredValue = new ExtendedValue { StringValue = "" }
                            });

                            isTotalAppend = true;
                        }
                    }
                    if (isTotalAppend == true)
                    {
                        if (row.Values.Count <= 0 && isPercentageAppend == false)
                        {

                            for (int k = 1; k <= 4; k++)
                            {
                                string desc = "";
                                if (k == 4)
                                {
                                    desc = "Difference";
                                }
                                row.Values.Add(new CellData
                                {
                                    UserEnteredValue = new ExtendedValue { StringValue = desc }
                                });
                            }
                            columnName = GetExcelColumnName(row.Values.Count + 1);
                            string prevColumnName = "";
                            string nextToNext = GetExcelColumnName(row.Values.Count + 3);
                            formula = string.Format("=(({0}{1} - {2}{1}) / {2}{1}) * 100", nextToNext, (i + 1), columnName);
                            row.Values.Add(new CellData
                            {
                                UserEnteredValue = new ExtendedValue { FormulaValue = formula }
                            });
                            formula = "";
                            row.Values.Add(new CellData
                            {
                                UserEnteredValue = new ExtendedValue { StringValue = "" }
                            });
                            columnName = GetExcelColumnName(row.Values.Count + 1);
                            prevColumnName = GetExcelColumnName(row.Values.Count);
                            formula = string.Format("=(({0}{1} - {2}{1}) / {2}{1}) * 100", columnName, (i + 1), prevColumnName);
                            row.Values.Add(new CellData
                            {
                                UserEnteredValue = new ExtendedValue { FormulaValue = formula }
                            });
                            row.Values.Add(new CellData
                            {
                                UserEnteredValue = new ExtendedValue { StringValue = "" }
                            });

                            isPercentageAppend = true;
                        }
                    }

                    if (isPercentageAppend == true)
                    {
                        if (row.Values.Count <= 0 && isNiftyAppend == false)
                        {

                            for (int k = 1; k <= 4; k++)
                            {
                                string desc = "";
                                if (k == 4)
                                {
                                    switch (category)
                                    {
                                        case "All": desc = "Nifty"; break;
                                        case "BANK": desc = "Nifty Private Bank"; break;
                                        case "IT": desc = "Nifty IT"; break;
                                        case "Others": desc = ""; break;
                                    }
                                }
                                row.Values.Add(new CellData
                                {
                                    UserEnteredValue = new ExtendedValue { StringValue = desc }
                                });
                            }
                            columnName = GetExcelColumnName(row.Values.Count + 1);
                            string prevColumnName = "";
                            string nextToNext = GetExcelColumnName(row.Values.Count + 3);
                            formula = "";
                            switch (category)
                            {
                                case "All": formula = "=GOOGLEFINANCE(\"INDEXNSE:NIFTY_50\",\"changepct\")"; break;
                                case "BANK": formula = "=GOOGLEFINANCE(\"INDEXNSE:NIFTY_PVT_BANK\",\"changepct\")"; break;
                                case "IT": formula = "=GOOGLEFINANCE(\"INDEXNSE:NIFTY_IT\",\"changepct\")"; break;
                            }
                            if (formula == "")
                            {
                                row.Values.Add(new CellData
                                {
                                    UserEnteredValue = new ExtendedValue { StringValue = "" }
                                });
                            }
                            else
                            {
                                row.Values.Add(new CellData
                                {
                                    UserEnteredValue = new ExtendedValue { FormulaValue = formula }
                                });
                            }
                            row.Values.Add(new CellData
                            {
                                UserEnteredValue = new ExtendedValue { StringValue = "" }
                            });
                            row.Values.Add(new CellData
                            {
                                UserEnteredValue = new ExtendedValue { StringValue = "" }
                            });
                            row.Values.Add(new CellData
                            {
                                UserEnteredValue = new ExtendedValue { StringValue = "" }
                            });
                            isNiftyAppend = true;
                        }
                    }

                    rows.Add(row);
                }

                gd.RowData = rows;
                sheet.Data.Add(gd);
                body.Sheets.Add(sheet);
            }
            SpreadsheetsResource.CreateRequest request = service.Spreadsheets.Create(body);

            // To execute asynchronously in an async method, replace `request.Execute()` as shown:
            Google.Apis.Sheets.v4.Data.Spreadsheet response = request.Execute();
            // Data.Spreadsheet response = await request.ExecuteAsync();
            //Helper.Log(JsonConvert.SerializeObject(response));
            //response.SpreadsheetId; //"1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms";

            Helper.Log("Spread sheet created");
            Thread.Sleep(5000);


            // Define the source and destination sheet IDs and ranges
            string sourceSheetId = response.SpreadsheetId;
            string sourceRange = "Sheet1!A1:CV200";
            string destSheetId = googleSheetId;
            string destRange = "Sheet1!A1:CV200";

            //// Clear the contents of the destination range
            //ClearValuesRequest clearRequest = new ClearValuesRequest();
            //SpreadsheetsResource.ValuesResource.ClearRequest clearValuesRequest =
            //    service.Spreadsheets.Values.Clear(clearRequest, destSheetId, destRange);
            //ClearValuesResponse clearValuesResponse = clearValuesRequest.Execute();

            // Get the source sheet ID
            var spreadsheet = service.Spreadsheets.Get(sourceSheetId).Execute();
            List<int> copySheetIds = new List<int>();
            foreach (var sourceSheet in spreadsheet.Sheets)
            {
                int sourcesheetid = (sourceSheet.Properties.SheetId ?? 0);
                // Copy the sheet to the destination spreadsheet
                var copyrequest = new CopySheetToAnotherSpreadsheetRequest()
                {
                    DestinationSpreadsheetId = destSheetId
                };
                var copySheetRequest = service.Spreadsheets.Sheets.CopyTo(copyrequest, sourceSheetId, sourcesheetid).Execute();
                int copiedSheetId = (copySheetRequest.SheetId ?? 0);
                copySheetIds.Add(copiedSheetId);
            }

            var dsspreadsheet = service.Spreadsheets.Get(destSheetId).Execute();
            int deleteSheetId = 0;
            foreach (var sh in dsspreadsheet.Sheets)
            {
                deleteSheetId = (sh.Properties.SheetId ?? 0);
                if (copySheetIds.Contains(deleteSheetId) == false)
                {
                    var deleteRequest = new DeleteSheetRequest()
                    {
                        SheetId = deleteSheetId
                    };
                    var drrequest = new BatchUpdateSpreadsheetRequest()
                    {
                        Requests = new List<Request>()
                    {
                        new Request()
                        {
                            DeleteSheet = deleteRequest
                        }
                    }
                    };
                    service.Spreadsheets.BatchUpdate(drrequest, destSheetId).Execute();
                }
            }

            //// Get the values from the source sheet
            //SpreadsheetsResource.ValuesResource.GetRequest sourceRequest =
            //    service.Spreadsheets.Values.Get(sourceSheetId, sourceRange);
            //ValueRange sourceResponse = sourceRequest.Execute();
            //IList<IList<Object>> sourceValues = sourceResponse.Values;

            //// Process the data as needed
            //IList<IList<Object>> processedValues = new List<IList<Object>>();
            //foreach (var srow in sourceValues)
            //{
            //    // Here, you can apply any processing you need to do to the row
            //    processedValues.Add(srow);
            //}

            //// Write the processed data to the destination sheet
            //ValueRange destBody = new ValueRange { Values = processedValues };
            //SpreadsheetsResource.ValuesResource.UpdateRequest destRequest =
            //    service.Spreadsheets.Values.Update(destBody, destSheetId, destRange);
            //destRequest.ValueInputOption = SpreadsheetsResource.ValuesResource.UpdateRequest.ValueInputOptionEnum.USERENTERED;
            //UpdateValuesResponse destResponse = destRequest.Execute();

            Helper.Log("Spread sheet merged");
            // Create the DriveService object
            DriveService driveservice = new DriveService(new BaseClientService.Initializer()
            {
                HttpClientInitializer = credential,
                ApplicationName = "AppName"
            });
            // Call the DriveService.Files.Delete method to delete the spreadsheet
            driveservice.Files.Delete(sourceSheetId).Execute();

            Helper.Log("Spread sheet deleted");
        }

        public static string GetExcelColumnName(int columnNumber)
        {
            int dividend = columnNumber;
            string columnName = string.Empty;

            while (dividend > 0)
            {
                int modulo = (dividend - 1) % 26;
                columnName = Convert.ToChar(65 + modulo).ToString() + columnName;
                dividend = (dividend - modulo) / 26;
            }

            return columnName;
        }

        public static void UpdateFinancial()
        {
            string category = "Income Statement";
            int periodTypeId = 2;
            string rootPath = System.Configuration.ConfigurationManager.AppSettings["RootPath"];
            string folderPath = System.IO.Path.Combine(rootPath, "tickertap");
            var files = System.IO.Directory.GetFiles(folderPath);
            int index = 0;
            foreach (var file in files)
            {
                index += 1;
                if (file.Contains(".csv") == true)
                {
                    string symbol = System.IO.Path.GetFileNameWithoutExtension(file);
                    using (TextReader reader = System.IO.File.OpenText(file))
                    {
                        CSVHeaderHelper csvHeader = new CSVHeaderHelper();
                        CsvReader csv = null;
                        csv = new CsvReader(reader);
                        int i = 0;
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
                            }
                            else
                            {
                                string key = csv[csvHeader.GetIndex("Quarter")].Trim();
                                key = key.Replace("&amp;", "&");
                                for (int z = 1; z < csvHeader.Headers.Count; z++)
                                {
                                    DateTime dt = DateTime.ParseExact(csvHeader.Headers[z].Name, "MMM yyyy", null);
                                    decimal v = DataTypeHelper.ToDecimal(csv[csvHeader.GetIndex(csvHeader.Headers[z].Name)]);
                                    if (dt.Year > 1900 && string.IsNullOrEmpty(key) == false)
                                    {
                                        DateTime lastDateOfMonth = new DateTime(dt.Year, dt.Month, DateTime.DaysInMonth(dt.Year, dt.Month));
                                        InsertFinanceValue(symbol, key, category, periodTypeId, lastDateOfMonth, DataTypeHelper.ToDecimal(v));
                                    }
                                }
                            }
                        }
                    }
                }
                Console.WriteLine(index + " of " + files.Length);
            }
        }

        public static void UpdateFinancial_Old()
        {
            string rootPath = System.Configuration.ConfigurationManager.AppSettings["RootPath"];
            string folderPath = System.IO.Path.Combine(rootPath, "screener");
            var files = System.IO.Directory.GetFiles(folderPath);
            int index = 0;
            foreach (var file in files)
            {
                index += 1;
                if (file.Contains(".html") == true)
                {
                    string symbol = System.IO.Path.GetFileNameWithoutExtension(file);
                    string html = System.IO.File.ReadAllText(file);
                    UpdateIndustry(symbol, html);
                    UpdateScreenQuarterly(symbol, html);
                    System.IO.File.Delete(file);
                }
                Console.WriteLine(index + " of " + files.Length);
            }
        }

        public static void UpdateIndustry(string symbol, string html)
        {
            // Regular expression patterns to match sector and industry
            string sectorPattern = @"<a href=""/company/compare/\d+/""[^>]*>([^<]+)";
            string industryPattern = @"<a href=""/company/compare/\d+/\d+/""[^>]*>([^<]+)";

            // Match sector and industry using regular expressions
            Match sectorMatch = Regex.Match(html, sectorPattern);
            Match industryMatch = Regex.Match(html, industryPattern);

            string sql = "update dm_asset_core_symbol set Industry=@Industry,Sector=@Sector,MarketCapital=@MarketCapital where Symbol=@Symbol";

            string sector = "";
            string industry = "";
            decimal marketCapital = 0;

            if (sectorMatch.Success && industryMatch.Success)
            {
                sector = sectorMatch.Groups[1].Value.Trim();
                industry = industryMatch.Groups[1].Value.Trim();
                //Console.WriteLine($"Sector: {sector}");
                //Console.WriteLine($"Industry: {industry}");
            }
            else
            {
                Console.WriteLine("Sector and/or Industry not found.");
            }

            string pattern = @"<span class=""name"">\s*Market Cap\s*</span>\s*<span class=""nowrap value"">\s*â‚¹\s*<span class=""number"">([0-9,]+)</span>\s*Cr.\s*</span>";

            Match match = Regex.Match(html, pattern, RegexOptions.Singleline);

            if (match.Success)
            {
                marketCapital = DataTypeHelper.ToDecimal(match.Groups[1].Value.Replace(",", ""));
            }
            else
            {
                Console.WriteLine("Market Cap not found.");
            }

            using (SqlConnection connection = new SqlConnection(_ConnectionString))
            {
                connection.Execute(sql, new
                {
                    Industry = industry,
                    Sector = sector,
                    MarketCapital = marketCapital,
                    Symbol = symbol
                });
            }
        }

        public static void UpdateScreener()
        {
            string rootPath = System.Configuration.ConfigurationManager.AppSettings["RootPath"];
            string folderPath = System.IO.Path.Combine(rootPath, "screener");
            List<string> ignoreSymbolList = new List<string>
            {
                "BRITANNIA-N3","DUMMYREL","NASDAQ","TATAMTRDVR","IBULHSGFIN-NE","GOLD"
            };
            string ignoreSymbols = Helper.ConvertStringSQLFormat(Helper.ConvertStringIds(ignoreSymbolList));
            string sql = "declare @quarterstartdate datetime;" + Environment.NewLine +
                        "SELECT @quarterstartdate = DATEADD(DD, -1, DATEADD(QQ, DATEDIFF(QQ, 0, GETDATE()) + 1, 0))  " + Environment.NewLine +
                        //"SELECT @quarterstartdate = DATEADD(DD, -1, DATEADD(QQ, DATEDIFF(QQ, 0, '2023-06-30') + 1, 0))  " + Environment.NewLine +
                        "declare @prevquarterenddate datetime; " + Environment.NewLine +
                        "SELECT @prevquarterenddate = DATEADD(MONTH, 3, DATEADD(DAY, -1, DATEADD(QUARTER, -1, DATEADD(QUARTER, DATEDIFF(QUARTER, 0, @quarterstartdate), 0))))" + Environment.NewLine +
                        "select * from (" + Environment.NewLine +
                        "select sym.Symbol,(select count(*) as cnt from FinancialReporting fr where fr.Symbol = sym.Symbol and fr.PeriodDate = @prevquarterenddate and fr.FinancialReportingSourceKeyID = 37) as cnt " + Environment.NewLine +
                        "from dm_asset_core_symbol sym" + Environment.NewLine +
                        " where sym.Symbol not in(" + ignoreSymbols + ")" + Environment.NewLine +
                        "group by sym.Symbol " + Environment.NewLine +
                        ") as tbl where isnull(tbl.cnt,0) <= 0" + Environment.NewLine +
                        "order by tbl.Symbol " + Environment.NewLine +
                        ""; 
            List<string> symbols;
            using (SqlConnection connection = new SqlConnection(_ConnectionString))
            {
                symbols = connection.Query<string>(sql).ToList();
            }
            string json = JsonConvert.SerializeObject(symbols);
            string fileName = System.IO.Path.Combine(folderPath, "symbols.json");
            System.IO.File.WriteAllText(fileName, json);
        }

        public static void UpdateScreenerUsingJSON()
        {
            string rootPath = System.Configuration.ConfigurationManager.AppSettings["RootPath"];
            string folderPath = System.IO.Path.Combine(rootPath, "screener");
            string fileName = System.IO.Path.Combine(folderPath, "symbols.json");
            List<string> symbols = new List<string>();
            if (System.IO.File.Exists(fileName) == true)
            {
                string json = System.IO.File.ReadAllText(fileName);
                try
                {
                    symbols = JsonConvert.DeserializeObject<List<string>>(json);
                }
                catch { symbols = new List<string>(); }
            }
            int index = 0;
            foreach (string symbol in symbols)
            {
                DownloadScreenerSymbol(symbol);
                index += 1;
                Console.WriteLine(index + " of " + symbols.Count);
            }
        }

        private static void DownloadScreenerSymbol(string symbol)
        {
            string rootPath = System.Configuration.ConfigurationManager.AppSettings["RootPath"];
            string folderPath = System.IO.Path.Combine(rootPath, "screener");
            string fileName = System.IO.Path.Combine(folderPath, symbol + ".html");
            string ignoreConsolidatedSymbol = System.Configuration.ConfigurationManager.AppSettings["IgnoreConsolidatedSymbols"];
            List<string> ignoreConsolidatedSymbolList = Helper.ConvertStringList(ignoreConsolidatedSymbol);
            if (System.IO.File.Exists(fileName) == false)
            {
                string html = "";
                bool isIgnoreConsolidated = false;
                string url = "https://www.screener.in/company/{0}/consolidated";
                if (ignoreConsolidatedSymbolList.Contains(symbol) == true) 
                {
                    url = "https://www.screener.in/company/{0}";
                    isIgnoreConsolidated = true;
                }
                url = string.Format(url, symbol);
                //Console.WriteLine(symbol); 
                WebClient webClient = new WebClient();
                try
                {
                    html = webClient.DownloadString(url);
                    if (isIgnoreConsolidated == false)
                    {
                        if (html.Contains("View Standalone") == false)
                        {
                            // Console.WriteLine(symbol + " try standalone");
                            webClient = new WebClient();
                            url = "https://www.screener.in/company/{0}";
                            url = string.Format(url, symbol);
                            html = webClient.DownloadString(url);
                        }
                    }
                    System.IO.File.WriteAllText(fileName, html); 
                    System.Threading.Thread.Sleep(2000); 
                }
                catch(Exception ex) {
                    string s = ex.Message;
                    Console.WriteLine(symbol + " Ex=" + ex.Message);
                }
            }
        }

        public static void UpdateScreenQuarterly(string symbol, string rootHtmlContent)
        {
            string category = "Income Statement";
            int periodTypeId = 2;
            string pattern = @"<section\s+id=""quarters""[^>]*>(.*?)<\/section>";
            // Use Regex.Match to find the section with id="quarters"
            Match match = Regex.Match(rootHtmlContent, pattern, RegexOptions.Singleline);

            if (match.Success)
            {
                string htmlContent = match.Groups[1].Value;


                // Define the regular expressions to match the table headers and rows
                string headerPattern = "<th[^>]*>(.*?)</th>";
                string rowPattern = "<tr[^>]*>(.*?)</tr>";
                string colPattern = "<td[^>]*>(.*?)</td>";

                // Initialize lists to store the header and data
                List<string> headers = new List<string>();


                // Match the table headers using the header pattern
                var headerMatches = Regex.Matches(htmlContent, headerPattern, RegexOptions.Singleline);

                // Extract the column headers
                foreach (Match headerMatch in headerMatches)
                {
                    string header = Regex.Replace(headerMatch.Groups[1].Value, "<.*?>", "").Trim();
                    if (string.IsNullOrEmpty(header) == true)
                    {
                        header = "Key";
                    }
                    headers.Add(header);
                }

                // Match the table rows using the row pattern
                var rowMatches = Regex.Matches(htmlContent, rowPattern, RegexOptions.Singleline);

                // Extract the data from each row
                foreach (Match rowMatch in rowMatches)
                {
                    // Get the content of the current row
                    string rowContent = rowMatch.Groups[1].Value;

                    // Match the table columns using the column pattern
                    var colMatches = Regex.Matches(rowContent, colPattern, RegexOptions.Singleline);

                    // Extract the data values from each column
                    List<string> values = new List<string>();
                    string key = "";
                    int index = -1;
                    foreach (Match colMatch in colMatches)
                    {
                        index += 1;
                        string header = string.Empty;
                        try
                        {
                            header = headers[index];
                        }
                        catch { }
                        string v = string.Empty;
                        string decimalPattern = @"[-+]?(?:\$\s*)?\b\d{1,3}(?:,\d{3})*(?:\.\d+)?\b";  // Regular expression pattern to match the decimal value
                        string result = Regex.Match(colMatch.Groups[1].Value, decimalPattern).Value;
                        if (DataTypeHelper.ToDecimal(result) != 0)
                        {
                            v = result.ToString();
                        }
                        else
                        {
                            if (string.IsNullOrEmpty(key) == true)
                            {
                                string pattern2 = @"<button[^>]*>(.*?)<\/button>";
                                Match match2 = Regex.Match(colMatch.Groups[1].Value, pattern2, RegexOptions.Singleline);
                                if (match2.Success)
                                {
                                    string innerText = match2.Groups[1].Value;
                                    v = Regex.Replace(innerText, @"<[^>]+>|&nbsp;", "").Replace("+", "").Trim();
                                }
                                else
                                {
                                    v = RemoveNewLines(colMatch.Groups[1].Value).Trim();
                                }
                                key = v;
                            }
                        }
                        if (string.IsNullOrEmpty(v) == false && v.Contains("Raw PDF") == true)
                        {
                            break;
                        }
                        else
                        {
                            DateTime dt = DataTypeHelper.ToDateTime(header);
                            if (dt.Year > 1900 && string.IsNullOrEmpty(key) == false)
                            {
                                if (key == "EPS")
                                {
                                    string s = string.Empty;
                                }
                                DateTime lastDateOfMonth = new DateTime(dt.Year, dt.Month, DateTime.DaysInMonth(dt.Year, dt.Month));
                                InsertFinanceValue(symbol, key, category, periodTypeId, lastDateOfMonth, DataTypeHelper.ToDecimal(v));
                            }
                        }
                    }
                }
            }
            else
            {
                Console.WriteLine("Section with id=\"quarters\" not found.");
            }
        }

        public static void InsertFinanceValue(string symbol, string key, string category, int periodTypeId, DateTime datetime, decimal value)
        {
            if (key == "Financing Profit")
            {
                key = "Operating Profit";
            }
            else if (key == "Financing Margin %")
            {
                key = "OPM %";
            }
            else if (key == "Revenue")
            {
                key = "Sales";
            }
            else if (key.Contains("EPS in R") == true)
            {
                key = "EPS";
            }
            using (SqlConnection connection = new SqlConnection(_ConnectionString))
            {
                int? keyId = InsertFinanceKey(key, category);
                string selectsql = "select FinancialReportingID from FinancialReporting " + Environment.NewLine +
                                " where FinancialReportingSourceKeyID = @FinancialReportingSourceKeyID" + Environment.NewLine +
                                " and FinancialReportingPeriodTypeID = @FinancialReportingPeriodTypeID" + Environment.NewLine +
                                " and PeriodDate = @PeriodDate" + Environment.NewLine +
                                " and Symbol = @Symbol" + Environment.NewLine +
                                "";
                int? id = connection.Query<int?>(selectsql, new
                {
                    FinancialReportingSourceKeyID = (keyId ?? 0),
                    FinancialReportingPeriodTypeID = periodTypeId,
                    PeriodDate = datetime,
                    Symbol = symbol
                }).FirstOrDefault();

                object param = new
                {
                    FinancialReportingSourceKeyID = (keyId ?? 0),
                    FinancialReportingPeriodTypeID = periodTypeId,
                    PeriodDate = datetime,
                    FinancialReportingID = (id ?? 0),
                    Value = value,
                    Symbol = symbol
                };

                string sql = "";
                int result;
                if ((id ?? 0) <= 0)
                {
                    sql = CommonHelper.GetResource("PepperExe.SQL.FinancialReporting.sql");
                    result = connection.Execute(sql, param);
                }
                else
                {
                    sql = CommonHelper.GetResource("PepperExe.SQL.FinancialReporting_Update.sql");
                    result = connection.Execute(sql, param);
                }
            }
        }

        public static int InsertFinanceKey(string key, string category)
        {
            using (SqlConnection connection = new SqlConnection(_ConnectionString))
            {
                int? categoryId = InsertFinanceCategory(category);
                string selectsql = "select FinancialReportingSchemaKeyID from FinancialReportingSchemaKey where FinancialReportingSchemaCategoryID = @FinancialReportingSchemaCategoryID and [Key] = @key";
                int? id = connection.Query<int?>(selectsql, new
                {
                    FinancialReportingSchemaCategoryID = categoryId,
                    key = key
                }).FirstOrDefault();

                if ((id ?? 0) <= 0)
                {
                    string sql = CommonHelper.GetResource("PepperExe.SQL.FinancialReportingSchemaKey.sql");
                    int result = connection.Execute(sql, new
                    {
                        FinancialReportingSchemaCategoryID = categoryId,
                        key = key,
                        IsEnabled = true
                    });
                }
                id = connection.Query<int?>(selectsql, new
                {
                    FinancialReportingSchemaCategoryID = categoryId,
                    key = key
                }).FirstOrDefault();
                return (id ?? 0);
            }
        }

        public static int InsertFinanceCategory(string category)
        {
            using (SqlConnection connection = new SqlConnection(_ConnectionString))
            {
                string selectsql = "select FinancialReportingSchemaCategoryID from FinancialReportingSchemaCategory where CategoryType = @CategoryType";
                int? id = connection.Query<int?>(selectsql, new
                {
                    CategoryType = category
                }).FirstOrDefault();
                if ((id ?? 0) <= 0)
                {
                    string sql = CommonHelper.GetResource("PepperExe.SQL.FinancialReportingSchemaCategory.sql");
                    int result = connection.Execute(sql, new
                    {
                        CategoryType = category
                    });
                }
                id = connection.Query<int?>(selectsql, new
                {
                    CategoryType = category
                }).FirstOrDefault();
                return (id ?? 0);
            }
        }

        public static string RemoveNewLines(string input)
        {
            string pattern = @"\r\n";
            string replacement = ""; // Replace with an empty string to remove \r\n
            string result = Regex.Replace(input, pattern, replacement);
            return result;
        }
    }
}
