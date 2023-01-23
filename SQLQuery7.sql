select * from (
select 
s.Symbol
,s.NumberOfShares
,s.SharePrice
,(s.NumberOfShares * s.SharePrice) as Amount
,(select top 1 lot.SharePrice  from dm_asset_core_lot lot where lot.Symbol = s.Symbol and lot.LotType != 'D' order by lot.RecordDate desc,lot.dm_asset_core_lot_id desc) as CurrentPrice
,s.NumberOfShares * (select top 1 lot.SharePrice  from dm_asset_core_lot lot where lot.Symbol = s.Symbol and lot.LotType != 'D' order by lot.RecordDate desc,lot.dm_asset_core_lot_id desc) as CurrentAmount
,(((s.NumberOfShares * 
(select top 1 lot.SharePrice  from dm_asset_core_lot lot where lot.Symbol = s.Symbol and lot.LotType != 'D' order by lot.RecordDate desc,lot.dm_asset_core_lot_id desc)
) - (s.NumberOfShares * s.SharePrice)) / (s.NumberOfShares * s.SharePrice)) * 100 as AbsolutePercent
,s.XIRR  
from dm_asset_core_lot_share s
where NumberOfShares > 0
) as tbl order by tbl.AbsolutePercent desc
go
--delete from dm_asset_core_lot_share
--go
--exec [PROC_dm_asset_core_lot_share]