using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Pepper.Models.CodeFirst;
using System.Data.Objects;
using Pepper.Framework.Validation;
using System.IO;
using System.Reflection;
using CsvHelper;
using System.Data.Entity.Validation;
using Pepper.Framework.Authentication;
using System.Data.SqlClient;
using Dapper;
using static PepperExcelImport.Program;
using Pepper.Models.CodeFirst.Enums;
using DocumentFormat.OpenXml.Drawing.Charts;

namespace PepperExcelImport
{
    class ImportDealUnderlyingDirect
    {
        // Check CSV Import sample
        public static int entityID = 100001; // Test case entity
        public static int dealID = 2606;
        public static int defaultEntityUserID = 65;

        public static void Import()
        {
            try
            {
                string rootPath = System.Configuration.ConfigurationManager.AppSettings["RootPath"];
                string updateFolder = "csv";
                string filesFolder = Path.Combine(rootPath, updateFolder);
                string[] files = System.IO.Directory.GetFiles(filesFolder);
                foreach (string filePath in files)
                {
                    // Start ImportDealUnderlyingDirect
                    if (filePath.ToLower().Contains(".csv") == true)
                    {
                        using (TextReader reader = System.IO.File.OpenText(filePath))
                        {
                            int i;
                            CSVHeaderHelper csvHeader = new CSVHeaderHelper();
                            CsvReader csv = null;
                            csv = new CsvReader(reader);
                            bool isHeadersAppend = false;
                            i = 0;
                            while (csv.Read())
                            {
                                i += 1;
                                if (isHeadersAppend == false)
                                {
                                    int j;
                                    for (j = 0; j < 100; j++)
                                    {
                                        try
                                        {
                                            if (csv[j] == "Symbol")
                                            {
                                                isHeadersAppend = true;
                                                break;
                                            }
                                        }
                                        catch
                                        {
                                            break;
                                        }
                                    }
                                    if (isHeadersAppend == true)
                                    {
                                        j = 0;
                                        for (j = 0; j < 100; j++)
                                        {
                                            try
                                            {
                                                if (csv[j] == "Symbol")
                                                {
                                                    isHeadersAppend = true;
                                                }
                                                csvHeader.Headers.Add(new CSVHeader { Name = csv[j], Index = j });
                                            }
                                            catch
                                            {
                                                break;
                                            }
                                        }
                                    }
                                }
                                else if (isHeadersAppend == true)
                                {
                                    string symbol = csv[csvHeader.GetIndex("Symbol")].Trim();//.Replace("-BE", "").Replace("IV", "").Trim();
                                    switch (symbol)
                                    {
                                        case "PROVOGE-BE": symbol = "PROVOGE"; break;
                                    }
                                    string action = csv[csvHeader.GetIndex("Trade Type")].Trim().ToLower();
                                    int numberOfShares = DataTypeHelper.ToInt32(csv[csvHeader.GetIndex("Quantity")].Trim());
                                    decimal price = DataTypeHelper.ToDecimal(csv[csvHeader.GetIndex("Price")].Trim());
                                    DateTime date = DataTypeHelper.ToDateTime(csv[csvHeader.GetIndex("Trade Date")].Trim());
                                    string transactionId = csv[csvHeader.GetIndex("Trade ID")].Trim();
                                    string insertSQL = CommonHelper.GetResource("PepperExcelImport.SQL.dm_asset_core.sql");
                                    string sql = "";
                                    DateTime todayDate = DateTime.Now.Date;
                                    string lotType = "";
                                    switch (action)
                                    {
                                        case "buy": lotType = "B"; break;
                                        case "sell": lotType = "S"; break;
                                        case "dividend": lotType = "D"; break;
                                        default: lotType = "P"; break;
                                    }
                                    CreateAssetCore(symbol, date, numberOfShares, price, transactionId, lotType);
                                    Console.WriteLine(i);
                                }
                            }
                        }
                        System.IO.File.Delete(filePath);
                    }
                }
            }catch(Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }

        public static void CreateAssetCore(string symbol,DateTime date,decimal numberOfShares,decimal price,string transactionId
            ,string lotType)
        {
            string insertSQL = CommonHelper.GetResource("PepperExcelImport.SQL.dm_asset_core.sql");
            if (string.IsNullOrEmpty(symbol) == false)
            {
                using (SqlConnection connection = new SqlConnection(ConfigHelper.ConnectionString))
                {
                    string sql = "select isnull(count(*),0) from dm_asset_core_lot where Symbol = @Symbol and RecordDate = @RecordDate and NumberOfShares = @NumberOfShares and LotType = @LotType and RefID = @RefID";
                    int? count = connection.Query<int?>(sql, new
                    {
                        Symbol = symbol
                       ,
                        RecordDate = date.Date
                       ,
                        NumberOfShares = numberOfShares
                       ,
                        RefID = transactionId
                       ,
                        LotType = lotType
                    }).FirstOrDefault();
                    if ((count ?? 0) <= 0)
                    {
                        int result = connection.Execute(insertSQL, new
                        {
                            Symbol = symbol
                           ,
                            RecordDate = date.Date
                           ,
                            NumberOfShares = numberOfShares
                           ,
                            RefID = transactionId
                           ,
                            SharePrice = price
                           ,
                            LotType = lotType
                        });
                    }
                }
            }
        }

        public static void ImportOld()
        {
            string currentDirectory = System.Configuration.ConfigurationManager.AppSettings["RootPath"];// Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);
            string excelFileName = "SecurityLotSharesHistory.csv";
            string filePath = Path.Combine(currentDirectory, excelFileName);

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
                    }
                    else
                    {
                        string symbol = csv[csvHeader.GetIndex("Symbol")].Replace("-BE","").Replace("IV","").Trim();
                        string action = csv[csvHeader.GetIndex("ActionType")].Trim().ToLower();
                        int numberOfShares = DataTypeHelper.ToInt32(csv[csvHeader.GetIndex("NumberOfShares")].Trim());
                        decimal price = DataTypeHelper.ToDecimal(csv[csvHeader.GetIndex("Price")].Trim());
                        DateTime date = DataTypeHelper.ToDateTime(csv[csvHeader.GetIndex("RecordDate")].Trim());
                        string transactionId = csv[csvHeader.GetIndex("TransactionID")].Trim();
                        string sql = "";
                        DateTime todayDate = DateTime.Now.Date;
                        if (string.IsNullOrEmpty(symbol) == false)
                        {
                            Equity equity = GetEquity(symbol);
                            sql = CommonHelper.GetResource("PepperExcelImport.SQL.SecurityLotSharesHistoryCreate.sql");
                            using (SqlConnection connection = new SqlConnection(ConfigHelper.ConnectionString))
                            {
                                sql = "select isnull(count(*),0) from SecurityLotSharesHistoryOld where DealID = @DealID and SecurityTypeID = @SecurityTypeID and SecurityID = @SecurityID and RecordDate = @RecordDate and NumberOfSharesUnsold = @NumberOfSharesUnsold and TransactionRefID = @TransactionRefID";
                                int? count = connection.Query<int?>(sql, new
                                {
                                   DealID = dealID
                                   ,SecurityTypeID = 1
                                   ,SecurityID = equity.EquityID
                                   ,RecordDate = date
                                   ,NumberOfSharesUnsold = numberOfShares
                                   ,Price = price
                                   ,TransactionTypeID = (action == "buy" ? 1 : (action == "sell" ? 2 : 3))
                                   ,TransactionRefID = transactionId
                                }).FirstOrDefault();
                                if((count ?? 0) <= 0) {
                                    sql = CommonHelper.GetResource("PepperExcelImport.SQL.SecurityLotSharesHistoryCreate.sql");
                                    int result = connection.Execute(sql, new
                                    {
                                       DealID = dealID
                                       ,SecurityTypeID = 1
                                       ,SecurityID = equity.EquityID
                                       ,RecordDate = date
                                       ,NumberOfSharesUnsold = numberOfShares
                                       ,Price = price
                                       ,TransactionTypeID = (action == "buy" ? 1 : (action == "sell" ? 2 : 3))
                                       ,TransactionRefID = transactionId
                                       ,SecurityLotHistoryID = 0
                                    });
                                 }
                            }
                            Console.WriteLine(i);
                        }
                    }
                }
            }
        }

        private static Equity GetEquity(string symbol)
        {
            string sql = "select * from Equity where EntityID = @entityId and Symbol = @symbol";
            Equity equity = null;
            using (SqlConnection connection = new SqlConnection(ConfigHelper.ConnectionString))
            {
                equity = connection.Query<Equity>(sql, new
                {
                    entityId = entityID,
                    symbol = symbol
                }).FirstOrDefault();
                if (equity == null)
                {
                    sql = CommonHelper.GetResource("PepperExcelImport.SQL.IssuerCreate.sql");
                    connection.Execute(sql, new
                    {
                        EntityID = entityID,
                        Name = symbol, 
                        IsArchive = true
                    });
                    sql = "select * from Issuer where EntityID = @entityId and Name = @symbol";
                    Issuer issuer = connection.Query<Issuer>(sql, new
                    {
                        entityId = entityID,
                        symbol = symbol
                    }).FirstOrDefault();
                    equity = new Equity
                    {
                        Symbol = symbol,
                        IssuerID = issuer.IssuerID,
                        CurrencyID = 6,
                        EquityTypeID = 1,
                        Public = true,
                    };
                    sql = CommonHelper.GetResource("PepperExcelImport.SQL.EquityCreate.sql");
                    connection.Execute(sql, new
                    {
                        EntityID = entityID,
                        Symbol = symbol,
                        IssuerID = issuer.IssuerID,
                        CurrencyID = 6,
                        EquityTypeID = 1,
                        Public = true,
                        IsArchive = true
                    });
                    sql = "select * from Equity where EntityID = @entityId and Symbol = @symbol";
                    equity = connection.Query<Equity>(sql, new
                    {
                        entityId = entityID,
                        symbol = symbol
                    }).FirstOrDefault();
                }
            }
            return equity;
        }
    }

    public class CommonHelper
    {
        public static string GetResource(string resourceName)
        {
            //string resourceName = ""; 
            string value = "";
            try
            {
                Assembly assembly = Assembly.GetExecutingAssembly();
                string[] names = assembly.GetManifestResourceNames();
                System.IO.TextReader reader = new System.IO.StreamReader(assembly.GetManifestResourceStream(resourceName));
                value = new StringBuilder(reader.ReadToEnd()).ToString();
            }
            catch (Exception ex)
            {
                //throw ex;
            }
            return value;
        }
    }
}

