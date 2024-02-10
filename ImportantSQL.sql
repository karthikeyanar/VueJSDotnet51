--declare @key varchar(max);
declare @quarterenddate datetime = '2023-12-31';
declare @lastyearquarter datetime; 
select @lastyearquarter = DATEADD(YEAR, -1, @quarterenddate);
DECLARE @prevquarterenddate datetime;
declare @symbol varchar(max);
--set @symbol = '%DIXON%';
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

,(select lq.[Value] from FinancialReporting lq 
join FinancialReportingSchemaKey lqkey on lqkey.FinancialReportingSchemaKeyID = lq.FinancialReportingSourceKeyID and lqkey.[Key] = 'Net Profit'
where lq.Symbol = fr.Symbol and lq.PeriodDate = @prevquarterenddate
) as PrevQuarterNetProfit

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
--and sym.IsCurrent = 1
and (fr.Symbol like @symbol or @symbol is null) 
and sym.Industry not in ('Banks - Public Sector')
and sym.Industry not in ('Construction')
and sym.Sector not in ('Stock/ Commodity Brokers')
and sym.Sector not in ('Cement')
and fr.Symbol not like '%ADANI%'
and fr.Symbol not in ('MRF')
and fr.Symbol not in ('AMBUJACEM')
and fr.Symbol not in ('LICI')
and fr.Symbol not in ('3MINDIA')
and fr.Symbol not in ('LTIM')
and fr.Symbol not in ('BANDHANBNK')
and fr.Symbol not in ('FIVESTAR')
and fr.Symbol not in ('IDBI')
and fr.Symbol not in ('PGHH')
and fr.Symbol not in ('SHREECEM')
and fr.Symbol not in ('ZFCVINDIA')
and fr.Symbol not in ('MARUTI')
and fr.Symbol not in ('PAGEIND')
and fr.Symbol not in ('HONAUT')
and fr.Symbol not in ('MINDIA')
and fr.Symbol not in ('ABBOTINDIA')
and fr.Symbol not in ('NESTLEIND')
and fr.Symbol not in ('BOSCHLTD')
and fr.Symbol not in ('LAXMIMACH')
and fr.Symbol not in ('ZFCVINDIA')
and fr.Symbol not in ('CERA')
and fr.Symbol not in ('ULTRACEMCO')
and fr.Symbol not in ('COALINDIA')
and fr.Symbol not in ('YESBANK')
and fr.Symbol not in ('OIL')
and fr.Symbol not in ('HUDCO')
and fr.Symbol not in ('SBILIFE')
and fr.Symbol not in ('CANFINHOME')
and fr.Symbol not in ('POWERINDIA')
and fr.Symbol not in ('INDIGRID')
and fr.Symbol not in ('ONGC')
and fr.Symbol not in ('STARHEALTH')
and fr.Symbol not in ('MOTILALOFS')
and fr.Symbol not in ('GAIL')
and fr.Symbol not in ('SAIL')
and fr.Symbol not in ('BEL')
and fr.Symbol not in ('HAL')
and fr.Symbol not in ('ACC')
and fr.Symbol not in ('BHARTIARTL')
and fr.Symbol not in ('IOC')
and fr.Symbol not in ('LICHSGFIN')
and fr.Symbol not in ('IRFC')
and fr.Symbol not in ('BPCL')
and fr.Symbol not in ('BDL')
and fr.Symbol not in ('MAPMYINDIA')
and fr.Symbol not in ('INDIGO')
and fr.Symbol not in ('IIFL')
group by fr.Symbol,sym.Industry,sym.Sector,sym.MarketCapital
) as tbl 
--where tbl.CurrentShares > 0
where tbl.QoQIncomeChange > 0
and tbl.PrevQuarterNetIncome > 0
and tbl.Sales > 0
and tbl.LastYearNetIncome > 0
and tbl.CurrentNetIncome > 0
and tbl.PrevQuarterNetIncome > 0
and tbl.PrevQuarterNetProfit > 0
order by tbl.QoQIncomeChange desc,tbl.Sales desc
