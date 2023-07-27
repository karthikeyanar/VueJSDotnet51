select 
case when lot.Symbol = 'NASDAQ' then 'ICICI Pru NASDAQ 100 Index Fund Direct-G' 
else case when lot.Symbol = 'ICICIIT' then 'ICICI Pru Nifty IT Index Fund-G' 
else case when lot.Symbol = 'BANKNIFTY' then 'ICICI Pru Nifty Bank Index Fund-G'
else case when lot.Symbol = 'NAVIBANK' then 'Navi Nifty Bank Index Fund Direct-G'
else case when lot.Symbol = 'INDIGRID' then 'INDIGRID-IV'
else case when lot.Symbol = 'PGINVIT' then 'PGINVIT-IV'
else lot.Symbol end end end end end end as CompanyName
,case when lot.LotType = 'B' then 'Buy' else 'Sell' end as TransactionType
,FORMAT(lot.RecordDate, 'dd/MM/yyyy') as [Date]
,lot.SharePrice as CostPerShare
,lot.NumberOfShares as Shares
,lot.NumberOfShares * lot.SharePrice as Amount
--,lot.*
from dm_asset_core_lot lot
where lot.LotType in ('B','S')
and lot.Symbol in ('NASDAQ','ICICIIT','BANKNIFTY','NAVIBANK','INDIGRID','PGINVIT')
order by lot.RecordDate,lot.Symbol,lot.LotType 
go

 