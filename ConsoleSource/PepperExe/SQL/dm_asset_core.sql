INSERT INTO [dbo].[dm_asset_core_lot]
([Symbol]
,[RecordDate]
,[NumberOfShares]
,[SharePrice]
,[LotType]
,[RefID])
VALUES
(@Symbol
,@RecordDate
,@NumberOfShares
,@SharePrice
,@LotType
,@RefID
)