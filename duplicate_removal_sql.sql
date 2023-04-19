 
DELETE FROM dm_asset_core_lot
WHERE dm_asset_core_lot_id IN (
select dm_asset_core_lot_id from (
select max(dm_asset_core_lot_id) as dm_asset_core_lot_id,Symbol,RefID,count(*) as cnt from dm_asset_core_lot 
where LotType != 'P' and LotType != 'D'
group by Symbol,RefID 
) as tbl where tbl.cnt > 1
)