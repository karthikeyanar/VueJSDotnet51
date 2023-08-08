UPDATE [dbo].[FinancialReporting]
   SET [Symbol] = @Symbol
      ,[FinancialReportingPeriodTypeID] = @FinancialReportingPeriodTypeID
      ,[FinancialReportingSourceKeyID] = @FinancialReportingSourceKeyID
      ,[PeriodDate] = @PeriodDate
      ,[Value] = @Value
 WHERE 
 FinancialReportingID = @FinancialReportingID