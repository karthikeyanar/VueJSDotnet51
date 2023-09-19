--declare @key varchar(max);
declare @quarterenddate datetime = '2023-03-31';
declare @lastyearquarter datetime; 
select @lastyearquarter = DATEADD(YEAR, -1, @quarterenddate);
DECLARE @prevquarterenddate datetime;
declare @symbol varchar(max);
--set @symbol = '%ICICIBANK%';
SET @prevquarterenddate = DATEADD(DAY, -1, DATEADD(QUARTER, DATEDIFF(QUARTER, -1, @quarterenddate) - 1, 0));
--set @key = 'Operating Profit';
select @quarterenddate as '@quarterenddate',@lastyearquarter as '@lastyearquarter',@prevquarterenddate as '@prevquarterenddate'

select * from (
select 
fr.Symbol,
--(select lq.[Value] from FinancialReporting lq 
--join FinancialReportingSchemaKey lqkey on lqkey.FinancialReportingSchemaKeyID = lq.FinancialReportingSourceKeyID and lqkey.[Key] = 'Operating Profit'
--where lq.Symbol = fr.Symbol and lq.PeriodDate = @lastyearquarter
--) as LastYearOperatingProfit
(select lq.[Value] from FinancialReporting lq 
join FinancialReportingSchemaKey lqkey on lqkey.FinancialReportingSchemaKeyID = lq.FinancialReportingSourceKeyID and lqkey.[Key] = 'Operating Profit'
where lq.Symbol = fr.Symbol and lq.PeriodDate = @quarterenddate
) as CurrentOperatingProfit
,
(select 
case when (select lq.[Value] from FinancialReporting lq 
join FinancialReportingSchemaKey lqkey on lqkey.FinancialReportingSchemaKeyID = lq.FinancialReportingSourceKeyID and lqkey.[Key] = 'Operating Profit'
where lq.Symbol = fv.Symbol and lq.PeriodDate = @lastyearquarter
) != 0 then 
 (fv.[Value] - (select lq.[Value] from FinancialReporting lq 
join FinancialReportingSchemaKey lqkey on lqkey.FinancialReportingSchemaKeyID = lq.FinancialReportingSourceKeyID and lqkey.[Key] = 'Operating Profit'
where lq.Symbol = fv.Symbol and lq.PeriodDate = @lastyearquarter
)) / (select lq.[Value] from FinancialReporting lq 
join FinancialReportingSchemaKey lqkey on lqkey.FinancialReportingSchemaKeyID = lq.FinancialReportingSourceKeyID and lqkey.[Key] = 'Operating Profit'
where lq.Symbol = fv.Symbol and lq.PeriodDate = @lastyearquarter
) * 100  else 0 end
from FinancialReporting fv 
join FinancialReportingSchemaKey fvkey on fvkey.FinancialReportingSchemaKeyID = fv.FinancialReportingSourceKeyID and fvkey.[Key] = 'Operating Profit'
where fv.Symbol = fr.Symbol and fv.PeriodDate = @quarterenddate
) as [LastYear_OperatingProfit]

--,(select lq.[Value] from FinancialReporting lq 
--join FinancialReportingSchemaKey lqkey on lqkey.FinancialReportingSchemaKeyID = lq.FinancialReportingSourceKeyID and lqkey.[Key] = 'Sales'
--where lq.Symbol = fr.Symbol and lq.PeriodDate = @lastyearquarter
--) as LastYearSales
--,(select lq.[Value] from FinancialReporting lq 
--join FinancialReportingSchemaKey lqkey on lqkey.FinancialReportingSchemaKeyID = lq.FinancialReportingSourceKeyID and lqkey.[Key] = 'Sales'
--where lq.Symbol = fr.Symbol and lq.PeriodDate = @quarterenddate
--) as CurrentSales

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
) as [LastYear_Sales]
  

--,(select lq.[Value] from FinancialReporting lq 
--join FinancialReportingSchemaKey lqkey on lqkey.FinancialReportingSchemaKeyID = lq.FinancialReportingSourceKeyID and lqkey.[Key] = 'Operating Profit'
--where lq.Symbol = fr.Symbol and lq.PeriodDate = @prevquarterenddate
--) as PrevQuarterOperating Profit

,(select 
case when (select lq.[Value] from FinancialReporting lq 
join FinancialReportingSchemaKey lqkey on lqkey.FinancialReportingSchemaKeyID = lq.FinancialReportingSourceKeyID and lqkey.[Key] = 'Operating Profit'
where lq.Symbol = fv.Symbol and lq.PeriodDate = @prevquarterenddate
) != 0 then 
 (fv.[Value] - (select lq.[Value] from FinancialReporting lq 
join FinancialReportingSchemaKey lqkey on lqkey.FinancialReportingSchemaKeyID = lq.FinancialReportingSourceKeyID and lqkey.[Key] = 'Operating Profit'
where lq.Symbol = fv.Symbol and lq.PeriodDate = @prevquarterenddate
)) / (select lq.[Value] from FinancialReporting lq 
join FinancialReportingSchemaKey lqkey on lqkey.FinancialReportingSchemaKeyID = lq.FinancialReportingSourceKeyID and lqkey.[Key] = 'Operating Profit'
where lq.Symbol = fv.Symbol and lq.PeriodDate = @prevquarterenddate
) * 100  else 0 end
from FinancialReporting fv 
join FinancialReportingSchemaKey fvkey on fvkey.FinancialReportingSchemaKeyID = fv.FinancialReportingSourceKeyID and fvkey.[Key] = 'Operating Profit'
where fv.Symbol = fr.Symbol and fv.PeriodDate = @quarterenddate
) as [OperatingProfit]

--,(select lq.[Value] from FinancialReporting lq 
--join FinancialReportingSchemaKey lqkey on lqkey.FinancialReportingSchemaKeyID = lq.FinancialReportingSourceKeyID and lqkey.[Key] = 'Sales'
--where lq.Symbol = fr.Symbol and lq.PeriodDate = @prevquarterenddate
--) as PrevQuarterSales

,(select 
case when (select lq.[Value] from FinancialReporting lq 
join FinancialReportingSchemaKey lqkey on lqkey.FinancialReportingSchemaKeyID = lq.FinancialReportingSourceKeyID and lqkey.[Key] = 'Sales'
where lq.Symbol = fv.Symbol and lq.PeriodDate = @prevquarterenddate
) != 0 then 
 (fv.[Value] - (select lq.[Value] from FinancialReporting lq 
join FinancialReportingSchemaKey lqkey on lqkey.FinancialReportingSchemaKeyID = lq.FinancialReportingSourceKeyID and lqkey.[Key] = 'Sales'
where lq.Symbol = fv.Symbol and lq.PeriodDate = @prevquarterenddate
)) / (select lq.[Value] from FinancialReporting lq 
join FinancialReportingSchemaKey lqkey on lqkey.FinancialReportingSchemaKeyID = lq.FinancialReportingSourceKeyID and lqkey.[Key] = 'Sales'
where lq.Symbol = fv.Symbol and lq.PeriodDate = @prevquarterenddate
) * 100  else 0 end
from FinancialReporting fv 
join FinancialReportingSchemaKey fvkey on fvkey.FinancialReportingSchemaKeyID = fv.FinancialReportingSourceKeyID and fvkey.[Key] = 'Sales'
where fv.Symbol = fr.Symbol and fv.PeriodDate = @quarterenddate
) as [Sales]

  

from FinancialReporting fr
where fr.PeriodDate = @quarterenddate 
and (fr.Symbol like @symbol or @symbol is null)
group by fr.Symbol 
) as tbl 
where tbl.LastYear_Sales > 0 
and tbl.LastYear_OperatingProfit > 0
and tbl.OperatingProfit > 0
and tbl.Sales > 0
and tbl.LastYear_OperatingProfit >= 10
order by tbl.LastYear_OperatingProfit desc