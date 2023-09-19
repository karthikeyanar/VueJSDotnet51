declare @entityId int;
declare @dealid varchar(max);
declare @securitytypeid varchar(max);
declare @securityid varchar(max);
declare @fromdate datetime;
declare @todate datetime;

--{{SET_PARAMS}}  

--select 
--lot.Symbol
--,case when lot.LotType = 'B' then 'Buy' else case when lot.LotType = 'S' then 'Sell' else case when lot.LotType = 'D' then 'Dividend' else '' end end end as [Description]
--,lot.RecordDate as [Date]
--,case when lot.LotType = 'B' then (lot.NumberOfShares * lot.SharePrice) * -1 else (lot.NumberOfShares * lot.SharePrice) end [Value]
--,0 as SortOrder
--from dm_asset_core_lot lot
--where --lot.RecordDate >= '01/01/2020' and 
--(lot.Symbol = @securityid or @securityid is null)
--and (lot.RecordDate <= @todate or @todate is null)
--and lot.LotType in ('B','S','D')
--union all
select Symbol,'' as [Description],GETDATE() as [Date],[Value],1 as SortOrder from (
select tbl.Symbol,isnull(sum(isnull(tbl.Shares,0)),0) as CurrentShares
,isnull(sum(isnull(tbl.Shares,0)),0) * (select top 1 lot.SharePrice from dm_asset_core_lot lot 
where lot.Symbol = tbl.Symbol
order by lot.RecordDate desc,lot.dm_asset_core_lot_id desc) as [Value]
from (
select 
lot.Symbol
,(case when lot.LotType = 'B' then isnull(lot.NumberOfShares,0) else case when lot.LotType = 'S' then isnull(lot.NumberOfShares,0) * -1 else 0 end end) as Shares
from dm_asset_core_lot lot
where 
--lot.RecordDate >= '01/01/2020' and 
(lot.Symbol = @securityid or @securityid is null)
and (lot.RecordDate <= @todate or @todate is null)
) as tbl 
group by tbl.Symbol
) as tbl2 where isnull(tbl2.CurrentShares,0) > 0
--where tbl.RowNumber = 1 and tbl.BalanceShares > 0
order by [Date] asc,SortOrder asc 