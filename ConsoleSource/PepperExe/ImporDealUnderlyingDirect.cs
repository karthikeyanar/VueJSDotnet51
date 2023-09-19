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
using System.Drawing;

namespace PepperExe
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
                                string insertSQL = CommonHelper.GetResource("PepperExe.SQL.dm_asset_core.sql");
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
                                symbol = ImportDealUnderlyingDirect.GetSymbol(symbol);
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

        private static string GetSymbol(string trsymbol)
        {
            string symbol = trsymbol;
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
            if (symbol.Contains("ICICI PRUDENTIAL NIFTY IT") == true)
            {
                symbol = "ICICIIT";
            }
            if (symbol.Contains("NAVI NIFTY BANK INDEX FUND") == true)
            {
                symbol = "NAVIBANK";
            }
            if (symbol.Contains("ICICI PRUDENTIAL NIFTY BANK") == true)
            {
                symbol = "BANKNIFTY";
            }
            if (symbol.Contains("INDIGRID") == true)
            {
                symbol = "INDIGRID";
            }
            if (symbol.Contains("PGINVIT") == true)
            {
                symbol = "PGINVIT";
            }
            return symbol;
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
                                symbol = ImportDealUnderlyingDirect.GetSymbol(symbol);
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
                                symbol = ImportDealUnderlyingDirect.GetSymbol(symbol);
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
                symbol = ImportDealUnderlyingDirect.GetSymbol(symbol);
            }
            string _ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["PepperContext"].ToString();
            string insertSQL = CommonHelper.GetResource("PepperExe.SQL.dm_asset_core.sql");
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

    public static class DataTypeHelper
    {

        public static int GetQuarter(this DateTime dateTime)
        {
            if (dateTime.Month <= 3)
                return 1;

            if (dateTime.Month <= 6)
                return 2;

            if (dateTime.Month <= 9)
                return 3;

            return 4;
        }

        public static string ConvertBit(bool? isCondition)
        {
            return ((isCondition ?? false) == true ? "1" : "0");
        }

        public static decimal SafeDivision(int d1, int d2)
        {
            if (d2 == 0)
                //throw new System.DivideByZeroException();
                return 0;
            else
                return decimal.Divide(d1, d2);
        }

        public static decimal SafeDivision(decimal d1, decimal d2)
        {
            if (d2 == 0)
                //throw new System.DivideByZeroException();
                return 0;
            else
                return decimal.Divide(d1, d2);
        }

        public static double SafeDivision(double d1, double d2)
        {
            if (d2 == 0)
                //throw new System.DivideByZeroException();
                return 0;
            else
                return d1 / d2;
        }

        public static float SafeDivision(float d1, float d2)
        {
            if (d2 == 0)
                //throw new System.DivideByZeroException();
                return 0;
            else
                return d1 / d2;
        }

        private static string RemoveSymbols(string value)
        {
            if (string.IsNullOrEmpty(value) == false)
            {
                value = value.Replace("$", "").Replace("%", "").Replace(",", "").Replace("(", "-").Replace(")", "").Replace("₹", "");
            }
            return (value == null ? "" : value);
        }

        public static float ToFloat(string value)
        {
            value = RemoveSymbols(value);
            float returnValue;
            float.TryParse(value, out returnValue);
            return returnValue;
        }

        public static decimal ToDecimal(object value)
        {
            if (value == null || value == DBNull.Value)
            {
                return 0;
            }
            else
            {
                decimal returnValue = 0;
                value = RemoveSymbols(value.ToString());
                decimal.TryParse(value.ToString(), NumberStyles.Any, CultureInfo.InvariantCulture, out returnValue);
                return returnValue;
            }
        }

        public static double ToDouble(object value)
        {
            if (value == null || value == DBNull.Value)
            {
                return 0;
            }
            else
            {
                double returnValue = 0;
                value = RemoveSymbols(value.ToString());
                double.TryParse(value.ToString(), NumberStyles.Any, CultureInfo.InvariantCulture, out returnValue);
                return returnValue;
            }
        }

        public static Int32 ToInt32(object value)
        {
            if (value == null || value == DBNull.Value) return 0;
            string v = RemoveSymbols(value.ToString());
            if (v.Contains("."))
            {
                decimal deValue = 0;
                decimal.TryParse(v, out deValue);
                return (Int32)deValue;
            }
            else
            {
                Int32 returnValue;
                Int32.TryParse(v, out returnValue);
                return returnValue;
            }
        }

        public static uint ToUInt(string value)
        {
            value = RemoveSymbols(value);
            if (value.Contains("."))
            {
                decimal deValue = 0;
                decimal.TryParse(value, out deValue);
                return (uint)deValue;
            }
            else
            {
                uint returnValue;
                uint.TryParse(value, out returnValue);
                return returnValue;
            }
        }

        public static Int32 ToInt32(string value)
        {
            value = RemoveSymbols(value);
            if (value.Contains("."))
            {
                decimal deValue = 0;
                decimal.TryParse(value, out deValue);
                return (Int32)deValue;
            }
            else
            {
                Int32 returnValue;
                Int32.TryParse(value, out returnValue);
                return returnValue;
            }
        }

        public static Int64 ToInt64(string value)
        {
            value = RemoveSymbols(value);
            if (value.Contains("."))
            {
                decimal deValue = 0;
                decimal.TryParse(value, out deValue);
                return (Int64)deValue;
            }
            else
            {
                Int64 returnValue;
                Int64.TryParse(value, out returnValue);
                return returnValue;
            }
        }

        public static Int16 ToInt16(string value)
        {
            value = RemoveSymbols(value);
            if (value.Contains("."))
            {
                decimal deValue = 0;
                decimal.TryParse(value, out deValue);
                return (Int16)deValue;
            }
            else
            {
                Int16 returnValue;
                Int16.TryParse(value, out returnValue);
                return returnValue;
            }
        }

        public static DateTime ToDateTime(string value)
        {
            DateTime returnValue;
            DateTime.TryParse(value, out returnValue);
            return returnValue.Year <= 1900 ? new DateTime(1900, 1, 1) : returnValue;
        }

        public static DateTime ToDateTime(object value)
        {
            DateTime returnValue;
            DateTime.TryParse(Convert.ToString(value), out returnValue);
            return returnValue.Year <= 1900 ? new DateTime(1900, 1, 1) : returnValue;
        }

        public static string FormatDate(DateTime? dt, string format = "dd/MMM/yyyy")
        {
            string result = string.Empty;
            if (dt.HasValue)
            {
                if (dt.Value.Year > 1900)
                    result = dt.Value.ToString(format);
            }
            return result;
        }

        public static string ToDateTimeFormat(string value, string format)
        {
            DateTime dt = ToDateTime(value);
            if (dt.Year <= 1900)
                return string.Empty;
            else
                return dt.ToString(format);
        }

        private static DateTime ToDateTime(string value, string format)
        {
            DateTime returnValue;
            DateTime.TryParseExact(value, format, CultureInfo.InvariantCulture, DateTimeStyles.None, out returnValue);
            return returnValue.Year <= 1900 ? new DateTime(1900, 1, 1) : returnValue;
        }

        //public static DateTime ToDateTimeAllFormat(string value) {
        //    DateTime returnValue = ToDateTime(value,"dd/MM/yyyy");
        //    if(returnValue.Year <= 1900) {
        //        returnValue = ToDateTime(value,"dd/MMM/yyyy");
        //    }
        //    if(returnValue.Year <= 1900) {
        //        returnValue = ToDateTime(value,"dd/M/yyyy");
        //    }
        //    if(returnValue.Year <= 1900) {
        //        returnValue = ToDateTime(value,"d/MM/yyyy");
        //    }
        //    if(returnValue.Year <= 1900) {
        //        returnValue = ToDateTime(value,"d/MMM/yyyy");
        //    }
        //    if(returnValue.Year <= 1900) {
        //        returnValue = ToDateTime(value,"d/M/yyyy");
        //    }
        //    return returnValue.Year <= 1900 ? new DateTime(1900,1,1) : returnValue;
        //}

        public static DateTime ToFromOADate(string value, string format = "")
        {
            if (value.Contains("-") == true || value.Contains("/") == true)
            {
                if (string.IsNullOrEmpty(format) == false)
                {
                    DateTime returnValue = Convert.ToDateTime("01/01/1900");
                    try { returnValue = DateTime.ParseExact(value, format, CultureInfo.InvariantCulture); } catch { }
                    return returnValue;
                }
                else
                {
                    return DataTypeHelper.ToDateTime(value);
                }
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

        public static DateTime ToFromExcelDate(decimal d)
        {
            //double d = (double)0.28819444444444448;
            double db = (double)d;
            double x = (24 * 60) * db * 60;
            DateTime dt = DateTime.Now.Date;
            dt = dt.AddSeconds(x);
            return dt;
        }

        public static string ToFromExcelTimeValue(string timeValue)
        {
            string result = string.Empty;
            if (timeValue.Contains(":"))
            {
                result = timeValue.Trim();
            }
            else
            {
                decimal etdValue = DataTypeHelper.ToDecimal(timeValue);
                if (timeValue.Contains("E-2") == true)
                {
                    timeValue = timeValue.Replace("E-2", "").Trim();
                    etdValue = DataTypeHelper.SafeDivision(DataTypeHelper.ToDecimal(timeValue), 100);
                }
                else if (timeValue.Contains("E+2") == true)
                {
                    timeValue = timeValue.Replace("E+2", "").Trim();
                    etdValue = DataTypeHelper.ToDecimal(timeValue) * 100;
                }
                DateTime minDate = Convert.ToDateTime("01/01/1900");
                DateTime etdDate = minDate;
                if (etdValue <= 1)
                {
                    etdDate = DataTypeHelper.ToFromExcelDate(etdValue);
                }
                if (etdDate.Year <= 1900)
                {
                    etdDate = DataTypeHelper.ToDateTime(DateTime.Now.Date.ToString("MM/dd/yyyy") + " " + timeValue);
                }
                if (etdDate.Year > 1900)
                {
                    result = etdDate.ToString("HH:mm");
                }
            }
            return result;
        }

        public static string Convert24HoursFormat(string value)
        {
            try
            {
                if (string.IsNullOrEmpty(value) == false)
                {
                    value = value.Replace(" ", "").Trim().ToUpper();
                }
                if (string.IsNullOrEmpty(value) == false)
                {
                    if (value.Contains("AM") == true || value.Contains("PM") == true)
                    {
                        value = value.Replace(" ", "").Replace("`", "").Replace("'", "").Replace("\"", "").Replace(";", "").Trim().ToUpper();
                    }
                    DateTime dt = Convert.ToDateTime(DateTime.Now.Date.ToString("MM/dd/yyyy") + " " + value);
                    value = dt.ToString("HH:mm");
                }
                if (string.IsNullOrEmpty(value) == false)
                {
                    value = value.Replace(".", ":");
                }
            }
            catch { value = string.Empty; }
            return value;
        }

        public static DateTime ExcelToDate(string value)
        {
            DateTime returnValue = DataTypeHelper.ToFromOADate(value);
            if (returnValue.Year <= 1900)
            {
                returnValue = ToDateTime(value, "dd/MMM/yyyy");
            }
            if (returnValue.Year <= 1900)
            {
                returnValue = ToDateTime(value, "d/MMM/yyyy");
            }
            if (returnValue.Year <= 1900)
            {
                returnValue = ToDateTime(value, "dd/MMM/yy");
            }
            if (returnValue.Year <= 1900)
            {
                returnValue = ToDateTime(value, "d/MMM/yy");
            }
            ///
            if (returnValue.Year <= 1900)
            {
                returnValue = ToDateTime(value, "dd-MMM-yyyy");
            }
            if (returnValue.Year <= 1900)
            {
                returnValue = ToDateTime(value, "d-MMM-yyyy");
            }
            if (returnValue.Year <= 1900)
            {
                returnValue = ToDateTime(value, "dd-MMM-yy");
            }
            if (returnValue.Year <= 1900)
            {
                returnValue = ToDateTime(value, "d-MMM-yy");
            }
            if (returnValue.Year <= 1900)
            {
                returnValue = ToDateTime(value, "dd/MM/yyyy");
            }
            if (returnValue.Year <= 1900)
            {
                returnValue = ToDateTime(value, "dd/MM/yy");
            }
            return returnValue.Year <= 1900 ? new DateTime(1900, 1, 1) : returnValue;
        }

        public static String ConvertString(object value)
        {
            if (value == null || value == DBNull.Value)
                return string.Empty;
            else
                return (value.ToString() == "null" ? "" : value.ToString());
        }

        public static string ConvertCode(object value)
        {
            string code = DataTypeHelper.ConvertString(value);
            if (string.IsNullOrEmpty(code) == false)
            {
                code = code.Replace(" ", "").ToUpper().Trim().ToString();
            }
            return code;
        }

        public static bool ToBoolean(object value)
        {
            if (value == null)
                return false;
            value = Convert.ToString(value).Trim().ToLower();
            if (value.ToString() == "true" || value.ToString() == "1" || value.ToString() == "yes" || value.ToString() == "y")
                return true;
            else
                return false;
        }

        public static bool CheckBoolean(string value)
        {
            bool calcValue = false;
            if (string.IsNullOrEmpty(value) == false)
                value = value.ToLower().Trim();
            else
                value = string.Empty;

            if (value.ToString().Contains("true"))
                calcValue = true;
            if (value.ToString().Contains("yes"))
                calcValue = true;
            if (value.ToString().Contains("on"))
                calcValue = true;
            if (value.ToString() == "1")
                calcValue = true;

            return calcValue;
        }

        public static int GetQuarterNumber(DateTime dtNow)
        {
            int quarter = 0;
            if (dtNow.Month >= 1 && dtNow.Month <= 3)
            {
                quarter = 1;
            }
            else if (dtNow.Month >= 4 && dtNow.Month <= 6)
            {
                quarter = 2;
            }
            else if (dtNow.Month >= 7 && dtNow.Month <= 9)
            {
                quarter = 3;
            }
            else if (dtNow.Month >= 10 && dtNow.Month <= 12)
            {
                quarter = 4;
            }
            return quarter;
        }

        public static DateTime[] DatesOfQuarter(DateTime dtNow)
        {
            DateTime[] dtReturn = new DateTime[2];
            if (dtNow.Month >= 1 && dtNow.Month <= 3)
            {
                dtReturn[0] = DateTime.Parse("1/1/" + dtNow.Year.ToString());
                dtReturn[1] = DateTime.Parse("3/31/" + dtNow.Year.ToString());
            }
            else if (dtNow.Month >= 4 && dtNow.Month <= 6)
            {
                dtReturn[0] = DateTime.Parse("4/1/" + dtNow.Year.ToString());
                dtReturn[1] = DateTime.Parse("6/30/" + dtNow.Year.ToString());
            }
            else if (dtNow.Month >= 7 && dtNow.Month <= 9)
            {
                dtReturn[0] = DateTime.Parse("7/1/" + dtNow.Year.ToString());
                dtReturn[1] = DateTime.Parse("9/30/" + dtNow.Year.ToString());
            }
            else if (dtNow.Month >= 10 && dtNow.Month <= 12)
            {
                dtReturn[0] = DateTime.Parse("10/1/" + dtNow.Year.ToString());
                dtReturn[1] = DateTime.Parse("12/31/" + dtNow.Year.ToString());
            }
            return dtReturn;
        }

        public static string GenerateAlphaNumeric(int length)
        {
            Random random = new Random();
            string characters = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
            StringBuilder result = new StringBuilder(length);
            for (int i = 0; i < length; i++)
            {
                result.Append(characters[random.Next(characters.Length)]);
            }
            return result.ToString();
        }

        public static int TotalWeeks(DateTime start, DateTime end)
        {
            return (int)(start - end).TotalDays / 7;
        }

        public static int TotalMonths(DateTime start, DateTime end)
        {
            return (start.Year * 12 + start.Month) - (end.Year * 12 + end.Month);
        }

        public static DateTime GetFirstDayOfMonth(DateTime dateTime)
        {
            return new DateTime(dateTime.Year, dateTime.Month, 1);
        }

        public static DateTime GetLastDayOfMonth(DateTime dateTime)
        {
            DateTime firstDayOfTheMonth = new DateTime(dateTime.Year, dateTime.Month, 1);
            return firstDayOfTheMonth.AddMonths(1).AddDays(-1);
        }

        public static bool CheckDate(DateTime? fromDate, DateTime? toDate, DateTime checkDate)
        {
            bool isExist = false;
            DateTime minDate = Convert.ToDateTime("01/01/1900");
            if (checkDate >= (fromDate ?? minDate) && checkDate <= (toDate ?? minDate))
            {
                isExist = true;
            }
            return isExist;
            //double fromDaysDiff = -1;
            //double toDaysDiff = -1;
            //if ((fromDate ?? minDate).Year > 1900)
            //{
            //    fromDaysDiff = Helper.GetDayDifference(fromDate, flightDate).TotalDays;
            //}
            //if ((toDate ?? minDate).Year > 1900)
            //{
            //    toDaysDiff = Helper.GetDayDifference(toDate, flightDate).TotalDays;
            //}
            //if ((fromDaysDiff == -1 && toDaysDiff == -1) ||
            //    (fromDaysDiff == -1 && toDaysDiff <= 0) ||
            //    (fromDaysDiff >= 0 && toDaysDiff == -1) ||
            //    (fromDaysDiff >= 0 && toDaysDiff <= 0)
            //)
            //{
            //    isExist = true;
            //}
            //return isExist;
        }

        public static double GetSeconds(string hours)
        {
            double seconds = 0;
            if (string.IsNullOrEmpty(hours) == false)
            {
                DateTime dt1 = DateTime.Now.Date;
                DateTime dt2 = dt1;
                if (hours.Contains(".") == true)
                {
                    double tempHours = 0;
                    double.TryParse(hours, out tempHours);
                    dt2 = dt2.AddHours(tempHours);
                }
                else
                {
                    if (hours.Contains(":") == false)
                    {
                        hours = hours + ":00";
                    }
                    CultureInfo culture = new CultureInfo("en-US");
                    dt2 = Convert.ToDateTime(dt1.ToString("MM/dd/yyyy") + " " + hours, culture);
                    //dt2 = Convert.ToDateTime(dt1.ToString("MM/dd/yyyy") + " " + hours);
                    //Helper.Log("dt2  : " + dt2);
                }
                TimeSpan ts = dt2 - dt1;
                //Console.WriteLine("TotalHours=" + ts.TotalHours + ",TotalMinutes=" + ts.TotalMinutes + ",TotalSeconds=" + ts.TotalSeconds);
                seconds = ts.TotalSeconds;
            }
            return seconds;
        }

        public static List<DateTime> GetFortNightDates(DateTime dt)
        {
            List<DateTime> dates = new List<DateTime>();
            if (dt.Day < 16)
            {
                dt = GetFirstDayOfMonth(dt);
                dates.Add(dt);
                dt = Convert.ToDateTime(string.Format("{0}/{1}/{2}", dt.Month, "15", dt.Year));
                dates.Add(dt);
            }
            else
            {
                dt = Convert.ToDateTime(string.Format("{0}/{1}/{2}", dt.Month, "16", dt.Year));
                dates.Add(dt);
                dt = GetLastDayOfMonth(dt);
                dates.Add(dt);
            }
            return dates;
        }

        public static List<DateTime> GetFortNightDates(DateTime startDate, DateTime endDate)
        {
            List<DateTime> dates = new List<DateTime>();
            var months = MonthDiff(startDate, endDate) + 1;
            int i;
            for (i = 0; i < months; i++)
            {
                DateTime calcDate = startDate;
                calcDate = GetFirstDayOfMonth(calcDate.AddMonths(i));
                DateTime dt = calcDate;
                if (dt <= endDate)
                {
                    dates.Add(dt);
                    dt = Convert.ToDateTime(string.Format("{0}/{1}/{2}", calcDate.Month, "15", calcDate.Year));
                    dates.Add(dt);
                }
                dt = Convert.ToDateTime(string.Format("{0}/{1}/{2}", calcDate.Month, "16", calcDate.Year));
                if (dt <= endDate)
                {
                    dates.Add(dt);
                    dt = GetLastDayOfMonth(calcDate);
                    dates.Add(dt);
                }
            }
            return dates;
        }

        public static double GetTotalSeconds(string hours)
        {
            double totalSeconds = 0;
            try
            {
                if (string.IsNullOrEmpty(hours) == false)
                {
                    string[] arr = hours.Split((":").ToCharArray());
                    if (arr.Length >= 1)
                    {
                        int h = 0, m = 0, s = 0;
                        h = DataTypeHelper.ToInt32(arr[0].ToString().Trim());
                        if (arr.Length >= 2)
                        {
                            m = DataTypeHelper.ToInt32(arr[1].ToString().Trim());
                        }
                        if (arr.Length >= 3)
                        {
                            s = DataTypeHelper.ToInt32(arr[2].ToString().Trim());
                        }
                        TimeSpan inTime = new TimeSpan(0, 0, 0); //or TimeSpan.Parse("9:35");
                        TimeSpan outTime = new TimeSpan(h, m, s); //or TimeSpan.Parse("11:55");

                        TimeSpan ts = outTime - inTime;
                        totalSeconds = ts.TotalSeconds;
                    }
                }
            }
            catch { }
            return totalSeconds;
        }

        public static List<DateTime> GetMonthDates(DateTime dt)
        {
            List<DateTime> dates = new List<DateTime>();
            dates.Add(GetFirstDayOfMonth(dt));
            dates.Add(GetLastDayOfMonth(dt));
            return dates;
        }

        public static List<DateTime> GetMonthDates(DateTime startDate, DateTime endDate)
        {
            List<DateTime> dates = new List<DateTime>();
            var months = MonthDiff(startDate, endDate) + 1;
            int i;
            for (i = 0; i < months; i++)
            {
                DateTime calcDate = startDate;
                calcDate = GetFirstDayOfMonth(calcDate.AddMonths(i));
                DateTime dt = calcDate;
                if (dt <= endDate)
                {
                    dates.Add(dt);
                    dt = GetLastDayOfMonth(calcDate);
                    dates.Add(dt);
                }
            }
            return dates;
        }


        public static List<DateTime> GetQuarterDates(DateTime startDate, DateTime endDate)
        {
            List<DateTime> dates = new List<DateTime>();
            var years = (endDate.Year - startDate.Year) + 1;
            int i;
            for (i = 0; i < years; i++)
            {
                DateTime calcDate = startDate;
                calcDate = startDate.AddYears(i);

                //Q1
                DateTime dt = Convert.ToDateTime(string.Format("{0}/{1}/{2}", "01", "01", calcDate.Year));
                if (dt <= endDate)
                {
                    dates.Add(dt);
                    dates.Add(Convert.ToDateTime(string.Format("{0}/{1}/{2}", "03", "31", calcDate.Year)));
                }

                //Q2
                dt = Convert.ToDateTime(string.Format("{0}/{1}/{2}", "04", "01", calcDate.Year));
                if (dt <= endDate)
                {
                    dates.Add(dt);
                    dates.Add(Convert.ToDateTime(string.Format("{0}/{1}/{2}", "06", "30", calcDate.Year)));
                }

                //Q3
                dt = Convert.ToDateTime(string.Format("{0}/{1}/{2}", "07", "01", calcDate.Year));
                if (dt <= endDate)
                {
                    dates.Add(dt);
                    dates.Add(Convert.ToDateTime(string.Format("{0}/{1}/{2}", "09", "30", calcDate.Year)));
                }

                //Q4
                dt = Convert.ToDateTime(string.Format("{0}/{1}/{2}", "10", "01", calcDate.Year));
                if (dt <= endDate)
                {
                    dates.Add(dt);
                    dates.Add(Convert.ToDateTime(string.Format("{0}/{1}/{2}", "12", "31", calcDate.Year)));
                }

            }
            return dates;
        }

        public static List<DateTime> GetYearDates(DateTime dt)
        {
            List<DateTime> dates = new List<DateTime>();
            dates.Add(Convert.ToDateTime(string.Format("{0}/{1}/{2}", "01", "01", dt.Year)));
            dates.Add(Convert.ToDateTime(string.Format("{0}/{1}/{2}", "12", "31", dt.Year)));
            return dates;
        }

        public static List<DateTime> GetYearDates(DateTime startDate, DateTime endDate)
        {
            List<DateTime> dates = new List<DateTime>();
            var years = (endDate.Year - startDate.Year) + 1;
            int i;
            for (i = 0; i < years; i++)
            {
                DateTime calcDate = startDate;
                calcDate = startDate.AddYears(i);

                DateTime dt = Convert.ToDateTime(string.Format("{0}/{1}/{2}", "01", "01", calcDate.Year));
                if (dt <= endDate)
                {
                    dates.Add(dt);
                    dates.Add(Convert.ToDateTime(string.Format("{0}/{1}/{2}", "12", "31", calcDate.Year)));
                }
            }
            return dates;
        }

        public static double MonthDiff(DateTime from, DateTime to)
        {
            /// |-------X----|---------------|---------------|--X-----------|
            ///         ^                                       ^
            ///       from                                     to

            //change the dates if to is before from
            if (to.Ticks < from.Ticks)
            {
                DateTime temp = from;
                from = to;
                to = temp;
            }

            /// Gets the day percentage of the months = 0...1
            ///
            /// 0            1                               0              1
            /// |-------X----|---------------|---------------|--X-----------|
            /// ^^^^^^^^^                                    ^^^^
            /// percFrom                                    percTo
            double percFrom = (double)from.Day / DateTime.DaysInMonth(from.Year, from.Month);
            double percTo = (double)to.Day / DateTime.DaysInMonth(to.Year, to.Month);

            /// get the amount of months between the two dates based on day one
            /// 
            /// |-------X----|---------------|---------------|--X-----------|
            /// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
            ///                        months
            double months = (to.Year * 12 + to.Month) - (from.Year * 12 + from.Month);

            /// Return the right parts
            /// 
            /// |-------X----|---------------|---------------|--X-----------|            
            ///         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
            ///                      return
            return months - percFrom + percTo;
        }

        public static int GetNDigitsRandomNumber(int digits)
        {
            var min = 1;
            for (int i = 0; i < digits - 1; i++)
            {
                min *= 10;
            }
            var max = min * 10;

            return (new Random()).Next(min, max);
        }

        public static bool IsAlphaNumeric(string value)
        {
            Regex regex = new Regex(
    @"^(?=.*[a-zA-Z])(?=.*[0-9])[a-zA-Z0-9]+$",
    RegexOptions.IgnoreCase
    | RegexOptions.Multiline
    | RegexOptions.IgnorePatternWhitespace
    | RegexOptions.Compiled
    );
            return regex.IsMatch(value);
        }

        public static string NumbersToWords(decimal inputNumber)
        {
            int inputNo = Decimal.ToInt32(inputNumber);

            if (inputNo == 0)
                return "Zero";

            int[] numbers = new int[4];
            int first = 0;
            int u, h, t;
            System.Text.StringBuilder sb = new System.Text.StringBuilder();

            if (inputNo < 0)
            {
                sb.Append("Minus ");
                inputNo = -inputNo;
            }

            string[] words0 = {"" ,"One ", "Two ", "Three ", "Four ",
            "Five " ,"Six ", "Seven ", "Eight ", "Nine "};
            string[] words1 = {"Ten ", "Eleven ", "Twelve ", "Thirteen ", "Fourteen ",
            "Fifteen ","Sixteen ","Seventeen ","Eighteen ", "Nineteen "};
            string[] words2 = {"Twenty ", "Thirty ", "Forty ", "Fifty ", "Sixty ",
            "Seventy ","Eighty ", "Ninety "};
            string[] words3 = { "Thousand ", "Lakh ", "Crore " };

            numbers[0] = inputNo % 1000; // units
            numbers[1] = inputNo / 1000;
            numbers[2] = inputNo / 100000;
            numbers[1] = numbers[1] - 100 * numbers[2]; // thousands
            numbers[3] = inputNo / 10000000; // crores
            numbers[2] = numbers[2] - 100 * numbers[3]; // lakhs

            for (int i = 3; i > 0; i--)
            {
                if (numbers[i] != 0)
                {
                    first = i;
                    break;
                }
            }
            for (int i = first; i >= 0; i--)
            {
                if (numbers[i] == 0) continue;
                u = numbers[i] % 10; // ones
                t = numbers[i] / 10;
                h = numbers[i] / 100; // hundreds
                t = t - 10 * h; // tens
                if (h > 0) sb.Append(words0[h] + "Hundred ");
                if (u > 0 || t > 0)
                {
                    if (h > 0 || i == 0) sb.Append("and ");
                    if (t == 0)
                        sb.Append(words0[u]);
                    else if (t == 1)
                        sb.Append(words1[u]);
                    else
                        sb.Append(words2[t - 2] + words0[u]);
                }
                if (i != 0) sb.Append(words3[i - 1]);
            }
            return sb.ToString().TrimEnd();
        }

        public static string FormatAWBNo(string awb_no)
        {
            return (awb_no.Length >= 11 ? awb_no.Substring(0, 3) + " " + awb_no.Substring(3, 4) + " " + awb_no.Substring(7, awb_no.Length - 7) : awb_no);
        }

        public static string FormatAWBNo2(string awb_no)
        {
            return (awb_no.Length >= 11 ? awb_no.Substring(0, 3) + " " + awb_no.Substring(3, awb_no.Length - 3) : awb_no);
        }

        public static string GetAWBNoWithOutPrefix(string awb_no)
        {
            return (awb_no.Length >= 11 ? awb_no.Substring(3, awb_no.Length - 3) : awb_no);
        }

        public static string GetAWBNoPrefix(string awb_no)
        {
            return (awb_no.Length >= 11 ? awb_no.Substring(0, 3) : "");
        }

        public static string GetMonthName(int month)
        {
            string result = string.Empty;
            switch (month)
            {
                case 1: result = "Jan"; break;
                case 2: result = "Feb"; break;
                case 3: result = "Mar"; break;
                case 4: result = "Apr"; break;
                case 5: result = "May"; break;
                case 6: result = "Jun"; break;
                case 7: result = "Jul"; break;
                case 8: result = "Aug"; break;
                case 9: result = "Sep"; break;
                case 10: result = "Oct"; break;
                case 11: result = "Nov"; break;
                case 12: result = "Dec"; break;
            }
            return result;
        }

        public static DateTime Get_FirstDay_Weekly_1_8_15_22(DateTime checkDate)
        {
            DateTime result = checkDate;
            int day = checkDate.Day;
            string monthName = DataTypeHelper.GetMonthName(checkDate.Month);
            int year = checkDate.Year;
            if (day >= 1 && day <= 7)
            {
                result = Convert.ToDateTime("01/" + monthName + "/" + year);
            }
            else if (day >= 8 && day <= 14)
            {
                result = Convert.ToDateTime("08/" + monthName + "/" + year);
            }
            else if (day >= 15 && day <= 21)
            {
                result = Convert.ToDateTime("15/" + monthName + "/" + year);
            }
            else if (day >= 22)
            {
                result = Convert.ToDateTime("22/" + monthName + "/" + year);
            }
            return result;
        }

        public static DateTime Get_LastDay_Weekly_1_8_15_22(DateTime checkDate)
        {
            DateTime result = checkDate;
            int day = checkDate.Day;
            string monthName = DataTypeHelper.GetMonthName(checkDate.Month);
            int year = checkDate.Year;
            if (day >= 1 && day <= 7)
            {
                result = Convert.ToDateTime("07/" + monthName + "/" + year);
            }
            else if (day >= 8 && day <= 14)
            {
                result = Convert.ToDateTime("14/" + monthName + "/" + year);
            }
            else if (day >= 15 && day <= 21)
            {
                result = Convert.ToDateTime("21/" + monthName + "/" + year);
            }
            else if (day >= 22)
            {
                result = DataTypeHelper.GetLastDayOfMonth(checkDate);
            }
            return result;
        }

        public static DateTime Get_FirstDay_Weekly_1_8_16_23(DateTime checkDate)
        {
            DateTime result = checkDate;
            int day = checkDate.Day;
            string monthName = DataTypeHelper.GetMonthName(checkDate.Month);
            int year = checkDate.Year;
            if (day >= 1 && day <= 7)
            {
                result = Convert.ToDateTime("01/" + monthName + "/" + year);
            }
            else if (day >= 8 && day <= 15)
            {
                result = Convert.ToDateTime("08/" + monthName + "/" + year);
            }
            else if (day >= 16 && day <= 22)
            {
                result = Convert.ToDateTime("15/" + monthName + "/" + year);
            }
            else if (day >= 23)
            {
                result = Convert.ToDateTime("22/" + monthName + "/" + year);
            }
            return result;
        }

        public static DateTime Get_LastDay_Weekly_1_8_16_23(DateTime checkDate)
        {
            DateTime result = checkDate;
            int day = checkDate.Day;
            string monthName = DataTypeHelper.GetMonthName(checkDate.Month);
            int year = checkDate.Year;
            if (day >= 1 && day <= 7)
            {
                result = Convert.ToDateTime("07/" + monthName + "/" + year);
            }
            else if (day >= 8 && day <= 15)
            {
                result = Convert.ToDateTime("15/" + monthName + "/" + year);
            }
            else if (day >= 16 && day <= 22)
            {
                result = Convert.ToDateTime("16/" + monthName + "/" + year);
            }
            else if (day >= 23)
            {
                result = DataTypeHelper.GetLastDayOfMonth(checkDate);
            }
            return result;
        }

        

        /// <summary>
        /// Returns the first day of the week that the specified
        /// date is in using the current culture. 
        /// </summary>
        public static DateTime GetFirstDayOfWeek(DateTime dayInWeek, DayOfWeek firstDay)
        {
            CultureInfo defaultCultureInfo = CultureInfo.CurrentCulture;
            return GetFirstDayOfWeek(dayInWeek, defaultCultureInfo, firstDay);
        }

        public static DateTime GetLastDayOfWeek(DateTime dayInWeek, DayOfWeek firstDay)
        {
            CultureInfo defaultCultureInfo = CultureInfo.CurrentCulture;
            return GetFirstDayOfWeek(dayInWeek, defaultCultureInfo, firstDay).AddDays(6);
        }

        public static DateTime GetLastDayOfWeek(DateTime dayInWeek, DayOfWeek firstDay, DateTime checkDate)
        {
            CultureInfo defaultCultureInfo = CultureInfo.CurrentCulture;
            DateTime result = GetFirstDayOfWeek(dayInWeek, defaultCultureInfo, firstDay).AddDays(6);
            DateTime tempMonthEndDate = DataTypeHelper.GetLastDayOfMonth(checkDate);
            TimeSpan ts = result - tempMonthEndDate;
            if (ts.Days > 0)
            {
                result = tempMonthEndDate;
            }
            return result;
        }

        /// <summary>
        /// Returns the first day of the week that the specified date 
        /// is in. 
        /// </summary>
        private static DateTime GetFirstDayOfWeek(DateTime dayInWeek, CultureInfo cultureInfo, DayOfWeek firstDay)
        {
            //DayOfWeek firstDay = DayOfWeek.Monday;
            DateTime firstDayInWeek = dayInWeek.Date;
            while (firstDayInWeek.DayOfWeek != firstDay)
                firstDayInWeek = firstDayInWeek.AddDays(-1);

            // International week start date is sunday
            // Airline week start date is monday. so add 1 day
            return firstDayInWeek;
        }

        public static string GetLetter(int intCol)
        {

            int intFirstLetter = ((intCol) / 676) + 64;
            int intSecondLetter = ((intCol % 676) / 26) + 64;
            int intThirdLetter = (intCol % 26) + 65;  // ' SHOULD BE + 64?

            char FirstLetter = (intFirstLetter > 64) ? (char)intFirstLetter : ' ';
            char SecondLetter = (intSecondLetter > 64) ? (char)intSecondLetter : ' ';
            char ThirdLetter = (char)intThirdLetter;

            return string.Concat(FirstLetter, SecondLetter, ThirdLetter).Trim();
        }

        public static object GetValue(PropertyInfo[] properties, string propertyName, object source)
        {
            object value = null;
            if (properties != null && source != null)
            {
                PropertyInfo property = (from q in properties
                                         where q.Name == propertyName
                                         select q).FirstOrDefault();
                if (property != null)
                {
                    value = property.GetValue(source);
                }
            }
            return value;
        }

        public static double ToRadians(
           double angleIn10thofaDegree)
        {
            // Angle in 10th 
            // of a degree 
            return (angleIn10thofaDegree *
                           Math.PI) / 180;
        }

        public static double CalculateDistance(double lat1,
                               double lat2,
                               double lon1,
                               double lon2)
        {

            // The math module contains  
            // a function named toRadians  
            // which converts from degrees  
            // to radians. 
            lon1 = ToRadians(lon1);
            lon2 = ToRadians(lon2);
            lat1 = ToRadians(lat1);
            lat2 = ToRadians(lat2);

            // Haversine formula  
            double dlon = lon2 - lon1;
            double dlat = lat2 - lat1;
            double a = Math.Pow(Math.Sin(dlat / 2), 2) +
                       Math.Cos(lat1) * Math.Cos(lat2) *
                       Math.Pow(Math.Sin(dlon / 2), 2);

            double c = 2 * Math.Asin(Math.Sqrt(a));

            // Radius of earth in  
            // kilometers. Use 3956  
            // for miles 
            double r = 6371;

            // calculate the result 
            return (c * r);
        }

        public static string ToHex(Color color)
        {
            return String.Format("#{0}{1}{2}{3}"
                , "" //color.A.ToString("X").Length == 1 ? String.Format("0{0}", color.A.ToString("X")) : color.A.ToString("X")
                , color.R.ToString("X").Length == 1 ? String.Format("0{0}", color.R.ToString("X")) : color.R.ToString("X")
                , color.G.ToString("X").Length == 1 ? String.Format("0{0}", color.G.ToString("X")) : color.G.ToString("X")
                , color.B.ToString("X").Length == 1 ? String.Format("0{0}", color.B.ToString("X")) : color.B.ToString("X"));
        }
    }
}

