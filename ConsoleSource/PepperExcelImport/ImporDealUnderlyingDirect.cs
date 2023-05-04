using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.Objects;
using System.IO;
using System.Reflection;
using CsvHelper;
using System.Data.SqlClient;
using Dapper;
using System.Globalization;
using System.Configuration;
using System.Text.RegularExpressions;
using System.Data.Common.CommandTrees.ExpressionBuilder;
using System.Data.Metadata.Edm;
using Newtonsoft.Json.Linq;

namespace PepperExcelImport
{
    class ImportDealUnderlyingDirect
    {
        // Check CSV Import sample
        public static int entityID = 100001; // Test case entity
        public static int dealID = 2606;
        public static int defaultEntityUserID = 65;
        public static string _ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["PepperContext"].ToString();

        public static void Import()
        {

            string sql = "";
            string rootPath = System.Configuration.ConfigurationManager.AppSettings["RootPath"];
            string updateFolder = "csv";
            string filesFolder = Path.Combine(rootPath, updateFolder);
            string[] files = System.IO.Directory.GetFiles(filesFolder);
            int i = 0;
            foreach (string filePath in files)
            {
                // Start ImportDealUnderlyingDirect
                if (filePath.ToLower().Contains(".csv") == true)
                {
                    using (TextReader reader = System.IO.File.OpenText(filePath))
                    {
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
                                string symbol = csv[csvHeader.GetIndex("Symbol")].Trim();//.Replace("-BE", "").Replace("IV", "").Trim();
                                switch (symbol)
                                {
                                    case "PROVOGE-BE": symbol = "PROVOGE"; break;
                                }
                                string action = csv[csvHeader.GetIndex("Trade Type")].Trim().ToLower();
                                decimal numberOfShares = DataTypeHelper.ToDecimal(csv[csvHeader.GetIndex("Quantity")].Trim());
                                decimal price = DataTypeHelper.ToDecimal(csv[csvHeader.GetIndex("Price")].Trim());
                                DateTime date = DataTypeHelper.ToDateTime(csv[csvHeader.GetIndex("Trade Date")].Trim());
                                string transactionId = csv[csvHeader.GetIndex("Trade ID")].Trim();
                                string insertSQL = CommonHelper.GetResource("PepperExcelImport.SQL.dm_asset_core.sql");
                                sql = "";
                                DateTime todayDate = DateTime.Now.Date;
                                string lotType = "";
                                switch (action)
                                {
                                    case "buy": lotType = "B"; break;
                                    case "sell": lotType = "S"; break;
                                    case "dividend": lotType = "D"; break;
                                    default: lotType = "P"; break;
                                }
                                if (symbol.StartsWith("NIFTY") == true)
                                {
                                    symbol = "NIFTY";
                                }
                                if (symbol.StartsWith("SGB") == true)
                                {
                                    symbol = "GOLD";
                                }
                                if (symbol.StartsWith("LIQUIDBEES") == true)
                                {
                                    symbol = "LIQUIDBEES";
                                }
                                if (symbol.Contains("NASDAQ") == true)
                                {
                                    symbol = "NASDAQ";
                                }
                                if (symbol.Contains("NIFTY IT") == true)
                                {
                                    symbol = "NIFTY IT";
                                }
                                if (symbol.Contains("INDIGRID") == true)
                                {
                                    symbol = "INDIGRID";
                                }
                                if (symbol.Contains("PGINVIT") == true)
                                {
                                    symbol = "PGINVIT";
                                }
                                CreateAssetCore(symbol, date, numberOfShares, price, transactionId, lotType);
                                Console.WriteLine(i);
                            }
                        }
                    }
                    System.IO.File.Delete(filePath);
                }
            }

            //Console.WriteLine("Execute Store Procedure please wait");
            //sql = "exec PROC_dm_asset_core_lot_share";
            //using (SqlConnection connection = new SqlConnection(_ConnectionString))
            //{
            //    connection.Execute(sql);
            //}

        }

        public static void ImportAllocation()
        {
            string sql = "";
            string rootPath = System.Configuration.ConfigurationManager.AppSettings["RootPath"];
            string updateFolder = "allocation";
            string filesFolder = Path.Combine(rootPath, updateFolder);
            string[] files = System.IO.Directory.GetFiles(filesFolder);
            int i = 0;
            if (files.Length > 0)
            {
                using (SqlConnection connection = new SqlConnection(_ConnectionString))
                {
                    sql = "delete from dm_asset_core_symbol_index";
                    connection.Execute(sql, new
                    {
                    });
                }
            }
            foreach (string filePath in files)
            {
                // Start ImportDealUnderlyingDirect
                if (filePath.ToLower().Contains(".csv") == true)
                {
                    using (TextReader reader = System.IO.File.OpenText(filePath))
                    {
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
                                string symbol = csv[csvHeader.GetIndex("Symbol")].Trim();
                                if (symbol.StartsWith("NIFTY") == true)
                                {
                                    symbol = "NIFTY";
                                }
                                if (symbol.StartsWith("SGB") == true)
                                {
                                    symbol = "GOLD";
                                }
                                if (symbol.StartsWith("LIQUIDBEES") == true)
                                {
                                    symbol = "LIQUIDBEES";
                                }
                                if (symbol.Contains("NASDAQ") == true)
                                {
                                    symbol = "NASDAQ";
                                }
                                if (symbol.Contains("NIFTY IT") == true)
                                {
                                    symbol = "NIFTY IT";
                                }
                                if (symbol.Contains("INDIGRID") == true)
                                {
                                    symbol = "INDIGRID";
                                }
                                if (symbol.Contains("PGINVIT") == true)
                                {
                                    symbol = "PGINVIT";
                                }
                                decimal percentage = DataTypeHelper.ToDecimal(csv[csvHeader.GetIndex("Percentage")].Trim());
                                string indexName = csv[csvHeader.GetIndex("Index")].Trim();
                                sql = "INSERT INTO [dbo].[dm_asset_core_symbol] ([Symbol]) VALUES (@Symbol)";
                                using (SqlConnection connection = new SqlConnection(_ConnectionString))
                                {
                                    try
                                    {
                                        connection.Execute(sql, new
                                        {
                                            Symbol = symbol
                                        });
                                    }
                                    catch { }
                                    sql = "select isnull(dm_asset_core_index_id,0) from dm_asset_core_index where [Name]=@name";
                                    int? dm_asset_core_index_id = connection.Query<int?>(sql, new
                                    {
                                        name = indexName
                                    }).FirstOrDefault();
                                    if ((dm_asset_core_index_id ?? 0) > 0)
                                    {
                                        sql = "delete from dm_asset_core_symbol_index where dm_asset_core_index_id = @dm_asset_core_index_id" + Environment.NewLine +
                                                " and Symbol = @Symbol" + Environment.NewLine +
                                                "";
                                        connection.Execute(sql, new
                                        {
                                            dm_asset_core_index_id = dm_asset_core_index_id,
                                            Symbol = symbol,
                                            Value = percentage
                                        });
                                        sql = "INSERT INTO [dbo].[dm_asset_core_symbol_index]" + Environment.NewLine +
                                                "([dm_asset_core_index_id]" + Environment.NewLine +
                                                ",[Symbol]" + Environment.NewLine +
                                                ",[Value])" + Environment.NewLine +
                                                " VALUES " + Environment.NewLine +
                                                "(@dm_asset_core_index_id" + Environment.NewLine +
                                                ",@Symbol" + Environment.NewLine +
                                                ",@Value)" + Environment.NewLine +
                                                "";
                                        connection.Execute(sql, new
                                        {
                                            dm_asset_core_index_id = dm_asset_core_index_id,
                                            Symbol = symbol,
                                            Value = percentage
                                        });
                                    }
                                    else
                                    {
                                        throw new Exception("Index name does not exist");
                                    }
                                }
                                Console.WriteLine(i);
                            }
                        }
                    }
                    System.IO.File.Delete(filePath);
                }
            }
        }

        public static void ImportAverage()
        {
            string sql = "";
            string rootPath = System.Configuration.ConfigurationManager.AppSettings["RootPath"];
            string updateFolder = "average";
            string filesFolder = Path.Combine(rootPath, updateFolder);
            string[] files = System.IO.Directory.GetFiles(filesFolder);
            int i = 0;
            if (files.Length > 0)
            {
                using (SqlConnection connection = new SqlConnection(_ConnectionString))
                {
                    sql = "delete from dm_asset_core_lot_share";
                    connection.Execute(sql, new
                    {
                    });
                }
            }
            foreach (string filePath in files)
            {
                // Start ImportDealUnderlyingDirect
                if (filePath.ToLower().Contains(".csv") == true)
                {
                    using (TextReader reader = System.IO.File.OpenText(filePath))
                    {
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
                                string symbol = csv[csvHeader.GetIndex("Symbol")].Trim();
                                decimal quantity = DataTypeHelper.ToDecimal(csv[csvHeader.GetIndex("Quantity Available")].Trim());
                                decimal avgprice = DataTypeHelper.ToDecimal(csv[csvHeader.GetIndex("Average Price")].Trim());
                                decimal amount = quantity * avgprice;
                                if (symbol.StartsWith("NIFTY") == true)
                                {
                                    symbol = "NIFTY";
                                }
                                if (symbol.StartsWith("SGB") == true)
                                {
                                    symbol = "GOLD";
                                }
                                if (symbol.StartsWith("LIQUIDBEES") == true)
                                {
                                    symbol = "LIQUIDBEES";
                                }
                                if (symbol.Contains("NASDAQ") == true)
                                {
                                    symbol = "NASDAQ";
                                }
                                if (symbol.Contains("NIFTY IT") == true)
                                {
                                    symbol = "NIFTY IT";
                                }
                                if (symbol.Contains("INDIGRID") == true)
                                {
                                    symbol = "INDIGRID";
                                }
                                if (symbol.Contains("PGINVIT") == true)
                                {
                                    symbol = "PGINVIT";
                                }
                                using (SqlConnection connection = new SqlConnection(_ConnectionString))
                                {
                                    sql = "INSERT INTO [dbo].[dm_asset_core_lot_share]" + Environment.NewLine +
                                                 "([Symbol]" + Environment.NewLine +
                                                 ",[NumberOfShares]" + Environment.NewLine +
                                                 ",[SharePrice]" + Environment.NewLine +
                                                 ",[Amount]" + Environment.NewLine +
                                                 ")" + Environment.NewLine +
                                                 " VALUES " + Environment.NewLine +
                                                 "(@Symbol" + Environment.NewLine +
                                                 ",@Shares" + Environment.NewLine +
                                                 ",@Price" + Environment.NewLine +
                                                 ",@Amount)" + Environment.NewLine +
                                                 "";
                                    connection.Execute(sql, new
                                    {
                                        Symbol = symbol,
                                        Shares = quantity,
                                        Price = avgprice,
                                        Amount = amount
                                    });
                                }
                                Console.WriteLine(i);
                            }
                        }
                    }
                    System.IO.File.Delete(filePath);
                }
            }
        }

        public static void CalculateXIRR()
        {
            string sql = "select symbol from dm_asset_core_lot group by symbol order by symbol";
            List<string> symbols = new List<string>();
            using (SqlConnection connection = new SqlConnection(_ConnectionString))
            {
                symbols = connection.Query<string>(sql).ToList();
            }
            double xirr = 0;
            int i = 0;
            foreach (string symbol in symbols)
            {
                i += 1;
                xirr = XIRR(symbol);
                sql = "update dm_asset_core_lot_share set xirr = @xirr where symbol = @symbol";
                using (var connection = new SqlConnection(_ConnectionString))
                {
                    connection.Execute(sql, new { xirr = xirr, symbol = symbol });
                }
                Console.WriteLine(i + " of " + symbols.Count + ",xirr=" + xirr);
            }
        }

        private static double XIRR(string symbol = ""
                , bool? isIgnore = false
                , DateTime? fromDate = null
                , DateTime? toDate = null)
        {
            DateTime minDate = Convert.ToDateTime("01/01/1900");
            double xirr = 0;
            if (string.IsNullOrEmpty(symbol) == false)
            {
                symbol = Helper.ConvertStringSQLFormat(symbol);
            }
            string where = "";
            where += " where lot.dm_asset_core_lot_id > 0";
            if ((fromDate ?? minDate).Year > 1900)
            {
                where += string.Format(" and lot.RecordDate >= '{0}' ", (fromDate ?? minDate).ToString("MM/dd/yyyy"));
            }
            if ((toDate ?? minDate).Year > 1900)
            {
                where += string.Format(" and lot.RecordDate <= '{0}' ", (toDate ?? minDate).ToString("MM/dd/yyyy"));
            }
            //Console.WriteLine("isIgnore=" + isIgnore);
            if (string.IsNullOrEmpty(symbol) == false)
            {
                if ((isIgnore ?? false) == true)
                {
                    where += " and lot.Symbol not in (" + symbol + ")";
                }
                else
                {
                    where += " and lot.Symbol in (" + symbol + ")";
                }
            }
            string sql = "select " + Environment.NewLine +
                        "lot.Symbol" + Environment.NewLine +
                        ",case when lot.LotType = 'B' then 'Buy' else case when lot.LotType = 'S' then 'Sell' else case when lot.LotType = 'D' then 'Dividend' else '' end end end as [Description]" + Environment.NewLine +
                        ",lot.RecordDate as [Date]" + Environment.NewLine +
                        ",case when lot.LotType = 'B'" + Environment.NewLine +
                        " then (lot.NumberOfShares * lot.SharePrice) * -1 " + Environment.NewLine +
                        " else case when lot.LotType = 'S' then (lot.NumberOfShares * lot.SharePrice) else lot.SharePrice end end [Value]" + Environment.NewLine +
                        ",0 as SortOrder" + Environment.NewLine +
                        "from dm_asset_core_lot lot" + Environment.NewLine +
                        where +
                        "and lot.LotType in ('B','S','D') " + Environment.NewLine +
                        "union all " + Environment.NewLine +
                        "select '' as Symbol,'Current Market Value' as [Description],[Date],sum(isnull([Value], 0)) as [Value],1 as SortOrder from (" + Environment.NewLine +
                        "select Symbol as Symbol, '' as [Description], GETDATE() as [Date],[Value], 1 as SortOrder from(" + Environment.NewLine +
                        "select tbl.Symbol" + Environment.NewLine +
                        ",isnull(sum(isnull(tbl.Shares, 0)), 0) as CurrentShares" + Environment.NewLine +
                        ",(select isnull(sum(isnull(tbl.Shares,0)),0) * (select top 1 l.SharePrice from dm_asset_core_lot l " + Environment.NewLine +
                        "where l.Symbol = tbl.Symbol" + Environment.NewLine +
                        " and l.LotType not in ('D')" + Environment.NewLine +
                        "order by l.RecordDate desc,l.dm_asset_core_lot_id desc)) as [Value]" + Environment.NewLine +
                        "from (" + Environment.NewLine +
                        "select " + Environment.NewLine +
                        "lot.Symbol" + Environment.NewLine +
                        ",(case when lot.LotType = 'B' then isnull(lot.NumberOfShares,0) else case when lot.LotType = 'S' then isnull(lot.NumberOfShares,0) * -1 else 0 end end) as Shares" + Environment.NewLine +
                        "from dm_asset_core_lot lot" + Environment.NewLine +
                        where +
                        ") as tbl " + Environment.NewLine +
                        "group by tbl.Symbol" + Environment.NewLine +
                        ") as tbl2 where isnull(tbl2.CurrentShares,0) > 0" + Environment.NewLine +
                        ") as tbl3 group by tbl3.[Date] order by [Date] asc" + Environment.NewLine +
                        "";
            List<DealXIRRReportModel> rows = new List<DealXIRRReportModel>();
            using (var connection = new SqlConnection(_ConnectionString))
            {
                rows = connection.Query<DealXIRRReportModel>(sql).ToList();
            }
            List<double> values = (from q in rows
                                   select (double)(q.Value ?? 0)).ToList();
            List<DateTime> dates = (from q in rows
                                    select (q.Date ?? minDate)).ToList();
            try
            {
                xirr = Excel.FinancialFunctions.Financial.XIrr(values, dates) * 100;
            }
            catch { xirr = 0; }
            return xirr;
        }

        public static void CreateAssetCore(string symbol, DateTime date, decimal numberOfShares, decimal price, string transactionId
            , string lotType)
        {
            if (string.IsNullOrEmpty(symbol) == false)
            {
                switch (symbol)
                {
                    case "PROVOGE-BE": symbol = "PROVOGE"; break;
                }
                if (symbol.StartsWith("NIFTY") == true)
                {
                    symbol = "NIFTY";
                }
                if (symbol.StartsWith("SGB") == true)
                {
                    symbol = "GOLD";
                }
                if (symbol.StartsWith("LIQUIDBEES") == true)
                {
                    symbol = "LIQUIDBEES";
                }
                if (symbol.Contains("NASDAQ") == true)
                {
                    symbol = "NASDAQ";
                }
                if (symbol.Contains("NIFTY IT") == true)
                {
                    symbol = "NIFTY IT";
                }
                if (symbol.Contains("INDIGRID") == true)
                {
                    symbol = "INDIGRID";
                }
                if (symbol.Contains("PGINVIT") == true)
                {
                    symbol = "PGINVIT";
                }
            }
            string _ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["PepperContext"].ToString();
            string insertSQL = CommonHelper.GetResource("PepperExcelImport.SQL.dm_asset_core.sql");
            if (string.IsNullOrEmpty(symbol) == false)
            {
                using (SqlConnection connection = new SqlConnection(_ConnectionString))
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
    }

    public class CSVHeaderHelper
    {
        public List<CSVHeader> Headers = new List<CSVHeader>();
        public int GetIndex(string name)
        {
            var header = (from q in this.Headers where q.Name.Trim() == name.Trim() select q).FirstOrDefault();
            if (header == null)
                throw new Exception("Column Name=" + name + " does not exist");
            return header.Index;
        }
    }

    public class CSVHeader
    {
        public string Name { get; set; }
        public int Index { get; set; }
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
            catch //(Exception ex)
            {
                //throw ex;
            }
            return value;
        }
    }

    public class DealXIRRReportModel
    {

        public string Fund { get; set; }

        public int? DealNumber { get; set; }

        public string DealName { get; set; }

        public string UnderlyingFund { get; set; }

        public string Direct { get; set; }

        public string Symbol { get; set; }

        public DateTime? Date { get; set; }

        public decimal? Value { get; set; }

        public string Description { get; set; }

        public string Type { get; set; }

        public int SecurityTypeID { get; set; }

        public int SecurityID { get; set; }

        public decimal? NumberOfSharesUnsold { get; set; }

        public decimal? LastPrice { get; set; }

        public int? ID { get; set; }
    }

    public class Select2List
    {
        public Select2List()
        {
            id = string.Empty;
            label = string.Empty;
            value = string.Empty;
        }
        public string id { get; set; }
        public string label { get; set; }
        public string value { get; set; }
        public string other { get; set; }
    }

    public class dm_asset_core_lot_share
    {
        public string Name { get; set; }
        public string Symbol { get; set; }
        public decimal? NumberOfShares { get; set; }
        public decimal? SharePrice { get;set; }
        public decimal? Amount { get; set; }
    }

    public class Helper
    {
        public static void Log(string log, string description = "", bool isWriteFile = true)
        {
            try
            {
                Console.WriteLine(log);
                if (isWriteFile == true)
                {
                    string fileName = (description != "" ? description + "_" : "") + DateTime.Now.ToString("dd-MMM-yyyy") + ".txt";
                    log = string.Format("{0} LOG: {1}", DateTime.Now.ToString("hh:mm:ss"), log + Environment.NewLine);
                    string rootPath = Environment.CurrentDirectory;
                    string tempFileName = Path.Combine(rootPath, "logs", fileName);
                    string directoryName = Path.GetDirectoryName(tempFileName);
                    if (Directory.Exists(directoryName) == false)
                    {
                        Directory.CreateDirectory(directoryName);
                    }
                    if (File.Exists(tempFileName) == false)
                    {
                        File.WriteAllText(tempFileName, log);
                    }
                    else
                    {
                        using (StreamWriter w = File.AppendText(tempFileName))
                        {
                            w.WriteLine(log);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("LOG:" + ex.Message);
            }
        }

        public static string ConvertIds(List<int> ids)
        {
            string result = string.Empty;
            foreach (int id in ids)
            {
                result += string.Format("{0},", id);
            }
            if (string.IsNullOrEmpty(result) == false)
            {
                result = result.Substring(0, result.Length - 1);
            }
            return result;
        }

        public static string ConvertIds(List<string> ids)
        {
            string result = string.Empty;
            foreach (string id in ids)
            {
                if (string.IsNullOrEmpty(id) == false)
                {
                    result += string.Format("{0},", id);
                }
            }
            if (string.IsNullOrEmpty(result) == false)
            {
                result = result.Substring(0, result.Length - 1);
            }
            return result;
        }

        public static List<int> ConvertIntIds(string ids)
        {
            List<int> result = new List<int>();
            if (string.IsNullOrEmpty(ids) == false)
            {
                string[] arr = ids.Split((",").ToCharArray());
                foreach (string strid in arr)
                {
                    if (string.IsNullOrEmpty(strid) == false)
                    {
                        result.Add(Helper.ToInt32(strid));
                    }
                }
            }
            return result;
        }

        public static List<int?> ConvertIntNullIds(string ids)
        {
            List<int?> result = new List<int?>();
            if (string.IsNullOrEmpty(ids) == false)
            {
                string[] arr = ids.Split((",").ToCharArray());
                foreach (string strid in arr)
                {
                    if (string.IsNullOrEmpty(strid) == false)
                    {
                        result.Add(Helper.ToInt32(strid));
                    }
                }
            }
            return result;
        }

        public static string ConvertStringIds(string ids)
        {
            string result = string.Empty;
            if (string.IsNullOrEmpty(ids) == false)
            {
                string[] arr = ids.Split((",").ToCharArray());
                foreach (string strid in arr)
                {
                    if (string.IsNullOrEmpty(strid) == false)
                    {
                        //int id = Helper.ToInt32(strid);
                        result += string.Format("{0},", strid);
                    }
                }
            }
            if (string.IsNullOrEmpty(result) == false)
            {
                result = result.Substring(0, result.Length - 1);
            }
            return result;
        }

        public static string ConvertStringIds(List<string> ids)
        {
            string result = string.Empty;
            foreach (string strid in ids)
            {
                if (string.IsNullOrEmpty(strid) == false)
                {
                    result += string.Format("{0},", strid);
                }
            }
            if (string.IsNullOrEmpty(result) == false)
            {
                result = result.Substring(0, result.Length - 1);
            }
            return result;
        }

        public static string ConvertDateTimeIds(List<DateTime?> ids)
        {
            string result = string.Empty;
            foreach (DateTime? dt in ids)
            {
                if (dt.HasValue)
                {
                    if (dt.Value.Year > 1900)
                    {
                        result += string.Format("{0},", dt.Value.ToString("yyyy-MM-dd"));
                    }
                }
            }
            if (string.IsNullOrEmpty(result) == false)
            {
                result = result.Substring(0, result.Length - 1);
            }
            return result;
        }

        public static string ConvertDateTimeIds(List<DateTime> ids)
        {
            string result = string.Empty;
            foreach (DateTime dt in ids)
            {
                if (dt.Year > 1900)
                {
                    result += string.Format("{0},", dt.ToString("yyyy-MM-dd"));
                }
            }
            if (string.IsNullOrEmpty(result) == false)
            {
                result = result.Substring(0, result.Length - 1);
            }
            return result;
        }

        public static string ToSQL(string value)
        {
            return (string.IsNullOrEmpty(value) == false ? value.Replace("'", "''") : "''");
        }

        public static string ConvertStringSQLFormat(string values)
        {
            string result = string.Empty;
            if (string.IsNullOrEmpty(values) == false)
            {
                string[] arr = values.Split((",").ToCharArray());
                foreach (string strid in arr)
                {
                    if (string.IsNullOrEmpty(strid) == false)
                    {
                        result += string.Format("'{0}',", strid.Replace("'", ""));
                    }
                }
            }
            if (string.IsNullOrEmpty(result) == false)
            {
                result = result.Substring(0, result.Length - 1);
            }
            return result;
        }

        public static List<string> ConvertStringList(string ids)
        {
            List<string> list = new List<string>();
            if (string.IsNullOrEmpty(ids) == false)
            {
                string[] arr = ids.Split((",").ToCharArray());
                foreach (string strid in arr)
                {
                    if (string.IsNullOrEmpty(strid) == false)
                    {
                        list.Add(strid);
                    }
                }
            }
            return list;
        }

        public static double SafeDivision(double d1, double d2)
        {
            if (d2 == 0)
                //throw new System.DivideByZeroException();
                return 0;
            else
                return d1 / d2;
        }

        //public static int SafeDivision(int d1,int d2) {
        //    if(d2 == 0)
        //        //throw new System.DivideByZeroException();
        //        return 0;
        //    else
        //        return d1 / d2;
        //}

        //public static int SafeDivision(int? d1,int? d2) {
        //    if((d2 ?? 0) == 0)
        //        //throw new System.DivideByZeroException();
        //        return 0;
        //    else
        //        return (d1 ?? 0) / (d2 ?? 0);
        //}

        public static decimal SafeDivision(decimal d1, decimal d2)
        {
            if (d2 == 0)
                //throw new System.DivideByZeroException();
                return 0;
            else
                return d1 / d2;
        }

        public static decimal SafeDivision(decimal? d1, decimal? d2)
        {
            if ((d2 ?? 0) == 0)
                //throw new System.DivideByZeroException();
                return 0;
            else
                return (d1 ?? 0) / (d2 ?? 0);
        }

        private static string RemoveSymbols(string value)
        {
            if (string.IsNullOrEmpty(value) == false)
            {
                value = value.Replace("$", "").Replace("%", "").Replace(",", "").Replace("(", "-").Replace(")", "");
            }
            else
            {
                value = string.Empty;
            }
            return value;
        }

        public static decimal ToDecimal(string value)
        {
            value = RemoveSymbols(value);
            decimal returnValue;
            decimal.TryParse(value, NumberStyles.Any, null, out returnValue);
            return returnValue;
        }

        public static decimal ToDecimal(string value, int precision)
        {
            value = RemoveSymbols(value);
            decimal returnValue;
            decimal.TryParse(value, NumberStyles.Any, null, out returnValue);
            // toFixed
            value = returnValue.ToString("N" + precision);
            decimal.TryParse(value, NumberStyles.Any, null, out returnValue);
            return returnValue;
        }

        public static double ToDouble(string value)
        {
            value = RemoveSymbols(value);
            double returnValue;
            double.TryParse(value, NumberStyles.Any, null, out returnValue);
            return returnValue;
        }

        public static String ConvertString(object value)
        {
            if (value == null || value == DBNull.Value)
                return string.Empty;
            else
                return value.ToString();
        }

        public static string RemoveHTML(string input)
        {
            if (string.IsNullOrEmpty(input) == false)
            {
                return Regex.Replace(input, "<.*?>", String.Empty);
            }
            else
            {
                return "";
            }
        }

        public static Int32 ToInt32(string value)
        {
            value = RemoveSymbols(value);
            if (value.Contains("."))
            {
                decimal deValue = 0;
                decimal.TryParse(value, NumberStyles.Any, null, out deValue);
                return (Int32)deValue;
            }
            else
            {
                Int32 returnValue;
                Int32.TryParse(value, out returnValue);
                return returnValue;
            }
        }

        public static Int16 ToInt16(string value)
        {
            value = RemoveSymbols(value);
            if (value.Contains("."))
            {
                decimal deValue = 0;
                decimal.TryParse(value, NumberStyles.Any, null, out deValue);
                return (Int16)deValue;
            }
            else
            {
                Int16 returnValue;
                Int16.TryParse(value, out returnValue);
                return returnValue;
            }
        }

        public static Int64 ToInt64(string value)
        {
            value = RemoveSymbols(value);
            if (value.Contains("."))
            {
                decimal deValue = 0;
                decimal.TryParse(value, NumberStyles.Any, null, out deValue);
                return (Int64)deValue;
            }
            else
            {
                Int64 returnValue;
                Int64.TryParse(value, out returnValue);
                return returnValue;
            }
        }

        public static DateTime ToDateTime(string value)
        {
            DateTime returnValue;
            DateTime.TryParse(value, out returnValue);
            return returnValue.Year <= 1900 ? new DateTime(1900, 1, 1) : returnValue;
        }

        public static DateTime ToFromOADate(string value)
        {
            if (value.Contains("-") == true || value.Contains("/") == true)
            {
                return Helper.ToDateTime(value);
            }
            else
            {
                DateTime returnValue;
                double dateValue = 0;
                double.TryParse(value, out dateValue);
                returnValue = DateTime.FromOADate(dateValue);
                return returnValue.Year <= 1900 ? new DateTime(1900, 1, 1) : returnValue;
            }
        }

        public static bool CheckBoolean(string value)
        {
            bool calcValue = false;
            if (string.IsNullOrEmpty(value) == false)
                value = value.ToLower().Trim();
            else
                value = string.Empty;

            if (value.Contains("true"))
                calcValue = true;
            if (value.Contains("yes"))
                calcValue = true;
            if (value == "1")
                calcValue = true;
            if (value == "on")
                calcValue = true;

            return calcValue;
        }
    }
}

