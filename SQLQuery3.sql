select PeriodDate from FinancialReporting
group by PeriodDate 
order by PeriodDate 
go 



--select * from FinancialReportingSchemaKey 

--select Industry,Sector from dm_asset_core_symbol
--group by Industry,Sector
--order by Industry,Sector
--go
--select * from dm_asset_core_symbol where Symbol like '%HDFCAMC%'