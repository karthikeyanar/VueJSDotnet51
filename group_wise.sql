 
  declare @TempSymbol as Table
(
ID INT IDENTITY(1, 1),
Symbol varchar(200),
LTCGShares decimal(19,8)
); 
insert into @TempSymbol(Symbol,LTCGShares)
select tbl.Symbol,sum(tbl.LTCGShares) as LTCGShares from (
select lot.Symbol, 
lot.dm_asset_core_lot_id,lot.RecordDate,lot.NumberOfShares,lot.SharePrice
,lot.LotType 
,lot.BalanceShares
,lot.AvgPrice
,case when DATEADD(YEAR, 1, lot.RecordDate) < getdate() and lot.BalanceShares > 0 then 
case when lot.LotType = 'B' then lot.NumberOfShares else lot.NumberOfShares * -1 end else 0 end as LTCGShares 
from dm_asset_core_lot lot
where lot.LotType in ('B','S') 
and BalanceShares > 0 
) as tbl 
group by tbl.Symbol 

select * from (
select tbl.GroupName,tbl.Symbol
,avg(PLPercent) as ChangePercent 
,count(*) as Count
from (select
--lot.Symbol
g.GroupName
,lot.Symbol
,lot.NumberOfShares
,lot.SharePrice
,lot.Amount
,lot.XIRR
,(lot.NumberOfShares * (select top 1 isnull(cp.SharePrice,0) as CurrentPrice from dm_asset_core_lot cp where cp.Symbol = lot.Symbol and cp.LotType != 'D' order by cp.RecordDate desc,cp.dm_asset_core_lot_id desc)) as CurrentMarketValue
,(select top 1 isnull(cp.SharePrice,0) as CurrentPrice from dm_asset_core_lot cp where cp.Symbol = lot.Symbol and cp.LotType != 'D' order by cp.RecordDate desc,cp.dm_asset_core_lot_id desc) as CurrentPrice 
,((lot.NumberOfShares * (select top 1 isnull(cp.SharePrice,0) as CurrentPrice from dm_asset_core_lot cp where cp.Symbol = lot.Symbol and cp.LotType != 'D' order by cp.RecordDate desc,cp.dm_asset_core_lot_id desc)) - (lot.NumberOfShares * lot.SharePrice)) as PL
,(((lot.NumberOfShares * (select top 1 isnull(cp.SharePrice,0) as CurrentPrice from dm_asset_core_lot cp where cp.Symbol = lot.Symbol and cp.LotType != 'D' order by cp.RecordDate desc,cp.dm_asset_core_lot_id desc)) - (lot.NumberOfShares * lot.SharePrice)) / (lot.NumberOfShares * lot.SharePrice)) * 100 as PLPercent
,ts.LTCGShares 
 from dm_asset_core_lot_share lot 
 join dm_asset_core_group_symbol gs on gs.Symbol = lot.Symbol 
 join dm_asset_core_group g on g.dm_asset_core_group_id = gs.dm_asset_core_group_id 
 join @TempSymbol ts on ts.Symbol = lot.Symbol
 where lot.Symbol != ''
 and lot.NumberOfShares >= 1
 ) as tbl 
 group by tbl.GroupName,tbl.Symbol  
 ) as tbl2 order by tbl2.GroupName,tbl2.ChangePercent desc




 select * from (
select tbl.GroupName 
,avg(PLPercent) as ChangePercent 
,count(*) as Count
from (select
--lot.Symbol
g.GroupName
,lot.Symbol
,lot.NumberOfShares
,lot.SharePrice
,lot.Amount
,lot.XIRR
,(lot.NumberOfShares * (select top 1 isnull(cp.SharePrice,0) as CurrentPrice from dm_asset_core_lot cp where cp.Symbol = lot.Symbol and cp.LotType != 'D' order by cp.RecordDate desc,cp.dm_asset_core_lot_id desc)) as CurrentMarketValue
,(select top 1 isnull(cp.SharePrice,0) as CurrentPrice from dm_asset_core_lot cp where cp.Symbol = lot.Symbol and cp.LotType != 'D' order by cp.RecordDate desc,cp.dm_asset_core_lot_id desc) as CurrentPrice 
,((lot.NumberOfShares * (select top 1 isnull(cp.SharePrice,0) as CurrentPrice from dm_asset_core_lot cp where cp.Symbol = lot.Symbol and cp.LotType != 'D' order by cp.RecordDate desc,cp.dm_asset_core_lot_id desc)) - (lot.NumberOfShares * lot.SharePrice)) as PL
,(((lot.NumberOfShares * (select top 1 isnull(cp.SharePrice,0) as CurrentPrice from dm_asset_core_lot cp where cp.Symbol = lot.Symbol and cp.LotType != 'D' order by cp.RecordDate desc,cp.dm_asset_core_lot_id desc)) - (lot.NumberOfShares * lot.SharePrice)) / (lot.NumberOfShares * lot.SharePrice)) * 100 as PLPercent
,ts.LTCGShares 
 from dm_asset_core_lot_share lot 
 join dm_asset_core_group_symbol gs on gs.Symbol = lot.Symbol 
 join dm_asset_core_group g on g.dm_asset_core_group_id = gs.dm_asset_core_group_id 
 join @TempSymbol ts on ts.Symbol = lot.Symbol
 where lot.Symbol != ''
 and lot.NumberOfShares >= 1
 ) as tbl 
 group by tbl.GroupName 
 ) as tbl2 order by tbl2.ChangePercent desc