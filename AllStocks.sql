--declare @key varchar(max);
declare @quarterenddate datetime = '2023-09-30';
declare @lastyearquarter datetime; 
select @lastyearquarter = DATEADD(YEAR, -1, @quarterenddate);
DECLARE @prevquarterenddate datetime;
declare @symbol varchar(max);
--set @symbol = 'BRI%';
SET @prevquarterenddate = DATEADD(DAY, -1, DATEADD(QUARTER, DATEDIFF(QUARTER, -1, @quarterenddate) - 1, 0));
--set @key = 'Net Profit';
select @quarterenddate as '@quarterenddate',@lastyearquarter as '@lastyearquarter',@prevquarterenddate as '@prevquarterenddate'

select * from (
select 
fr.Symbol
,(select isnull(cs.NumberOfShares,0) from dm_asset_core_lot_share cs where cs.Symbol = fr.Symbol) as CurrentShares
,sym.Sector,sym.Industry
,(select lq.[Value] from FinancialReporting lq 
join FinancialReportingSchemaKey lqkey on lqkey.FinancialReportingSchemaKeyID = lq.FinancialReportingSourceKeyID and lqkey.[Key] = 'Net Profit'
where lq.Symbol = fr.Symbol and lq.PeriodDate = @lastyearquarter
) as LastYearNetIncome
,(select lq.[Value] from FinancialReporting lq 
join FinancialReportingSchemaKey lqkey on lqkey.FinancialReportingSchemaKeyID = lq.FinancialReportingSourceKeyID and lqkey.[Key] = 'Net Profit'
where lq.Symbol = fr.Symbol and lq.PeriodDate = @quarterenddate
) as CurrentNetIncome
,(select lq.[Value] from FinancialReporting lq 
join FinancialReportingSchemaKey lqkey on lqkey.FinancialReportingSchemaKeyID = lq.FinancialReportingSourceKeyID and lqkey.[Key] = 'Net Profit'
where lq.Symbol = fr.Symbol and lq.PeriodDate = @prevquarterenddate
) as PrevQuarterNetProfit
 
,
(select 
case when (select lq.[Value] from FinancialReporting lq 
join FinancialReportingSchemaKey lqkey on lqkey.FinancialReportingSchemaKeyID = lq.FinancialReportingSourceKeyID and lqkey.[Key] = 'Net Profit'
where lq.Symbol = fv.Symbol and lq.PeriodDate = @lastyearquarter
) != 0 then 
 (fv.[Value] - (select lq.[Value] from FinancialReporting lq 
join FinancialReportingSchemaKey lqkey on lqkey.FinancialReportingSchemaKeyID = lq.FinancialReportingSourceKeyID and lqkey.[Key] = 'Net Profit'
where lq.Symbol = fv.Symbol and lq.PeriodDate = @lastyearquarter
)) / ABS((select lq.[Value] from FinancialReporting lq 
join FinancialReportingSchemaKey lqkey on lqkey.FinancialReportingSchemaKeyID = lq.FinancialReportingSourceKeyID and lqkey.[Key] = 'Net Profit'
where lq.Symbol = fv.Symbol and lq.PeriodDate = @lastyearquarter
)) * 100  else 0 end
from FinancialReporting fv 
join FinancialReportingSchemaKey fvkey on fvkey.FinancialReportingSchemaKeyID = fv.FinancialReportingSourceKeyID and fvkey.[Key] = 'Net Profit'
where fv.Symbol = fr.Symbol and fv.PeriodDate = @quarterenddate
) as [QoQIncomeChange]

--,(select lq.[Value] from FinancialReporting lq 
--join FinancialReportingSchemaKey lqkey on lqkey.FinancialReportingSchemaKeyID = lq.FinancialReportingSourceKeyID and lqkey.[Key] = 'Sales'
--where lq.Symbol = fr.Symbol and lq.PeriodDate = @lastyearquarter
--) as LastYearSales
--,(select lq.[Value] from FinancialReporting lq 
--join FinancialReportingSchemaKey lqkey on lqkey.FinancialReportingSchemaKeyID = lq.FinancialReportingSourceKeyID and lqkey.[Key] = 'Sales'
--where lq.Symbol = fr.Symbol and lq.PeriodDate = @quarterenddate
--) as CurrentSales
 

--,(select lq.[Value] from FinancialReporting lq 
--join FinancialReportingSchemaKey lqkey on lqkey.FinancialReportingSchemaKeyID = lq.FinancialReportingSourceKeyID and lqkey.[Key] = 'Net Profit'
--where lq.Symbol = fr.Symbol and lq.PeriodDate = @prevquarterenddate
--) as PrevQuarterNet Profit

,(select 
case when (select lq.[Value] from FinancialReporting lq 
join FinancialReportingSchemaKey lqkey on lqkey.FinancialReportingSchemaKeyID = lq.FinancialReportingSourceKeyID and lqkey.[Key] = 'Net Profit'
where lq.Symbol = fv.Symbol and lq.PeriodDate = @prevquarterenddate
) != 0 then 
 (fv.[Value] - (select lq.[Value] from FinancialReporting lq 
join FinancialReportingSchemaKey lqkey on lqkey.FinancialReportingSchemaKeyID = lq.FinancialReportingSourceKeyID and lqkey.[Key] = 'Net Profit'
where lq.Symbol = fv.Symbol and lq.PeriodDate = @prevquarterenddate
)) / ABS((select lq.[Value] from FinancialReporting lq 
join FinancialReportingSchemaKey lqkey on lqkey.FinancialReportingSchemaKeyID = lq.FinancialReportingSourceKeyID and lqkey.[Key] = 'Net Profit'
where lq.Symbol = fv.Symbol and lq.PeriodDate = @prevquarterenddate
)) * 100  else 0 end
from FinancialReporting fv 
join FinancialReportingSchemaKey fvkey on fvkey.FinancialReportingSchemaKeyID = fv.FinancialReportingSourceKeyID and fvkey.[Key] = 'Net Profit'
where fv.Symbol = fr.Symbol and fv.PeriodDate = @quarterenddate
) as [PrevQuarterNetIncome]

--,(select lq.[Value] from FinancialReporting lq 
--join FinancialReportingSchemaKey lqkey on lqkey.FinancialReportingSchemaKeyID = lq.FinancialReportingSourceKeyID and lqkey.[Key] = 'Sales'
--where lq.Symbol = fr.Symbol and lq.PeriodDate = @prevquarterenddate
--) as PrevQuarterSales
 
,(select 
case when (select lq.[Value] from FinancialReporting lq 
join FinancialReportingSchemaKey lqkey on lqkey.FinancialReportingSchemaKeyID = lq.FinancialReportingSourceKeyID and lqkey.[Key] = 'Sales'
where lq.Symbol = fv.Symbol and lq.PeriodDate = @lastyearquarter
) != 0 then 
 (fv.[Value] - (select lq.[Value] from FinancialReporting lq 
join FinancialReportingSchemaKey lqkey on lqkey.FinancialReportingSchemaKeyID = lq.FinancialReportingSourceKeyID and lqkey.[Key] = 'Sales'
where lq.Symbol = fv.Symbol and lq.PeriodDate = @lastyearquarter
)) / (select lq.[Value] from FinancialReporting lq 
join FinancialReportingSchemaKey lqkey on lqkey.FinancialReportingSchemaKeyID = lq.FinancialReportingSourceKeyID and lqkey.[Key] = 'Sales'
where lq.Symbol = fv.Symbol and lq.PeriodDate = @lastyearquarter
) * 100  else 0 end
from FinancialReporting fv 
join FinancialReportingSchemaKey fvkey on fvkey.FinancialReportingSchemaKeyID = fv.FinancialReportingSourceKeyID and fvkey.[Key] = 'Sales'
where fv.Symbol = fr.Symbol and fv.PeriodDate = @quarterenddate
) as [Sales]

--,(select 
--case when (select lq.[Value] from FinancialReporting lq 
--join FinancialReportingSchemaKey lqkey on lqkey.FinancialReportingSchemaKeyID = lq.FinancialReportingSourceKeyID and lqkey.[Key] = 'Total Revenue'
--where lq.Symbol = fv.Symbol and lq.PeriodDate = @lastyearquarter
--) != 0 then 
-- (fv.[Value] - (select lq.[Value] from FinancialReporting lq 
--join FinancialReportingSchemaKey lqkey on lqkey.FinancialReportingSchemaKeyID = lq.FinancialReportingSourceKeyID and lqkey.[Key] = 'Total Revenue'
--where lq.Symbol = fv.Symbol and lq.PeriodDate = @lastyearquarter
--)) / (select lq.[Value] from FinancialReporting lq 
--join FinancialReportingSchemaKey lqkey on lqkey.FinancialReportingSchemaKeyID = lq.FinancialReportingSourceKeyID and lqkey.[Key] = 'Total Revenue'
--where lq.Symbol = fv.Symbol and lq.PeriodDate = @lastyearquarter
--) * 100  else 0 end
--from FinancialReporting fv 
--join FinancialReportingSchemaKey fvkey on fvkey.FinancialReportingSchemaKeyID = fv.FinancialReportingSourceKeyID and fvkey.[Key] = 'Total Revenue'
--where fv.Symbol = fr.Symbol and fv.PeriodDate = @quarterenddate
--) as [Revenue]
 
from FinancialReporting fr
join dm_asset_core_symbol sym on sym.Symbol = fr.Symbol 
where fr.PeriodDate = @quarterenddate 
and (fr.Symbol like @symbol or @symbol is null)  
group by fr.Symbol,sym.Industry,sym.Sector,sym.MarketCapital
) as tbl 
order by tbl.QoQIncomeChange desc,tbl.Sales desc
