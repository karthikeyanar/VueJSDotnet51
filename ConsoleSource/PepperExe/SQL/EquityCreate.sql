INSERT INTO [dbo].[Equity]
([EntityID]
,[IssuerID]
,[EquityTypeID]
,[Symbol]
,[Public]
,[CurrencyID]
,[IsArchive])
VALUES
(@EntityID
,@IssuerID
,@EquityTypeID
,@Symbol
,@Public
,@CurrencyID
,@IsArchive
)
