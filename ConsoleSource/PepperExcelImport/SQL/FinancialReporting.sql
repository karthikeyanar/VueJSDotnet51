INSERT INTO [dbo].[FinancialReporting]
([Symbol]
,[FinancialReportingPeriodTypeID]
,[FinancialReportingSourceKeyID]
,[PeriodDate]
,[Value])
VALUES
(
@Symbol
,@FinancialReportingPeriodTypeID
,@FinancialReportingSourceKeyID
,@PeriodDate
,@Value
)