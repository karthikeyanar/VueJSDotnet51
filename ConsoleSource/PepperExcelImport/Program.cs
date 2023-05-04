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

namespace PepperExcelImport
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

        static void Main(string[] args)
        {
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
                }
            } 
            if (isSkip == false)
            {
                ImportDealUnderlyingDirect.Import();
                ImportDealUnderlyingDirect.ImportAllocation();
                ImportDealUnderlyingDirect.ImportAverage();
            }
            ImportDealUnderlyingDirect.CalculateXIRR();
            Console.WriteLine("Press any key to continue........");
            Console.ReadLine();
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
            foreach (string symbol in symbols)
            {
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
            string sql = "select inx.[Name],ls.* from dm_asset_core_lot_share ls" + Environment.NewLine +
                            "join dm_asset_core_symbol_index syminx on syminx.Symbol = ls.Symbol " + Environment.NewLine +
                            "join dm_asset_core_index inx on inx.dm_asset_core_index_id = syminx.dm_asset_core_index_id " + Environment.NewLine +
                            "where ls.NumberOfShares > 0" + Environment.NewLine +
                            "";
            List<dm_asset_core_lot_share> symbols = new List<dm_asset_core_lot_share>();
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                symbols = connection.Query<dm_asset_core_lot_share>(sql).ToList();
            }

            string exchangeName = "NSE";
            List<string> categories = (from q in symbols
                                       select q.Name).Distinct().ToList();

            categories.Add("All");

            categories = (from q in categories
                          orderby q
                          select q).ToList();

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
                    UserEnteredValue = new ExtendedValue { StringValue = "" }
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

                        row.Values.Add(new CellData
                        {
                            UserEnteredValue = new ExtendedValue { StringValue = "" }
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
    }
}
