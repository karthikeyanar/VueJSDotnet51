declare @key varchar(max);
declare @quarterenddate datetime = '2023-03-31';
declare @lastyearquarter datetime; 
select @lastyearquarter = DATEADD(YEAR, -1, @quarterenddate);
DECLARE @prevquarterenddate datetime;
SET @prevquarterenddate = DATEADD(DAY, -1, DATEADD(QUARTER, DATEDIFF(QUARTER, -1, @quarterenddate) - 1, 0));
set @key = 'EPS';
--select @lastyearquarter,@prevquarterenddate

select tbl2.Symbol,tbl2.[Key],tbl2.[QonQDiffPercent],tbl2.[PreviousQuarterDiffPercent] from (

select tbl.*
,isnull(tbl.[Value],0) - isnull(tbl.QonQValue,0) as [QonQDifference]
,case when isnull(tbl.QonQValue,0) > 0 then ((isnull(tbl.[Value],0) - isnull(tbl.QonQValue,0)) / isnull(tbl.QonQValue,0)) * 100 else 0 end as [QonQDiffPercent]

,isnull(tbl.[Value],0) - isnull(tbl.PreviousQuarterValue,0) as [PreviousQuarterDifference]
,case when isnull(tbl.PreviousQuarterValue,0) > 0 then ((isnull(tbl.[Value],0) - isnull(tbl.PreviousQuarterValue,0)) / isnull(tbl.PreviousQuarterValue,0)) * 100 else 0 end as [PreviousQuarterDiffPercent]

from (
select 
fr.Symbol
,k.[Key]
,fr.PeriodDate
,fr.[Value]
,@lastyearquarter as QonQ
,(select top 1 lr.[Value] from FinancialReporting lr 
join FinancialReportingSchemaKey lrk on lrk.FinancialReportingSchemaKeyID = lr.FinancialReportingSourceKeyID
where lr.Symbol = fr.Symbol
and lrk.[Key] = k.[Key]
and lr.PeriodDate = @lastyearquarter
) as QonQValue
,@prevquarterenddate as PreviousQuarter
,(select top 1 lr.[Value] from FinancialReporting lr 
join FinancialReportingSchemaKey lrk on lrk.FinancialReportingSchemaKeyID = lr.FinancialReportingSourceKeyID
where lr.Symbol = fr.Symbol
and lrk.[Key] = k.[Key]
and lr.PeriodDate = @prevquarterenddate
) as PreviousQuarterValue
from FinancialReporting fr
join FinancialReportingSchemaKey k on k.FinancialReportingSchemaKeyID = fr.FinancialReportingSourceKeyID 
where (k.[Key] = @key or @key is null)
and fr.PeriodDate = @quarterenddate 
) as tbl
) as tbl2 
order by tbl2.[QonQDiffPercent] desc
  
--select * from FinancialReporting fr
--join FinancialReportingSchemaKey k on k.FinancialReportingSchemaKeyID = fr.FinancialReportingSourceKeyID 
--where k.[Key] = 'Net Profit'
--and fr.PeriodDate = @quarterenddate
--go

--select * from FinancialReporting fr 
--join FinancialReportingSchemaKey k on k.FinancialReportingSchemaKeyID = fr.FinancialReportingSourceKeyID 
--where k.[Key] = 'Net Profit'
--and fr.Symbol = 'ADANIENT'
--order by fr.PeriodDate 