using Microsoft.AspNetCore.Mvc;
using Dapper;
using System.Data.SqlClient;
using api.Models;
using api.Helpers;
using System.Collections.Generic;
using System;
using System.Linq;
using Microsoft.Net.Http.Headers;

namespace api.Controllers
{
    [ApiController]
    [Route("[controller]/[action]")]
    public class HomeController : ControllerBase
    {
        private readonly IConfiguration configuration;
        private string connectionString = "";
        public HomeController(IConfiguration config)
        {
            configuration = config;
            connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        public dynamic New()
        {
            return new dm_asset_core_lot();
        }

        public dynamic List(int pageIndex
                , int pageSize
                , string sortName = ""
                , string sortOrder = ""
                , string symbol = ""
                , bool? isIgnore = false
                , DateTime? fromDate = null
                , DateTime? toDate = null
                , bool? isOptions = false
                , bool? isGold = false
                , string tradeType = "")
        {
            DateTime minDate = Convert.ToDateTime("01/01/1900");
            int totalRows = 0;
            if (string.IsNullOrEmpty(symbol) == false)
            {
                symbol = Helper.ConvertStringSQLFormat(symbol);
            }
            string where = "";
            where += " where lot.dm_asset_core_lot_id > 0" + Environment.NewLine;
            if ((fromDate ?? minDate).Year > 1900)
            {
                where += string.Format(" and lot.RecordDate >= '{0}' ", (fromDate ?? minDate).ToString("MM/dd/yyyy")) + Environment.NewLine;
            }
            if ((toDate ?? minDate).Year > 1900)
            {
                where += string.Format(" and lot.RecordDate <= '{0}' ", (toDate ?? minDate).ToString("MM/dd/yyyy")) + Environment.NewLine;
            }
            Console.WriteLine("isIgnore=" + isIgnore);
            if (string.IsNullOrEmpty(symbol) == false)
            {
                if ((isIgnore ?? false) == true)
                {
                    where += " and lot.Symbol not in (" + symbol + ")" + Environment.NewLine;
                }
                else
                {
                    where += " and lot.Symbol in (" + symbol + ")" + Environment.NewLine;
                }
            }
            if (string.IsNullOrEmpty(tradeType) == false)
            {
                tradeType = Helper.ConvertStringSQLFormat(tradeType);
                where += " and lot.LotType in (" + tradeType + ")" + Environment.NewLine;
            }
            string sql = "select isnull(count(*),0) as cnt from dm_asset_core_lot lot " + where + Environment.NewLine;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                totalRows = (int)connection.ExecuteScalar(sql);
            }
            sql = "select" + Environment.NewLine;
            sql += " lot.* from dm_asset_core_lot lot" + Environment.NewLine;
            sql += where + Environment.NewLine;
            sql += " order by " + sortName + " " + sortOrder + Environment.NewLine;
            sql += " OFFSET (" + (pageIndex - 1) + ") * " + pageSize + " ROWS " + Environment.NewLine;
            sql += " FETCH NEXT " + pageSize + " ROWS ONLY" + Environment.NewLine;
            //Helper.Log("pageIndex=" + pageIndex + ",pageSize=" + pageSize);
            Helper.Log(sql);
            List<dm_asset_core_lot> list;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                list = connection.Query<dm_asset_core_lot>(sql).ToList();
            }
            double xirr = this.XIRR(symbol, isIgnore, fromDate, toDate, isOptions, isGold);
            List<dm_asset_core_lot_share> totalSharesList = this.ListShare(symbol, isIgnore, isOptions, isGold);
            List<string> dividendSymbols = new List<string> { };//"PGINVIT-IV", "INDIGRID-IV", "RECLTD" };
            List<string> debtSymbols = new List<string> { };// "LIQUIDBEES", "LIQUIDBEES-F" };
            totalSharesList = (from q in totalSharesList
                               where debtSymbols.Contains(q.Symbol) == false
                               select q).ToList();

            //decimal? totalGold = (from q in totalSharesList where q.Symbol == "GOLD" select q.Amount).Sum();
            decimal? totalCapitalCall = (from q in totalSharesList select q.Amount).Sum();
            //decimal? totalDividendCall = (from q in totalSharesList where dividendSymbols.Contains(q.Symbol) == true select q.Amount).Sum();
            decimal? totalInvestmentCall = (from q in totalSharesList
                                            where dividendSymbols.Contains(q.Symbol) == false
                                            && debtSymbols.Contains(q.Symbol) == false
                                            select q.Amount).Sum();

            decimal? totalStrategyCall = (from q in totalSharesList
                                          where dividendSymbols.Contains(q.Symbol) == false
                                          && debtSymbols.Contains(q.Symbol) == false
                                          && (q.Value ?? 0) > 0
                                          select q.Amount).Sum();

            //decimal? totalOptionsCall = (from q in totalSharesList
            //                           select q.Amount).Sum();
            decimal? totalPL = (from q in totalSharesList select (q.PL ?? 0)).Sum();

            decimal? totalUnRealizedPL = (from q in totalSharesList
                                          select (q.UnRealizedPL ?? 0)).Sum();
            decimal? currentMarketValue = (from q in totalSharesList
                                           select (q.CurrentMarketValue ?? 0)).Sum();
            decimal? totalDebtCall = (from q in totalSharesList where debtSymbols.Contains(q.Symbol) == true select q.Amount).Sum();

            sql = "exec [PROC_CALC_dm_asset_core_index]";
            CurrentIndexValue currentIndexValue;
            List<IndexList> indexList;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (var multi = connection.QueryMultiple(sql))
                {
                    currentIndexValue = multi.Read<CurrentIndexValue>().FirstOrDefault();
                    indexList = multi.Read<IndexList>().ToList();
                }
            }
            //totalCapitalCall = currentIndexValue.Total;
            //totalInvestmentCall = currentIndexValue.Total;
            //currentMarketValue = currentIndexValue.Current;
            //totalPL = currentIndexValue.PL;
            return new
            {
                xirr = xirr
                ,
                total = totalRows
                ,
                rows = list
                //,TotalGold = totalGold
                ,
                TotalCapitalCall = totalCapitalCall
                //,TotalDividendCall = totalDividendCall
                ,
                TotalInvestmentCall = totalInvestmentCall
                ,
                TotalStrategyCall = totalStrategyCall
                //,TotalOptionsCall = totalOptionsCall
                //,TotalDebtCall = totalDebtCall
                ,
                TotalPL = totalPL
                ,
                TotalPLPercent = currentIndexValue.PLPercent
                ,
                TotalUnRealizedPL = totalUnRealizedPL
                ,
                CurrentMarketValue = currentMarketValue
                ,
                indexList = indexList
            };
        }


        public List<dm_asset_core_lot_share> ListShare(string symbol = ""
                , bool? isIgnore = false
                , bool? isOptions = false
                , bool? isGold = false
                , bool? isCurrent = false
                , string sortName = ""
                , string sortOrder = "")
        {
            string declareSQL = "";
            string sql = "";
            DateTime minDate = Convert.ToDateTime("01/01/1900");

            declareSQL += "declare @TempSymbol as Table" + Environment.NewLine +
                    "(" + Environment.NewLine +
                    "ID INT IDENTITY(1, 1)," + Environment.NewLine +
                    "Symbol varchar(200)," + Environment.NewLine +
                    "LTCGShares decimal(19,8)" + Environment.NewLine +
                    "); " + Environment.NewLine +
                    "insert into @TempSymbol(Symbol,LTCGShares)" + Environment.NewLine +
                    "select tbl.Symbol,sum(tbl.LTCGShares) as LTCGShares from (" + Environment.NewLine +
                    "select lot.Symbol, " + Environment.NewLine +
                    "lot.dm_asset_core_lot_id,lot.RecordDate,lot.NumberOfShares,lot.SharePrice" + Environment.NewLine +
                    ",lot.LotType " + Environment.NewLine +
                    ",lot.BalanceShares" + Environment.NewLine +
                    ",lot.AvgPrice" + Environment.NewLine +
                    ",case when DATEADD(YEAR, 1, lot.RecordDate) < getdate() and lot.BalanceShares > 0 then " + Environment.NewLine +
                    "case when lot.LotType = 'B' then lot.NumberOfShares else lot.NumberOfShares * -1 end else 0 end as LTCGShares " + Environment.NewLine +
                    "from dm_asset_core_lot lot" + Environment.NewLine +
                    "where lot.LotType in ('B','S') " + Environment.NewLine +
                    "and BalanceShares > 0 " + Environment.NewLine +
                    ") as tbl " + Environment.NewLine +
                    "group by tbl.Symbol " + Environment.NewLine +
                    "";
            sql += "select" + Environment.NewLine;
            sql += " lot.Symbol" + Environment.NewLine +
                    ",lot.NumberOfShares" + Environment.NewLine +
                    ",lot.SharePrice" + Environment.NewLine +
                    ",lot.Amount" + Environment.NewLine +
                    ",lot.XIRR" + Environment.NewLine +
                    ",(lot.NumberOfShares * (select top 1 isnull(cp.SharePrice,0) as CurrentPrice from dm_asset_core_lot cp where cp.Symbol = lot.Symbol and cp.LotType != 'D' order by cp.RecordDate desc,cp.dm_asset_core_lot_id desc)) as CurrentMarketValue" + Environment.NewLine +
                    ",(select top 1 isnull(cp.SharePrice,0) as CurrentPrice from dm_asset_core_lot cp where cp.Symbol = lot.Symbol and cp.LotType != 'D' order by cp.RecordDate desc,cp.dm_asset_core_lot_id desc) as CurrentPrice " + Environment.NewLine +
                    ",((lot.NumberOfShares * (select top 1 isnull(cp.SharePrice,0) as CurrentPrice from dm_asset_core_lot cp where cp.Symbol = lot.Symbol and cp.LotType != 'D' order by cp.RecordDate desc,cp.dm_asset_core_lot_id desc)) - (lot.NumberOfShares * lot.SharePrice)) as PL" + Environment.NewLine +
                    ",(((lot.NumberOfShares * (select top 1 isnull(cp.SharePrice,0) as CurrentPrice from dm_asset_core_lot cp where cp.Symbol = lot.Symbol and cp.LotType != 'D' order by cp.RecordDate desc,cp.dm_asset_core_lot_id desc)) - (lot.NumberOfShares * lot.SharePrice)) / (lot.NumberOfShares * lot.SharePrice)) * 100 as PLPercent" + Environment.NewLine +
                    ",ts.LTCGShares" + Environment.NewLine +
                    ",si.[Value] as [Value]" + Environment.NewLine +
                    " from dm_asset_core_lot_share lot" + Environment.NewLine +
                    " left outer join dm_asset_core_symbol_index si on si.symbol = lot.symbol" + Environment.NewLine +
                    " join @TempSymbol ts on ts.Symbol = lot.Symbol" + Environment.NewLine +
                    "";
            string where = "";
            where += " where lot.Symbol != ''" + Environment.NewLine;
            if (string.IsNullOrEmpty(symbol) == false)
            {
                symbol = Helper.ConvertStringSQLFormat(symbol);
            }
            if (string.IsNullOrEmpty(symbol) == false)
            {
                if ((isIgnore ?? false) == true)
                {
                    where += " and lot.Symbol not in (" + symbol + ")" + Environment.NewLine;
                }
                else
                {
                    where += " and lot.Symbol in (" + symbol + ")" + Environment.NewLine;
                }
            }
            where += " and lot.NumberOfShares >= 1" + Environment.NewLine;
            sql += where + Environment.NewLine;
            if (string.IsNullOrEmpty(sortName) == true)
            {
                sortName = "PLPercent";
            }
            if (string.IsNullOrEmpty(sortOrder) == true)
            {
                sortOrder = "asc";
            }
            sql = declareSQL + Environment.NewLine + "select * from (" + sql + ") as tbl " + " order by " + sortName + " " + sortOrder;
            Helper.Log(sql, "ListShare");
            List<dm_asset_core_lot_share> list;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                list = connection.Query<dm_asset_core_lot_share>(sql).ToList();
            }
            return list;
        }

        public List<AllocationList> AllocationList(decimal totalAmount)
        {
            string sql = "exec PROC_dm_asset_core_partition " + totalAmount.ToString() + Environment.NewLine;
            Helper.Log(sql, "AllocationList");
            List<AllocationList> list;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                list = connection.Query<AllocationList>(sql).ToList();
            }
            list = (from q in list
                    orderby q.Balance descending
                    select q).ToList();
            return list;
        }

        [HttpPost]
        public dynamic Create(dm_asset_core_lot row)
        {
            string sql = "INSERT INTO [dbo].[dm_asset_core_lot]" + Environment.NewLine +
                        "([Symbol]" + Environment.NewLine +
                        ",[RecordDate]" + Environment.NewLine +
                        ",[NumberOfShares] " + Environment.NewLine +
                        ",[SharePrice] " + Environment.NewLine +
                        ",[LotType] " + Environment.NewLine +
                        ",[RefID])" + Environment.NewLine +
                        " VALUES " + Environment.NewLine +
                        "(@Symbol" + Environment.NewLine +
                        ",@RecordDate" + Environment.NewLine +
                        ",@NumberOfShares" + Environment.NewLine +
                        ",@SharePrice" + Environment.NewLine +
                        ",@LotType" + Environment.NewLine +
                        ",@RefID)" + Environment.NewLine +
                        "";
            if (row.dm_asset_core_lot_id > 0)
            {
                sql = "UPDATE [dbo].[dm_asset_core_lot]" + Environment.NewLine +
                        " SET [Symbol] = @Symbol " + Environment.NewLine +
                        ",[RecordDate] = @RecordDate " + Environment.NewLine +
                        ",[NumberOfShares] = @NumberOfShares " + Environment.NewLine +
                        ",[SharePrice] = @SharePrice " + Environment.NewLine +
                        ",[LotType] = @LotType " + Environment.NewLine +
                        ",[RefID] = @RefID " + Environment.NewLine +
                        " WHERE dm_asset_core_lot_id = @dm_asset_core_lot_id " + Environment.NewLine +
                        "";
            }
            int result = 0;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                result = (int)connection.Execute(sql, new
                {
                    dm_asset_core_lot_id = row.dm_asset_core_lot_id,
                    Symbol = row.Symbol,
                    RecordDate = row.RecordDate,
                    NumberOfShares = row.NumberOfShares,
                    SharePrice = row.SharePrice,
                    LotType = row.LotType,
                    RefID = row.RefID,
                });
                Console.WriteLine("Create=" + result);
                if (result > 0)
                {
                    sql = "SELECT IDENT_CURRENT('dm_asset_core_lot') AS IdentityValue";
                    row.dm_asset_core_lot_id = (int)connection.Query<int>(sql).FirstOrDefault();
                    Console.WriteLine("row.dm_asset_core_lot_id=" + row.dm_asset_core_lot_id);
                }
            }
            return row;
        }

        public dynamic SearchSymbol(string term = "")
        {
            int totalRows = 0;
            string where = "";
            if (string.IsNullOrEmpty(term) == false)
            {
                where += " where ";
                where += " lot.Symbol like '" + term + "%'";
            }
            string sql = "";
            sql = "select lot.Symbol as id,lot.Symbol as label,lot.Symbol as value from dm_asset_core_symbol lot";
            sql += where;
            sql += " group by lot.Symbol";
            sql += " order by lot.Symbol asc ";
            //Helper.Log(sql, "SearchSymbol");
            List<Select2List> list;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                list = connection.Query<Select2List>(sql).ToList();
            }
            return list;
        }

        [HttpDelete]
        public dynamic Delete(int id)
        {
            string sql = "delete from [dbo].[dm_asset_core_lot]" + Environment.NewLine +
                         " WHERE dm_asset_core_lot_id = @id " + Environment.NewLine +
                         "";
            int result = 0;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                result = (int)connection.Execute(sql, new
                {
                    id = id,
                });
            }
            return result;
        }

        //private decimal GetTotalCapitalCall(string symbol = ""
        //        , bool? isIgnore = false
        //        , DateTime? fromDate = null
        //        , DateTime? toDate = null)
        //{
        //    DateTime minDate = Convert.ToDateTime("01/01/1900");
        //    double xirr = 0;
        //    if (string.IsNullOrEmpty(symbol) == false)
        //    {
        //        symbol = Helper.ConvertStringSQLFormat(symbol);
        //    }
        //    string where = "";
        //    where += " where lot.dm_asset_core_lot_id > 0";
        //    if ((fromDate ?? minDate).Year > 1900)
        //    {
        //        where += string.Format(" and lot.RecordDate >= '{0}' ", (fromDate ?? minDate).ToString("MM/dd/yyyy"));
        //    }
        //    if ((toDate ?? minDate).Year > 1900)
        //    {
        //        where += string.Format(" and lot.RecordDate <= '{0}' ", (toDate ?? minDate).ToString("MM/dd/yyyy"));
        //    }
        //    Console.WriteLine("isIgnore=" + isIgnore);
        //    if (string.IsNullOrEmpty(symbol) == false)
        //    {
        //        if ((isIgnore ?? false) == true)
        //        {
        //            where += " and lot.Symbol not in (" + symbol + ")";
        //        }
        //        else
        //        {
        //            where += " and lot.Symbol in (" + symbol + ")";
        //        }
        //    }
        //    string sql = "select '' as Symbol,'Current Market Value' as [Description],[Date],sum(isnull([Value], 0)) as [Value],1 as SortOrder from (" + Environment.NewLine +
        //                "select Symbol as Symbol, '' as [Description], GETDATE() as [Date],[Value], 1 as SortOrder from(" + Environment.NewLine +
        //                "select tbl.Symbol" + Environment.NewLine +
        //                ",isnull(sum(isnull(tbl.Shares, 0)), 0) as CurrentShares" + Environment.NewLine +
        //                ",(select isnull(sum(isnull(tbl.Shares,0)),0) * (select top 1 l.SharePrice from dm_asset_core_lot l " + Environment.NewLine +
        //                "where l.Symbol = tbl.Symbol" + Environment.NewLine +
        //                "order by l.RecordDate desc,l.dm_asset_core_lot_id desc)) as [Value]" + Environment.NewLine +
        //                "from (" + Environment.NewLine +
        //                "select " + Environment.NewLine +
        //                "lot.Symbol" + Environment.NewLine +
        //                ",(case when lot.LotType = 'B' then isnull(lot.NumberOfShares,0) else case when lot.LotType = 'S' then isnull(lot.NumberOfShares,0) * -1 else 0 end end) as Shares" + Environment.NewLine +
        //                ",(case when lot.LotType = 'B' then isnull(lot.NumberOfShares,0) * isnull(lot.SharePrice,0) else 0 end) as BuyAmount" + Environment.NewLine +
        //                "from dm_asset_core_lot lot" + Environment.NewLine +
        //                where +
        //                ") as tbl " + Environment.NewLine +
        //                "group by tbl.Symbol" + Environment.NewLine +
        //                ") as tbl2 where isnull(tbl2.CurrentShares,0) > 0" + Environment.NewLine +
        //                ") as tbl3 group by tbl3.[Date]" + Environment.NewLine +
        //                "";
        //    Helper.Log(sql, "XIRR");
        //    List<DealXIRRReportModel> rows = new List<DealXIRRReportModel>();
        //    using (var connection = new SqlConnection(connectionString))
        //    {
        //        rows = connection.Query<DealXIRRReportModel>(sql).ToList();
        //    }
        //    List<double> values = (from q in rows
        //                           select (double)(q.Value ?? 0)).ToList();
        //    List<DateTime> dates = (from q in rows
        //                            select (q.Date ?? minDate)).ToList();
        //    try
        //    {
        //        xirr = Excel.FinancialFunctions.Financial.XIrr(values, dates) * 100;
        //    }
        //    catch { xirr = 0; }
        //    return xirr;
        //}

        private double XIRR(string symbol = ""
                , bool? isIgnore = false
                , DateTime? fromDate = null
                , DateTime? toDate = null
                , bool? isOptions = false
                , bool? isGold = false)
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
            Console.WriteLine("isIgnore=" + isIgnore);
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
                        ",case when lot.LotType = 'B' then 'Buy' else case when lot.LotType = 'S' then 'Sell' else case when lot.LotType = 'D' then 'Dividend' else case when lot.LotType = 'E' then 'Expenses' else '' end end end end as [Description]" + Environment.NewLine +
                        ",lot.RecordDate as [Date]" + Environment.NewLine +
                        ",case when lot.LotType = 'B'" + Environment.NewLine +
                        " then (lot.NumberOfShares * lot.SharePrice) * -1 " + Environment.NewLine +
                        " else case when lot.LotType = 'S' then (lot.NumberOfShares * lot.SharePrice) else lot.SharePrice end end [Value]" + Environment.NewLine +
                        ",0 as SortOrder" + Environment.NewLine +
                        "from dm_asset_core_lot lot" + Environment.NewLine +
                        where +
                        "and lot.LotType in ('B','S','D','E') " + Environment.NewLine +
                        "union all " + Environment.NewLine +
                        "select '' as Symbol,'Current Market Value' as [Description],[Date],sum(isnull([Value], 0)) as [Value],1 as SortOrder from (" + Environment.NewLine +
                        "select Symbol as Symbol, '' as [Description], GETDATE() as [Date],[Value], 1 as SortOrder from(" + Environment.NewLine +
                        "select tbl.Symbol" + Environment.NewLine +
                        ",isnull(sum(isnull(tbl.Shares, 0)), 0) as CurrentShares" + Environment.NewLine +
                        ",(select isnull(sum(isnull(tbl.Shares,0)),0) * (select top 1 l.SharePrice from dm_asset_core_lot l " + Environment.NewLine +
                        "where l.Symbol = tbl.Symbol" + Environment.NewLine +
                        " and l.LotType not in ('D','E')" + Environment.NewLine +
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
            Helper.Log(sql, "XIRR");
            List<DealXIRRReportModel> rows = new List<DealXIRRReportModel>();
            using (var connection = new SqlConnection(connectionString))
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

        [HttpPost]
        public dynamic Import()
        {
            string error = "";
            int total = 0;
            try
            {
                IFormFile file = Request.Form.Files[0];
                var folderName = "temp";
                var pathToSave = System.IO.Path.Combine(Directory.GetCurrentDirectory(), folderName);
                if (System.IO.Directory.Exists(pathToSave) == false)
                {
                    System.IO.Directory.CreateDirectory(pathToSave);
                }
                if (file.Length > 0)
                {
                    var fileName = System.IO.Path.GetFileName(file.FileName);// ContentDispositionHeaderValue.Parse(file.ContentDisposition).FileName.Trim();
                    var fullPath = Path.Combine(pathToSave, fileName);
                    var dbPath = Path.Combine(folderName, fileName);
                    using (var stream = new FileStream(fullPath, FileMode.Create))
                    {
                        file.CopyTo(stream);
                    }

                    return Ok(new { dbPath });
                }
                else
                {
                    return BadRequest();
                }
            }
            catch (Exception ex)
            {
                error = ex.Message;
            }
            return new { error = error, total = total };
        }

        public dynamic TickerList(DateTime periodDate)
        {
            string sql = "select * from (" + Environment.NewLine +
                            "select sym.Symbol" + Environment.NewLine +
                            ",sym.TickerUrl " + Environment.NewLine +
                            ",(select isnull(count(*), 0) as cnt from FinancialReporting fr" + Environment.NewLine +
                            "where fr.Symbol = sym.Symbol and fr.PeriodDate = @PeriodDate) as cnt" + Environment.NewLine +
                            "from dm_asset_core_symbol sym" + Environment.NewLine +
                            "where isnull(sym.TickerUrl, '') != ''" + Environment.NewLine +
                            ") as tbl where isnull(tbl.cnt,0) <= 0 " + Environment.NewLine +
                            " order by tbl.Symbol" + Environment.NewLine +
                            "";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                return connection.Query<dynamic>(sql, new { PeriodDate = periodDate }).ToList();
            }
        }
    }
}