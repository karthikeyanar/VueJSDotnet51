insert into dm_asset_core_symbol(Symbol,Industry,Sector,MarketCapital,TickerUrl,IsCurrent)
select lot.Symbol,'' as Industry,'' as Secotor,0 as MarketCapital,'' as TickerUrl,1 as IsCurrent from dm_asset_core_lot lot
left outer join dm_asset_core_symbol sym on sym.Symbol = lot.symbol 
where sym.dm_asset_core_symbol_id is null
group by lot.Symbol 
go