USE [onpepper-willowridge-12102022]
GO
/****** Object:  StoredProcedure [dbo].[PROC_XIRR_DataPoints]    Script Date: 7/27/2023 12:05:05 PM ******/
DROP PROCEDURE [dbo].[PROC_XIRR_DataPoints]
GO
/****** Object:  StoredProcedure [dbo].[PROC_Get_Deal_XIRR_DataPoints]    Script Date: 7/27/2023 12:05:05 PM ******/
DROP PROCEDURE [dbo].[PROC_Get_Deal_XIRR_DataPoints]
GO
/****** Object:  StoredProcedure [dbo].[PROC_dm_security_lot]    Script Date: 7/27/2023 12:05:05 PM ******/
DROP PROCEDURE [dbo].[PROC_dm_security_lot]
GO
/****** Object:  StoredProcedure [dbo].[PROC_dm_deal_xirr]    Script Date: 7/27/2023 12:05:05 PM ******/
DROP PROCEDURE [dbo].[PROC_dm_deal_xirr]
GO
/****** Object:  StoredProcedure [dbo].[PROC_dm_asset_core_partition]    Script Date: 7/27/2023 12:05:05 PM ******/
DROP PROCEDURE [dbo].[PROC_dm_asset_core_partition]
GO
/****** Object:  StoredProcedure [dbo].[PROC_dm_asset_core_lot_year]    Script Date: 7/27/2023 12:05:05 PM ******/
DROP PROCEDURE [dbo].[PROC_dm_asset_core_lot_year]
GO
/****** Object:  StoredProcedure [dbo].[PROC_dm_asset_core_lot_share]    Script Date: 7/27/2023 12:05:05 PM ******/
DROP PROCEDURE [dbo].[PROC_dm_asset_core_lot_share]
GO
/****** Object:  StoredProcedure [dbo].[PROC_CALC_XIRR_Year]    Script Date: 7/27/2023 12:05:05 PM ******/
DROP PROCEDURE [dbo].[PROC_CALC_XIRR_Year]
GO
/****** Object:  StoredProcedure [dbo].[PROC_CALC_XIRR]    Script Date: 7/27/2023 12:05:05 PM ******/
DROP PROCEDURE [dbo].[PROC_CALC_XIRR]
GO
/****** Object:  StoredProcedure [dbo].[PROC_CALC_dm_asset_core_index]    Script Date: 7/27/2023 12:05:05 PM ******/
DROP PROCEDURE [dbo].[PROC_CALC_dm_asset_core_index]
GO
/****** Object:  Index [Unique_Symbol]    Script Date: 7/27/2023 12:05:05 PM ******/
DROP INDEX [Unique_Symbol] ON [dbo].[dm_asset_core_symbol]
GO
/****** Object:  Table [dbo].[dm_Calendar_Quarter]    Script Date: 7/27/2023 12:05:05 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dm_Calendar_Quarter]') AND type in (N'U'))
DROP TABLE [dbo].[dm_Calendar_Quarter]
GO
/****** Object:  Table [dbo].[dm_Calendar_Month]    Script Date: 7/27/2023 12:05:05 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dm_Calendar_Month]') AND type in (N'U'))
DROP TABLE [dbo].[dm_Calendar_Month]
GO
/****** Object:  Table [dbo].[dm_asset_core_symbol_index]    Script Date: 7/27/2023 12:05:05 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dm_asset_core_symbol_index]') AND type in (N'U'))
DROP TABLE [dbo].[dm_asset_core_symbol_index]
GO
/****** Object:  Table [dbo].[dm_asset_core_symbol]    Script Date: 7/27/2023 12:05:05 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dm_asset_core_symbol]') AND type in (N'U'))
DROP TABLE [dbo].[dm_asset_core_symbol]
GO
/****** Object:  Table [dbo].[dm_asset_core_lot_year]    Script Date: 7/27/2023 12:05:05 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dm_asset_core_lot_year]') AND type in (N'U'))
DROP TABLE [dbo].[dm_asset_core_lot_year]
GO
/****** Object:  Table [dbo].[dm_asset_core_lot_share]    Script Date: 7/27/2023 12:05:05 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dm_asset_core_lot_share]') AND type in (N'U'))
DROP TABLE [dbo].[dm_asset_core_lot_share]
GO
/****** Object:  Table [dbo].[dm_asset_core_index]    Script Date: 7/27/2023 12:05:05 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dm_asset_core_index]') AND type in (N'U'))
DROP TABLE [dbo].[dm_asset_core_index]
GO
/****** Object:  View [dbo].[InvestmentCostReport]    Script Date: 7/27/2023 12:05:05 PM ******/
DROP VIEW [dbo].[InvestmentCostReport]
GO
/****** Object:  View [dbo].[dm_vw_XIRR_DataPoints]    Script Date: 7/27/2023 12:05:05 PM ******/
DROP VIEW [dbo].[dm_vw_XIRR_DataPoints]
GO
/****** Object:  View [dbo].[dm_vw_UnderlyingFund]    Script Date: 7/27/2023 12:05:05 PM ******/
DROP VIEW [dbo].[dm_vw_UnderlyingFund]
GO
/****** Object:  View [dbo].[dm_vw_Strategy]    Script Date: 7/27/2023 12:05:05 PM ******/
DROP VIEW [dbo].[dm_vw_Strategy]
GO
/****** Object:  View [dbo].[dm_vw_Investor_Contribution_Distribution]    Script Date: 7/27/2023 12:05:05 PM ******/
DROP VIEW [dbo].[dm_vw_Investor_Contribution_Distribution]
GO
/****** Object:  View [dbo].[dm_vw_Invesment_Distribution_Report]    Script Date: 7/27/2023 12:05:05 PM ******/
DROP VIEW [dbo].[dm_vw_Invesment_Distribution_Report]
GO
/****** Object:  View [dbo].[dm_vw_Industry]    Script Date: 7/27/2023 12:05:05 PM ******/
DROP VIEW [dbo].[dm_vw_Industry]
GO
/****** Object:  View [dbo].[dm_vw_Geography]    Script Date: 7/27/2023 12:05:05 PM ******/
DROP VIEW [dbo].[dm_vw_Geography]
GO
/****** Object:  View [dbo].[dm_vw_Fund_Investment_Map]    Script Date: 7/27/2023 12:05:05 PM ******/
DROP VIEW [dbo].[dm_vw_Fund_Investment_Map]
GO
/****** Object:  View [dbo].[dm_vw_Fund_Economic_Quater]    Script Date: 7/27/2023 12:05:05 PM ******/
DROP VIEW [dbo].[dm_vw_Fund_Economic_Quater]
GO
/****** Object:  View [dbo].[dm_vw_Fund_Detail]    Script Date: 7/27/2023 12:05:05 PM ******/
DROP VIEW [dbo].[dm_vw_Fund_Detail]
GO
/****** Object:  View [dbo].[dm_vw_Fund]    Script Date: 7/27/2023 12:05:05 PM ******/
DROP VIEW [dbo].[dm_vw_Fund]
GO
/****** Object:  View [dbo].[dm_vw_Equity]    Script Date: 7/27/2023 12:05:05 PM ******/
DROP VIEW [dbo].[dm_vw_Equity]
GO
/****** Object:  View [dbo].[dm_vw_direct_last_price_history_by_time_period]    Script Date: 7/27/2023 12:05:05 PM ******/
DROP VIEW [dbo].[dm_vw_direct_last_price_history_by_time_period]
GO
/****** Object:  View [dbo].[dm_vw_DealUnderlyingFund]    Script Date: 7/27/2023 12:05:05 PM ******/
DROP VIEW [dbo].[dm_vw_DealUnderlyingFund]
GO
/****** Object:  View [dbo].[dm_vw_Deal_Closed_Quater]    Script Date: 7/27/2023 12:05:05 PM ******/
DROP VIEW [dbo].[dm_vw_Deal_Closed_Quater]
GO
/****** Object:  View [dbo].[dm_vw_Deal]    Script Date: 7/27/2023 12:05:05 PM ******/
DROP VIEW [dbo].[dm_vw_Deal]
GO
/****** Object:  View [dbo].[dm_vw_Asset]    Script Date: 7/27/2023 12:05:05 PM ******/
DROP VIEW [dbo].[dm_vw_Asset]
GO
/****** Object:  View [dbo].[DistributionReport]    Script Date: 7/27/2023 12:05:05 PM ******/
DROP VIEW [dbo].[DistributionReport]
GO
/****** Object:  View [dbo].[dm_vw_asset_core_xirr]    Script Date: 7/27/2023 12:05:05 PM ******/
DROP VIEW [dbo].[dm_vw_asset_core_xirr]
GO
/****** Object:  Table [dbo].[dm_asset_core_lot]    Script Date: 7/27/2023 12:05:05 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dm_asset_core_lot]') AND type in (N'U'))
DROP TABLE [dbo].[dm_asset_core_lot]
GO
/****** Object:  View [dbo].[dm_vw_rolled_forward_nav_by_strategy]    Script Date: 7/27/2023 12:05:05 PM ******/
DROP VIEW [dbo].[dm_vw_rolled_forward_nav_by_strategy]
GO
/****** Object:  View [dbo].[dm_vw_rolled_forward_nav_by_attribute]    Script Date: 7/27/2023 12:05:05 PM ******/
DROP VIEW [dbo].[dm_vw_rolled_forward_nav_by_attribute]
GO
/****** Object:  View [dbo].[dm_vw_rolled_forward_nav]    Script Date: 7/27/2023 12:05:05 PM ******/
DROP VIEW [dbo].[dm_vw_rolled_forward_nav]
GO
/****** Object:  View [dbo].[dm_vw_cashflow_by_attribute]    Script Date: 7/27/2023 12:05:05 PM ******/
DROP VIEW [dbo].[dm_vw_cashflow_by_attribute]
GO
/****** Object:  View [dbo].[dm_vw_CashFlow]    Script Date: 7/27/2023 12:05:05 PM ******/
DROP VIEW [dbo].[dm_vw_CashFlow]
GO
/****** Object:  View [dbo].[dm_vw_AttributeAllocation]    Script Date: 7/27/2023 12:05:05 PM ******/
DROP VIEW [dbo].[dm_vw_AttributeAllocation]
GO
/****** Object:  UserDefinedFunction [dbo].[XIRR]    Script Date: 7/27/2023 12:05:05 PM ******/
DROP FUNCTION [dbo].[XIRR]
GO
/****** Object:  UserDefinedTableType [dbo].[UD_XIRRTableType]    Script Date: 7/27/2023 12:05:05 PM ******/
DROP TYPE [dbo].[UD_XIRRTableType]
GO
/****** Object:  UserDefinedTableType [dbo].[UD_XIRRTableType]    Script Date: 7/27/2023 12:05:05 PM ******/
CREATE TYPE [dbo].[UD_XIRRTableType] AS TABLE(
	[PayDate] [datetime] NULL,
	[Payment] [decimal](19, 8) NULL,
	[Description] [varchar](max) NULL,
	[SortOrder] [int] NULL
)
GO
/****** Object:  UserDefinedFunction [dbo].[XIRR]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE FUNCTION [dbo].[XIRR] (@Sample dbo.UD_XIRRTableType READONLY,@Rate DECIMAL(38, 9) = 0.1)
RETURNS DECIMAL(38, 9)
AS
BEGIN
    DECLARE @X DECIMAL(38, 9) = 0.0,
    @X0 DECIMAL(38, 9) = 0.1,
    @f DECIMAL(38, 9) = 0.0,
    @fbar DECIMAL(38, 9) = 0.0,
    @i TINYINT = 0,
    @found TINYINT = 0

IF @Rate IS NULL
    SET @Rate = 0.1

SET @X0 = @Rate

WHILE @i < 100
    BEGIN
        SELECT  @f = 0.0,
            @fbar = 0.0

        SELECT      @f = @f + Payment * POWER(1 + @X0, (-theDelta / 365.0E)),
        @fbar = @fbar - theDelta / 365.0E * Payment * POWER(1 + @X0, (-theDelta / 365.0E - 1))
        FROM    (
                SELECT  Payment,
                    DATEDIFF(DAY, MIN(PayDate) OVER (), PayDate) AS theDelta
                FROM    @Sample
            ) AS d

        SET @X = @X0 - @f / @fbar

        If ABS(@X - @X0) < 0.00000001
        BEGIN
           SET @found = 1
           BREAK;
        END

        SET @X0 = @X
        SET @i += 1
   END

If @found = 1
    RETURN  @X

RETURN NULL
END
GO
/****** Object:  View [dbo].[dm_vw_AttributeAllocation]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[dm_vw_AttributeAllocation] AS
select 
aa.AttributeAllocationID
,aa.EntityID 
,aa.AttributeID
,aa.AttributeTypeID
,attType.[Name] as AttributeTypeName
,(case when aa.AttributeTypeID = 1 then geo.Geography else 
	case when aa.AttributeTypeID = 2 then ind.Industry else 
	case when aa.AttributeTypeID = 3 then sta.StrategyName else '' end
	end 
	end) as AttributeName
,aa.[Value]
,aa.AttributeImplementationTypeID
,aiType.[Name] as AttributeImplementationType
,(case when aa.AttributeImplementationTypeID = 1 then uf.FundName else 
	case when aa.AttributeImplementationTypeID = 2 then eq.Symbol else
	case when aa.AttributeImplementationTypeID = 11 then fi.Symbol else
	case when aa.AttributeImplementationTypeID = 12 then loan.AssetName else
	case when aa.AttributeImplementationTypeID = 13 then deal.DealName else '' end
	end
	end
	end
	end
   --end
) as AttributeImplementation
,(case when aa.AttributeImplementationTypeID = 2 then eq_iss.[Name] else
	case when aa.AttributeImplementationTypeID = 11 then fi_iss.[Name]
	end
	end
) as Direct
,aa.AttributeImplementationID
,aa.FromDate
,aa.ToDate 
,aa.AttributeGroupingID
,aa.IsCurrent  
,e.EntityCode
from AttributeAllocation aa
join entity e on aa.entityid = e.entityid 
join AttributeType attType on aa.AttributeTypeID = attType.AttributeTypeID
left outer join [Geography] geo on  aa.AttributeTypeID = 1 and geo.GeographyID = aa.AttributeID
left outer join [Industry] ind on  aa.AttributeTypeID = 2 and ind.IndustryID = aa.AttributeID
left outer join [Strategy] sta on  aa.AttributeTypeID = 3 and sta.StrategyID = aa.AttributeID

left outer join [UnderlyingFund] uf on aa.AttributeImplementationTypeID = 1 and aa.AttributeImplementationID = uf.UnderlyingFundID
left outer join [Equity] eq on aa.AttributeImplementationTypeID = 2 and aa.AttributeImplementationID = eq.EquityID
left outer join [Issuer] eq_iss on eq_iss.IssuerID = eq.IssuerID

left outer join [FixedIncome] fi on aa.AttributeImplementationTypeID = 11 and aa.AttributeImplementationID = fi.FixedIncomeID
left outer join [Issuer] fi_iss on fi_iss.IssuerID = fi.IssuerID

left outer join [Loan] loan on aa.AttributeImplementationTypeID = 12 and aa.AttributeImplementationID = loan.LoanID
left outer join [Deal] deal on aa.AttributeImplementationTypeID = 13 and aa.AttributeImplementationID = deal.DealID

left outer join AttributeImplementationType aiType on aiType.AttributeImplementationTypeID = aa.AttributeImplementationTypeID
GO
/****** Object:  View [dbo].[dm_vw_CashFlow]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[dm_vw_CashFlow] AS
select 
cf.CashFlowID 
,cf.FundID
,cf.DealID
,cf.EntityID
,cf.AssetID
,(case when cf.AssetTypeID = 1 then uf.FundName else case when cf.AssetTypeID = 2 then equity.Symbol else case when cf.AssetTypeID = 3 then assetFund.FundName else '' end end end) as AssetName
,(case when cf.ParentAssetTypeID = 1 then parentUF.FundName else case when cf.ParentAssetTypeID = 2 then parentEquity.Symbol else case when cf.ParentAssetTypeID = 3 then assetParentFund.FundName else '' end end end) as ParentAssetName
,f.FundName
,d.DealNumber
,d.DealName
,cf.Amount 
,atype.AssetTypeName
,cf.AssetTypeID
,tt.TransactionTypeName
,cf.TransactionTypeID
,st.TransactionSubTypeName
,cf.TransactionSubTypeID 
,cf.TransactionDate
,DATEPART(year,cf.TransactionDate) as [Year]
,DATEPART(QUARTER,cf.TransactionDate) as [Quarter]
,DATEPART(MONTH,cf.TransactionDate) as [Month]
,DATEPART(DAY,cf.TransactionDate) as [Day]
,cast(DATEPART(QUARTER,cf.TransactionDate) as varchar(5)) + ' Q' + cast(DATEPART(year,cf.TransactionDate) as varchar(10)) as [Quarterly] 
,(case when datepart(month,cf.TransactionDate) <= 6 then '1' else '2' end) + ' H' + cast(DATEPART(year,cf.TransactionDate) as varchar(10)) as [HalfYearly] 
,stype.[Name] as SecurityType
,cf.SourcePKID
,cf.SourceTableName 
,ptype.AssetTypeName as ParentAssetTypeName
,cf.ParentAssetTypeID 
,cf.ParentAssetID
,cf.SourceCreatedBy
,cf.SourceCreatedDate
,cf.SourceLastUpdatedBy
,cf.SourceLastUpdatedDate
,cf.CreatedBy
,cf.CreatedDate
,cf.LastUpdatedBy
,cf.LastUpdatedDate
,cf.SecurityTypeID
--,cast(isnull(f.IsPowerBIHide,'0') as varchar(2)) as IsPowerBIHide
,e.EntityCode
,0 as ActionID
,0 as ActionCashFlowID
from dm_CashFlow cf
join entity e on cf.entityid = e.entityid 
left outer join fund f on f.FundID = cf.FundID
left outer join deal d on d.DealID = cf.DealID
left outer join securitytype stype on cf.SecurityTypeID = stype.SecurityTypeID 

left outer join underlyingfund uf on uf.UnderlyingFundID = cf.AssetID and cf.AssetTypeID = 1
left outer join underlyingfund parentUF on parentUF.UnderlyingFundID = cf.ParentAssetID and cf.ParentAssetTypeID = 1

left outer join fund assetFund on assetFund.FundID = cf.AssetID and cf.AssetTypeID = 3
left outer join fund assetParentFund on assetParentFund.FundID = cf.ParentAssetID and cf.ParentAssetTypeID = 3

left outer join Equity equity on equity.EquityID = cf.AssetID and cf.AssetTypeID = 2
left outer join Equity parentEquity on parentEquity.EquityID = cf.ParentAssetID and cf.ParentAssetTypeID = 2

left outer join dm_AssetType atype on atype.AssetTypeID = cf.AssetTypeID
left outer join dm_AssetType ptype on ptype.AssetTypeID = cf.ParentAssetTypeID
left outer join dm_CashFlow_TransactionType tt on tt.TransactionTypeID = cf.TransactionTypeID
left outer join dm_CashFlow_TransactionSubType st on st.TransactionSubTypeID = cf.TransactionSubTypeID
-- Add additional transaction for use power bi report
union all
select 
100 + duf.DealUnderlyingFundID + (select isnull(max(cashflowid),0) from dm_cashflow) + FLOOR(RAND()*(100000-10+1))+10 as CashFlowID
,f.FundID
,d.DealID
,d.EntityID
,0 as AssetID
,uf.FundName as AssetName
,'' as ParentAssetName
,f.FundName
,d.DealNumber
,d.DealName
,isnull(duf.NetPurchasePrice,0) as Amount 
,'' as AssetTypeName
,0 as AssetTypeID
,'NPP' as TransactionTypeName
,23 TransactionTypeID
,'' TransactionSubTypeName
,0 as TransactionSubTypeID 
,duf.EffectiveDate as TransactionDate
,DATEPART(year,duf.EffectiveDate) as [Year]
,DATEPART(QUARTER,duf.EffectiveDate) as [Quarter]
,DATEPART(MONTH,duf.EffectiveDate) as [Month]
,DATEPART(DAY,duf.EffectiveDate) as [Day]
,cast(DATEPART(QUARTER,duf.EffectiveDate) as varchar(5)) + ' Q' + cast(DATEPART(year,duf.EffectiveDate) as varchar(10)) as [Quarterly] 
,(case when datepart(month,duf.EffectiveDate) <= 6 then '1' else '2' end) + ' H' + cast(DATEPART(year,duf.EffectiveDate) as varchar(10)) as [HalfYearly] 
,'' as SecurityType
,duf.DealUnderlyingFundID as SourcePKID
,'DealUnderlyingFund' as SourceTableName 
,'' as ParentAssetTypeName
,0 as ParentAssetTypeID 
,0 as ParentAssetID
,duf.CreatedBy as SourceCreatedBy
,duf.CreatedDate as SourceCreatedDate
,duf.LastUpdatedBy as SourceLastUpdatedBy
,duf.LastUpdatedDate as SourceLastUpdatedDate
,duf.CreatedBy
,duf.CreatedDate
,duf.LastUpdatedBy
,duf.LastUpdatedDate
,0 as SecurityTypeID
--,cast(isnull(f.IsPowerBIHide,'0') as varchar(2)) as IsPowerBIHide
,e.EntityCode
,duf.DealUnderlyingFundID as ActionID
,(select isnull(max(CashFlowID),0) from dm_CashFlow) as ActionCashFlowID
from DealUnderlyingFund duf
left outer join deal d on d.DealID = duf.DealID
left outer join fund f on f.FundID = d.FundID
join entity e on d.entityid = e.entityid 
join underlyingfund uf on uf.UnderlyingFundID = duf.UnderlyingFundID
union all
select 
101 + duf.DealUnderlyingFundID + (select isnull(max(cashflowid),0) from dm_cashflow) + FLOOR(RAND()*(100000-10+1))+10 as CashFlowID
,f.FundID
,d.DealID
,d.EntityID
,0 as AssetID
,uf.FundName as AssetName
,'' as ParentAssetName
,f.FundName
,d.DealNumber
,d.DealName
,(isnull(duf.NetPurchasePrice,0)) 
--+ (select isnull(sum(isnull(dc.Amount,0)),0) from DealClosingCostDistributionLineItem dc 
--		join DealClosingCostDistribution dist on dist.DealClosingCostDistributionID = dc.DealClosingCostDistributionID
--		join DealClosingCost cost on cost.DealClosingCostID = dist.DealClosingCostID
--		where cost.DealID = duf.dealid and dc.DealUnderlyingFundID = duf.DealUnderlyingFundID))
	+  case when isnull(duf.ExpectedUnfundedAmount,0) > 0 then isnull(duf.ExpectedUnfundedAmount,0) else isnull(duf.UnfundedAmount,0) end as Amount 
,'' as AssetTypeName
,0 as AssetTypeID
,'DealSize' as TransactionTypeName
,24 TransactionTypeID
,'' TransactionSubTypeName
,0 as TransactionSubTypeID 
,duf.EffectiveDate as TransactionDate
,DATEPART(year,duf.EffectiveDate) as [Year]
,DATEPART(QUARTER,duf.EffectiveDate) as [Quarter]
,DATEPART(MONTH,duf.EffectiveDate) as [Month]
,DATEPART(DAY,duf.EffectiveDate) as [Day]
,cast(DATEPART(QUARTER,duf.EffectiveDate) as varchar(5)) + ' Q' + cast(DATEPART(year,duf.EffectiveDate) as varchar(10)) as [Quarterly] 
,(case when datepart(month,duf.EffectiveDate) <= 6 then '1' else '2' end) + ' H' + cast(DATEPART(year,duf.EffectiveDate) as varchar(10)) as [HalfYearly] 
,'' as SecurityType
,duf.DealUnderlyingFundID as SourcePKID
,'DealUnderlyingFund' as SourceTableName 
,'' as ParentAssetTypeName
,0 as ParentAssetTypeID 
,0 as ParentAssetID
,duf.CreatedBy as SourceCreatedBy
,duf.CreatedDate as SourceCreatedDate
,duf.LastUpdatedBy as SourceLastUpdatedBy
,duf.LastUpdatedDate as SourceLastUpdatedDate
,duf.CreatedBy
,duf.CreatedDate
,duf.LastUpdatedBy
,duf.LastUpdatedDate
,0 as SecurityTypeID
--,cast(isnull(f.IsPowerBIHide,'0') as varchar(2)) as IsPowerBIHide
,e.EntityCode
,duf.DealUnderlyingFundID as ActionID
,(select isnull(max(CashFlowID),0) from dm_CashFlow) as ActionCashFlowID
from DealUnderlyingFund duf
left outer join deal d on d.DealID = duf.DealID
left outer join fund f on f.FundID = d.FundID
join entity e on d.entityid = e.entityid 
join underlyingfund uf on uf.UnderlyingFundID = duf.UnderlyingFundID
union all
select 
102 + dud.DealUnderlyingDirectID + (select isnull(max(cashflowid),0) from dm_cashflow) + FLOOR(RAND()*(100000-10+1))+10 as CashFlowID
,f.FundID
,d.DealID
,d.EntityID
,0 as AssetID
,sym.Symbol as AssetName
,'' as ParentAssetName
,f.FundName
,d.DealNumber
,d.DealName
--,isnull(dud.TotalCost,0) - (select sum(isnull(cf.Amount,0)) from PostRecordCashFlow cf where cf.DealID = dud.DealID and cf.SecurityTypeID = dud.SecurityTypeID and cf.SecurityID = dud.SecurityID) as Amount 
,isnull(dud.FMV,0) - (select sum(isnull(cf.Amount,0)) from PostRecordCashFlow cf where cf.DealID = dud.DealID and cf.SecurityTypeID = dud.SecurityTypeID and cf.SecurityID = dud.SecurityID) as Amount 
,'' as AssetTypeName
,0 as AssetTypeID
,'NPP' as TransactionTypeName
,23 TransactionTypeID
,'' TransactionSubTypeName
,0 as TransactionSubTypeID 
,dud.RecordDate as TransactionDate
,DATEPART(year,dud.RecordDate) as [Year]
,DATEPART(QUARTER,dud.RecordDate) as [Quarter]
,DATEPART(MONTH,dud.RecordDate) as [Month]
,DATEPART(DAY,dud.RecordDate) as [Day]
,cast(DATEPART(QUARTER,dud.RecordDate) as varchar(5)) + ' Q' + cast(DATEPART(year,dud.RecordDate) as varchar(10)) as [Quarterly] 
,(case when datepart(month,dud.RecordDate) <= 6 then '1' else '2' end) + ' H' + cast(DATEPART(year,dud.RecordDate) as varchar(10)) as [HalfYearly] 
,'' as SecurityType
,dud.DealUnderlyingDirectID as SourcePKID
,'DealUnderlyingFund' as SourceTableName 
,'' as ParentAssetTypeName
,0 as ParentAssetTypeID 
,0 as ParentAssetID
,dud.CreatedBy as SourceCreatedBy
,dud.CreatedDate as SourceCreatedDate
,dud.LastUpdatedBy as SourceLastUpdatedBy
,dud.LastUpdatedDate as SourceLastUpdatedDate
,dud.CreatedBy
,dud.CreatedDate
,dud.LastUpdatedBy
,dud.LastUpdatedDate
,0 as SecurityTypeID
--,cast(isnull(f.IsPowerBIHide,'0') as varchar(2)) as IsPowerBIHide
,e.EntityCode
,dud.DealUnderlyingDirectID as ActionID
,(select isnull(max(CashFlowID),0) from dm_CashFlow) as ActionCashFlowID
from DealUnderlyingDirect dud
left outer join deal d on d.DealID = dud.DealID
left outer join fund f on f.FundID = d.FundID
join entity e on d.entityid = e.entityid 
join SecuritySymbol sym on sym.SecurityTypeID = dud.SecurityTypeID and sym.SecurityID = dud.SecurityID
union all
select 
103 + dud.DealUnderlyingDirectID + (select isnull(max(cashflowid),0) from dm_cashflow) + FLOOR(RAND()*(100000-10+1))+10 as CashFlowID
,f.FundID
,d.DealID
,d.EntityID
,0 as AssetID
,sym.Symbol as AssetName
,'' as ParentAssetName
,f.FundName
,d.DealNumber
,d.DealName
--,((isnull(dud.FMV,0) - (select sum(isnull(cf.Amount,0)) from PostRecordCashFlow cf where cf.DealID = dud.DealID and cf.SecurityTypeID = dud.SecurityTypeID and cf.SecurityID = dud.SecurityID)))
--	+ (select isnull(sum(isnull(dc.Amount,0)),0) from DealClosingCostDistributionLineItem dc 
--		join DealClosingCostDistribution dist on dist.DealClosingCostDistributionID = dc.DealClosingCostDistributionID
--		join DealClosingCost cost on cost.DealClosingCostID = dist.DealClosingCostID
--		where cost.DealID = dud.dealid and dc.DealUnderlyingDirectID = dud.DealUnderlyingDirectID) as Amount 
,((isnull(dud.FMV,0) - (select sum(isnull(cf.Amount,0)) from PostRecordCashFlow cf where cf.DealID = dud.DealID and cf.SecurityTypeID = dud.SecurityTypeID and cf.SecurityID = dud.SecurityID))) as Amount 
,'' as AssetTypeName
,0 as AssetTypeID
,'DealSize' as TransactionTypeName
,24 TransactionTypeID
,'' TransactionSubTypeName
,0 as TransactionSubTypeID 
,dud.RecordDate as TransactionDate
,DATEPART(year,dud.RecordDate) as [Year]
,DATEPART(QUARTER,dud.RecordDate) as [Quarter]
,DATEPART(MONTH,dud.RecordDate) as [Month]
,DATEPART(DAY,dud.RecordDate) as [Day]
,cast(DATEPART(QUARTER,dud.RecordDate) as varchar(5)) + ' Q' + cast(DATEPART(year,dud.RecordDate) as varchar(10)) as [Quarterly] 
,(case when datepart(month,dud.RecordDate) <= 6 then '1' else '2' end) + ' H' + cast(DATEPART(year,dud.RecordDate) as varchar(10)) as [HalfYearly] 
,'' as SecurityType
,dud.DealUnderlyingDirectID as SourcePKID
,'DealUnderlyingFund' as SourceTableName 
,'' as ParentAssetTypeName
,0 as ParentAssetTypeID 
,0 as ParentAssetID
,dud.CreatedBy as SourceCreatedBy
,dud.CreatedDate as SourceCreatedDate
,dud.LastUpdatedBy as SourceLastUpdatedBy
,dud.LastUpdatedDate as SourceLastUpdatedDate
,dud.CreatedBy
,dud.CreatedDate
,dud.LastUpdatedBy
,dud.LastUpdatedDate
,0 as SecurityTypeID
--,cast(isnull(f.IsPowerBIHide,'0') as varchar(2)) as IsPowerBIHide
,e.EntityCode
,dud.DealUnderlyingDirectID as ActionID
,(select isnull(max(CashFlowID),0) from dm_CashFlow) as ActionCashFlowID
from DealUnderlyingDirect dud
left outer join deal d on d.DealID = dud.DealID
left outer join fund f on f.FundID = d.FundID
join entity e on d.entityid = e.entityid 
join SecuritySymbol sym on sym.SecurityTypeID = dud.SecurityTypeID and sym.SecurityID = dud.SecurityID
where isnull(dud.IsFollowOn,0) = 0 and isnull(dud.IsSecurityConversionDetail,0) = 0
GO
/****** Object:  View [dbo].[dm_vw_cashflow_by_attribute]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[dm_vw_cashflow_by_attribute] AS
select cf.CashFlowID,cf.EntityID,cf.Amount,aa.AttributeAllocationID,aa.[Value],((isnull(cf.Amount,0) * isnull(aa.[Value],0))/100) as Value_Amount,ent.EntityCode 
,aa.AttributeTypeID 
,aa.AttributeTypeName 
,aa.AttributeName
,aa.AttributeImplementation 
,aa.FromDate
,aa.ToDate
,cf.TransactionDate 
,DATEPART(year,cf.TransactionDate) as [Year]
,DATEPART(QUARTER,cf.TransactionDate) as [Quarter]
,DATEPART(MONTH,cf.TransactionDate) as [Month]
,DATEPART(DAY,cf.TransactionDate) as [Day]
,cast(DATEPART(year,cf.TransactionDate) as varchar(10)) + ' Q' + cast(DATEPART(QUARTER,cf.TransactionDate) as varchar(5)) as [Quarterly] 
,cast(DATEPART(year,cf.TransactionDate) as varchar(10)) + ' H' + (case when datepart(month,cf.TransactionDate) <= 6 then '1' else '2' end) as [HalfYearly] 
from dm_vw_AttributeAllocation aa
join entity ent on aa.EntityID = ent.EntityID 
join dm_vw_CashFlow cf on cf.EntityID = aa.EntityID 
and cf.AssetTypeID = aa.AttributeImplementationTypeID 
and cf.AssetID = aa.AttributeImplementationID 
and (cf.TransactionDate between aa.FromDate and aa.ToDate)
and aa.AttributeImplementationTypeID != 13
union all
select cf.CashFlowID,cf.EntityID,cf.Amount,aa.AttributeAllocationID,aa.[Value],((isnull(cf.Amount,0) * isnull(aa.[Value],0))/100) as Value_Amount,ent.EntityCode 
,aa.AttributeTypeID 
,aa.AttributeTypeName 
,aa.AttributeName
,aa.AttributeImplementation 
,aa.FromDate
,aa.ToDate
,cf.TransactionDate 
,DATEPART(year,cf.TransactionDate) as [Year]
,DATEPART(QUARTER,cf.TransactionDate) as [Quarter]
,DATEPART(MONTH,cf.TransactionDate) as [Month]
,DATEPART(DAY,cf.TransactionDate) as [Day]
,cast(DATEPART(year,cf.TransactionDate) as varchar(10)) + ' Q' + cast(DATEPART(QUARTER,cf.TransactionDate) as varchar(5)) as [Quarterly] 
,cast(DATEPART(year,cf.TransactionDate) as varchar(10)) + ' H' + (case when datepart(month,cf.TransactionDate) <= 6 then '1' else '2' end) as [HalfYearly] 
from dm_vw_AttributeAllocation aa
join entity ent on aa.EntityID = ent.EntityID 
join dm_vw_CashFlow cf on cf.EntityID = aa.EntityID and cf.DealID =  aa.AttributeImplementationID and (cf.TransactionDate between aa.FromDate and aa.ToDate) and aa.AttributeImplementationTypeID = 13
GO
/****** Object:  View [dbo].[dm_vw_rolled_forward_nav]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[dm_vw_rolled_forward_nav] AS
select * from (
select 
ROW_NUMBER() OVER (PARTITION BY rfv.DealID,rfv.AssetTypeID,rfv.AssetID,rfv.RolledForwardNAVDate
ORDER BY rfv.dm_rolled_forward_nav_id desc) as PartitionNumber
,rfv.dm_rolled_forward_nav_id
,rfv.EntityID 
,rfv.FundID
,f.FundName
,rfv.DealID 
,d.DealNumber
,d.DealName
,rfv.AssetID
,(case when rfv.AssetTypeID = 1 then uf.FundName else sym.IssuerName end) as AssetName
,(case when rfv.AssetTypeID = 1 then '' else sym.Symbol end) as Symbol
,rfv.AssetTypeID
,atype.[Name] as AssetTypeName
,(case when isnull(rfv.AssetTypeID,0) = 1 
	then sum(isnull(duf.NetPurchasePrice,0)) else 
	(
		--isnull((select sum(isnull(dud.TotalCost,0)) from DealUnderlyingDirect dud
		isnull((select sum(isnull(dud.FMV,0)) from DealUnderlyingDirect dud
		where dud.DealID = rfv.DealID and dud.SecurityTypeID = sym.SecurityTypeID and dud.SecurityID = sym.SecurityID
		and isnull(dud.IsFollowOn,0) = 0
		and isnull(dud.IsSecurityConversionDetail,0) = 0
		),0)
	- isnull((select sum(isnull(prcf.Amount,0)) from PostRecordCashFlow prcf
		where prcf.DealID = rfv.DealID and prcf.SecurityTypeID = sym.SecurityTypeID and prcf.SecurityID = sym.SecurityID
	   ),0)
	) end) as NetPurchasePrice
,case when sum(isnull(duf.ExpectedUnfundedAmount,0)) > 0 then sum(isnull(duf.ExpectedUnfundedAmount,0)) else sum(isnull(duf.UnfundedAmount,0)) end as CurrentExpectedUnfundedAmount
,((case when isnull(rfv.AssetTypeID,0) = 1 
	then sum(isnull(duf.NetPurchasePrice,0)) else 
	(
		--isnull((select sum(isnull(dud.TotalCost,0)) from DealUnderlyingDirect dud
		isnull((select sum(isnull(dud.FMV,0)) from DealUnderlyingDirect dud
		where dud.DealID = rfv.DealID and dud.SecurityTypeID = sym.SecurityTypeID and dud.SecurityID = sym.SecurityID
		and isnull(dud.IsFollowOn,0) = 0
		and isnull(dud.IsSecurityConversionDetail,0) = 0
		),0)
	- isnull((select sum(isnull(prcf.Amount,0)) from PostRecordCashFlow prcf
		where prcf.DealID = rfv.DealID and prcf.SecurityTypeID = sym.SecurityTypeID and prcf.SecurityID = sym.SecurityID
	   ),0)
	) end) 
	--+ 
	--	(case when isnull(rfv.AssetTypeID,0) = 1 then 
	--		(select isnull(sum(isnull(dc.Amount,0)),0) from DealClosingCostDistributionLineItem dc 
	--		join DealClosingCostDistribution dist on dist.DealClosingCostDistributionID = dc.DealClosingCostDistributionID
	--		join DealClosingCost cost on cost.DealClosingCostID = dist.DealClosingCostID
	--		where cost.DealID = rfv.dealid and dc.DealUnderlyingFundID = duf.DealUnderlyingFundID)
	--	else
	--		(select isnull(sum(isnull(dc.Amount,0)),0) from DealUnderlyingDirect dud
	--		join DealClosingCostDistributionLineItem dc on dc.DealUnderlyingDirectID = dud.DealUnderlyingDirectID
	--		join DealClosingCostDistribution dist on dist.DealClosingCostDistributionID = dc.DealClosingCostDistributionID
	--		join DealClosingCost cost on cost.DealClosingCostID = dist.DealClosingCostID
	--		where dud.DealID = rfv.dealid and dud.SecurityTypeID = sym.SecurityTypeID and dud.SecurityID = sym.SecurityID)
	--	end)
	)
	+ case when isnull(rfv.AssetTypeID,0) = 1 then case when sum(isnull(duf.ExpectedUnfundedAmount,0)) > 0 then sum(isnull(duf.ExpectedUnfundedAmount,0)) else sum(isnull(duf.UnfundedAmount,0)) end else 0 end as DealSize
,case when max(isnull(rfv.RolledForwardNAV,0)) > 0 then max(isnull(rfv.RolledForwardNAV,0)) else 0 end as RolledForwardNAV
,rfv.RolledForwardNAVDate 
,DATEPART(year,rfv.RolledForwardNAVDate) as [Year]
,DATEPART(QUARTER,rfv.RolledForwardNAVDate) as [Quarter]
,DATEPART(MONTH,rfv.RolledForwardNAVDate) as [Month]
,DATEPART(DAY,rfv.RolledForwardNAVDate) as [Day]
,ctype.TransactionTypeName 
,bnavt.[Name] as dm_rolled_forward_nav_base_nav_type_name
,dnavs.[Name] as dm_rolled_forward_nav_status_name
,ent.EntityCode
from dm_rolled_forward_nav rfv
join entity ent on rfv.EntityID = ent.EntityID 
join deal d on d.DealID = rfv.DealID
join fund f on d.FundID = f.FundID 
--and isnull(f.IsPowerBIHide,0) = 0
left outer join UnderlyingFund uf on rfv.AssetID = uf.UnderlyingFundID and rfv.AssetTypeID = 1
left outer join SecuritySymbol sym on sym.SecurityTypeID = (case when rfv.AssetTypeID = 2 then 1 else case when rfv.AssetTypeID = 11 then 2 else case when rfv.AssetTypeID = 12 then 3 else case when rfv.AssetTypeID = 13 then 4 else 0 end end end end)
and sym.SecurityID = rfv.AssetID 
left outer join AssetType atype on atype.AssetTypeID = rfv.AssetTypeID 
left outer join dm_CashFlow_TransactionType ctype on ctype.TransactionTypeID = rfv.TransactionTypeID
left outer join dm_rolled_forward_nav_base_nav_type bnavt on bnavt.dm_rolled_forward_nav_base_nav_type_id = rfv.dm_rolled_forward_nav_base_nav_type_id 
left outer join dm_rolled_forward_nav_status dnavs on dnavs.dm_rolled_forward_nav_status_id = rfv.dm_rolled_forward_nav_status_id
left outer join dealunderlyingfund duf on duf.DealID = rfv.DealID and duf.UnderlyingFundID = rfv.AssetID and rfv.AssetTypeID = 1 and isnull(duf.DealClosingID,0) > 0
group by rfv.dm_rolled_forward_nav_id,rfv.DealID,rfv.AssetTypeID,rfv.AssetID,rfv.RolledForwardNAVDate,duf.DealUnderlyingFundID,rfv.EntityID,rfv.FundID,f.FundName,d.DealNumber,d.DealName,uf.FundName,sym.IssuerName,sym.Symbol
,atype.[Name],sym.SecurityTypeID,sym.SecurityID,ctype.TransactionTypeName,bnavt.[Name],dnavs.[Name],ent.EntityCode
) as tbl where PartitionNumber = 1
GO
/****** Object:  View [dbo].[dm_vw_rolled_forward_nav_by_attribute]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[dm_vw_rolled_forward_nav_by_attribute] AS
select 
--ROW_NUMBER() OVER (PARTITION BY rfv.DealID,rfv.AssetTypeID,aa.AttributeImplementationID
--,aa.AttributeTypeID
--,aa.AttributeID
--ORDER BY rfv.RolledForwardNAVDate desc,rfv.dm_rolled_forward_nav_id desc) as PartitionNumber
rfv.dm_rolled_forward_nav_id,rfv.EntityID
,rfv.FundID
,rfv.FundName
,rfv.DealID
,rfv.DealNumber
,rfv.DealName
,rfv.AssetTypeID
,rfv.AssetTypeName
,rfv.RolledForwardNAVDate
,rfv.RolledForwardNAV as Amount
,rfv.[Year]
,rfv.[Quarter]
,rfv.[Month]
,rfv.[Day]

,aa.AttributeAllocationID

,aa.[Value]
,((isnull(rfv.RolledForwardNAV,0) * isnull(aa.[Value],0))/100) as Value_Amount

,isnull(duf.NetPurchasePrice,0) as NetPurchasePrice
,((isnull(duf.NetPurchasePrice,0) * isnull(aa.[Value],0))/100) as NPP_Amount

,(isnull(duf.NetPurchasePrice,0)) 
	--+ isnull((select isnull(sum(isnull(dc.Amount,0)),0) from DealClosingCostDistributionLineItem dc 
	--		join DealClosingCostDistribution dist on dist.DealClosingCostDistributionID = dc.DealClosingCostDistributionID
	--		join DealClosingCost cost on cost.DealClosingCostID = dist.DealClosingCostID
	--		where cost.DealID = rfv.dealid and dc.DealUnderlyingFundID = duf.DealUnderlyingFundID and dc.DistributionDate <= rfv.RolledForwardNAVDate),0)) 
	+  case when isnull(duf.ExpectedUnfundedAmount,0) > 0 then isnull(duf.ExpectedUnfundedAmount,0) else isnull(duf.UnfundedAmount,0) end  as DealSize

,((((isnull(duf.NetPurchasePrice,0)) 
	--+ isnull((select isnull(sum(isnull(dc.Amount,0)),0) from DealClosingCostDistributionLineItem dc 
	--		join DealClosingCostDistribution dist on dist.DealClosingCostDistributionID = dc.DealClosingCostDistributionID
	--		join DealClosingCost cost on cost.DealClosingCostID = dist.DealClosingCostID
	--		where cost.DealID = rfv.dealid and dc.DealUnderlyingFundID = duf.DealUnderlyingFundID and dc.DistributionDate <= rfv.RolledForwardNAVDate),0)) 
	+  case when isnull(duf.ExpectedUnfundedAmount,0) > 0 then isnull(duf.ExpectedUnfundedAmount,0) else isnull(duf.UnfundedAmount,0) end) * isnull(aa.[Value],0))/100) as DealSize_Amount

,ent.EntityCode 
,1 as is_from_rolled_forward_nav
,1 as is_inner_date

,aa.AttributeTypeName 
,aa.AttributeName
,aa.AttributeImplementation 
,aa.Direct
,aa.FromDate
,aa.ToDate
,aa.AttributeTypeID
,aa.AttributeImplementationID 
,aa.AttributeGroupingID
,aa.AttributeID
,cast(rfv.FundID as varchar(max)) + '_' + cast(rfv.DealID as varchar(max)) + '_' + cast(rfv.AssetTypeID as varchar(max)) + '_' + cast(aa.AttributeImplementationID as varchar(max)) + '_' + cast(aa.AttributeTypeID as varchar(max)) + '_' + cast(aa.AttributeID as varchar(max))  as GroupKey
from dm_vw_AttributeAllocation aa
join entity ent on aa.EntityID = ent.EntityID 
join dm_vw_rolled_forward_nav rfv on rfv.EntityID = aa.EntityID 
and rfv.AssetTypeID = aa.AttributeImplementationTypeID 
and rfv.AssetID = aa.AttributeImplementationID 
and (rfv.RolledForwardNAVDate between aa.FromDate and aa.ToDate)
left outer join dealunderlyingfund duf on duf.DealID = rfv.DealID and duf.UnderlyingFundID = rfv.AssetID and rfv.AssetTypeID = 1 and isnull(duf.DealClosingID,0) > 0
union all
select 
--ROW_NUMBER() OVER (PARTITION BY rfv.DealID,rfv.AssetTypeID,aa.AttributeImplementationID
--,aa.AttributeTypeID
--,aa.AttributeID
--ORDER BY rfv.RolledForwardNAVDate desc,rfv.dm_rolled_forward_nav_id desc) as PartitionNumber
rfv.dm_rolled_forward_nav_id,rfv.EntityID
,rfv.FundID
,rfv.FundName
,rfv.DealID
,rfv.DealNumber
,rfv.DealName
,rfv.AssetTypeID
,rfv.AssetTypeName
,rfv.RolledForwardNAVDate
,rfv.RolledForwardNAV as Amount
,rfv.[Year]
,rfv.[Quarter]
,rfv.[Month]
,rfv.[Day]

,0 as AttributeAllocationID

,100 as [Value]
,isnull(rfv.RolledForwardNAV,0) as Value_Amount

,isnull(duf.NetPurchasePrice,0) as NetPurchasePrice
,isnull(duf.NetPurchasePrice,0) as NPP_Amount

,(isnull(duf.NetPurchasePrice,0)) 
			--+ isnull((select isnull(sum(isnull(dc.Amount,0)),0) from DealClosingCostDistributionLineItem dc 
			--join DealClosingCostDistribution dist on dist.DealClosingCostDistributionID = dc.DealClosingCostDistributionID
			--join DealClosingCost cost on cost.DealClosingCostID = dist.DealClosingCostID
			--where cost.DealID = rfv.dealid and dc.DealUnderlyingFundID = duf.DealUnderlyingFundID and dc.DistributionDate <= rfv.RolledForwardNAVDate),0)) 
	+  case when isnull(duf.ExpectedUnfundedAmount,0) > 0 then isnull(duf.ExpectedUnfundedAmount,0) else isnull(duf.UnfundedAmount,0) end as DealSize 

,(isnull(duf.NetPurchasePrice,0)) 
			--+ isnull((select isnull(sum(isnull(dc.Amount,0)),0) from DealClosingCostDistributionLineItem dc 
			--join DealClosingCostDistribution dist on dist.DealClosingCostDistributionID = dc.DealClosingCostDistributionID
			--join DealClosingCost cost on cost.DealClosingCostID = dist.DealClosingCostID
			--where cost.DealID = rfv.dealid and dc.DealUnderlyingFundID = duf.DealUnderlyingFundID and dc.DistributionDate <= rfv.RolledForwardNAVDate),0)) 
	+  case when isnull(duf.ExpectedUnfundedAmount,0) > 0 then isnull(duf.ExpectedUnfundedAmount,0) else isnull(duf.UnfundedAmount,0) end as DealSize_Amount

,ent.EntityCode 
,1 as is_from_rolled_forward_nav
,1 as is_inner_date

,'Vintage' as AttributeTypeName 
,cast(uf.VintageYear as varchar(max)) as AttributeName
,uf.FundName as AttributeImplementation 
,'' as Direct
,cast(('01/01/'+cast(uf.VintageYear as varchar(max))) as date) as FromDate
,cast('2100-01-01' as date) as ToDate 
,100 as AttributeTypeID
,uf.UnderlyingFundID as AttributeImplementationID 
,'' as AttributeGroupingID
,0 as AttributeID
,cast(rfv.FundID as varchar(max)) + '_' + cast(rfv.DealID as varchar(max)) + '_1_' + cast(uf.UnderlyingFundID as varchar(max)) + '_0_0' as GroupKey
from underlyingfund uf
join entity ent on uf.EntityID = ent.EntityID 
join dm_vw_rolled_forward_nav rfv on rfv.EntityID = uf.EntityID 
and rfv.AssetID = uf.UnderlyingFundID and rfv.AssetTypeID = 1
and (rfv.RolledForwardNAVDate between cast(('01/01/'+cast(uf.VintageYear as varchar(max))) as date) and cast('2100-01-01' as date))
left outer join dealunderlyingfund duf on duf.DealID = rfv.DealID and duf.UnderlyingFundID = rfv.AssetID and rfv.AssetTypeID = 1 and isnull(duf.DealClosingID,0) > 0
where isnull(uf.vintageyear,0) > 0
union all
select 
--ROW_NUMBER() OVER (PARTITION BY rfv.DealID,rfv.AssetTypeID,aa.AttributeImplementationID
--,aa.AttributeTypeID
--,aa.AttributeID
--ORDER BY rfv.RolledForwardNAVDate desc,rfv.dm_rolled_forward_nav_id desc) as PartitionNumber
rfv.dm_rolled_forward_nav_id,rfv.EntityID
,rfv.FundID
,rfv.FundName
,rfv.DealID
,rfv.DealNumber
,rfv.DealName
,rfv.AssetTypeID
,rfv.AssetTypeName
,rfv.RolledForwardNAVDate
,rfv.RolledForwardNAV as Amount
,rfv.[Year]
,rfv.[Quarter]
,rfv.[Month]
,rfv.[Day]

,0 as AttributeAllocationID
,100 as [Value]
,isnull(rfv.RolledForwardNAV,0) as Value_Amount

,isnull(duf.NetPurchasePrice,0) as NetPurchasePrice
,isnull(duf.NetPurchasePrice,0) as NPP_Amount

,(isnull(duf.NetPurchasePrice,0)) 
			--+ isnull((select isnull(sum(isnull(dc.Amount,0)),0) from DealClosingCostDistributionLineItem dc 
			--join DealClosingCostDistribution dist on dist.DealClosingCostDistributionID = dc.DealClosingCostDistributionID
			--join DealClosingCost cost on cost.DealClosingCostID = dist.DealClosingCostID
			--where cost.DealID = rfv.dealid and dc.DealUnderlyingFundID = duf.DealUnderlyingFundID and dc.DistributionDate <= rfv.RolledForwardNAVDate),0)) 
	+  case when isnull(duf.ExpectedUnfundedAmount,0) > 0 then isnull(duf.ExpectedUnfundedAmount,0) else isnull(duf.UnfundedAmount,0) end as DealSize

,(isnull(duf.NetPurchasePrice,0)) 
			--+ isnull((select isnull(sum(isnull(dc.Amount,0)),0) from DealClosingCostDistributionLineItem dc 
			--join DealClosingCostDistribution dist on dist.DealClosingCostDistributionID = dc.DealClosingCostDistributionID
			--join DealClosingCost cost on cost.DealClosingCostID = dist.DealClosingCostID
			--where cost.DealID = rfv.dealid and dc.DealUnderlyingFundID = duf.DealUnderlyingFundID and dc.DistributionDate <= rfv.RolledForwardNAVDate),0)) 
	+  case when isnull(duf.ExpectedUnfundedAmount,0) > 0 then isnull(duf.ExpectedUnfundedAmount,0) else isnull(duf.UnfundedAmount,0) end as DealSize_Amount

,ent.EntityCode 
,1 as is_from_rolled_forward_nav
,1 as is_inner_date

,'SellerType' as AttributeTypeName 
,stype.SellerType as AttributeName
,case when rfv.AssetTypeID = 1 then rfv.AssetName else '' end as AttributeImplementation 
,case when rfv.AssetTypeID != 1 then rfv.AssetName else '' end as Direct
,cast('1900-01-01' as date) as FromDate
,cast('2100-01-01' as date) as ToDate 
,101 as AttributeTypeID
,rfv.AssetID as AttributeImplementationID 
,'' as AttributeGroupingID
,0 as AttributeID
,cast(rfv.FundID as varchar(max)) + '_' + cast(rfv.DealID as varchar(max)) + '_' + cast(rfv.AssetTypeID as varchar(max)) + '_' + cast(rfv.AssetID as varchar(max)) + '_0_0' as GroupKey
from deal d
join DealSeller ds on d.DealID = ds.DealID 
join SellerType stype on ds.SellerTypeID = stype.SellerTypeID 
join entity ent on d.EntityID = ent.EntityID 
join dm_vw_rolled_forward_nav rfv on rfv.EntityID = d.EntityID and rfv.DealID = d.DealID
left outer join dealunderlyingfund duf on duf.DealID = rfv.DealID and duf.UnderlyingFundID = rfv.AssetID and rfv.AssetTypeID = 1 and isnull(duf.DealClosingID,0) > 0
GO
/****** Object:  View [dbo].[dm_vw_rolled_forward_nav_by_strategy]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[dm_vw_rolled_forward_nav_by_strategy] 
AS
select 
--ROW_NUMBER() OVER (PARTITION BY rfv.DealID,rfv.AssetTypeID,aa.AttributeImplementationID
--,aa.AttributeTypeID
--,aa.AttributeID
--ORDER BY rfv.RolledForwardNAVDate desc,rfv.dm_rolled_forward_nav_id desc) as PartitionNumber
rfv.dm_rolled_forward_nav_id,rfv.EntityID
,rfv.FundID
,rfv.FundName
,rfv.DealID
,rfv.DealNumber
,rfv.DealName
,rfv.AssetTypeID
,rfv.AssetTypeName
,rfv.RolledForwardNAVDate
,rfv.RolledForwardNAV as Amount
,rfv.[Year]
,rfv.[Quarter]
,rfv.[Month]
,rfv.[Day]

,aa.AttributeAllocationID
,aa.[Value]
,((isnull(rfv.RolledForwardNAV,0) * isnull(aa.[Value],0))/100) as Value_Amount
,ent.EntityCode 
,1 as is_from_rolled_forward_nav
,1 as is_inner_date

,aa.AttributeTypeName 
,aa.AttributeName
,aa.AttributeImplementation 
,aa.Direct
,aa.FromDate
,aa.ToDate
,aa.AttributeTypeID
,aa.AttributeImplementationID 
,aa.AttributeGroupingID
,aa.AttributeID
,cast(rfv.FundID as varchar(max)) + '_' + cast(rfv.DealID as varchar(max)) + '_' + cast(rfv.AssetTypeID as varchar(max)) + '_' + cast(aa.AttributeImplementationID as varchar(max)) + '_' + cast(aa.AttributeTypeID as varchar(max)) + '_' + cast(aa.AttributeID as varchar(max))  as GroupKey
from dm_vw_AttributeAllocation aa
join entity ent on aa.EntityID = ent.EntityID 
join dm_vw_rolled_forward_nav rfv on rfv.EntityID = aa.EntityID 
and rfv.AssetTypeID = aa.AttributeImplementationTypeID 
and rfv.AssetID = aa.AttributeImplementationID 
and (rfv.RolledForwardNAVDate between aa.FromDate and aa.ToDate)
and aa.AttributeTypeID = 3
GO
/****** Object:  Table [dbo].[dm_asset_core_lot]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dm_asset_core_lot](
	[dm_asset_core_lot_id] [int] IDENTITY(1,1) NOT NULL,
	[Symbol] [varchar](100) NOT NULL,
	[RecordDate] [datetime] NOT NULL,
	[NumberOfShares] [decimal](19, 8) NOT NULL,
	[SharePrice] [decimal](19, 8) NOT NULL,
	[LotType] [varchar](1) NOT NULL,
	[RefID] [varchar](100) NOT NULL,
	[BalanceShares] [decimal](19, 8) NULL,
	[AvgPrice] [decimal](19, 8) NULL,
	[BuyPrice] [decimal](19, 8) NULL,
 CONSTRAINT [PK_dm_asset_core_lot] PRIMARY KEY CLUSTERED 
(
	[dm_asset_core_lot_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[dm_vw_asset_core_xirr]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE view [dbo].[dm_vw_asset_core_xirr]
AS 
select 
lot.dm_asset_core_lot_id
,lot.NumberOfShares
,lot.SharePrice
,lot.LotType
,lot.RefID
,lot.RecordDate
,case when lot.LotType = 'B' then (lot.NumberOfShares * lot.SharePrice) * -1 else (lot.NumberOfShares * lot.SharePrice) end [Amount]
from dm_asset_core_lot lot 
GO
/****** Object:  View [dbo].[DistributionReport]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[DistributionReport] AS
select 
tbl.* from (
select
ROW_NUMBER() OVER (ORDER BY cd.Amount desc,DealName asc) as RankDeal
,ROW_NUMBER() OVER (ORDER BY cd.Amount desc,uf.FundName asc) as RankUnderlyingFund
,d.EntityID
,d.DealID
,uf.UnderlyingFundID
,ufcd.ReceivedDate as Date
,(isnull(cd.Amount, 0) / (case when isnull(fcr.ConversionFactor,0) = 0 then 1 else isnull(fcr.ConversionFactor,0) end)) as Base_Amount
,isnull(fcr.ConversionFactor,0) as FxRate
,cd.Amount
,d.DealNumber,d.DealName,f.FundName
,uf.FundName as 'UnderlyingFundName'
,0 as NoOfShares
,0 as PricePerShare
,0 as BrokerFees
,0 as Sold
,'' as Stock
,'' as Direct
,0 as IssuerID
,ctype.Name as 'DistributionType'
,cd.cashdistributionid as id
,(case when isnull(ctype.Name, '') = 'Deemed Distribution' then 'Deemed' else 'Cash' end) as Type
,cd.Notes
,cd.ROC
,cd.Interest
,cd.Dividend
,1 as QueryOrder
,ent.EntityCode
from cashdistribution cd
join underlyingfundcashdistribution ufcd on ufcd.underlyingfundcashdistributionid = cd.underlyingfundcashdistributionid
join underlyingfund uf on uf.underlyingfundid = cd.underlyingfundid
join deal d on cd.dealid = d.dealid
join fund f on d.fundid = f.fundid
join entity ent on ent.entityid = f.entityid 
left outer join cashdistributiontype ctype on ctype.CashDistributionTypeID = cd.CashDistributionTypeID
left outer join fxtransaction fxt on fxt.FXTransactionSourceID = ufcd.UnderlyingFundCashDistributionID and fxt.FXTransactionSourceTypeID = 5
left outer join fxconversionrate fcr on fcr.FXConversionRateID = fxt.FXConversionRateID
union
select
ROW_NUMBER() OVER (ORDER BY ufsdItem.FMV desc,DealName asc) as RankDeal
,ROW_NUMBER() OVER (ORDER BY ufsdItem.FMV desc,uf.FundName asc) as RankUnderlyingFund
,d.EntityID
,d.DealID
,uf.UnderlyingFundID 
,ufsd.DistributionDate as Date
,(isnull(ufsdItem.FMV, 0) / (case when isnull(fcr.ConversionFactor,0) = 0 then 1 else isnull(fcr.ConversionFactor,0) end)) as Base_Amount
,isnull(fcr.ConversionFactor,0) as FxRate
,ufsdItem.FMV as 'Amount'
,d.DealNumber
,d.DealName
,f.FundName
,uf.FundName as 'UnderlyingFundName'
,ufsdItem.NumberOfShares as NoOfShares
,ufsd.PurchasePrice as PricePerShare
,0 as BrokerFees
,(select sum(his.finalsaleamount)
			from underlyingfundstockdistributionlineitem ufitem
			join underlyingfundstockdistribution ufsd on ufsd.underlyingfundstockdistributionid = ufitem.underlyingfundstockdistributionid
			join underlyingfund uf on uf.underlyingfundid = ufsd.underlyingfundid
			join securitylot lot on lot.securityacquisitionid = ufitem.underlyingfundstockdistributionlineitemid and lot.securityacquisitiontypeid = 2
			join securitylothistory his on his.securitylotnumber = lot.securitylotnumber and his.securitylothistoryreason = 3
			join equity e on e.equityid = ufsd.securityid
			join deal d on d.dealid = ufitem.dealid
			where ufitem.dealid = ufsdItem.dealid
			and d.dealid = ufsdItem.dealid
			and uf.underlyingfundid = ufsdItem.underlyingfundid  
			and ufsd.securitytypeid = 1
			and ufitem.UnderlyingFundStockDistributionLineItemID = ufsdItem.UnderlyingFundStockDistributionLineItemID
			) as Sold
,(CASE WHEN ufsd.SecurityTypeID =1 THEN equity.Symbol ELSE (CASE WHEN ufsd.SecurityTypeID =2 THEN fi.Symbol ELSE loan.AssetName END) END ) as Stock
,(CASE WHEN ufsd.SecurityTypeID =1 THEN equityIssuer.Name ELSE (CASE WHEN ufsd.SecurityTypeID =2 THEN fiIssuer.Name ELSE loanIssuer.Name END) END ) as Direct
,(CASE WHEN ufsd.SecurityTypeID =1 THEN equityIssuer.IssuerID ELSE (CASE WHEN ufsd.SecurityTypeID =2 THEN fiIssuer.IssuerID ELSE loanIssuer.IssuerID END) END ) as IssuerID
,'Stock Distribution' as 'DistributionType'
,ufsdItem.UnderlyingFundStockDistributionLineItemid as id
,'Stock' as Type
,ufsd.Notes
,0 'ROC'
,0 'Interest'
,0 'Dividend'
,2 as QueryOrder
,ent.EntityCode
from UnderlyingFundStockDistributionLineItem ufsdItem
join UnderlyingFundStockDistribution ufsd on ufsd.UnderlyingFundStockDistributionID = ufsdItem.UnderlyingFundStockDistributionID
join underlyingfund uf on uf.underlyingfundid = ufsdItem.underlyingfundid
join deal d on ufsdItem.dealid = d.dealid
join fund f on d.fundid = f.fundid
join entity ent on ent.entityid = f.entityid 
left outer join Equity equity on equity.EquityID = ufsd.SecurityID
left outer join Issuer equityIssuer on equityIssuer.IssuerID = equity.IssuerID
left outer join FixedIncome fi on fi.FixedIncomeID = ufsd.SecurityID
left outer join Issuer fiIssuer on fiIssuer.IssuerID = fi.IssuerID
left outer join Loan loan on ufsd.SecurityID = loan.LoanID
left outer join Issuer loanIssuer on loanIssuer.IssuerID = loan.IssuerID
left outer join fxtransaction fxt on fxt.FXTransactionSourceID = ufsdItem.UnderlyingFundStockDistributionLineItemid and fxt.FXTransactionSourceTypeID = 10
left outer join fxconversionrate fcr on fcr.FXConversionRateID = fxt.FXConversionRateID
union
select 
ROW_NUMBER() OVER (ORDER BY max(his.FinalSaleAmount) desc,max(d.DealName) asc) as RankDeal
,ROW_NUMBER() OVER (ORDER BY max(his.FinalSaleAmount) desc,max(uf.FundName) asc) as RankUnderlyingFund
,max(d.EntityID) as EntityID
,max(d.DealID) as DealID
,0 as UnderlyingFundID--max(uf.UnderlyingFundID) as UnderlyingFundID
,max(ss.SellDate) as Date
,(max(isnull(his.FinalSaleAmount, 0)) / (case when max(isnull(fcr.ConversionFactor,0)) = 0 then 1 else max(isnull(fcr.ConversionFactor,0)) end)) as Base_Amount
,max(isnull(fcr.ConversionFactor,0)) as FxRate
,max(his.FinalSaleAmount) as 'Amount'
,max(d.DealNumber) as DealNumber,max(d.DealName) as DealName,max(f.FundName) as FundName
--,max(uf.FundName) as 'UnderlyingFundName'
--,(CASE WHEN max(ss.SecurityTypeID) =1 THEN max(equityIssuer.[Name]) ELSE (CASE WHEN max(ss.SecurityTypeID) =2 THEN max(fiIssuer.[Name]) ELSE max(loanIssuer.[Name]) END) END ) as 'UnderlyingFundName'
,'' as 'UnderlyingFundName'
,max(isnull(his.NumberOfSharesSold,0)) as NoOfShares
,max(ss.SellPrice) as PricePerShare
,max(ss.Fees) as BrokerFees
,0 as Sold
,(CASE WHEN max(ss.SecurityTypeID) =1 THEN max(equity.Symbol) ELSE (CASE WHEN max(ss.SecurityTypeID) =2 THEN max(fi.Symbol) ELSE max(loan.AssetName) END) END ) as Stock
,(CASE WHEN max(ss.SecurityTypeID) =1 THEN max(equityIssuer.[Name]) ELSE (CASE WHEN max(ss.SecurityTypeID) =2 THEN max(fiIssuer.[Name]) ELSE max(loanIssuer.[Name]) END) END ) as Direct
,(CASE WHEN max(ss.SecurityTypeID) =1 THEN max(equityIssuer.IssuerID) ELSE (CASE WHEN max(ss.SecurityTypeID) =2 THEN max(fiIssuer.IssuerID) ELSE max(loanIssuer.IssuerID) END) END ) as IssuerID
--,(case when isnull(max(ufsdtype.[Name]),'') = '' then 'Regular Distribution' else isnull(max(ufsdtype.[Name]),'') end) as 'DistributionType'
,'Stock Security Distribution' as 'DistributionType'
,max(his.SecurityLotHistoryID) as id
,'Cash' as Type
,'' as Notes
,0 'ROC'
,0 'Interest'
,0 'Dividend'
,3 as QueryOrder
,ent.EntityCode
from UnderlyingFundStockDistributionLineItem ufsdItem
join underlyingfund uf on uf.underlyingfundid = ufsdItem.underlyingfundid
join deal d on ufsdItem.dealid = d.dealid
join fund f on d.fundid = f.fundid
join entity ent on ent.entityid = f.entityid 
join securitylot lot on lot.securityacquisitionid = ufsdItem.underlyingfundstockdistributionlineitemid and lot.securityacquisitiontypeid = 2
join securitylothistory his on his.securitylotnumber = lot.securitylotnumber and his.securitylothistoryreason = 3
join securitysale ss on ss.securitysaleid = his.securitylothistoryreasonid
--left outer join underlyingfunddistributiontype ufsdtype on ufsdtype.underlyingfunddistributiontypeid = ufsditem.underlyingfunddistributiontypeid
left outer join saledistributiontype sdt on sdt.saledistributiontypeid = his.SecurityDistributionTypeID
left outer join Equity equity on equity.EquityID = ss.SecurityID
left outer join Issuer equityIssuer on equityIssuer.IssuerID = equity.IssuerID
left outer join FixedIncome fi on fi.FixedIncomeID = ss.SecurityID
left outer join Issuer fiIssuer on fiIssuer.IssuerID = fi.IssuerID
left outer join Loan loan on ss.SecurityID = loan.LoanID
left outer join Issuer loanIssuer on loanIssuer.IssuerID = loan.IssuerID
left outer join fxtransaction fxt on fxt.FXTransactionSourceID = ss.securitysaleid and fxt.FXTransactionSourceTypeID = 15
left outer join fxconversionrate fcr on fcr.FXConversionRateID = fxt.FXConversionRateID
group by ufsdItem.underlyingfundstockdistributionlineitemid,ent.EntityCode 
union
select 
ROW_NUMBER() OVER (ORDER BY dd.Amount desc,d.DealName asc) as RankDeal
,ROW_NUMBER() OVER (ORDER BY dd.Amount desc) as RankUnderlyingFund
,d.EntityID
,d.DealID
,0 as 'UnderlyingFundID'
,uddd.DistributionDate as Date
,(isnull(dd.Amount, 0) / (case when isnull(fcr.ConversionFactor,0) = 0 then 1 else isnull(fcr.ConversionFactor,0) end)) as Base_Amount
,isnull(fcr.ConversionFactor,0) as FxRate
,dd.Amount as 'Amount'
,d.DealNumber,d.DealName,f.FundName
--,(CASE WHEN uddd.SecurityTypeID =1 THEN equityIssuer.Name ELSE (CASE WHEN uddd.SecurityTypeID =2 THEN fiIssuer.Name ELSE loanIssuer.Name END) END ) as 'UnderlyingFundName'
,'' as 'UnderlyingFundName'
,0 as NoOfShares
,0 as PricePerShare
,0 as BrokerFees
,0 as Sold
,(CASE WHEN uddd.SecurityTypeID =1 THEN equity.Symbol ELSE (CASE WHEN uddd.SecurityTypeID =2 THEN fi.Symbol ELSE loan.AssetName END) END ) as Stock
,(CASE WHEN uddd.SecurityTypeID =1 THEN equityIssuer.Name ELSE (CASE WHEN uddd.SecurityTypeID =2 THEN fiIssuer.Name ELSE loanIssuer.Name END) END ) as Direct
,(CASE WHEN uddd.SecurityTypeID =1 THEN equityIssuer.IssuerID ELSE (CASE WHEN uddd.SecurityTypeID =2 THEN fiIssuer.IssuerID ELSE loanIssuer.IssuerID END) END ) as IssuerID
,ctype.Name as 'DistributionType'
,dd.DividendDistributionID as id
,'Cash Dividend' as Type
,dd.Notes
,0 'ROC'
,0 'Interest'
,0 'Dividend'
,4 as QueryOrder
,ent.EntityCode
from DividendDistribution dd
join UnderlyingDirectDividendDistribution uddd on uddd.UnderlyingDirectDividendDistributionID = dd.UnderlyingDirectDividendDistributionID
join deal d on dd.dealid = d.dealid
join fund f on d.fundid = f.fundid
join entity ent on ent.entityid = f.entityid 
left outer join CashDistributionType ctype on ctype.CashDistributionTypeID = dd.CashDistributionTypeID
left outer join Equity equity on equity.EquityID = uddd.SecurityID
left outer join Issuer equityIssuer on equityIssuer.IssuerID = equity.IssuerID
left outer join FixedIncome fi on fi.FixedIncomeID = uddd.SecurityID
left outer join Issuer fiIssuer on fiIssuer.IssuerID = fi.IssuerID
left outer join Loan loan on uddd.SecurityID = loan.LoanID
left outer join Issuer loanIssuer on loanIssuer.IssuerID = loan.IssuerID
left outer join fxtransaction fxt on fxt.FXTransactionSourceID = dd.DividendDistributionID and fxt.FXTransactionSourceTypeID = 13
left outer join fxconversionrate fcr on fcr.FXConversionRateID = fxt.FXConversionRateID
union
select 
ROW_NUMBER() OVER (ORDER BY sitem.FinalSaleAmount desc,d.DealName asc) as RankDeal
,ROW_NUMBER() OVER (ORDER BY sitem.FinalSaleAmount desc) as RankUnderlyingFund
,d.EntityID
,d.DealID
,0 as 'UnderlyingFundID'
,sale.SellDate as Date
,(isnull(sitem.FinalSaleAmount, 0) / (case when isnull(fcr.ConversionFactor,0) = 0 then 1 else isnull(fcr.ConversionFactor,0) end)) as Base_Amount
,isnull(fcr.ConversionFactor,0) as FxRate
,sitem.FinalSaleAmount as 'Amount'
,d.DealNumber,d.DealName,f.FundName
--,(CASE WHEN uddd.SecurityTypeID =1 THEN equityIssuer.Name ELSE (CASE WHEN uddd.SecurityTypeID =2 THEN fiIssuer.Name ELSE loanIssuer.Name END) END ) as 'UnderlyingFundName'
,'' as 'UnderlyingFundName'
,0 as NoOfShares
,0 as PricePerShare
,0 as BrokerFees
,0 as Sold
,(CASE WHEN sale.SecurityTypeID =1 THEN equity.Symbol ELSE (CASE WHEN sale.SecurityTypeID =2 THEN fi.Symbol ELSE loan.AssetName END) END ) as Stock
,(CASE WHEN sale.SecurityTypeID =1 THEN equityIssuer.Name ELSE (CASE WHEN sale.SecurityTypeID =2 THEN fiIssuer.Name ELSE loanIssuer.Name END) END ) as Direct
,(CASE WHEN sale.SecurityTypeID =1 THEN equityIssuer.IssuerID ELSE (CASE WHEN sale.SecurityTypeID =2 THEN fiIssuer.IssuerID ELSE loanIssuer.IssuerID END) END ) as IssuerID
,'SecuritySale' as 'DistributionType'
,sale.SecuritySaleID as id
,'SecuritySale' as Type
,'' Notes
,0 'ROC'
,0 'Interest'
,0 'Dividend'
,4 as QueryOrder
,ent.EntityCode
from SecuritySale sale
join SecuritySaleLineItem sitem on sitem.SecuritySaleID = sale.SecuritySaleID
join deal d on sitem.dealid = d.dealid
join fund f on d.fundid = f.fundid
join entity ent on ent.entityid = f.entityid 
left outer join Equity equity on equity.EquityID = sale.SecurityID
left outer join Issuer equityIssuer on equityIssuer.IssuerID = equity.IssuerID
left outer join FixedIncome fi on fi.FixedIncomeID = sale.SecurityID
left outer join Issuer fiIssuer on fiIssuer.IssuerID = fi.IssuerID
left outer join Loan loan on sale.SecurityID = loan.LoanID
left outer join Issuer loanIssuer on loanIssuer.IssuerID = loan.IssuerID
left outer join fxtransaction fxt on fxt.FXTransactionSourceID = sale.SecuritySaleID and fxt.FXTransactionSourceTypeID = 15
left outer join fxconversionrate fcr on fcr.FXConversionRateID = fxt.FXConversionRateID
union
select 
ROW_NUMBER() OVER (ORDER BY ufsl.NetSellPrice desc,d.DealName asc) as RankDeal
,ROW_NUMBER() OVER (ORDER BY ufsl.NetSellPrice desc,uf.FundName asc) as RankUnderlyingFund
,d.EntityID
,d.DealID
,uf.UnderlyingFundID
,ufs.SellDate as Date
,(isnull(ufsl.NetSellPrice, 0) / (case when isnull(fcr.ConversionFactor,0) = 0 then 1 else isnull(fcr.ConversionFactor,0) end)) as Base_Amount
,isnull(fcr.ConversionFactor,0) as FxRate
,ufsl.NetSellPrice as 'Amount',d.DealNumber,d.DealName,f.FundName,uf.FundName as 'UnderlyingFundName'
,0 as NoOfShares
,0 as PricePerShare
,0 as BrokerFees
,0 as Sold
,'' as Stock
,'' as Direct
,0 as IssuerID
,ufstype.Name as 'DistributionType'
,ufsl.underlyingfundsalelineitemid as id
,'Underlying Fund Sale' as Type
,ufs.Notes
,0 'ROC'
,0 'Interest'
,0 'Dividend'
,5 as QueryOrder
,ent.EntityCode
from underlyingfundsalelineitem ufsl
join underlyingfundsale ufs on ufsl.underlyingfundsaleid = ufs.underlyingfundsaleid
join underlyingfund uf on uf.underlyingfundid = ufs.underlyingfundid
join deal d on ufsl.dealid = d.dealid
join fund f on ufs.fundid = f.fundid
join entity ent on ent.entityid = f.entityid 
left outer join underlyingfundsaledistributiontype ufstype on ufstype.underlyingfundsaledistributiontypeid = ufs.underlyingfundsaledistributiontypeid
left outer join fxtransaction fxt on fxt.FXTransactionSourceID = ufsl.underlyingfundsalelineitemid and fxt.FXTransactionSourceTypeID = 22
left outer join fxconversionrate fcr on fcr.FXConversionRateID = fxt.FXConversionRateID
) as tbl
GO
/****** Object:  View [dbo].[dm_vw_Asset]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[dm_vw_Asset] AS
select 
tbl.* from (
select
uf.UnderlyingFundID as AssetID
,'UnderlyingFund' as AssetTypeID
,uf.EntityID
,isnull(uf.IssuerID, 0) as IssuerID
,isnull(issuer.[Name], '') as IssuerName
,isnull(uf.ShareClassTypeID,0) as ShareClassTypeID
,isnull(shareClassType.ShareClass, '') as ShareClass
,isnull(uf.IndustryID, 0) as IndustryID
,isnull(industry.Industry, '') as Industry
,isnull(investmentType.InvestmentTypeID, 0) as InvestmentTypeID
,isnull(investmentType.Investment, '') as Investment
,isnull(uf.VehicleTypeID, 0) as VehicleTypeID
,isnull(vehicleType.Vehicle, '') as Vehicle
,uf.FundName as [Name]
,isnull(uf.FundTypeID, 0) as AssetSubTypeID
,isnull(fundType.[Name], '') as AssetSubType
,ent.EntityCode
from UnderlyingFund uf
join entity ent on uf.EntityID = ent.EntityID 
left outer join Issuer issuer on uf.IssuerID = issuer.IssuerID
left outer join UnderlyingFundType fundType on uf.FundTypeID = fundType.UnderlyingFundTypeID
left outer join Industry industry on uf.IndustryID = industry.IndustryID
left outer join ShareClassType shareClassType on uf.ShareClassTypeID = shareClassType.ShareClassTypeID
left outer join InvestmentType investmentType on uf.InvestmentTypeID = investmentType.InvestmentTypeID
left outer join VehicleType vehicleType on uf.VehicleTypeID = vehicleType.VehicleTypeID
union
select
equity.EquityID as AssetID
,'Equity' as AssetTypeID
,equity.EntityID
,isnull(equity.IssuerID, 0) as IssuerID
,isnull(issuer.[Name], '') as IssuerName
,isnull(equity.ShareClassTypeID,0) as ShareClassTypeID
,isnull(shareClassType.ShareClass, '') as ShareClass
,isnull(equity.IndustryID, 0) as IndustryID
,isnull(industry.Industry, '') as Industry
,isnull(equity.InvestmentTypeID, 0) as InvestmentTypeID
,isnull(investmentType.Investment, '') as Investment
,isnull(equity.VehicleTypeID, 0) as VehicleTypeID
,isnull(vehicleType.Vehicle, '') as Vehicle
,equity.Symbol as [Name]
,isnull(equity.EquityTypeID, 0) as AssetSubTypeID
,isnull(equityType.Equity, '') as AssetSubType
,ent.EntityCode
from Equity equity
join entity ent on equity.EntityID = ent.EntityID 
left join Issuer issuer on equity.IssuerID = issuer.IssuerID
left outer join EquityType equityType on equity.EquityTypeID = equityType.EquityTypeID
left outer join ShareClassType shareClassType on equity.ShareClassTypeID = shareClassType.ShareClassTypeID
left outer join Industry industry on equity.IndustryID = industry.IndustryID
left outer join InvestmentType investmentType on equity.InvestmentTypeID = investmentType.InvestmentTypeID
left outer join VehicleType vehicleType on equity.VehicleTypeID = vehicleType.VehicleTypeID
) as tbl
GO
/****** Object:  View [dbo].[dm_vw_Deal]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[dm_vw_Deal] AS
select 
d.DealID
,f.FundID
,f.FullName
,d.EntityID
,d.DealName
,d.DealNumber
,isnull(pt.PurchaseTypeID, 0) as PurchaseTypeID
,isnull(pt.[Name], '') as PurchaseTypeName
,d.IsPartnered
,isnull(d.SellerTypeID, 0) as SellerTypeID
,isnull(st.SellerType, '') as SellerType
,d.GrossPurchasePrice
,d.NetPurchasePrice
,isnull(d.SellerGeographyID, 0) as SellerGeographyID
,isnull(geo.Geography, '') as SellerGeograpy
,isnull(d.SaleProcessTypeID, 0) as SaleProcessTypeID
,isnull(spt.SaleProcessType, '') as SaleProcessType
,isnull(sct.SourcingChannelTypeID, 0) as SourcingChannelTypeID
,isnull(sct.SourcingChannelType, '') as SourcingChannelType
,isnull(d.NetPurchasePrice,0) + isnull((select sum(isnull(case when isnull(duf.ExpectedUnfundedAmount,0) > 0 then isnull(duf.ExpectedUnfundedAmount,0) else isnull(duf.UnfundedAmount,0) end,0)) from dealunderlyingfund duf
where duf.DealID = d.DealID),0) + isnull((select sum(isnull(dc.Amount,0)) from dealclosingcost dc where dc.dealid = d.dealid),0) as DealSize
,entity.EntityCode 
from deal d
join Fund f on d.FundID = f.FundID
left outer join PurchaseType pt on d.PurchaseTypeID = pt.PurchaseTypeID
left outer join SellerType st on d.SellerTypeID = st.SellerTypeID
left outer join [Geography] geo on d.SellerGeographyID = geo.GeographyID
left outer join SaleProcessType spt on d.SaleProcessTypeID = spt.SaleProcessTypeID
left outer join SourcingChannelType sct on d.SourcingChannelTypeID = sct.SourcingChannelTypeID
join ENTITY entity on entity.EntityID = d.EntityID
GO
/****** Object:  View [dbo].[dm_vw_Deal_Closed_Quater]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[dm_vw_Deal_Closed_Quater]
AS
select ent.EntityID,ent.EntityCode,p.dm_time_period_key_1,p.dm_time_period_key_2
,'Q' + cast(p.dm_time_period_key_1 as varchar(max)) + ' ' + cast(p.dm_time_period_key_2 as varchar(max)) as Quater
,p.FromDate,p.ToDate
,sum(isnull(dc.TotalPaid,0)) as TotalPaid 
,count(dc.DealClosingID) as TotalClosing
from dm_time_period p
join dealclosing dc on dc.CloseDate between p.FromDate and p.ToDate 
join deal d on d.dealid = dc.dealid 
join entity ent on ent.EntityID = d.EntityID 
where p.dm_time_period_type_id = 1
and dc.CloseDate > '01/01/1900'
and isnull(dc.TotalPaid,0) > 0
group by ent.EntityID,ent.EntityCode,p.dm_time_period_key_1,p.dm_time_period_key_2,p.dm_time_period_key_3,p.FromDate,p.ToDate,p.dm_time_period_type_id
--order by ent.EntityID,ent.EntityCode,p.dm_time_period_key_2,p.dm_time_period_key_1
GO
/****** Object:  View [dbo].[dm_vw_DealUnderlyingFund]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[dm_vw_DealUnderlyingFund] AS
select 
f.FundID
,f.FullName
,d.EntityID
,d.DealName
,d.DealNumber
,uf.FundName
,entity.EntityCode 
,case when isnull(duf.ExpectedUnfundedAmount,0) > 0 then isnull(duf.ExpectedUnfundedAmount,0) else isnull(duf.UnfundedAmount,0) end as CurrentExpectedUnfundedAmount
,
(isnull(duf.NetPurchasePrice,0))  + 
--		(select isnull(sum(isnull(dc.Amount,0)),0) from DealClosingCostDistributionLineItem dc 
--		join DealClosingCostDistribution dist on dist.DealClosingCostDistributionID = dc.DealClosingCostDistributionID
--		join DealClosingCost cost on cost.DealClosingCostID = dist.DealClosingCostID
--		where cost.DealID = duf.dealid and dc.DealUnderlyingFundID = duf.DealUnderlyingFundID)
--)	+ 
case when isnull(duf.ExpectedUnfundedAmount,0) > 0 then isnull(duf.ExpectedUnfundedAmount,0) else isnull(duf.UnfundedAmount,0) end as DealSize
,duf.*
from DealUnderlyingFund duf
join Deal d on duf.DealID = d.DealID 
join Fund f on d.FundID = f.FundID
join UnderlyingFund uf on uf.UnderlyingFundID = duf.UnderlyingFundID
join ENTITY entity on entity.EntityID = d.EntityID
GO
/****** Object:  View [dbo].[dm_vw_direct_last_price_history_by_time_period]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/****** Object:  View [dbo].[dm_vw_direct_last_price_history_by_time_period]    Script Date: 3/4/2020 3:28:35 PM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO
--declare @entityId int;
--set @entityId = 22;


CREATE VIEW [dbo].[dm_vw_direct_last_price_history_by_time_period] AS
select 
isnull(tbl.NumberOfSharesUnsold,0) * isnull(tbl.StartPrice,0) as StartPeriod,
(isnull(tbl.NumberOfSharesUnsold,0) * isnull(tbl.LastPrice,0)) + isnull(tbl.Realized,0) + isnull(tbl.Dividend,0) as EndPeriod,
case when isnull(tbl.TotalFMV,0) > 0 then (isnull(tbl.FMV,0) / isnull(tbl.TotalFMV,0)) * 100 else 0 end as Allocation,
tbl.* from (
select ent.EntityCode,f.FundName,d.DealNumber,d.DealName
,iss.[Name] as Company
,eq.Symbol as Symbol
,tp.dm_time_period_key_2
,tp.dm_time_period_key_1
,tp.dm_time_period_type_id
,(case when tp.dm_time_period_type_id = 1 then cast(DATEPART(QUARTER,tp.FromDate) as varchar(5)) + ' Q' + cast(DATEPART(year,tp.FromDate) as varchar(10)) 
else case when tp.dm_time_period_type_id = 2 then cast(FORMAT(tp.FromDate, 'MMM', 'en-US') as varchar(5)) + ' ' + cast(DATEPART(year,tp.FromDate) as varchar(10)) else cast(tp.dm_time_period_key_2 as varchar(max)) end
end) as tp_key
,tp.FromDate
,tp.ToDate
,(select top 1 lp.LastPrice from UnderlyingDirectLastPriceHistory lp 
	where lp.DealID = his.DealID and lp.SecurityTypeID = his.SecurityTypeID and lp.SecurityID = his.SecurityID
	and lp.LastPriceDate between tp.FromDate and tp.ToDate 
	order by lp.LastPriceDate asc,lp.UnderlyingDirectLastPriceHistoryID asc) as StartPrice	
,his.LastPrice
,his.LastPriceDate

,(select sum(isnull(sharestbl.FMV,0)) from (
select ROW_NUMBER() OVER (PARTITION BY 
	shares.DealID,shares.SecurityTypeID,shares.SecurityID
 ORDER BY shares.RecordDate desc,shares.SecurityLotSharesHistoryID desc) as RowNumber,isnull(shares.NumberOfSharesUnSold,0) * isnull(his.LastPrice,0) as FMV  from SecurityLotSharesHistory shares 
	where shares.DealID = his.DealID
	--and shares.SecurityTypeID = his.SecurityTypeID and shares.SecurityID = his.SecurityID
	and shares.RecordDate <= tp.ToDate
	) as sharestbl where sharestbl.RowNumber = 1) as TotalFMV

,(select top 1 isnull(shares.NumberOfSharesUnsold,0) * isnull(his.LastPrice,0) from SecurityLotSharesHistory shares 
	where shares.DealID = his.DealID 
	and shares.SecurityTypeID = his.SecurityTypeID and shares.SecurityID = his.SecurityID
	and shares.RecordDate <= tp.ToDate
	order by shares.RecordDate desc,shares.SecurityLotSharesHistoryID desc) as FMV

,(select top 1 shares.NumberOfSharesUnsold from SecurityLotSharesHistory shares 
	where shares.DealID = his.DealID and shares.SecurityTypeID = his.SecurityTypeID and shares.SecurityID = his.SecurityID
	and shares.RecordDate <= tp.ToDate
	order by shares.RecordDate desc,shares.SecurityLotSharesHistoryID desc) as NumberOfSharesUnsold
,(select sum(isnull(lothis.NumberOfSharesSold,0) * (isnull(lothis.SharePrice,0) - isnull(lot.OriginalSharePrice,0))) from SecurityLotHistory lothis
	join securitylot lot on lot.securitylotnumber = lothis.securitylotnumber
	where lothis.DealID = his.DealID and lothis.OldSecurityTypeID = his.SecurityTypeID and lothis.OldSecurityID = his.SecurityID
	and lothis.SecurityLotHistoryReason in (3,4)
	and lothis.RecordDate between tp.FromDate and tp.ToDate) as Realized
,(select sum(isnull(dd.Amount,0)) from dividenddistribution dd
	where dd.DealID = his.DealID and dd.SecurityTypeID = his.SecurityTypeID and dd.SecurityID = his.SecurityID
	and dd.DistributionDate between tp.FromDate and tp.ToDate) as Dividend
,ROW_NUMBER() OVER (PARTITION BY 
	his.DealID,his.SecurityTypeID,his.SecurityID
	,tp.dm_time_period_key_2
	,tp.dm_time_period_key_1
	,tp.dm_time_period_type_id
 ORDER BY his.LastPriceDate desc,his.UnderlyingDirectLastPriceHistoryID desc) as RowNumber
,his.DealID
,his.SecurityTypeID
,his.SecurityID
from UnderlyingDirectLastPriceHistory his
join deal d on d.dealid = his.dealid 
join fund f on d.fundid = f.fundid
join entity ent on d.entityid = ent.entityid
join Equity eq on eq.EquityId = his.SecurityID and his.SecurityTypeID = 1
join Issuer iss on iss.IssuerId = eq.IssuerId
join dm_time_period tp on his.LastPriceDate between tp.FromDate and tp.ToDate 
--where d.entityid = @entityId
--and tp.dm_time_period_type_id = 1
--and tp.dm_time_period_key_2 = 2018
--and tp.dm_time_period_key_1 = 1
) as tbl where tbl.RowNumber = 1
GO
/****** Object:  View [dbo].[dm_vw_Equity]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[dm_vw_Equity] AS
select
equity.EquityID
,equity.EntityID
,equity.IssuerID
,issuer.Name
,isnull(equity.EquityTypeID, 0) as EquityTypeID
,isnull(equityType.Equity, '') as Equity
,equity.Symbol
,equity.[Public]
,isnull(equity.ShareClassTypeID, 0) as ShareClassTypeID
,isnull(shareClassType.ShareClass, '') as ShareClass
,isnull(investmentType.InvestmentTypeID, 0) as InvestmentTypeID
,isnull(investmentType.Investment, '') as Investment
,isnull(vehicleType.VehicleTypeID, 0) as VehicleTypeID
,isnull(vehicleType.Vehicle, '') as Vehicle
,ent.EntityCode 
from Equity equity
join entity ent on equity.EntityID = ent.EntityID 
left join Issuer issuer on equity.IssuerID = issuer.IssuerID
left outer join EquityType equityType on equity.EquityTypeID = equityType.EquityTypeID
left outer join ShareClassType shareClassType on equity.ShareClassTypeID = shareClassType.ShareClassTypeID
left outer join InvestmentType investmentType on equity.InvestmentTypeID = investmentType.InvestmentTypeID
left outer join VehicleType vehicleType on equity.VehicleTypeID = vehicleType.VehicleTypeID
GO
/****** Object:  View [dbo].[dm_vw_Fund]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[dm_vw_Fund] AS
select 
f.FundID
,f.EntityID
,f.FullName
--,f.FundTypeID
--,ft.[Name]
,entity.EntityCode
--,cast(isnull(f.IsPowerBIHide,'0') as varchar(2)) as IsPowerBIHide
from Fund f
--join FundType ft on f.FundTypeID = ft.FundTypeID
join ENTITY entity on entity.EntityID = f.EntityID
GO
/****** Object:  View [dbo].[dm_vw_Fund_Detail]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[dm_vw_Fund_Detail] AS
select 
f.FundID
,f.EntityID
,f.FullName
--,f.FundTypeID
--,ft.[Name]
,entity.EntityCode
--,cast(isnull(f.IsPowerBIHide,'0') as varchar(2)) as IsPowerBIHide
--,sum(isnull(det.TotalDistribution,0)) as TotalDistribution
--,sum(isnull(det.TotalInvestment,0)) as TotalInvestment
,sum(isnull(det.EstimatedNAV,0)) as CurrentNAV
,(select count(*) as cnt from deal secdeal where secdeal.fundid = f.fundid) as TotalDeals
,(select count(*) as cnt from ( 
select count(*) as cnt from DealUnderlyingFund duf
join deal dufdeal on dufdeal.dealid = duf.dealid where dufdeal.fundid = f.fundid 
group by duf.UnderlyingFundID
union all
select count(*) as cnt from DealUnderlyingDirect duf
join deal dufdeal on dufdeal.dealid = duf.dealid where dufdeal.fundid = f.fundid 
group by duf.SecurityTypeID,duf.SecurityID
) as tbl) as TotalAssets
,case when sum(isnull(det.TotalInvestment,0)) > 0 then ROUND((sum(isnull(det.TotalDistribution,0)) + sum(isnull(det.EstimatedNAV,0))) / sum(isnull(det.TotalInvestment,0)),2) else 0 end as TotalMultiple
,case when sum(isnull(det.TotalInvestment,0)) > 0 then ROUND(sum(isnull(det.TotalDistribution,0)) / sum(isnull(det.TotalInvestment,0)),2) else 0 end as RealizedMultiple
,(select count(*) from ((select item.InvestorID as cnt from CapitalCallLineItem item join CapitalCall cc on cc.CapitalCallID = item.CapitalCallID where cc.FundID = f.FundID group by item.InvestorID)) as tbl) as TotalInvestors
,(select sum(isnull(item.TotalCommitment,0)) from InvestorFund item where item.FundID = f.FundID) as TotalCommittedCapital
,(select sum(isnull(item.CapitalAmountCalled,0)) from CapitalCallLineItem item join CapitalCall cc on cc.CapitalCallID = item.CapitalCallID where cc.FundID = f.FundID) as TotalDrawnCapital
,(select sum(isnull(item.DistributionAmount,0)) from CapitalDistributionLineItem item join CapitalDistribution cc on cc.CapitalDistributionID = item.CapitalDistributionID where cc.FundID = f.FundID)  as TotalReturnCapital
from Fund f
left outer join Deal d on d.FundID = f.FundID 
left outer join DealDetail det on d.DealID = det.DealID 
--join FundType ft on f.FundTypeID = ft.FundTypeID
join ENTITY entity on entity.EntityID = f.EntityID
where isnull(f.IsHide,0) = 0 
--and isnull(f.IsPowerBIHide,0) = 0
group by f.FundID,f.EntityID,f.FullName,entity.EntityCode
--f.FundTypeID,ft.[Name],entity.EntityCode,f.IsPowerBIHide 
GO
/****** Object:  View [dbo].[dm_vw_Fund_Economic_Quater]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[dm_vw_Fund_Economic_Quater] 
AS
select tbl.FundID,tbl.FundName,tbl.EntityID,tbl.EntityCode
,sum((isnull(tbl.InvestmentCost,0) + isnull(tbl.DealClosingCost,0)) - isnull(tbl.DealExpenseContribution,0)) as InvestmentCost 
,sum(isnull(tbl.InvestmentNAV,0)) as InvestmentNAV 
,sum(isnull(tbl.InvestmentReturns,0) + isnull(tbl.DealExpenseDistribution,0)) as InvestmentReturns 
,tbl.QuaterNumber
,tbl.[Year]
,tbl.Quater 
from (
select f.FundID,f.FundName,d.DealID,sum(isnull(p.InvestmentCost,0)) as InvestmentCost,sum(isnull(p.InvestmentNAV,0)) as InvestmentNAV,sum(isnull(p.InvestmentReturns,0)) as InvestmentReturns
,(select sum(isnull(fe.amount,0)) from FundExpense fe where fe.dealid = d.dealid and isnull(fe.underlyingfundid,0) = 0 and isnull(fe.securitytypeid,0) = 0 and isnull(fe.securityid,0) = 0
and fe.[Date] <= t.ToDate
and isnull(fe.isreceived,0) = 1
) as DealExpenseDistribution
,(select sum(isnull(fe.amount,0)) from FundExpense fe where fe.dealid = d.dealid and isnull(fe.underlyingfundid,0) = 0 and isnull(fe.securitytypeid,0) = 0 and isnull(fe.securityid,0) = 0
and fe.[Date] <= t.ToDate
and isnull(fe.isreceived,0) = 0
) as DealExpenseContribution
,(select sum(isnull(dc.amount,0)) from dealclosingcost dc where dc.dealid = d.dealid and dc.[Date] <= t.ToDate) as DealClosingCost
,t.dm_time_period_key_1 as QuaterNumber
,t.dm_time_period_key_2 as [Year]
,'Q' + cast(t.dm_time_period_key_1 as varchar(max)) + ' ' + cast(t.dm_time_period_key_2 as varchar(max)) as Quater
,ent.EntityID,ent.EntityCode
from dm_economic_history_by_time_period p
join dm_time_period t on t.dm_time_period_id = p.dm_time_period_id 
join deal d on d.dealid = p.dealid 
join fund f on d.fundid = f.fundid 
join ENTITY ent on ent.EntityID = f.EntityID 
where t.dm_time_period_type_id = 1
group by d.dealid,f.fundid,f.fundname,t.dm_time_period_key_1,t.dm_time_period_key_2,ent.EntityID,ent.EntityCode,t.ToDate
--order by t.dm_time_period_key_2,t.dm_time_period_key_1
) as tbl group by tbl.FundID,tbl.FundName,tbl.EntityID,tbl.EntityCode,tbl.QuaterNumber,tbl.[Year],tbl.Quater
GO
/****** Object:  View [dbo].[dm_vw_Fund_Investment_Map]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[dm_vw_Fund_Investment_Map]
AS
--select tbl.EntityID,tbl.EntityCode,tbl.FundID,tbl.FundName,p.FromDate as EffectiveDate,Avg(isnull(tbl.RealizedMultiple,0)) as RealizedMultiple
--,sum(isnull(tbl.TotalRemainingValue,0)) as TotalRemainingValue from (
select ent.EntityID,ent.EntityCode,f.FundID,f.FundName,d.DealID,d.DealName,d.DealNumber,d.EffectiveDate,p.FromDate
,isnull(det.RealizedROI,0) as RealizedMultiple
,isnull(det.ROI,0) as TotalMultiple
,isnull((select sum(isnull(RolledForwardNAV,0)) as TotalRolledForwardNAV from ( 
	select ROW_NUMBER() over(PARTITION BY nav.DealID,nav.AssetID,nav.AssetTypeID order by nav.RolledForwardNAVDate desc,nav.dm_rolled_forward_nav_id desc) as RowNumber 
	,(case when isnull(nav.RolledForwardNAV,0) <= 0 then 0 else isnull(nav.RolledForwardNAV,0) end) as RolledForwardNAV 
	,(case when isnull(nav.LatestFXRate,0)<= 0 then 1 else isnull(nav.LatestFXRate,0) end) as LatestFXRate 
	from dm_rolled_forward_nav nav 
	join dealunderlyingfund duf on nav.DealID = duf.DealID and nav.AssetID = duf.UnderlyingFundID and nav.AssetTypeID = 1 
	where nav.DealID = d.dealid
	) as tbl where RowNumber = 1),0) --as DUFRFNAV
+ 
isnull((select sum(isnull(RolledForwardNAV,0)) as TotalRolledForwardNAV from ( 
	select ROW_NUMBER() over(PARTITION BY nav.DealID,nav.AssetID,nav.AssetTypeID order by nav.RolledForwardNAVDate desc,nav.dm_rolled_forward_nav_id desc) as RowNumber 
	,(case when isnull(nav.RolledForwardNAV,0)<=0 then 0 else isnull(nav.RolledForwardNAV,0) end) as RolledForwardNAV 
	from dm_rolled_forward_nav nav
	join dealunderlyingdirect dud on nav.DealID = dud.DealID and nav.AssetID = dud.securityid and nav.AssetTypeID = 2 and dud.securitytypeid = 1
	where nav.DealID = d.dealid 
	) as tbl where RowNumber = 1),0) as TotalRemainingValue --as DirectRFNAV
from deal d 
join dm_time_period p on d.EffectiveDate between p.FromDate and p.ToDate and p.dm_time_period_type_id = 1
join DealDetail det on det.dealid = d.dealid
join fund f on f.fundid = d.fundid 
join entity ent on ent.entityid = d.entityid 
where d.EffectiveDate >= '01/01/2010'
--) as tbl
--join dm_time_period p on tbl.EffectiveDate between p.FromDate and p.ToDate
----where tbl.EntityID = 13
--group by tbl.EntityID,tbl.EntityCode,tbl.FundID,tbl.FundName,p.FromDate
----order by p.FromDate asc
GO
/****** Object:  View [dbo].[dm_vw_Geography]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[dm_vw_Geography] AS
select geo.GeographyID 
,geo.Geography as 'DisplayName' 
,geo.EntityID 
,ent.EntityCode 
from [Geography] geo
join entity ent on geo.EntityID = ent.EntityID
GO
/****** Object:  View [dbo].[dm_vw_Industry]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[dm_vw_Industry] AS
select 
ind.IndustryID
,ind.EntityID
,ind.Industry as 'Title'
,ent.EntityCode 
from Industry ind
join entity ent on ind.EntityID = ent.EntityID
GO
/****** Object:  View [dbo].[dm_vw_Invesment_Distribution_Report]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--/****** Object:  View [dbo].[dm_vw_Invesment_Distribution_Report]    Script Date: 5/30/2020 4:44:59 PM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO


CREATE VIEW [dbo].[dm_vw_Invesment_Distribution_Report] AS
select
ent.EntityCode
,d.EntityID
,f.FundID
,f.FundName
,d.DealID
,d.DealName
,uf.UnderlyingFundID
,uf.FundName as 'UnderlyingFundName'
,0 as IssuerID
,'' as Direct
,ufcd.ReceivedDate as [Date]
,year(ufcd.ReceivedDate) as [Year]
,(isnull(cd.Amount, 0) / (case when isnull(fcr.ConversionFactor,0) = 0 then 1 else isnull(fcr.ConversionFactor,0) end)) as Base_Amount
,isnull(fcr.ConversionFactor,0) as FxRate
,cd.Amount
,cd.Amount as 'DistributionAmount'
,0 as 'InvesmentAmount'
,ctype.[Name] as 'Type'
,1 as IsDistribution
from cashdistribution cd
join underlyingfundcashdistribution ufcd on ufcd.underlyingfundcashdistributionid = cd.underlyingfundcashdistributionid
join underlyingfund uf on uf.underlyingfundid = cd.underlyingfundid
join deal d on cd.dealid = d.dealid
join fund f on d.fundid = f.fundid
join entity ent on ent.EntityID = d.EntityID
left outer join cashdistributiontype ctype on ctype.CashDistributionTypeID = cd.CashDistributionTypeID
left outer join fxtransaction fxt on fxt.FXTransactionSourceID = ufcd.UnderlyingFundCashDistributionID and fxt.FXTransactionSourceTypeID = 5
left outer join fxconversionrate fcr on fcr.FXConversionRateID = fxt.FXConversionRateID
union all
select
ent.EntityCode
,d.EntityID
,f.FundID
,f.FundName
,d.DealID
,d.DealName
,uf.UnderlyingFundID 
,uf.FundName as 'UnderlyingFundName'
,(CASE WHEN ufsd.SecurityTypeID =1 THEN equityIssuer.IssuerID ELSE (CASE WHEN ufsd.SecurityTypeID =2 THEN fiIssuer.IssuerID ELSE loanIssuer.IssuerID END) END ) as IssuerID
,(CASE WHEN ufsd.SecurityTypeID =1 THEN equityIssuer.Name ELSE (CASE WHEN ufsd.SecurityTypeID =2 THEN fiIssuer.Name ELSE loanIssuer.Name END) END ) as Direct
,ufsd.DistributionDate as [Date]
,year(ufsd.DistributionDate) as [Year]
,(isnull(ufsdItem.FMV, 0) / (case when isnull(fcr.ConversionFactor,0) = 0 then 1 else isnull(fcr.ConversionFactor,0) end)) as Base_Amount
,isnull(fcr.ConversionFactor,0) as FxRate
,ufsdItem.FMV as 'Amount'
,ufsdItem.FMV as 'DistributionAmount'
,0 as 'InvesmentAmount'
,'Stock Distribution' as 'DistributionType'
,1 as IsDistribution
from UnderlyingFundStockDistributionLineItem ufsdItem
join UnderlyingFundStockDistribution ufsd on ufsd.UnderlyingFundStockDistributionID = ufsdItem.UnderlyingFundStockDistributionID
join underlyingfund uf on uf.underlyingfundid = ufsdItem.underlyingfundid
join deal d on ufsdItem.dealid = d.dealid
join fund f on d.fundid = f.fundid
join entity ent on ent.EntityID = d.EntityID
left outer join Equity equity on equity.EquityID = ufsd.SecurityID
left outer join Issuer equityIssuer on equityIssuer.IssuerID = equity.IssuerID
left outer join FixedIncome fi on fi.FixedIncomeID = ufsd.SecurityID
left outer join Issuer fiIssuer on fiIssuer.IssuerID = fi.IssuerID
left outer join Loan loan on ufsd.SecurityID = loan.LoanID
left outer join Issuer loanIssuer on loanIssuer.IssuerID = loan.IssuerID
left outer join fxtransaction fxt on fxt.FXTransactionSourceID = ufsdItem.UnderlyingFundStockDistributionLineItemid and fxt.FXTransactionSourceTypeID = 10
left outer join fxconversionrate fcr on fcr.FXConversionRateID = fxt.FXConversionRateID
union all
select 
max(ent.EntityCode) as EntityCode
,max(d.EntityID) as EntityID
,max(f.FundID) as FundID
,max(f.FundName) as FundName
,max(d.DealID) as DealID
,max(d.DealName) as DealName
,max(uf.UnderlyingFundID) as UnderlyingFundID
,'' as 'UnderlyingFundName'
,(CASE WHEN max(ss.SecurityTypeID) =1 THEN max(equityIssuer.IssuerID) ELSE (CASE WHEN max(ss.SecurityTypeID) =2 THEN max(fiIssuer.IssuerID) ELSE max(loanIssuer.IssuerID) END) END ) as IssuerID
,(CASE WHEN max(ss.SecurityTypeID) =1 THEN max(equityIssuer.[Name]) ELSE (CASE WHEN max(ss.SecurityTypeID) =2 THEN max(fiIssuer.[Name]) ELSE max(loanIssuer.[Name]) END) END ) as Direct
,max(ss.SellDate) as [Date]
,Year(max(ss.SellDate)) as [Year]
,(max(isnull(his.FinalSaleAmount, 0)) / (case when max(isnull(fcr.ConversionFactor,0)) = 0 then 1 else max(isnull(fcr.ConversionFactor,0)) end)) as Base_Amount
,max(isnull(fcr.ConversionFactor,0)) as FxRate
,max(his.FinalSaleAmount) as 'Amount'
,max(his.FinalSaleAmount) as 'DistributionAmount'
,0 as 'InvesmentAmount'
--,(case when isnull(max(ufsdtype.[Name]),'') = '' then 'Regular Distribution' else isnull(max(ufsdtype.[Name]),'') end) as 'DistributionType'
,'Security Stock Distribution' as 'DistributionType'
,1 as IsDistribution
from UnderlyingFundStockDistributionLineItem ufsdItem
join underlyingfund uf on uf.underlyingfundid = ufsdItem.underlyingfundid
join deal d on ufsdItem.dealid = d.dealid
join fund f on d.fundid = f.fundid
join entity ent on ent.EntityID = d.EntityID
join securitylot lot on lot.securityacquisitionid = ufsdItem.underlyingfundstockdistributionlineitemid and lot.securityacquisitiontypeid = 2
join securitylothistory his on his.securitylotnumber = lot.securitylotnumber and his.securitylothistoryreason = 3
join securitysale ss on ss.securitysaleid = his.securitylothistoryreasonid
--left outer join underlyingfunddistributiontype ufsdtype on ufsdtype.underlyingfunddistributiontypeid = ufsditem.underlyingfunddistributiontypeid
left outer join saledistributiontype sdt on sdt.saledistributiontypeid = his.SecurityDistributionTypeID
left outer join Equity equity on equity.EquityID = ss.SecurityID
left outer join Issuer equityIssuer on equityIssuer.IssuerID = equity.IssuerID
left outer join FixedIncome fi on fi.FixedIncomeID = ss.SecurityID
left outer join Issuer fiIssuer on fiIssuer.IssuerID = fi.IssuerID
left outer join Loan loan on ss.SecurityID = loan.LoanID
left outer join Issuer loanIssuer on loanIssuer.IssuerID = loan.IssuerID
left outer join fxtransaction fxt on fxt.FXTransactionSourceID = ss.securitysaleid and fxt.FXTransactionSourceTypeID = 15
left outer join fxconversionrate fcr on fcr.FXConversionRateID = fxt.FXConversionRateID
group by ufsdItem.underlyingfundstockdistributionlineitemid
union all
select 
ent.EntityCode
,d.EntityID
,f.FundID
,f.FundName
,d.DealID
,d.DealName
,0 as UnderlyingFundID
,'' as 'UnderlyingFundName'
,(CASE WHEN uddd.SecurityTypeID =1 THEN equityIssuer.IssuerID ELSE (CASE WHEN uddd.SecurityTypeID =2 THEN fiIssuer.IssuerID ELSE loanIssuer.IssuerID END) END ) as IssuerID
,(CASE WHEN uddd.SecurityTypeID =1 THEN equityIssuer.Name ELSE (CASE WHEN uddd.SecurityTypeID =2 THEN fiIssuer.Name ELSE loanIssuer.Name END) END ) as Direct
,uddd.DistributionDate as [Date]
,Year(uddd.DistributionDate) as [Year]
,(isnull(dd.Amount, 0) / (case when isnull(fcr.ConversionFactor,0) = 0 then 1 else isnull(fcr.ConversionFactor,0) end)) as Base_Amount
,isnull(fcr.ConversionFactor,0) as FxRate
,dd.Amount as 'Amount'
,dd.Amount as 'DistributionAmount'
,0 as 'InvesmentAmount'
,ctype.Name as 'DistributionType'
,1 as IsDistribution
from DividendDistribution dd
join UnderlyingDirectDividendDistribution uddd on uddd.UnderlyingDirectDividendDistributionID = dd.UnderlyingDirectDividendDistributionID
join deal d on dd.dealid = d.dealid
join fund f on d.fundid = f.fundid
join entity ent on ent.EntityID = d.EntityID
left outer join CashDistributionType ctype on ctype.CashDistributionTypeID = dd.CashDistributionTypeID
left outer join Equity equity on equity.EquityID = uddd.SecurityID
left outer join Issuer equityIssuer on equityIssuer.IssuerID = equity.IssuerID
left outer join FixedIncome fi on fi.FixedIncomeID = uddd.SecurityID
left outer join Issuer fiIssuer on fiIssuer.IssuerID = fi.IssuerID
left outer join Loan loan on uddd.SecurityID = loan.LoanID
left outer join Issuer loanIssuer on loanIssuer.IssuerID = loan.IssuerID
left outer join fxtransaction fxt on fxt.FXTransactionSourceID = dd.DividendDistributionID and fxt.FXTransactionSourceTypeID = 13
left outer join fxconversionrate fcr on fcr.FXConversionRateID = fxt.FXConversionRateID
union all
select 
ent.EntityCode
,d.EntityID
,f.FundID
,f.FundName
,d.DealID
,d.DealName
,0 as UnderlyingFundID
,'' as 'UnderlyingFundName'
,(CASE WHEN sale.SecurityTypeID =1 THEN equityIssuer.IssuerID ELSE (CASE WHEN sale.SecurityTypeID =2 THEN fiIssuer.IssuerID ELSE loanIssuer.IssuerID END) END ) as IssuerID
,(CASE WHEN sale.SecurityTypeID =1 THEN equityIssuer.Name ELSE (CASE WHEN sale.SecurityTypeID =2 THEN fiIssuer.Name ELSE loanIssuer.Name END) END ) as Direct
,sale.SellDate as [Date]
,Year(sale.SellDate) as [Year]
,(isnull(sitem.FinalSaleAmount, 0) / (case when isnull(fcr.ConversionFactor,0) = 0 then 1 else isnull(fcr.ConversionFactor,0) end)) as Base_Amount
,isnull(fcr.ConversionFactor,0) as FxRate
,sitem.FinalSaleAmount as 'Amount'
,sitem.FinalSaleAmount as 'DistributionAmount'
,0 as 'InvesmentAmount'
,'SecuritySale' as 'DistributionType'
,1 as IsDistribution
from SecuritySale sale
join SecuritySaleLineItem sitem on sitem.SecuritySaleID = sale.SecuritySaleID
join deal d on sitem.dealid = d.dealid
join fund f on d.fundid = f.fundid
join entity ent on ent.EntityID = d.EntityID
left outer join Equity equity on equity.EquityID = sale.SecurityID
left outer join Issuer equityIssuer on equityIssuer.IssuerID = equity.IssuerID
left outer join FixedIncome fi on fi.FixedIncomeID = sale.SecurityID
left outer join Issuer fiIssuer on fiIssuer.IssuerID = fi.IssuerID
left outer join Loan loan on sale.SecurityID = loan.LoanID
left outer join Issuer loanIssuer on loanIssuer.IssuerID = loan.IssuerID
left outer join fxtransaction fxt on fxt.FXTransactionSourceID = sale.SecuritySaleID and fxt.FXTransactionSourceTypeID = 15
left outer join fxconversionrate fcr on fcr.FXConversionRateID = fxt.FXConversionRateID
union all
select 
ent.EntityCode
,d.EntityID
,f.FundID
,f.FundName
,d.DealID
,d.DealName
,uf.UnderlyingFundID
,uf.FundName
,0 as IssuerID
,'' as Direct
,ufs.SellDate as [Date]
,Year(ufs.SellDate) as [Year]
,(isnull(ufsl.NetSellPrice, 0) / (case when isnull(fcr.ConversionFactor,0) = 0 then 1 else isnull(fcr.ConversionFactor,0) end)) as Base_Amount
,isnull(fcr.ConversionFactor,0) as FxRate
,ufsl.NetSellPrice as 'Amount'
,ufsl.NetSellPrice as 'DistributionAmount'
,0 as 'InvesmentAmount'
,ufstype.Name as 'DistributionType'
,1 as IsDistribution
from underlyingfundsalelineitem ufsl
join underlyingfundsale ufs on ufsl.underlyingfundsaleid = ufs.underlyingfundsaleid
join underlyingfund uf on uf.underlyingfundid = ufs.underlyingfundid
join deal d on ufsl.dealid = d.dealid
join fund f on ufs.fundid = f.fundid
join entity ent on ent.EntityID = d.EntityID
left outer join underlyingfundsaledistributiontype ufstype on ufstype.underlyingfundsaledistributiontypeid = ufs.underlyingfundsaledistributiontypeid
left outer join fxtransaction fxt on fxt.FXTransactionSourceID = ufsl.underlyingfundsalelineitemid and fxt.FXTransactionSourceTypeID = 22
left outer join fxconversionrate fcr on fcr.FXConversionRateID = fxt.FXConversionRateID
/* START INVESTMENT */
/* START INVESTMENT */
union all  /* union investment */
/* START INVESTMENT */
/* START INVESTMENT */
select 
ent.EntityCode
,d.EntityID
,f.FundID
,f.FundName
,d.DealID
,d.DealName
,uf.UnderlyingFundID
,uf.FundName as 'UnderlyingFundName'
,0 as IssuerID
,'' as Direct
,ufccItem.PaidON as [Date] -- ,ufccItem.ReceivedDate as EffectiveDate
,Year(ufccItem.PaidON) as [Year]
,(isnull(ufccItem.TotalAmount,0) / (case when isnull(fcr.ConversionFactor,0) = 0 then 1 else isnull(fcr.ConversionFactor,0) end)) as Base_Amount
,isnull(fcr.ConversionFactor,0) as FX_Rate
,ufccItem.TotalAmount as Amount
,0 as 'DistributionAmount'
,ufccItem.TotalAmount as 'InvesmentAmount'
,'Capital Call' as Type
,0 as IsDistribution
from underlyingFundCapitalCallLineItem ufccItem
join UnderlyingFundCapitalCall ufcc on ufccItem.UnderlyingFundCapitalCallID = ufcc.UnderlyingFundCapitalCallID
join UnderlyingFund uf on ufccItem.UnderlyingFundID = uf.UnderlyingFundID and (isnull(uf.IsArchive,0)=0)
join deal d on ufccItem.DealID = d.DealID	
join ENTITY ent on ent.EntityID = d.EntityID
join fund f on d.FundID = f.FundID and (isnull(f.IsHide,0)=0)
left outer join fxtransaction fxt on fxt.FXTransactionSourceID = ufccItem.UnderlyingFundCapitalCallLineItemID and fxt.FXTransactionSourceTypeID = 4
left outer join fxconversionrate fcr on fcr.FXConversionRateID = fxt.FXConversionRateID
--union all 
--select 
--ent.EntityCode
--,d.EntityID
--,f.FundID
--,f.FundName
--,d.DealID
--,d.DealName
--,uf.UnderlyingFundID as UnderlyingFundID
--,uf.FundName as 'UnderlyingFundName'
--,0 as IssuerID
--,'' as Direct
--,dist.DistributionDate as DueDate --,dcc.Date as EffectiveDate
--,Year(dist.DistributionDate) as [Year]
--,item.Amount as Base_Amount
--,0 as FX_Rate
--,item.Amount as Amount
--,0 as 'DistributionAmount'
--,item.Amount as 'InvesmentAmount'
--,'Closing Costs' as Type
--,0 as IsDistribution
--from dealclosingcostdistributionlineitem item
--join dealclosingcostdistribution dist on dist.dealclosingcostdistributionid = item.dealclosingcostdistributionid
----join dealclosingCost dcc on dcc.DealClosingCostID = dist.DealClosingCostID 
--join dealunderlyingfund duf on duf.dealunderlyingfundid = item.dealunderlyingfundid
--join underlyingfund uf on duf.underlyingfundid = uf.underlyingfundid
--join deal d on d.DealID = duf.DealID	
--join ENTITY ent on ent.EntityID = d.EntityID
--join fund f on d.FundID = f.FundID and (isnull(f.IsHide,0)=0)
--union all
--select 
--ent.EntityCode
--,d.EntityID
--,f.FundID
--,f.FundName
--,d.DealID
--,d.DealName
--,0 as UnderlyingFundID
--,'' as 'UnderlyingFundName'
--,CASE WHEN dud.SecurityTypeID = 1 THEN isnull(equityIssuer.IssuerID,'') ELSE isnull(fiIssuer.IssuerID,'') END as IssuerID
--,CASE WHEN dud.SecurityTypeID = 1 THEN isnull(equityIssuer.Name,'') ELSE isnull(fiIssuer.Name,'') END as Direct
--,dist.DistributionDate as DueDate --,dcc.Date as EffectiveDate
--,Year(dist.DistributionDate) as [Year]
--,item.Amount as Base_Amount
--,0 as FX_Rate
--,item.Amount as Amount
--,0 as 'DistributionAmount'
--,item.Amount as 'InvesmentAmount'
--,'Closing Costs' as Type
--,0 as IsDistribution
--from dealclosingcostdistributionlineitem item
--join dealclosingcostdistribution dist on dist.dealclosingcostdistributionid = item.dealclosingcostdistributionid
----join dealclosingCost dcc on dcc.DealClosingCostID = dist.DealClosingCostID 
--join DealUnderlyingDirect dud on dud.DealUnderlyingDirectID = item.DealUnderlyingDirectID
--left outer join Equity e on e.EquityID = dud.SecurityID 
--left outer join Issuer equityIssuer on equityIssuer.IssuerID = e.IssuerID 
--left outer join fixedIncome fi on fi.FixedIncomeID = dud.SecurityID
--left outer join Issuer fiIssuer on fiIssuer.IssuerID = fi.IssuerID
--join deal d on d.DealID = dud.DealID	
--join ENTITY ent on ent.EntityID = d.EntityID
--join fund f on d.FundID = f.FundID and (isnull(f.IsHide,0)=0)
union all 
select 
ent.EntityCode
,d.EntityID
,f.FundID
,f.FundName
,d.DealID
,d.DealName
,uf.UnderlyingFundID
,uf.FundName as 'UnderlyingFundName'
,0 as IssuerID
,'' as Direct
,(case when duf.EffectiveDate is null then duf.RecordDate else duf.EffectiveDate end) as DueDate
,Year((case when duf.EffectiveDate is null then duf.RecordDate else duf.EffectiveDate end)) as [Year]
,(isnull(duf.NetPurchasePrice,0) / (case when isnull(fcr.ConversionFactor,0) = 0 then 1 else isnull(fcr.ConversionFactor,0) end)) as Base_Amount
,isnull(fcr.ConversionFactor,0) as FX_Rate
,duf.NetPurchasePrice as Amount
,0 as 'DistributionAmount'
,duf.NetPurchasePrice as 'InvesmentAmount'
,'Net Purchase' as Type
,0 as IsDistribution
from DealUnderlyingFund duf
join UnderlyingFund uf on duf.UnderlyingFundID = uf.UnderlyingFundID and isnull(uf.IsArchive,0)=0
join deal d on duf.DealID = d.DealID	
join ENTITY ent on ent.EntityID = d.EntityID
join fund f on d.FundID = f.FundID and (isnull(f.IsHide,0)=0)
left outer join DealClosing dc on duf.DealClosingID = dc.DealClosingID
left outer join fxtransaction fxt on fxt.FXTransactionSourceID = duf.DealUnderlyingFundID and fxt.FXTransactionSourceTypeID = 1
left outer join fxconversionrate fcr on fcr.FXConversionRateID = fxt.FXConversionRateID
union all 
select 
ent.EntityCode
,d.EntityID
,f.FundID
,f.FundName
,d.DealID
,d.DealName
,0 as UnderlyingFundID
,'' as 'UnderlyingFundName'
,CASE WHEN dud.SecurityTypeID = 1 THEN isnull(equityIssuer.IssuerID,'') ELSE isnull(fiIssuer.IssuerID,'') END as IssuerID
,CASE WHEN dud.SecurityTypeID = 1 THEN isnull(equityIssuer.Name,'') ELSE isnull(fiIssuer.Name,'') END as Direct
,CASE WHEN dud.DealClosingID > 0 THEN dc.CloseDate ELSE '1/2/1900' END as DueDate
,Year(CASE WHEN dud.DealClosingID > 0 THEN dc.CloseDate ELSE '1/2/1900' END) as [Year]
,((isnull(dud.FMV,0))/ (case when isnull(fcr.ConversionFactor,0) = 0 then 1 else isnull(fcr.ConversionFactor,0) end)) - isnull(dud.PostRecordCashFlow,0) as Base_Amount
,isnull(fcr.ConversionFactor,0) as FX_Rate
,(isnull(dud.FMV,0) - isnull(dud.PostRecordCashFlow,0)) as Amount
,0 as 'DistributionAmount'
,(isnull(dud.FMV,0) - isnull(dud.PostRecordCashFlow,0)) as 'InvesmentAmount'
,'FMV' as Type
,0 as IsDistribution
from dealUnderlyingDirect dud
join deal d on dud.DealID = d.DealID	
join ENTITY ent on ent.EntityID = d.EntityID
join fund f on d.FundID = f.FundID and (isnull(f.IsHide,0)=0)
left outer join Equity e on e.EquityID = dud.SecurityID and (isnull(e.IsArchive,0)=0)
left outer join Issuer equityIssuer on equityIssuer.IssuerID = e.IssuerID and (isnull(equityIssuer.IsArchive,0)=0)
left outer join fixedIncome fi on fi.FixedIncomeID = dud.SecurityID and (isnull(fi.IsArchive,0)=0)
left outer join Issuer fiIssuer on fiIssuer.IssuerID = fi.IssuerID and (isnull(fiIssuer.IsArchive,0)=0)
left outer join DealClosing dc on dud.DealClosingID = dc.DealClosingID
left outer join fxtransaction fxt on fxt.FXTransactionSourceID = dud.DealUnderlyingDirectID and fxt.FXTransactionSourceTypeID = 2
left outer join fxconversionrate fcr on fcr.FXConversionRateID = fxt.FXConversionRateID
where isnull(dud.IsFollowOn,0)=0
and dud.IsActive = 1
union all 
select 
ent.EntityCode
,d.EntityID
,f.FundID
,f.FundName
,d.DealID
,d.DealName
,0 as UnderlyingFundID
,'' as 'UnderlyingFundName'
,CASE WHEN fe.SecurityTypeID = 1 THEN isnull(equityIssuer.IssuerID,'') ELSE isnull(fiIssuer.IssuerID,'') END as IssuerID
,CASE WHEN fe.SecurityTypeID = 1 THEN isnull(equityIssuer.Name,'') ELSE isnull(fiIssuer.Name,'') END as Direct
,fe.[Date] as DueDate
,Year(fe.[Date]) as [Year]
,(isnull(fe.Amount,0) / (case when isnull(fcr.ConversionFactor,0) = 0 then 1 else isnull(fcr.ConversionFactor,0) end)) as Base_Amount
,isnull(fcr.ConversionFactor,0) as FX_Rate
,fe.Amount as Amount
,0 as 'DistributionAmount'
,fe.Amount as 'InvesmentAmount'
,'Manual Cash Transaction' as Type
,0 as IsDistribution
from fundExpense fe
join deal d on fe.DealID = d.DealID	
join ENTITY ent on ent.EntityID = d.EntityID
join fund f on d.FundID = f.FundID and (isnull(f.IsHide,0)=0)
left outer join UnderlyingFund uf on fe.UnderlyingFundID = uf.UnderlyingFundID and (isnull(uf.IsArchive,0)=0)
left outer join Equity e on e.EquityID = fe.SecurityID and (isnull(e.IsArchive,0)=0)
left outer join Issuer equityIssuer on equityIssuer.IssuerID = e.IssuerID and (isnull(equityIssuer.IsArchive,0)=0)
left outer join fixedIncome fi on fi.FixedIncomeID = fe.SecurityID and (isnull(fi.IsArchive,0)=0)
left outer join Issuer fiIssuer on fiIssuer.IssuerID = fi.IssuerID and (isnull(fiIssuer.IsArchive,0)=0)
left outer join fxtransaction fxt on fxt.FXTransactionSourceID = fe.FundExpenseID and fxt.FXTransactionSourceTypeID = 11
left outer join fxconversionrate fcr on fcr.FXConversionRateID = fxt.FXConversionRateID
union all 
select 
ent.EntityCode
,d.EntityID
,f.FundID
,f.FundName
,d.DealID
,d.DealName
,0 as UnderlyingFundID
,'' as 'UnderlyingFundName'
,CASE WHEN followOn.SecurityTypeID = 1 THEN isnull(equityIssuer.IssuerID,'') ELSE isnull(fiIssuer.IssuerID,'') END as IssuerID
,CASE WHEN followOn.SecurityTypeID = 1 THEN isnull(equityIssuer.Name,'') ELSE isnull(fiIssuer.Name,'') END as Direct
,followOn.RecordDate as DueDate
,Year(followOn.RecordDate) as [Year]
,(isnull(followOn.FMV,0) / (case when isnull(fcr.ConversionFactor,0) = 0 then 1 else isnull(fcr.ConversionFactor,0) end)) as Base_Amount
,isnull(fcr.ConversionFactor,0) as FX_Rate
,followOn.FMV as Amount
,0 as 'DistributionAmount'
,followOn.FMV as 'InvesmentAmount'
,'Follow On' as Type
,0 as IsDistribution
from dealUnderlyingDirect followOn
join deal d on followOn.DealID = d.DealID	
join ENTITY ent on ent.EntityID = d.EntityID
join fund f on d.FundID = f.FundID and (isnull(f.IsHide,0)=0)
left outer join Equity e on e.EquityID = followOn.SecurityID and (isnull(e.IsArchive,0)=0)
left outer join Issuer equityIssuer on equityIssuer.IssuerID = e.IssuerID and (isnull(equityIssuer.IsArchive,0)=0)
left outer join fixedIncome fi on fi.FixedIncomeID = followOn.SecurityID and (isnull(fi.IsArchive,0)=0)
left outer join Issuer fiIssuer on fiIssuer.IssuerID = fi.IssuerID and (isnull(fiIssuer.IsArchive,0)=0)
left outer join fxtransaction fxt on fxt.FXTransactionSourceID = followOn.DealUnderlyingDirectID and fxt.FXTransactionSourceTypeID = 2
left outer join fxconversionrate fcr on fcr.FXConversionRateID = fxt.FXConversionRateID
where followOn.IsSecurityConversionDetail = 0 and followOn.IsFollowOn=1
and followon.IsActive = 1
GO
/****** Object:  View [dbo].[dm_vw_Investor_Contribution_Distribution]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [dbo].[dm_vw_Investor_Contribution_Distribution]
as
select ent.EntityCode,f.FundName as Fund,inv.InvestorName as Investor,cc.CapitalCallDate as [Date]
,item.CapitalAmountCalled as [Total Contribution]
,0 as [Total Distribution]
,0 as [Dry Powder]
,'Total Contribution' as [Type] 
,DATEPART(year,cc.CapitalCallDate) as [Year]
,DATEPART(QUARTER,cc.CapitalCallDate) as [Quarter]
,DATEPART(MONTH,cc.CapitalCallDate) as [Month]
,DATEPART(DAY,cc.CapitalCallDate) as [Day]
,cast(DATEPART(QUARTER,cc.CapitalCallDate) as varchar(5)) + ' Q' + cast(DATEPART(year,cc.CapitalCallDate) as varchar(10)) as [Quarterly] 
,(case when datepart(month,cc.CapitalCallDate) <= 6 then '1' else '2' end) + ' H' + cast(DATEPART(year,cc.CapitalCallDate) as varchar(10)) as [HalfYearly]
from CapitalCallLineItem item
join CapitalCall cc on cc.CapitalCallID = item.CapitalCallID 
join Investor inv on inv.InvestorID = item.InvestorID 
join Fund f on f.FundID = cc.FundID  and isnull(f.IsHide,0) = 0
join ENTITY ent on ent.EntityID = f.EntityID 
union all
select ent.EntityCode,f.FundName as Fund,inv.InvestorName as Investor,cd.CapitalDistributionDate as [Date]
,0 as [Total Contribution]
,item.DistributionAmount as [Total Distribution]
,0 as [Dry Powder]
,'Total Distribution' as [Type] 
,DATEPART(year,cd.CapitalDistributionDate) as [Year]
,DATEPART(QUARTER,cd.CapitalDistributionDate) as [Quarter]
,DATEPART(MONTH,cd.CapitalDistributionDate) as [Month]
,DATEPART(DAY,cd.CapitalDistributionDate) as [Day]
,cast(DATEPART(QUARTER,cd.CapitalDistributionDate) as varchar(5)) + ' Q' + cast(DATEPART(year,cd.CapitalDistributionDate) as varchar(10)) as [Quarterly] 
,(case when datepart(month,cd.CapitalDistributionDate) <= 6 then '1' else '2' end) + ' H' + cast(DATEPART(year,cd.CapitalDistributionDate) as varchar(10)) as [HalfYearly]
from CapitalDistributionLineItem item
join CapitalDistribution cd on cd.CapitalDistributionID = item.CapitalDistributionID 
join Investor inv on inv.InvestorID = item.InvestorID 
join Fund f on f.FundID = cd.FundID  and isnull(f.IsHide,0) = 0
join ENTITY ent on ent.EntityID = f.EntityID 

union all
select ent.EntityCode,f.FundName as Fund,inv.InvestorName as Investor,item.CommittedDate as [Date]
,0 as [Total Contribution]
,0 as [Total Distribution]
,item.Amount as [Dry Powder]
,'Dry Powder' as [Type] 
,DATEPART(year,item.CommittedDate) as [Year]
,DATEPART(QUARTER,item.CommittedDate) as [Quarter]
,DATEPART(MONTH,item.CommittedDate) as [Month]
,DATEPART(DAY,item.CommittedDate) as [Day]
,cast(DATEPART(QUARTER,item.CommittedDate) as varchar(5)) + ' Q' + cast(DATEPART(year,item.CommittedDate) as varchar(10)) as [Quarterly] 
,(case when datepart(month,item.CommittedDate) <= 6 then '1' else '2' end) + ' H' + cast(DATEPART(year,item.CommittedDate) as varchar(10)) as [HalfYearly]
from InvestorFundTransaction item
join InvestorFund ivf on ivf.InvestorFundID = item.InvestorFundID
join Investor inv on inv.InvestorID = ivf.InvestorID 
join Fund f on f.FundID = ivf.FundID and isnull(f.IsHide,0) = 0
join ENTITY ent on ent.EntityID = f.EntityID
GO
/****** Object:  View [dbo].[dm_vw_Strategy]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[dm_vw_Strategy] AS
select sta.StrategyID,sta.EntityID,sta.StrategyName,sta.StrategyAllocationTypeID,staType.[Name] as StrategyAllocationType,sta.[Enabled],ent.EntityCode from Strategy sta
join entity ent on sta.EntityID = ent.EntityID 
join StrategyAllocationType staType on staType.StrategyAllocationTypeID = sta.StrategyAllocationTypeID
GO
/****** Object:  View [dbo].[dm_vw_UnderlyingFund]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[dm_vw_UnderlyingFund] AS
select 
uf.UnderlyingFundID
,uf.EntityID
,isnull(uf.IssuerID, 0) as IssuerID
,isnull(issuer.[Name], '') as IssuerName
,uf.FundName
,isnull(uf.FundTypeID, 0) as FundTypeID
,isnull(fundType.[Name], '') as FundTypeName
,uf.VintageYear
,uf.TotalSize
,uf.TerminationDate
,isnull(uf.ReportingFrequencyID, 0) as ReportingFrequencyID
,isnull(rf.ReportingFrequency, '') as ReportingFrequency
,isnull(uf.ReportingTypeID, 0) as ReportingTypeID
,isnull(rt.Reporting, '') as Reporting
,uf.LegalFundName
,isnull(uf.ShareClassTypeID,0) as ShareClassTypeID
,isnull(sct.ShareClass, '') as ShareClass
,isnull(inv.InvestmentTypeID, 0) as InvestmentTypeID
,isnull(inv.Investment, '') as Investment
,isnull(uf.VehicleTypeID, 0) as VehicleTypeID
,isnull(veh.Vehicle, '') as Vehicle
,isnull(uf.AssetCategoryID, 0) as AssetCategoryID
,isnull(ac.[Name], '') as AssetCategoryName
,ent.EntityCode
from UnderlyingFund uf
join entity ent on uf.EntityID = ent.EntityID 
left outer join Issuer issuer on uf.IssuerID = issuer.IssuerID
left outer join UnderlyingFundType fundType on uf.FundTypeID = fundType.UnderlyingFundTypeID
left outer join ReportingFrequency rf on uf.ReportingFrequencyID = rf.ReportingFrequencyID
left outer join ReportingType rt on uf.ReportingTypeID = rt.ReportingTypeID
left outer join ShareClassType sct on uf.ShareClassTypeID = sct.ShareClassTypeID
left outer join InvestmentType inv on uf.InvestmentTypeID = inv.InvestmentTypeID
left outer join VehicleType veh on uf.VehicleTypeID = veh.VehicleTypeID
left outer join AssetCategory ac on uf.AssetCategoryID = ac.AssetCategoryID
GO
/****** Object:  View [dbo].[dm_vw_XIRR_DataPoints]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [dbo].[dm_vw_XIRR_DataPoints]
AS
select Fund,DealNumber,DealName,[Date],Sum(isnull(Amount,0)) as Amount,[Description],SortOrder,UnderlyingFund,Direct,Symbol,FundID,DealID,UnderlyingFundID,IssuerID,SecurityTypeID,SecurityID,EntityID,EntityCode,PartitionNumber,Max(KeyID) as KeyID from (
--select 
--f.FundName as Fund
--,d.DealNumber
--,d.DealName
--,case when Year(item.DistributionDate) <= 1900 then dcc.[Date] else item.DistributionDate end as [Date]
--,isnull(item.Amount,0) * -1 as Amount
--,'Deal Expense Distribution' as [Description]
--,1 as SortOrder
--,uf.FundName as UnderlyingFund
--,'' as Direct
--,'' as Symbol
--,f.FundID
--,dcc.DealID
--,uf.UnderlyingFundID as UnderlyingFundID
--,0 as IssuerID
--,0 as SecurityTypeID
--,0 as SecurityID
--,ent.EntityCode
--,0 as PartitionNumber
--,cast(d.DealID as varchar(max)) + '_1_' + cast(uf.UnderlyingFundID as varchar(max)) as KeyID

--,d.EntityID
----,item.DealClosingCostDistributionLineItemID as ID
--from DealClosingCostDistributionLineItem item
--join DealClosingCostDistribution dist on dist.DealClosingCostDistributionID = item.DealClosingCostDistributionID
--join dealclosingcost dcc on dcc.DealClosingCostID = dist.DealClosingCostID
--join DealUnderlyingFund duf on duf.DealUnderlyingFundID = item.DealUnderlyingFundID
--join UnderlyingFund uf on uf.UnderlyingFundID = duf.UnderlyingFundID
--join deal d on d.dealid = dcc.dealid 
--join fund f on f.fundid = d.fundid and isnull(f.ishide,0) = 0
--join entity ent on ent.EntityID = d.EntityID
--union all
--select 
--f.FundName as Fund
--,d.DealNumber
--,d.DealName
--,item.DistributionDate as [Date]
--,isnull(item.Amount,0) * -1 as Amount
--,'Deal Expense Distribution' as [Description]
--,1 as SortOrder
--,'' as UnderlyingFund
--,iss.[Name] as Direct
--,isnull(eq.Symbol,'') as Symbol 
--,f.FundID
--,dcc.DealID
--,0 as UnderlyingFundID
--,iss.IssuerID as IssuerID
--,dir.SecurityTypeID as SecurityTypeID
--,dir.SecurityID as SecurityID
--,ent.EntityCode
--,0 as PartitionNumber
--,cast(d.DealID as varchar(max)) + '_2_' + cast(dir.SecurityID as varchar(max)) as KeyID

--,d.EntityID
----,dcc.DealClosingCostID as ID
--from DealClosingCostDistributionLineItem item
--join DealClosingCostDistribution dist on dist.DealClosingCostDistributionID = item.DealClosingCostDistributionID
--join dealclosingcost dcc on dcc.DealClosingCostID = dist.DealClosingCostID
--join DealUnderlyingDirect dir on dir.DealUnderlyingDirectID = item.DealUnderlyingDirectID 
--join Equity eq on eq.EquityID = dir.SecurityID and dir.SecurityTypeID = 1
--join Issuer iss on eq.IssuerID = iss.IssuerID 
--join deal d on d.dealid = dcc.dealid 
--join fund f on f.fundid = d.fundid and isnull(f.ishide,0) = 0
--join entity ent on ent.EntityID = d.EntityID
--union all
select 
f.FundName as Fund
,d.DealNumber
,d.DealName
,dc.CloseDate as [Date]
,isnull(dir.FMV,0) * -1 as Amount
,'DealUnderlyingDirect' as [Description]
,2 as SortOrder
,'' as UnderlyingFund
,iss.[Name] as 'Direct'
,e.Symbol
,f.FundID
,dir.DealID
,0 as UnderlyingFundID
,iss.IssuerID as IssuerID
,dir.SecurityTypeID as SecurityTypeID
,dir.SecurityID as SecurityID
,ent.EntityCode
,0 as PartitionNumber
,cast(d.DealID as varchar(max)) + '_2_' + cast(dir.SecurityID as varchar(max)) as KeyID

,d.EntityID
--,dir.DealUnderlyingDirectID as ID
from DealUnderlyingDirect dir
join deal d on d.dealid = dir.dealid 
join fund f on f.fundid = d.fundid and isnull(f.ishide,0) = 0
left outer join Equity e on e.EquityID = dir.SecurityID and dir.SecurityTypeID = 1
left outer join Issuer iss on iss.IssuerID = e.IssuerID
join DealClosing dc on dc.DealClosingID = dir.DealClosingID
join entity ent on ent.EntityID = d.EntityID
where isnull(dir.IsMultipleClose,0) = 0
and isnull(dir.IsFollowOn,0) = 0
union all
select 
f.FundName as Fund
,d.DealNumber
,d.DealName
,dir.RecordDate as [Date]
,isnull(dir.FMV,0) * -1 as Amount
,'FollowOn' as [Description]
,2 as SortOrder
,'' as UnderlyingFund
,iss.[Name] as 'Direct'
,e.Symbol 
,f.FundID
,dir.DealID
,0 as UnderlyingFundID
,iss.IssuerID as IssuerID
,dir.SecurityTypeID as SecurityTypeID
,dir.SecurityID as SecurityID
,ent.EntityCode
,0 as PartitionNumber
,cast(d.DealID as varchar(max)) + '_2_' + cast(dir.SecurityID as varchar(max)) as KeyID

,d.EntityID
--,dir.DealUnderlyingDirectID as ID
from DealUnderlyingDirect dir
join deal d on d.dealid = dir.dealid 
join fund f on f.fundid = d.fundid and isnull(f.ishide,0) = 0
left outer join Equity e on e.EquityID = dir.SecurityID and dir.SecurityTypeID = 1
left outer join Issuer iss on iss.IssuerID = e.IssuerID
left outer join DealClosing dc on dc.DealClosingID = dir.DealClosingID
join entity ent on ent.EntityID = d.EntityID
where isnull(dir.IsFollowOn,0) = 1
union all
select 
f.FundName as Fund
,d.DealNumber
,d.DealName
,dc.CloseDate as [Date]
,isnull(dirclo.NetFMV,0) * -1 as Amount
,(case when dir.IsFollowOn = 1 then 'FollowOn' else 'DealUnderlyingDirect' end) as [Description]
,2 as SortOrder
,'' as UnderlyingFund
,iss.[Name] as 'Direct'
,e.Symbol
,f.FundID
,dir.DealID
,0 as UnderlyingFundID
,iss.IssuerID
,dir.SecurityTypeID
,dir.SecurityID
,ent.EntityCode
,0 as PartitionNumber
,cast(d.DealID as varchar(max)) + '_2_' + cast(dir.SecurityID as varchar(max)) as KeyID

,d.EntityID
--,dir.DealUnderlyingDirectID as ID
from DealUnderlyingDirect dir
join deal d on d.dealid = dir.dealid 
join fund f on f.fundid = d.fundid and isnull(f.ishide,0) = 0
left outer join Equity e on e.EquityID = dir.SecurityID and dir.SecurityTypeID = 1
left outer join Issuer iss on iss.IssuerID = e.IssuerID
join DealUnderlyingDirectClosing dirclo on dirclo.DealUnderlyingDirectID = dir.DealUnderlyingDirectID
join DealClosing dc on dc.DealClosingID = dirclo.DealClosingID
join entity ent on ent.EntityID = d.EntityID
where isnull(dir.IsMultipleClose,0) = 1
--union all
--select 
----case when isnull(duf.DealClosingID,0) > 0 then dc.CloseDate else (case when isnull(duf.EffectiveDate,'01/01/1900')<='01/01/1900' then duf.RecordDate else duf.EffectiveDate end) end
--f.FundName as Fund
--,d.DealNumber
--,d.DealName
--,dc.CloseDate as [Date]
--,isnull(duf.NetPurchasePrice,0) * -1
--,'DealUndelyingFund' as [Description]
--,3 as SortOrder
--,uf.FundName as UnderlyingFund
--,'' as Direct
--,'' as Symbol
--,f.FundID
--,duf.DealID
--,duf.UnderlyingFundID
--,0 as IssuerID
--,0 as SecurityTypeID
--,0 as SecurityID
--,ent.EntityCode
--,0 as PartitionNumber
--,cast(d.DealID as varchar(max)) + '_1_' + cast(uf.UnderlyingFundID as varchar(max)) as KeyID

--,d.EntityID
----,duf.DealUnderlyingFundID as ID
--from DealUnderlyingFund duf
--join deal d on d.dealid = duf.dealid 
--join fund f on f.fundid = d.fundid and isnull(f.ishide,0) = 0
--join underlyingfund uf on duf.UnderlyingFundID = uf.UnderlyingFundID
--join DealClosing dc on dc.DealClosingID = duf.DealClosingID
--join entity ent on ent.EntityID = d.EntityID
--where isnull(duf.IsMultipleClose,0) = 0
--union all
--select 
--f.FundName as Fund
--,d.DealNumber
--,d.DealName
--,dc.CloseDate as [Date]
--,isnull(dufc.NetPurchasePrice,0) * -1 as Amount
--,'DealUndelyingFund' as [Description]
--,3 as SortOrder
--,uf.FundName as UnderlyingFund
--,'' as Direct
--,'' as Symbol 
--,f.FundID
--,duf.DealID
--,duf.UnderlyingFundID
--,0 as IssuerID
--,0 as SecurityTypeID
--,0 as SecurityID
--,ent.EntityCode
--,0 as PartitionNumber
--,cast(d.DealID as varchar(max)) + '_1_' + cast(uf.UnderlyingFundID as varchar(max)) as KeyID

--,d.EntityID
----,duf.DealUnderlyingFundID as ID
--from DealUnderlyingFund duf
--join deal d on d.dealid = duf.dealid 
--join fund f on f.fundid = d.fundid and isnull(f.ishide,0) = 0
--join underlyingfund uf on duf.UnderlyingFundID = uf.UnderlyingFundID
--join dealunderlyingfundclosing dufc on dufc.DealUnderlyingFundID = duf.DealUnderlyingFundID
--join dealclosing dc on dc.DealClosingID = dufc.DealClosingID
--join entity ent on ent.EntityID = d.EntityID
--where isnull(duf.IsMultipleClose,0) = 1
union all
select 
f.FundName as Fund
,d.DealNumber
,d.DealName
,df.FundingDate as [Date]
,isnull(df.FundingAmount,0) * -1 as Amount
,'Funding' as [Description]
,3 as SortOrder
,'' as UnderlyingFund
,'' as Direct
,'' as Symbol 
,f.FundID
,d.DealID
,0 as UnderlyingFundID
,0 as IssuerID
,0 as SecurityTypeID
,0 as SecurityID
,ent.EntityCode
,0 as PartitionNumber
,cast(d.DealID as varchar(max)) + '_3_' + cast(df.DealFundingID as varchar(max)) as KeyID
,d.EntityID
--,duf.DealUnderlyingFundID as ID
from DealFunding df
join deal d on d.dealid = df.dealid 
join fund f on f.fundid = d.fundid and isnull(f.ishide,0) = 0
join dealclosing dc on dc.DealClosingID = df.DealClosingID
join entity ent on ent.EntityID = d.EntityID

union all
select 
f.FundName as Fund
,d.DealNumber
,d.DealName
,df.DeferredPaymentDate as [Date]
,isnull(df.DeferredPaymentAmount,0) * -1 as Amount
,'Deferred Payment Schedule' as [Description]
,3 as SortOrder
,'' as UnderlyingFund
,'' as Direct
,'' as Symbol 
,f.FundID
,d.DealID
,0 as UnderlyingFundID
,0 as IssuerID
,0 as SecurityTypeID
,0 as SecurityID
,ent.EntityCode
,0 as PartitionNumber
,cast(d.DealID as varchar(max)) + '_3_' + cast(df.DealDeferredPaymentID as varchar(max)) as KeyID
,d.EntityID
--,duf.DealUnderlyingFundID as ID
from DealDeferredPayment df
join deal d on d.dealid = df.dealid 
join fund f on f.fundid = d.fundid and isnull(f.ishide,0) = 0
join entity ent on ent.EntityID = d.EntityID
where isnull(df.IsPaid,0) = 1

union all
select 
f.FundName as Fund
,d.DealNumber
,d.DealName
,fe.[Date] as [Date]
,fe.Amount * -1 as Amount
,'FundExpense' as [Description]
,6 as SortOrder  
,uf.FundName 
,'' as Direct
,'' as Symbol
,f.FundID
,fe.DealID
,fe.UnderlyingFundID
,0 as IssuerID
,0 as SecurityTypeID
,0 as SecurityID
,ent.EntityCode
,0 as PartitionNumber
,cast(d.DealID as varchar(max)) + '_1_' + cast(uf.UnderlyingFundID as varchar(max)) as KeyID

,d.EntityID
--,fe.FundExpenseID as ID
from FundExpense fe
join deal d on d.dealid = fe.dealid 
join fund f on f.fundid = d.fundid and isnull(f.ishide,0) = 0
left outer join UnderlyingFund uf on uf.UnderlyingFundID = fe.UnderlyingFundID
join entity ent on ent.EntityID = d.EntityID
union all
select 
f.FundName as Fund
,d.DealNumber
,d.DealName
,ufcc.ReceivedDate as [Date]
,item.TotalAmount * -1 as Amount
,'UnderlyingFundCapitalCall' as [Description]
,7 as SortOrder 
,uf.FundName 
,'' as Direct
,'' as Symbol
,f.FundID
,item.DealID
,item.UnderlyingFundID
,0 as IssuerID
,0 as SecurityTypeID
,0 as SecurityID
,ent.EntityCode
,0 as PartitionNumber
,cast(d.DealID as varchar(max)) + '_1_' + cast(uf.UnderlyingFundID as varchar(max)) as KeyID

,d.EntityID
--,item.UnderlyingFundCapitalCallLineItemID as ID
from UnderlyingFundCapitalCallLineItem item
join deal d on d.dealid = item.dealid 
join fund f on f.fundid = d.fundid and isnull(f.ishide,0) = 0
join underlyingfundcapitalcall ufcc on ufcc.underlyingfundcapitalcallid = item.underlyingfundcapitalcallid
left outer join UnderlyingFund uf on uf.UnderlyingFundID = item.UnderlyingFundID
join entity ent on ent.EntityID = d.EntityID
where item.UnderlyingFundCapitalCallID > 0
union all
select 
f.FundName as Fund
,d.DealNumber
,d.DealName
,ufcd.ReceivedDate as [Date]
,item.Amount as Amount
,'CashDistribution' as [Description]
,8 as SortOrder 
,uf.FundName 
,'' as Direct
,'' as Symbol
,f.FundID
,item.DealID
,item.UnderlyingFundID
,0 as IssuerID
,0 as SecurityTypeID
,0 as SecurityID
,ent.EntityCode
,0 as PartitionNumber
,cast(d.DealID as varchar(max)) + '_1_' + cast(uf.UnderlyingFundID as varchar(max)) as KeyID

,d.EntityID
--,item.CashDistributionID as ID
from CashDistribution item
join deal d on d.dealid = item.dealid 
join fund f on f.fundid = d.fundid and isnull(f.ishide,0) = 0
join underlyingfundcashdistribution ufcd on ufcd.underlyingfundcashdistributionid = item.underlyingfundcashdistributionid
left outer join UnderlyingFund uf on uf.UnderlyingFundID = item.UnderlyingFundID
join entity ent on ent.EntityID = d.EntityID
where item.underlyingfundcashdistributionid > 0
union all
select 
f.FundName as Fund
,d.DealNumber
,d.DealName
,dd.DistributionDate as [Date]
,item.FMV as Amount
,'DirectDistribution' as [Description]
,9 as SortOrder 
,'' as UnderlyingFundName 
,iss.[Name] as Direct
,e.Symbol as Symbol
,f.FundID
,item.DealID
,0 as UnderlyingFundID
,iss.IssuerID as IssuerID
,dd.SecurityTypeID
,dd.SecurityID
,ent.EntityCode
,0 as PartitionNumber
,cast(d.DealID as varchar(max)) + '_2_' + cast(dd.SecurityID as varchar(max)) as KeyID

,d.EntityID
--,item.DirectDistributionLineItemID as ID
from DirectDistributionLineItem item
join deal d on d.dealid = item.dealid 
join fund f on f.fundid = d.fundid and isnull(f.ishide,0) = 0
join DirectDistribution dd on dd.DirectDistributionID = item.DirectDistributionID
left outer join Equity e on e.EquityID = dd.SecurityID and dd.SecurityTypeID = 1
left outer join Issuer iss on iss.IssuerID = e.IssuerID
join entity ent on ent.EntityID = d.EntityID
where item.DirectDistributionID > 0
union all
select 
f.FundName as Fund
,d.DealNumber
,d.DealName
,ss.SellDate as [Date]
,item.FinalSaleAmount as Amount
,'SecuritySale' as [Description]
,10 as SortOrder 
,'' as UnderlyingFundName 
,iss.[Name] as Direct
,e.Symbol as Symbol
,f.FundID
,item.DealID
,0 as UnderlyingFundID
,iss.IssuerID as IssuerID
,ss.SecurityTypeID
,ss.SecurityID
,ent.EntityCode
,0 as PartitionNumber
,cast(d.DealID as varchar(max)) + '_2_' + cast(ss.SecurityID as varchar(max)) as KeyID

,d.EntityID
--,item.SecuritySaleLineItemID as ID
from SecuritySaleLineItem item
join deal d on d.dealid = item.dealid 
join fund f on f.fundid = d.fundid and isnull(f.ishide,0) = 0
join SecuritySale ss on ss.SecuritySaleID = item.SecuritySaleID
left outer join Equity e on e.EquityID = ss.SecurityID and ss.SecurityTypeID = 1
left outer join Issuer iss on iss.IssuerID = e.IssuerID
join entity ent on ent.EntityID = d.EntityID
where item.SecuritySaleID > 0
union all
select 
f.FundName as Fund
,d.DealNumber
,d.DealName
,sd.SecurityDistributionDate as [Date]
,sd.Proceeds * -1 as Amount
,'SecurityDistribution' as [Description]
,11 as SortOrder 
,'' as UnderlyingFundName 
,iss.[Name] as Direct
,e.Symbol as Symbol
,f.FundID
,sd.DealID
,0 as UnderlyingFundID
,iss.IssuerID as IssuerID
,sd.SecurityTypeID
,sd.SecurityID
,ent.EntityCode
,0 as PartitionNumber
,cast(d.DealID as varchar(max)) + '_2_' + cast(sd.SecurityID as varchar(max)) as KeyID

,d.EntityID
--,sd.SecurityDistributionID as ID
from SecurityDistribution sd
join deal d on d.dealid = sd.dealid 
join fund f on f.fundid = d.fundid and isnull(f.ishide,0) = 0
left outer join Equity e on e.EquityID = sd.SecurityID and sd.SecurityTypeID = 1
left outer join Issuer iss on iss.IssuerID = e.IssuerID
join entity ent on ent.EntityID = d.EntityID
union all
select 
f.FundName as Fund
,d.DealNumber
,d.DealName
,item.AmortizationDate as [Date]
,item.Amount as Amount
,'LoanAmortization' as [Description]
,12 as SortOrder 
,'' as UnderlyingFundName 
,iss.[Name] as Direct
,e.Symbol as Symbol
,f.FundID
,item.DealID
,0 as UnderlyingFundID
,iss.IssuerID as IssuerID
,item.SecurityTypeID
,item.SecurityID
,ent.EntityCode
,0 as PartitionNumber
,cast(d.DealID as varchar(max)) + '_2_' + cast(item.SecurityID as varchar(max)) as KeyID

,d.EntityID
--,item.LoanAmortizationLineItemID as ID
from LoanAmortizationLineItem item
join deal d on d.dealid = item.dealid 
join fund f on f.fundid = d.fundid and isnull(f.ishide,0) = 0
left outer join Equity e on e.EquityID = item.SecurityID and item.SecurityTypeID = 1
left outer join Issuer iss on iss.IssuerID = e.IssuerID
join entity ent on ent.EntityID = d.EntityID
union all
select 
max(f.FundName) as Fund
,max(d.DealNumber) as DealNumber
,max(d.DealName) as DealName
,rfv.RolledForwardNAVDate as [Date]
,max(isnull(rfv.RolledForwardNAV,0)) + 
 isnull((select top 1 isnull(his.NumberOfSharesUnsold,0) * isnull((select top 1 p.LastPrice from underlyingdirectlastprice p 
			where p.dealid = his.dealid and p.securityid = his.securityid and p.securitytypeid = his.securitytypeid 
			and p.lastpricedate <= his.recorddate 
			order by p.LastPriceDate desc,p.UnderlyingDirectLastPriceID desc),0)
	from underlyingfundshareshistory his
	where his.dealid = rfv.DealID
	and his.underlyingfundid = rfv.AssetID
	and isnull(his.RecordDate,'01/01/1900') <= rfv.RolledForwardNAVDate
	order by his.RecordDate desc
	),0) as Amount
,'Underlying Fund RolledForwardNAV' as [Description]
,4 as SortOrder 
,max(uf.FundName) as UnderlyingFund
,'' as Direct
,'' as Symbol
,f.FundID
,rfv.DealID
,max(uf.UnderlyingFundID) as UnderlyingFundID
,0 as IssuerID
,0 as SecurityTypeID
,0 as SecurityID
,max(ent.EntityCode) as EntityCode
,ROW_NUMBER() OVER (PARTITION BY rfv.DealID,rfv.AssetTypeID,rfv.AssetID ORDER BY rfv.RolledForwardNAVDate desc) as PartitionNumber
--,isnull((select top 1 isnull(his.NumberOfSharesUnsold,0) * isnull((select top 1 p.LastPrice from underlyingdirectlastprice p 
--			where p.dealid = his.dealid and p.securityid = his.securityid and p.securitytypeid = his.securitytypeid 
--			and p.lastpricedate <= his.recorddate 
--			order by p.LastPriceDate desc,p.UnderlyingDirectLastPriceID desc),0)
--	from underlyingfundshareshistory his
--	where his.dealid = rfv.DealID
--	and his.underlyingfundid = rfv.AssetID
--	and isnull(his.RecordDate,'01/01/1900') <= rfv.RolledForwardNAVDate
--	order by his.RecordDate desc
--	),0) as CurrentFMV
,cast(rfv.DealID as varchar(max)) + '_1_' + cast(rfv.AssetID as varchar(max)) as KeyID
,d.EntityID
--,0 as ID
from dm_rolled_forward_nav rfv
join deal d on d.dealid = rfv.dealid 
join fund f on f.fundid = d.fundid and isnull(f.ishide,0) = 0
join UnderlyingFund uf on rfv.AssetID = uf.UnderlyingFundID and rfv.AssetTypeID = 1
join entity ent on ent.EntityID = d.EntityID
where rfv.AssetTypeID = 1
group by d.EntityID,rfv.DealID,rfv.AssetTypeID,rfv.AssetID,f.FundID,rfv.RolledForwardNAVDate
) as tbl 
group by Fund,DealNumber,DealName,[Date],[Description],SortOrder,UnderlyingFund,Direct,Symbol,FundID,DealID,UnderlyingFundID,IssuerID,SecurityTypeID,SecurityID,EntityID,EntityCode,PartitionNumber
GO
/****** Object:  View [dbo].[InvestmentCostReport]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[InvestmentCostReport] AS
select 
tbl.* from (
select 
d.EntityID
,ufccItem.UnderlyingFundCapitalCallLineItemID as ID
,(isnull(ufccItem.TotalAmount,0) / (case when isnull(fcr.ConversionFactor,0) = 0 then 1 else isnull(fcr.ConversionFactor,0) end)) as Base_Amount
,isnull(fcr.ConversionFactor,0) as FX_Rate
,ufccItem.TotalAmount as Amount
,d.dealid as DealID
,uf.UnderlyingFundID 
,d.dealname as Dealname
,d.dealnumber as DealNumber
--,@startdate as Fromdate
--,@enddate as Todate
,ufccItem.PaidON as DueDate
,f.fundname as FundName
,uf.Fundname as UnderlyingFund
,ufccItem.isReconciled as IsPaid
,'Capital Call' as Type
,'' as Direct
,0 as IssuerID
,ufcc.IsDeemedCapitalCall as IsDeemedCapitalCall
,f.sortorder as FundSortOrder
,ufccItem.ReceivedDate as EffectiveDate
,'1/2/1900' as FundingDate
,0 as IsActive
,'1/2/1900' as CloseDate
,ent.EntityCode
from underlyingFundCapitalCallLineItem ufccItem
join UnderlyingFundCapitalCall ufcc on ufccItem.UnderlyingFundCapitalCallID = ufcc.UnderlyingFundCapitalCallID
join UnderlyingFund uf on ufccItem.UnderlyingFundID = uf.UnderlyingFundID and (isnull(uf.IsArchive,0)=0)
join deal d on ufccItem.DealID = d.DealID	
join ENTITY ent on ent.EntityID = d.EntityID
join fund f on d.FundID = f.FundID and (isnull(f.IsHide,0)=0)
left outer join fxtransaction fxt on fxt.FXTransactionSourceID = ufccItem.UnderlyingFundCapitalCallLineItemID and fxt.FXTransactionSourceTypeID = 4
left outer join fxconversionrate fcr on fcr.FXConversionRateID = fxt.FXConversionRateID
union all 
select 
d.EntityID
,dcc.DealClosingCostID as ID
,dcc.Amount as Base_Amount
,0 as FX_Rate
,dcc.Amount as Amount
,d.dealid as DealID
,0 as UnderlyingFundID 
,d.dealname as Dealname
,d.dealnumber as DealNumber
--,@startdate as Fromdate
--,@enddate as Todate
,dcc.PaidON as DueDate
,f.fundname as Fund
,'' as UnderlyingFund
,dcc.isReconciled as IsPaid
,'Closing Costs' as Type
,'' as Direct
,0 as IssuerID
,0 as IsDeemedCapitalCall
,f.sortorder as FundSortOrder
,dcc.Date as EffectiveDate
,'1/2/1900' as FundingDate
,0 as IsActive
,'1/2/1900' as CloseDate
,ent.EntityCode
from dealClosingCost dcc
join deal d on dcc.DealID = d.DealID	
join ENTITY ent on ent.EntityID = d.EntityID
join fund f on d.FundID = f.FundID and (isnull(f.IsHide,0)=0)
union all 
select 
d.EntityID
,duf.DealUnderlyingFundID as ID
,(isnull(duf.NetPurchasePrice,0) / (case when isnull(fcr.ConversionFactor,0) = 0 then 1 else isnull(fcr.ConversionFactor,0) end)) as Base_Amount
,isnull(fcr.ConversionFactor,0) as FX_Rate
,duf.NetPurchasePrice as Amount
,d.dealid as DealID
,uf.UnderlyingFundID 
,d.dealname as Dealname
,d.dealnumber as DealNumber
--,@startdate as Fromdate
--,@enddate as Todate
,duf.EffectiveDate as DueDate
,f.fundname as Fund
,uf.FundName as UnderlyingFund
,CASE WHEN duf.DealClosingID > 0 THEN 1 ELSE 0 END as IsPaid
,'Net Purchase' as Type
,'' as Direct
,0 as IssuerID
,0 as IsDeemedCapitalCall
,f.sortorder as FundSortOrder
,duf.EffectiveDate as EffectiveDate
,(select top 1 dcf.FundingDate from DealFunding dcf 
where dcf.DealID = duf.DealID
order by dcf.FundingDate asc, dcf.DealFundingID asc) as FundingDate
,0 as IsActive
,dc.CloseDate as CloseDate
,ent.EntityCode
from DealUnderlyingFund duf
join UnderlyingFund uf on duf.UnderlyingFundID = uf.UnderlyingFundID and isnull(uf.IsArchive,0)=0
join deal d on duf.DealID = d.DealID	
join ENTITY ent on ent.EntityID = d.EntityID
join fund f on d.FundID = f.FundID and (isnull(f.IsHide,0)=0)
left outer join DealClosing dc on duf.DealClosingID = dc.DealClosingID
left outer join fxtransaction fxt on fxt.FXTransactionSourceID = duf.DealUnderlyingFundID and fxt.FXTransactionSourceTypeID = 1
left outer join fxconversionrate fcr on fcr.FXConversionRateID = fxt.FXConversionRateID
union all 
select 
d.EntityID
,dud.DealUnderlyingDirectID as ID
,((isnull(dud.FMV,0))/ (case when isnull(fcr.ConversionFactor,0) = 0 then 1 else isnull(fcr.ConversionFactor,0) end)) - isnull(dud.PostRecordCashFlow,0) as Base_Amount
,isnull(fcr.ConversionFactor,0) as FX_Rate
,(isnull(dud.FMV,0) - isnull(dud.PostRecordCashFlow,0)) as Amount
,d.dealid as DealID
,0 as UnderlyingFundID 
,d.dealname as Dealname
,d.dealnumber as DealNumber
--,@startdate as Fromdate
--,@enddate as Todate
,CASE WHEN dud.DealClosingID > 0 THEN dc.CloseDate ELSE '1/2/1900' END as DueDate
,f.fundname as Fund
,'' as UnderlyingFund
,CASE WHEN dud.DealClosingID > 0 THEN 1 ELSE 0 END as IsPaid
,'FMV' as Type
,CASE WHEN dud.SecurityTypeID = 1 THEN isnull(equityIssuer.Name,'') ELSE isnull(fiIssuer.Name,'') END as Direct
,CASE WHEN dud.SecurityTypeID = 1 THEN isnull(equityIssuer.IssuerID,'') ELSE isnull(fiIssuer.IssuerID,'') END as IssuerID
,0 as IsDeemedCapitalCall
,f.sortorder as FundSortOrder
,dud.RecordDate as EffectiveDate
,(select top 1 dcf.FundingDate from DealFunding dcf 
where dcf.DealID = dud.DealID
order by dcf.FundingDate asc, dcf.DealFundingID asc) as FundingDate
,dud.IsActive as IsActive
,dc.CloseDate as CloseDate
,ent.EntityCode
from dealUnderlyingDirect dud
join deal d on dud.DealID = d.DealID	
join ENTITY ent on ent.EntityID = d.EntityID
join fund f on d.FundID = f.FundID and (isnull(f.IsHide,0)=0)
left outer join Equity e on e.EquityID = dud.SecurityID and (isnull(e.IsArchive,0)=0)
left outer join Issuer equityIssuer on equityIssuer.IssuerID = e.IssuerID and (isnull(equityIssuer.IsArchive,0)=0)
left outer join fixedIncome fi on fi.FixedIncomeID = dud.SecurityID and (isnull(fi.IsArchive,0)=0)
left outer join Issuer fiIssuer on fiIssuer.IssuerID = fi.IssuerID and (isnull(fiIssuer.IsArchive,0)=0)
left outer join DealClosing dc on dud.DealClosingID = dc.DealClosingID
left outer join fxtransaction fxt on fxt.FXTransactionSourceID = dud.DealUnderlyingDirectID and fxt.FXTransactionSourceTypeID = 2
left outer join fxconversionrate fcr on fcr.FXConversionRateID = fxt.FXConversionRateID
where isnull(dud.IsFollowOn,0)=0
and dud.IsActive = 1
union all 
select 
d.EntityID
,fe.FundExpenseID as ID
,(isnull(fe.Amount,0) / (case when isnull(fcr.ConversionFactor,0) = 0 then 1 else isnull(fcr.ConversionFactor,0) end)) as Base_Amount
,isnull(fcr.ConversionFactor,0) as FX_Rate
,fe.Amount as Amount
,d.dealid as DealID
,uf.UnderlyingFundID
,d.dealname as Dealname
,d.dealnumber as DealNumber
--,@startdate as Fromdate
--,@enddate as Todate
,fe.[Date] as DueDate
,f.fundname as Fund
,uf.fundname as UnderlyingFund
,fe.isReconciled as IsPaid
,'Manual Cash Transaction' as Type
,CASE WHEN fe.SecurityTypeID = 1 THEN isnull(equityIssuer.Name,'') ELSE isnull(fiIssuer.Name,'') END as Direct
,CASE WHEN fe.SecurityTypeID = 1 THEN isnull(equityIssuer.IssuerID,'') ELSE isnull(fiIssuer.IssuerID,'') END as IssuerID
,0 as IsDeemedCapitalCall
,f.sortorder as FundSortOrder
,fe.Date as EffectiveDate
,'1/2/1900' as FundingDate
,0 as IsActive
,'1/2/1900' as CloseDate
,ent.EntityCode 
from fundExpense fe
join deal d on fe.DealID = d.DealID	
join ENTITY ent on ent.EntityID = d.EntityID
join fund f on d.FundID = f.FundID and (isnull(f.IsHide,0)=0)
left outer join UnderlyingFund uf on fe.UnderlyingFundID = uf.UnderlyingFundID and (isnull(uf.IsArchive,0)=0)
left outer join Equity e on e.EquityID = fe.SecurityID and (isnull(e.IsArchive,0)=0)
left outer join Issuer equityIssuer on equityIssuer.IssuerID = e.IssuerID and (isnull(equityIssuer.IsArchive,0)=0)
left outer join fixedIncome fi on fi.FixedIncomeID = fe.SecurityID and (isnull(fi.IsArchive,0)=0)
left outer join Issuer fiIssuer on fiIssuer.IssuerID = fi.IssuerID and (isnull(fiIssuer.IsArchive,0)=0)
left outer join fxtransaction fxt on fxt.FXTransactionSourceID = fe.FundExpenseID and fxt.FXTransactionSourceTypeID = 11
left outer join fxconversionrate fcr on fcr.FXConversionRateID = fxt.FXConversionRateID
union all 
select 
d.EntityID
,followOn.DealUnderlyingDirectID as ID
,(isnull(followOn.FMV,0) / (case when isnull(fcr.ConversionFactor,0) = 0 then 1 else isnull(fcr.ConversionFactor,0) end)) as Base_Amount
,isnull(fcr.ConversionFactor,0) as FX_Rate
,followOn.FMV as Amount
,d.dealid as DealID
,0 as UnderlyingFundID
,d.dealname as Dealname
,d.dealnumber as DealNumber
--,@startdate as Fromdate
--,@enddate as Todate
,followOn.RecordDate as DueDate
,f.fundname as Fund
,'' as UnderlyingFund
,followOn.isReconciled as IsPaid
,'Follow On' as Type
,CASE WHEN followOn.SecurityTypeID = 1 THEN isnull(equityIssuer.Name,'') ELSE isnull(fiIssuer.Name,'') END as Direct
,CASE WHEN followOn.SecurityTypeID = 1 THEN isnull(equityIssuer.IssuerID,'') ELSE isnull(fiIssuer.IssuerID,'') END as IssuerID
,0 as IsDeemedCapitalCall
,f.sortorder as FundSortOrder
,followOn.RecordDate as EffectiveDate
,'1/2/1900' as FundingDate
,followOn.IsActive as IsActive
,'1/2/1900' as CloseDate
,ent.EntityCode 
from dealUnderlyingDirect followOn
join deal d on followOn.DealID = d.DealID	
join ENTITY ent on ent.EntityID = d.EntityID
join fund f on d.FundID = f.FundID and (isnull(f.IsHide,0)=0)
left outer join Equity e on e.EquityID = followOn.SecurityID and (isnull(e.IsArchive,0)=0)
left outer join Issuer equityIssuer on equityIssuer.IssuerID = e.IssuerID and (isnull(equityIssuer.IsArchive,0)=0)
left outer join fixedIncome fi on fi.FixedIncomeID = followOn.SecurityID and (isnull(fi.IsArchive,0)=0)
left outer join Issuer fiIssuer on fiIssuer.IssuerID = fi.IssuerID and (isnull(fiIssuer.IsArchive,0)=0)
left outer join fxtransaction fxt on fxt.FXTransactionSourceID = followOn.DealUnderlyingDirectID and fxt.FXTransactionSourceTypeID = 2
left outer join fxconversionrate fcr on fcr.FXConversionRateID = fxt.FXConversionRateID
where followOn.IsSecurityConversionDetail = 0 and followOn.IsFollowOn=1
and followon.IsActive = 1
) as tbl
GO
/****** Object:  Table [dbo].[dm_asset_core_index]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dm_asset_core_index](
	[dm_asset_core_index_id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[Value] [decimal](19, 8) NOT NULL,
 CONSTRAINT [PK_dm_asset_core_index] PRIMARY KEY CLUSTERED 
(
	[dm_asset_core_index_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dm_asset_core_lot_share]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dm_asset_core_lot_share](
	[Symbol] [varchar](100) NOT NULL,
	[NumberOfShares] [decimal](19, 8) NULL,
	[SharePrice] [decimal](19, 8) NULL,
	[Amount] [decimal](19, 8) NULL,
	[PL] [decimal](19, 8) NULL,
	[PLPercent] [decimal](19, 8) NULL,
	[BuyAmount] [decimal](19, 8) NULL,
	[SellAmount] [decimal](19, 8) NULL,
	[CurrentMarketValue] [decimal](19, 8) NULL,
	[XIRR] [decimal](19, 8) NULL,
	[UnRealizedPL] [decimal](19, 8) NULL,
 CONSTRAINT [PK_dm_asset_core_lot_share] PRIMARY KEY CLUSTERED 
(
	[Symbol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dm_asset_core_lot_year]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dm_asset_core_lot_year](
	[Symbol] [varchar](max) NOT NULL,
	[AsOfDate] [datetime] NOT NULL,
	[NumberOfShares] [decimal](19, 8) NOT NULL,
	[Price] [decimal](19, 8) NULL,
	[TotalAmount] [decimal](19, 8) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dm_asset_core_symbol]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dm_asset_core_symbol](
	[dm_asset_core_symbol_id] [int] IDENTITY(1,1) NOT NULL,
	[Symbol] [varchar](100) NOT NULL,
 CONSTRAINT [PK_dm_asset_core_symbol] PRIMARY KEY CLUSTERED 
(
	[dm_asset_core_symbol_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dm_asset_core_symbol_index]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dm_asset_core_symbol_index](
	[dm_asset_core_index_id] [int] NOT NULL,
	[Symbol] [varchar](100) NOT NULL,
	[Value] [decimal](19, 8) NULL,
 CONSTRAINT [PK_dm_asset_core_symbol_index] PRIMARY KEY CLUSTERED 
(
	[dm_asset_core_index_id] ASC,
	[Symbol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dm_Calendar_Month]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dm_Calendar_Month](
	[MonthID] [int] NOT NULL,
	[Name] [varchar](10) NULL,
	[ShortName] [varchar](3) NULL,
 CONSTRAINT [PK_dm_Calendar_Month] PRIMARY KEY CLUSTERED 
(
	[MonthID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dm_Calendar_Quarter]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dm_Calendar_Quarter](
	[QuarterID] [int] NOT NULL,
	[Name] [varchar](100) NULL,
	[QuarterPeriod] [varchar](200) NULL,
 CONSTRAINT [PK_dm_Calendar_Quarter] PRIMARY KEY CLUSTERED 
(
	[QuarterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[dm_asset_core_index] ON 

INSERT [dbo].[dm_asset_core_index] ([dm_asset_core_index_id], [Name], [Value]) VALUES (1, N'IT', CAST(0.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_index] ([dm_asset_core_index_id], [Name], [Value]) VALUES (2, N'BANK', CAST(0.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_index] ([dm_asset_core_index_id], [Name], [Value]) VALUES (5, N'MyIdea', CAST(100.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_index] ([dm_asset_core_index_id], [Name], [Value]) VALUES (7, N'Others', CAST(0.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_index] ([dm_asset_core_index_id], [Name], [Value]) VALUES (8, N'IndexFund', CAST(0.00000000 AS Decimal(19, 8)))
SET IDENTITY_INSERT [dbo].[dm_asset_core_index] OFF
GO
SET IDENTITY_INSERT [dbo].[dm_asset_core_lot] ON 

INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2758, N'HDFCBANK', CAST(N'2020-03-23T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(769.95000000 AS Decimal(19, 8)), N'B', N'27603679', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2759, N'INFY', CAST(N'2020-03-23T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(530.30000000 AS Decimal(19, 8)), N'B', N'27614773', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2760, N'ITC', CAST(N'2020-03-23T00:00:00.000' AS DateTime), CAST(11.00000000 AS Decimal(19, 8)), CAST(151.40000000 AS Decimal(19, 8)), N'B', N'27620726', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2761, N'DABUR', CAST(N'2020-03-23T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(410.10000000 AS Decimal(19, 8)), N'B', N'1986192', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2762, N'MARICO', CAST(N'2020-03-23T00:00:00.000' AS DateTime), CAST(7.00000000 AS Decimal(19, 8)), CAST(237.95000000 AS Decimal(19, 8)), N'B', N'51490189', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2763, N'HAVELLS', CAST(N'2020-03-23T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(500.05000000 AS Decimal(19, 8)), N'B', N'27654485', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2764, N'KANSAINER', CAST(N'2020-03-23T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(313.95000000 AS Decimal(19, 8)), N'B', N'51496445', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2765, N'KANSAINER', CAST(N'2020-03-23T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(313.95000000 AS Decimal(19, 8)), N'B', N'51496444', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2766, N'CROMPTON', CAST(N'2020-03-23T00:00:00.000' AS DateTime), CAST(9.00000000 AS Decimal(19, 8)), CAST(190.20000000 AS Decimal(19, 8)), N'B', N'2009665', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2767, N'VGUARD', CAST(N'2020-03-23T00:00:00.000' AS DateTime), CAST(11.00000000 AS Decimal(19, 8)), CAST(160.95000000 AS Decimal(19, 8)), N'B', N'77396680', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2768, N'VIPIND', CAST(N'2020-03-23T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(208.55000000 AS Decimal(19, 8)), N'B', N'77405121', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2769, N'VIPIND', CAST(N'2020-03-23T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(208.60000000 AS Decimal(19, 8)), N'B', N'77405122', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2770, N'VIPIND', CAST(N'2020-03-23T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(208.60000000 AS Decimal(19, 8)), N'B', N'77405144', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2771, N'RELIANCE', CAST(N'2020-03-23T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(883.80000000 AS Decimal(19, 8)), N'B', N'77409850', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2772, N'GODREJCP', CAST(N'2020-03-23T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(449.20000000 AS Decimal(19, 8)), N'B', N'27694980', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2773, N'HATSUN', CAST(N'2020-03-23T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(477.10000000 AS Decimal(19, 8)), N'B', N'27703433', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2774, N'INDUSINDBK', CAST(N'2020-03-23T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(341.85000000 AS Decimal(19, 8)), N'B', N'27708387', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2775, N'HINDUNILVR', CAST(N'2020-03-23T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1861.30000000 AS Decimal(19, 8)), N'B', N'27715308', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2776, N'HDFCBANK', CAST(N'2020-03-23T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(767.60000000 AS Decimal(19, 8)), N'B', N'27721861', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2777, N'ITC', CAST(N'2020-03-23T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(150.80000000 AS Decimal(19, 8)), N'B', N'27724652', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2778, N'INFY', CAST(N'2020-03-23T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(528.25000000 AS Decimal(19, 8)), N'B', N'27764612', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2779, N'BAJFINANCE', CAST(N'2020-03-23T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2364.60000000 AS Decimal(19, 8)), N'B', N'2092341', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2780, N'ITC', CAST(N'2020-03-23T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(151.00000000 AS Decimal(19, 8)), N'B', N'27786193', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2781, N'ITC', CAST(N'2020-03-23T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(150.20000000 AS Decimal(19, 8)), N'B', N'27795766', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2782, N'ITC', CAST(N'2020-03-23T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(151.50000000 AS Decimal(19, 8)), N'B', N'27862736', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2783, N'TCS', CAST(N'2020-04-03T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1651.00000000 AS Decimal(19, 8)), N'B', N'79942433', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2784, N'HDFC', CAST(N'2020-04-03T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1499.05000000 AS Decimal(19, 8)), N'B', N'30496051', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2785, N'KOTAKBANK', CAST(N'2020-04-03T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1159.00000000 AS Decimal(19, 8)), N'B', N'53910007', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2786, N'KOTAKBANK', CAST(N'2020-04-03T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1158.20000000 AS Decimal(19, 8)), N'B', N'53910816', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2787, N'ASIANPAINT', CAST(N'2020-04-03T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1524.00000000 AS Decimal(19, 8)), N'B', N'4953053', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2788, N'TITAN', CAST(N'2020-04-03T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(863.45000000 AS Decimal(19, 8)), N'B', N'79968371', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2789, N'BRITANNIA', CAST(N'2020-04-03T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2572.05000000 AS Decimal(19, 8)), N'B', N'4961507', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2790, N'PIDILITIND', CAST(N'2020-04-03T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1219.60000000 AS Decimal(19, 8)), N'B', N'53929227', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2791, N'BERGEPAINT', CAST(N'2020-04-03T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(448.60000000 AS Decimal(19, 8)), N'B', N'4973650', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2792, N'WHIRLPOOL', CAST(N'2020-04-03T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1800.00000000 AS Decimal(19, 8)), N'B', N'79988540', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2793, N'JUBLFOOD', CAST(N'2020-04-03T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1300.50000000 AS Decimal(19, 8)), N'B', N'53940308', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2794, N'BATAINDIA', CAST(N'2020-04-03T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1191.00000000 AS Decimal(19, 8)), N'B', N'4982590', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2795, N'ITC', CAST(N'2020-08-13T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(202.35000000 AS Decimal(19, 8)), N'B', N'26620010', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2796, N'WHIRLPOOL', CAST(N'2021-11-24T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2198.45000000 AS Decimal(19, 8)), N'S', N'3078000', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1800.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2797, N'VIPIND', CAST(N'2021-11-24T00:00:00.000' AS DateTime), CAST(8.00000000 AS Decimal(19, 8)), CAST(594.65000000 AS Decimal(19, 8)), N'S', N'80625541', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(208.60000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2798, N'VGUARD', CAST(N'2021-11-24T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(248.70000000 AS Decimal(19, 8)), N'S', N'80628562', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(160.95000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2799, N'VGUARD', CAST(N'2021-11-24T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(248.80000000 AS Decimal(19, 8)), N'S', N'80628560', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(160.95000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2800, N'VGUARD', CAST(N'2021-11-24T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(248.75000000 AS Decimal(19, 8)), N'S', N'80628561', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(160.95000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2801, N'VGUARD', CAST(N'2021-11-24T00:00:00.000' AS DateTime), CAST(7.00000000 AS Decimal(19, 8)), CAST(248.70000000 AS Decimal(19, 8)), N'S', N'80628563', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(160.95000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2802, N'KANSAINER', CAST(N'2021-11-24T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(588.55000000 AS Decimal(19, 8)), N'S', N'55523943', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(313.95000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2803, N'IBULHSGFIN-NE', CAST(N'2021-12-08T00:00:00.000' AS DateTime), CAST(7.00000000 AS Decimal(19, 8)), CAST(899.90000000 AS Decimal(19, 8)), N'B', N'30049657', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2804, N'HDFC', CAST(N'2021-12-17T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2665.90000000 AS Decimal(19, 8)), N'S', N'2755200', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1499.05000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2805, N'ITC', CAST(N'2021-12-17T00:00:00.000' AS DateTime), CAST(20.00000000 AS Decimal(19, 8)), CAST(221.90000000 AS Decimal(19, 8)), N'S', N'1051500', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(202.35000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2806, N'INDUSINDBK', CAST(N'2021-12-17T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(912.20000000 AS Decimal(19, 8)), N'S', N'2111000', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(341.85000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2807, N'INDUSINDBK', CAST(N'2021-12-17T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(909.15000000 AS Decimal(19, 8)), N'S', N'2262600', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(341.85000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2808, N'INDUSINDBK', CAST(N'2021-12-17T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(909.20000000 AS Decimal(19, 8)), N'S', N'2262400', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(341.85000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2809, N'IBULHSGFIN-NE', CAST(N'2022-02-22T00:00:00.000' AS DateTime), CAST(7.00000000 AS Decimal(19, 8)), CAST(950.00000000 AS Decimal(19, 8)), N'S', N'26318322', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(899.90000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2810, N'TATACONSUM', CAST(N'2022-02-24T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(680.60000000 AS Decimal(19, 8)), N'B', N'82247901', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2811, N'CHOLAFIN', CAST(N'2022-02-24T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(650.00000000 AS Decimal(19, 8)), N'B', N'5990459', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2812, N'TATAMOTORS', CAST(N'2022-02-24T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(433.35000000 AS Decimal(19, 8)), N'B', N'82253642', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2813, N'ICICIBANK', CAST(N'2022-02-24T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(715.85000000 AS Decimal(19, 8)), N'B', N'32685418', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2814, N'AARTIIND', CAST(N'2022-02-24T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(867.70000000 AS Decimal(19, 8)), N'B', N'6020527', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2815, N'RELAXO', CAST(N'2022-02-24T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1168.00000000 AS Decimal(19, 8)), N'B', N'82307601', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2816, N'HCLTECH', CAST(N'2022-02-24T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1093.20000000 AS Decimal(19, 8)), N'B', N'32747889', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2817, N'MUTHOOTFIN', CAST(N'2022-02-24T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1317.90000000 AS Decimal(19, 8)), N'B', N'55983286', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2818, N'TECHM', CAST(N'2022-02-24T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1336.90000000 AS Decimal(19, 8)), N'B', N'82317891', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2819, N'BALKRISIND', CAST(N'2022-02-24T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1775.35000000 AS Decimal(19, 8)), N'B', N'6056254', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2820, N'ICICIBANK', CAST(N'2022-02-24T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(714.60000000 AS Decimal(19, 8)), N'B', N'32868379', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2821, N'HCLTECH', CAST(N'2022-02-24T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1093.20000000 AS Decimal(19, 8)), N'B', N'32954705', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2822, N'AARTIIND', CAST(N'2022-02-24T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(870.00000000 AS Decimal(19, 8)), N'B', N'6280071', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2823, N'MUTHOOTFIN', CAST(N'2022-02-24T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1322.50000000 AS Decimal(19, 8)), N'B', N'56223794', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2824, N'RELAXO', CAST(N'2022-02-24T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1172.00000000 AS Decimal(19, 8)), N'B', N'82618795', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2825, N'CROMPTON', CAST(N'2022-02-24T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(405.65000000 AS Decimal(19, 8)), N'B', N'6301359', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2826, N'MARICO', CAST(N'2022-02-24T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(483.00000000 AS Decimal(19, 8)), N'B', N'56245612', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2827, N'DABUR', CAST(N'2022-02-24T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(532.35000000 AS Decimal(19, 8)), N'B', N'33101734', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2828, N'HATSUN', CAST(N'2022-02-24T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1077.55000000 AS Decimal(19, 8)), N'B', N'33106121', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2829, N'HAVELLS', CAST(N'2022-02-24T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1150.15000000 AS Decimal(19, 8)), N'B', N'33115178', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2830, N'DIVISLAB', CAST(N'2022-02-24T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(3943.70000000 AS Decimal(19, 8)), N'B', N'33187058', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2831, N'PIDILITIND', CAST(N'2022-03-04T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2279.00000000 AS Decimal(19, 8)), N'B', N'50636675', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2832, N'TATAMOTORS', CAST(N'2022-03-04T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(428.15000000 AS Decimal(19, 8)), N'B', N'75770457', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2833, N'TECHM', CAST(N'2022-03-04T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1402.20000000 AS Decimal(19, 8)), N'B', N'75793606', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2834, N'GODREJCP', CAST(N'2022-03-04T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(720.65000000 AS Decimal(19, 8)), N'B', N'26012097', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2835, N'CHOLAFIN', CAST(N'2022-03-04T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(666.45000000 AS Decimal(19, 8)), N'B', N'717989', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2836, N'BATAINDIA', CAST(N'2022-03-04T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1745.00000000 AS Decimal(19, 8)), N'B', N'720877', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2837, N'TATACONSUM', CAST(N'2022-03-04T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(673.90000000 AS Decimal(19, 8)), N'B', N'75828726', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2838, N'CROMPTON', CAST(N'2022-03-04T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(396.55000000 AS Decimal(19, 8)), N'B', N'738689', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2839, N'ICICIBANK', CAST(N'2022-03-04T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(693.80000000 AS Decimal(19, 8)), N'B', N'26073689', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2840, N'MARICO', CAST(N'2022-03-04T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(507.20000000 AS Decimal(19, 8)), N'B', N'50738021', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2841, N'MARICO', CAST(N'2022-03-04T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(507.00000000 AS Decimal(19, 8)), N'B', N'50749137', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2842, N'HCLTECH', CAST(N'2022-03-04T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1126.00000000 AS Decimal(19, 8)), N'B', N'26120758', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2843, N'BERGEPAINT', CAST(N'2022-03-04T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(652.70000000 AS Decimal(19, 8)), N'B', N'792474', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2844, N'BALKRISIND', CAST(N'2022-03-04T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1763.10000000 AS Decimal(19, 8)), N'B', N'807242', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2845, N'JUBLFOOD', CAST(N'2022-03-04T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2710.75000000 AS Decimal(19, 8)), N'B', N'50791837', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2846, N'ASIANPAINT', CAST(N'2022-03-04T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2739.90000000 AS Decimal(19, 8)), N'B', N'833566', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2847, N'TCS', CAST(N'2022-03-04T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(3500.10000000 AS Decimal(19, 8)), N'B', N'75952565', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2848, N'INFY', CAST(N'2022-03-04T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1689.65000000 AS Decimal(19, 8)), N'B', N'26224975', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2849, N'HDFCBANK', CAST(N'2022-03-04T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1350.80000000 AS Decimal(19, 8)), N'B', N'26238690', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2850, N'KOTAKBANK', CAST(N'2022-03-04T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1757.35000000 AS Decimal(19, 8)), N'B', N'50845154', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2851, N'HATSUN', CAST(N'2022-03-04T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1105.00000000 AS Decimal(19, 8)), N'B', N'26253372', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2852, N'HINDUNILVR', CAST(N'2022-03-04T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2046.75000000 AS Decimal(19, 8)), N'B', N'26270402', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2853, N'TATAMOTORS', CAST(N'2022-03-04T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(428.60000000 AS Decimal(19, 8)), N'B', N'76047013', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2854, N'MARICO', CAST(N'2022-03-04T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(505.30000000 AS Decimal(19, 8)), N'B', N'50921530', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2855, N'DEEPAKFERT', CAST(N'2022-03-07T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(568.75000000 AS Decimal(19, 8)), N'B', N'30956029', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2856, N'RELIANCE', CAST(N'2022-03-07T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2245.85000000 AS Decimal(19, 8)), N'B', N'79812251', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
GO
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2857, N'DABUR', CAST(N'2022-03-07T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(507.30000000 AS Decimal(19, 8)), N'B', N'30967859', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2858, N'RELAXO', CAST(N'2022-03-07T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1137.00000000 AS Decimal(19, 8)), N'B', N'79852544', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2859, N'TITAN', CAST(N'2022-03-07T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2380.70000000 AS Decimal(19, 8)), N'B', N'79864741', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2860, N'AARTIIND', CAST(N'2022-03-07T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(798.00000000 AS Decimal(19, 8)), N'B', N'4209684', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2861, N'DEEPAKFERT', CAST(N'2022-03-10T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(547.05000000 AS Decimal(19, 8)), N'S', N'84982700', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(568.75000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2862, N'DEEPAKFERT', CAST(N'2022-03-10T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(546.60000000 AS Decimal(19, 8)), N'S', N'85026800', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(568.75000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2863, N'BALKRISIND', CAST(N'2022-03-10T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1960.70000000 AS Decimal(19, 8)), N'S', N'6776500', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1763.10000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2864, N'BRITANNIA', CAST(N'2022-03-10T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(3219.80000000 AS Decimal(19, 8)), N'B', N'5320875', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2865, N'MUTHOOTFIN', CAST(N'2022-03-10T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1396.25000000 AS Decimal(19, 8)), N'B', N'54645024', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2866, N'HAVELLS', CAST(N'2022-04-22T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1315.00000000 AS Decimal(19, 8)), N'B', N'29805292', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2867, N'BAJFINANCE', CAST(N'2022-04-22T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(7091.00000000 AS Decimal(19, 8)), N'B', N'4646811', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2868, N'TECHM', CAST(N'2022-04-22T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1305.70000000 AS Decimal(19, 8)), N'B', N'79597451', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2869, N'TECHM', CAST(N'2022-04-22T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1305.70000000 AS Decimal(19, 8)), N'B', N'79597619', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2870, N'BATAINDIA', CAST(N'2022-04-22T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1914.95000000 AS Decimal(19, 8)), N'B', N'4653472', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2871, N'CHOLAFIN', CAST(N'2022-04-22T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(708.35000000 AS Decimal(19, 8)), N'B', N'4658864', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2872, N'CROMPTON', CAST(N'2022-04-22T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(379.20000000 AS Decimal(19, 8)), N'B', N'4661392', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2873, N'CROMPTON', CAST(N'2022-04-22T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(379.20000000 AS Decimal(19, 8)), N'B', N'4663142', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2874, N'HCLTECH', CAST(N'2022-04-22T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1101.60000000 AS Decimal(19, 8)), N'B', N'29824541', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2875, N'TATACONSUM', CAST(N'2022-04-22T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(812.85000000 AS Decimal(19, 8)), N'B', N'79610648', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2876, N'AARTIIND', CAST(N'2022-04-22T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(922.80000000 AS Decimal(19, 8)), N'B', N'4672090', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2877, N'RELAXO', CAST(N'2022-04-22T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1109.25000000 AS Decimal(19, 8)), N'B', N'79622909', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2878, N'ICICIBANK', CAST(N'2022-04-22T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(749.30000000 AS Decimal(19, 8)), N'B', N'29857110', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2879, N'ICICIBANK', CAST(N'2022-04-22T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(749.30000000 AS Decimal(19, 8)), N'B', N'29857367', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2880, N'BERGEPAINT', CAST(N'2022-04-22T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(712.65000000 AS Decimal(19, 8)), N'B', N'4706131', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2881, N'HATSUN', CAST(N'2022-04-22T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1109.40000000 AS Decimal(19, 8)), N'B', N'29878492', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2882, N'HDFCBANK', CAST(N'2022-04-22T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1354.80000000 AS Decimal(19, 8)), N'B', N'29881781', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2883, N'INFY', CAST(N'2022-04-22T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1585.60000000 AS Decimal(19, 8)), N'B', N'29887861', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2884, N'DABUR', CAST(N'2022-04-22T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(555.35000000 AS Decimal(19, 8)), N'B', N'29888289', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2885, N'PIDILITIND', CAST(N'2022-04-22T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2424.00000000 AS Decimal(19, 8)), N'B', N'54217608', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2886, N'JUBLFOOD', CAST(N'2022-04-22T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(576.80000000 AS Decimal(19, 8)), N'B', N'54224188', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2887, N'MARICO', CAST(N'2022-04-22T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(518.00000000 AS Decimal(19, 8)), N'B', N'54236250', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2888, N'MUTHOOTFIN', CAST(N'2022-04-22T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1310.90000000 AS Decimal(19, 8)), N'B', N'54241179', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2889, N'TATAMTRDVR', CAST(N'2022-04-22T00:00:00.000' AS DateTime), CAST(20.00000000 AS Decimal(19, 8)), CAST(218.90000000 AS Decimal(19, 8)), N'B', N'79707061', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2890, N'TATAMOTORS', CAST(N'2022-04-22T00:00:00.000' AS DateTime), CAST(10.00000000 AS Decimal(19, 8)), CAST(439.50000000 AS Decimal(19, 8)), N'S', N'79708926', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(428.60000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2891, N'HINDUNILVR', CAST(N'2022-04-22T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2135.00000000 AS Decimal(19, 8)), N'B', N'29958571', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2892, N'INFY', CAST(N'2022-04-22T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1586.50000000 AS Decimal(19, 8)), N'B', N'29967312', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2893, N'HDFCBANK', CAST(N'2022-04-22T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1354.80000000 AS Decimal(19, 8)), N'B', N'29968898', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2894, N'HDFCBANK', CAST(N'2022-04-22T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1354.80000000 AS Decimal(19, 8)), N'B', N'29968869', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2895, N'HDFCBANK', CAST(N'2022-04-22T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1354.85000000 AS Decimal(19, 8)), N'B', N'29976100', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2896, N'DIVISLAB', CAST(N'2022-05-16T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(4296.65000000 AS Decimal(19, 8)), N'B', N'25788941', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2897, N'RELIANCE', CAST(N'2022-05-16T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2459.55000000 AS Decimal(19, 8)), N'B', N'75947232', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2898, N'KOTAKBANK', CAST(N'2022-05-16T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1809.20000000 AS Decimal(19, 8)), N'B', N'50672291', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2899, N'ASIANPAINT', CAST(N'2022-05-16T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(3060.55000000 AS Decimal(19, 8)), N'B', N'935666', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2900, N'GODREJCP', CAST(N'2022-05-16T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(784.70000000 AS Decimal(19, 8)), N'B', N'25824372', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2901, N'GODREJCP', CAST(N'2022-05-16T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(784.70000000 AS Decimal(19, 8)), N'B', N'25824373', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2902, N'RELAXO', CAST(N'2022-05-16T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1022.65000000 AS Decimal(19, 8)), N'B', N'75982244', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2903, N'GODREJCP', CAST(N'2022-05-16T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(784.70000000 AS Decimal(19, 8)), N'B', N'25827871', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2904, N'HATSUN', CAST(N'2022-05-16T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(923.75000000 AS Decimal(19, 8)), N'B', N'25831612', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2905, N'TITAN', CAST(N'2022-05-16T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2149.70000000 AS Decimal(19, 8)), N'B', N'76000356', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2906, N'BERGEPAINT', CAST(N'2022-05-16T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(652.40000000 AS Decimal(19, 8)), N'B', N'974194', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2907, N'BERGEPAINT', CAST(N'2022-05-16T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(652.40000000 AS Decimal(19, 8)), N'B', N'974193', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2908, N'TATACONSUM', CAST(N'2022-05-16T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(743.15000000 AS Decimal(19, 8)), N'B', N'76015254', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2909, N'TCS', CAST(N'2022-05-16T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(3422.00000000 AS Decimal(19, 8)), N'B', N'76028426', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2910, N'JUBLFOOD', CAST(N'2022-05-16T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(483.30000000 AS Decimal(19, 8)), N'B', N'50735413', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2911, N'MARICO', CAST(N'2022-05-16T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(501.00000000 AS Decimal(19, 8)), N'B', N'50741063', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2912, N'ICICIBANK', CAST(N'2022-05-16T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(688.45000000 AS Decimal(19, 8)), N'B', N'25884166', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2913, N'BATAINDIA', CAST(N'2022-05-16T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1707.45000000 AS Decimal(19, 8)), N'B', N'1005843', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2914, N'HAVELLS', CAST(N'2022-05-16T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1242.60000000 AS Decimal(19, 8)), N'B', N'25899981', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2915, N'MUTHOOTFIN', CAST(N'2022-05-16T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1132.65000000 AS Decimal(19, 8)), N'B', N'50758452', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2916, N'TECHM', CAST(N'2022-05-16T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1215.55000000 AS Decimal(19, 8)), N'B', N'76063719', CAST(0.00000000 AS Decimal(19, 8)), CAST(1014.76500000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2917, N'AARTIIND', CAST(N'2022-05-16T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(760.40000000 AS Decimal(19, 8)), N'B', N'1029877', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2918, N'DABUR', CAST(N'2022-05-16T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(502.80000000 AS Decimal(19, 8)), N'B', N'25914582', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2919, N'DABUR', CAST(N'2022-05-16T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(502.65000000 AS Decimal(19, 8)), N'B', N'25914581', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2920, N'CHOLAFIN', CAST(N'2022-05-16T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(640.60000000 AS Decimal(19, 8)), N'B', N'1039989', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2921, N'CROMPTON', CAST(N'2022-05-16T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(354.50000000 AS Decimal(19, 8)), N'B', N'1041816', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2922, N'TATAMTRDVR', CAST(N'2022-05-16T00:00:00.000' AS DateTime), CAST(16.00000000 AS Decimal(19, 8)), CAST(196.00000000 AS Decimal(19, 8)), N'B', N'76119677', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2923, N'BATAINDIA', CAST(N'2022-06-22T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(1645.60000000 AS Decimal(19, 8)), N'S', N'2955100', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1707.45000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2924, N'BERGEPAINT', CAST(N'2022-06-22T00:00:00.000' AS DateTime), CAST(12.00000000 AS Decimal(19, 8)), CAST(583.90000000 AS Decimal(19, 8)), N'S', N'2741754', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(652.40000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2925, N'CROMPTON', CAST(N'2022-06-22T00:00:00.000' AS DateTime), CAST(18.00000000 AS Decimal(19, 8)), CAST(327.70000000 AS Decimal(19, 8)), N'S', N'2742234', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(379.20000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2926, N'CROMPTON', CAST(N'2022-06-22T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(327.70000000 AS Decimal(19, 8)), N'S', N'2743156', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(354.50000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2927, N'TATASTEEL', CAST(N'2022-06-22T00:00:00.000' AS DateTime), CAST(7.00000000 AS Decimal(19, 8)), CAST(845.55000000 AS Decimal(19, 8)), N'B', N'78612547', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2928, N'MANAPPURAM', CAST(N'2022-06-22T00:00:00.000' AS DateTime), CAST(65.00000000 AS Decimal(19, 8)), CAST(85.60000000 AS Decimal(19, 8)), N'B', N'53052437', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2929, N'ITC', CAST(N'2022-06-22T00:00:00.000' AS DateTime), CAST(10.00000000 AS Decimal(19, 8)), CAST(266.00000000 AS Decimal(19, 8)), N'B', N'28487264', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2930, N'ITC', CAST(N'2022-06-22T00:00:00.000' AS DateTime), CAST(10.00000000 AS Decimal(19, 8)), CAST(266.00000000 AS Decimal(19, 8)), N'B', N'28487288', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2931, N'HCLTECH', CAST(N'2022-06-23T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(970.95000000 AS Decimal(19, 8)), N'B', N'3750200', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2932, N'MANAPPURAM', CAST(N'2022-06-23T00:00:00.000' AS DateTime), CAST(6.00000000 AS Decimal(19, 8)), CAST(86.70000000 AS Decimal(19, 8)), N'B', N'50782338', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2933, N'TATASTEEL', CAST(N'2022-06-23T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(849.00000000 AS Decimal(19, 8)), N'B', N'76119401', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2934, N'AARTIIND', CAST(N'2022-08-22T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(799.25000000 AS Decimal(19, 8)), N'S', N'959652', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(867.70000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2935, N'ASIANPAINT', CAST(N'2022-08-22T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(3436.05000000 AS Decimal(19, 8)), N'S', N'965170', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1524.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2936, N'ASIANPAINT', CAST(N'2022-08-22T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(3436.05000000 AS Decimal(19, 8)), N'S', N'965193', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(3060.55000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2937, N'BAJFINANCE', CAST(N'2022-08-22T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(7154.70000000 AS Decimal(19, 8)), N'S', N'967482', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(7091.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2938, N'DIVISLAB', CAST(N'2022-08-22T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(3615.80000000 AS Decimal(19, 8)), N'S', N'25941894', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(4296.65000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2939, N'HAVELLS', CAST(N'2022-08-22T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(1319.95000000 AS Decimal(19, 8)), N'S', N'25945423', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1315.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2940, N'HAVELLS', CAST(N'2022-08-22T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1319.95000000 AS Decimal(19, 8)), N'S', N'25945424', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1242.60000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2941, N'DABUR', CAST(N'2022-08-22T00:00:00.000' AS DateTime), CAST(6.00000000 AS Decimal(19, 8)), CAST(583.10000000 AS Decimal(19, 8)), N'S', N'25963266', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(507.30000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2942, N'DABUR', CAST(N'2022-08-22T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(583.10000000 AS Decimal(19, 8)), N'S', N'25963655', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(555.35000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2943, N'DABUR', CAST(N'2022-08-22T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(583.10000000 AS Decimal(19, 8)), N'S', N'25964969', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(502.80000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2944, N'DABUR', CAST(N'2022-08-22T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(583.10000000 AS Decimal(19, 8)), N'S', N'25965925', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(502.65000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2945, N'HCLTECH', CAST(N'2022-08-22T00:00:00.000' AS DateTime), CAST(7.00000000 AS Decimal(19, 8)), CAST(961.10000000 AS Decimal(19, 8)), N'S', N'25966711', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(970.95000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2946, N'CHOLAFIN', CAST(N'2022-08-22T00:00:00.000' AS DateTime), CAST(10.00000000 AS Decimal(19, 8)), CAST(770.25000000 AS Decimal(19, 8)), N'S', N'1011571', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(640.60000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2947, N'HINDUNILVR', CAST(N'2022-08-22T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(2655.00000000 AS Decimal(19, 8)), N'S', N'25971894', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(2135.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2948, N'ICICIBANK', CAST(N'2022-08-22T00:00:00.000' AS DateTime), CAST(10.00000000 AS Decimal(19, 8)), CAST(860.70000000 AS Decimal(19, 8)), N'S', N'25978173', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(688.45000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2949, N'INFY', CAST(N'2022-08-22T00:00:00.000' AS DateTime), CAST(8.00000000 AS Decimal(19, 8)), CAST(1591.70000000 AS Decimal(19, 8)), N'S', N'3044100', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1586.50000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2950, N'ITC', CAST(N'2022-08-22T00:00:00.000' AS DateTime), CAST(20.00000000 AS Decimal(19, 8)), CAST(314.40000000 AS Decimal(19, 8)), N'S', N'1271400', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(266.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2951, N'HDFCBANK', CAST(N'2022-08-22T00:00:00.000' AS DateTime), CAST(8.00000000 AS Decimal(19, 8)), CAST(1473.90000000 AS Decimal(19, 8)), N'S', N'2876900', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1354.85000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2952, N'BRITANNIA', CAST(N'2022-08-22T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(3700.40000000 AS Decimal(19, 8)), N'S', N'1091400', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(3219.80000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2953, N'KOTAKBANK', CAST(N'2022-08-22T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(1822.50000000 AS Decimal(19, 8)), N'S', N'1481000', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1809.20000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2954, N'MANAPPURAM', CAST(N'2022-08-22T00:00:00.000' AS DateTime), CAST(71.00000000 AS Decimal(19, 8)), CAST(101.80000000 AS Decimal(19, 8)), N'S', N'50893135', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(86.70000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2955, N'MUTHOOTFIN', CAST(N'2022-08-22T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(1028.00000000 AS Decimal(19, 8)), N'S', N'50897723', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1132.65000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2956, N'MARICO', CAST(N'2022-08-22T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(517.30000000 AS Decimal(19, 8)), N'S', N'1413400', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(237.95000000 AS Decimal(19, 8)))
GO
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2957, N'MARICO', CAST(N'2022-08-22T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(517.30000000 AS Decimal(19, 8)), N'S', N'1418400', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(237.95000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2958, N'PIDILITIND', CAST(N'2022-08-22T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(2661.75000000 AS Decimal(19, 8)), N'S', N'50900145', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(2424.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2959, N'RELIANCE', CAST(N'2022-08-22T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(2614.60000000 AS Decimal(19, 8)), N'S', N'76096611', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(2459.55000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2960, N'TATACONSUM', CAST(N'2022-08-22T00:00:00.000' AS DateTime), CAST(9.00000000 AS Decimal(19, 8)), CAST(788.20000000 AS Decimal(19, 8)), N'S', N'1238400', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(743.15000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2961, N'TATAMTRDVR', CAST(N'2022-08-22T00:00:00.000' AS DateTime), CAST(36.00000000 AS Decimal(19, 8)), CAST(231.95000000 AS Decimal(19, 8)), N'S', N'76101007', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(196.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2962, N'TATASTEEL', CAST(N'2022-08-22T00:00:00.000' AS DateTime), CAST(90.00000000 AS Decimal(19, 8)), CAST(107.90000000 AS Decimal(19, 8)), N'S', N'76103980', CAST(81.00000000 AS Decimal(19, 8)), NULL, CAST(849.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2963, N'TCS', CAST(N'2022-08-22T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(3360.05000000 AS Decimal(19, 8)), N'S', N'76106397', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(3422.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2964, N'RELAXO', CAST(N'2022-08-22T00:00:00.000' AS DateTime), CAST(6.00000000 AS Decimal(19, 8)), CAST(986.90000000 AS Decimal(19, 8)), N'S', N'3743100', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1022.65000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2965, N'TITAN', CAST(N'2022-08-22T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(2413.50000000 AS Decimal(19, 8)), N'S', N'76110520', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(2149.70000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2966, N'TECHM', CAST(N'2022-08-22T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(1086.35000000 AS Decimal(19, 8)), N'S', N'76112317', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1215.55000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2967, N'MARICO', CAST(N'2022-08-22T00:00:00.000' AS DateTime), CAST(11.00000000 AS Decimal(19, 8)), CAST(517.30000000 AS Decimal(19, 8)), N'S', N'1462100', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(501.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2968, N'HATSUN', CAST(N'2022-08-22T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1085.10000000 AS Decimal(19, 8)), N'S', N'26053967', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(477.10000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2969, N'HATSUN', CAST(N'2022-08-22T00:00:00.000' AS DateTime), CAST(6.00000000 AS Decimal(19, 8)), CAST(1085.00000000 AS Decimal(19, 8)), N'S', N'26053968', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(923.75000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2970, N'HATSUN', CAST(N'2022-08-22T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1085.10000000 AS Decimal(19, 8)), N'S', N'26053966', CAST(1.00000000 AS Decimal(19, 8)), NULL, CAST(923.75000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2971, N'JUBLFOOD', CAST(N'2022-08-22T00:00:00.000' AS DateTime), CAST(15.00000000 AS Decimal(19, 8)), CAST(575.40000000 AS Decimal(19, 8)), N'S', N'50957398', CAST(8.00000000 AS Decimal(19, 8)), NULL, CAST(483.30000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2972, N'GODREJCP', CAST(N'2022-08-22T00:00:00.000' AS DateTime), CAST(9.00000000 AS Decimal(19, 8)), CAST(893.45000000 AS Decimal(19, 8)), N'S', N'1788000', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(784.70000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2973, N'GODREJCP', CAST(N'2022-08-22T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(893.50000000 AS Decimal(19, 8)), N'S', N'1787800', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(784.70000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2974, N'AARTIIND', CAST(N'2022-08-22T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(794.15000000 AS Decimal(19, 8)), N'S', N'1105647', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(922.80000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2975, N'AARTIIND', CAST(N'2022-08-22T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(794.15000000 AS Decimal(19, 8)), N'S', N'1105648', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(760.40000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2986, N'ASIANPAINT', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(3218.55000000 AS Decimal(19, 8)), N'B', N'3592317', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2987, N'AXISBANK', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(12.00000000 AS Decimal(19, 8)), CAST(818.30000000 AS Decimal(19, 8)), N'B', N'3594304', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2988, N'BRITANNIA', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(3750.00000000 AS Decimal(19, 8)), N'B', N'3597824', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2989, N'BAJFINANCE', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(7370.10000000 AS Decimal(19, 8)), N'B', N'3598551', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2990, N'CHOLAFIN', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(13.00000000 AS Decimal(19, 8)), CAST(742.30000000 AS Decimal(19, 8)), N'B', N'3600763', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2991, N'DABUR', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(19.00000000 AS Decimal(19, 8)), CAST(531.35000000 AS Decimal(19, 8)), N'B', N'28978652', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2992, N'DIVISLAB', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(3564.40000000 AS Decimal(19, 8)), N'B', N'28980843', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2993, N'DMART', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(4141.95000000 AS Decimal(19, 8)), N'B', N'28981514', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2994, N'DMART', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(4141.95000000 AS Decimal(19, 8)), N'B', N'28981513', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2995, N'GODREJCP', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(12.00000000 AS Decimal(19, 8)), CAST(834.05000000 AS Decimal(19, 8)), N'B', N'28982670', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2996, N'HDFC', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(2324.95000000 AS Decimal(19, 8)), N'B', N'28998461', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2997, N'HDFCBANK', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(7.00000000 AS Decimal(19, 8)), CAST(1442.05000000 AS Decimal(19, 8)), N'B', N'28999060', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2998, N'HCLTECH', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(10.00000000 AS Decimal(19, 8)), CAST(1006.35000000 AS Decimal(19, 8)), N'B', N'28999618', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (2999, N'HINDUNILVR', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(2603.60000000 AS Decimal(19, 8)), N'B', N'29000731', CAST(0.00000000 AS Decimal(19, 8)), CAST(2646.30000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3000, N'INFY', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(6.00000000 AS Decimal(19, 8)), CAST(1500.45000000 AS Decimal(19, 8)), N'B', N'29004321', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3001, N'ICICIBANK', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(10.00000000 AS Decimal(19, 8)), CAST(895.25000000 AS Decimal(19, 8)), N'B', N'29004902', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3002, N'ITC', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(30.00000000 AS Decimal(19, 8)), CAST(339.45000000 AS Decimal(19, 8)), N'B', N'29005440', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3003, N'JUBLFOOD', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(17.00000000 AS Decimal(19, 8)), CAST(599.80000000 AS Decimal(19, 8)), N'B', N'53450757', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3004, N'KOTAKBANK', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1860.20000000 AS Decimal(19, 8)), N'B', N'53452865', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3005, N'KOTAKBANK', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1860.20000000 AS Decimal(19, 8)), N'B', N'53452866', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3006, N'KOTAKBANK', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1860.20000000 AS Decimal(19, 8)), N'B', N'53452867', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3007, N'LT', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(1911.50000000 AS Decimal(19, 8)), N'B', N'53454282', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3008, N'NAUKRI', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(3842.50000000 AS Decimal(19, 8)), N'B', N'53458048', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3009, N'HATSUN', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(995.25000000 AS Decimal(19, 8)), N'B', N'29014308', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3010, N'HATSUN', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(9.00000000 AS Decimal(19, 8)), CAST(995.25000000 AS Decimal(19, 8)), N'B', N'29014312', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3011, N'PIDILITIND', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(2705.60000000 AS Decimal(19, 8)), N'B', N'53459646', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3012, N'MARICO', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(19.00000000 AS Decimal(19, 8)), CAST(514.10000000 AS Decimal(19, 8)), N'B', N'53459887', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3013, N'RELIANCE', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(2451.05000000 AS Decimal(19, 8)), N'B', N'79112834', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3014, N'SBIN', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(18.00000000 AS Decimal(19, 8)), CAST(561.75000000 AS Decimal(19, 8)), N'B', N'79114085', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3015, N'SRF', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(2560.25000000 AS Decimal(19, 8)), N'B', N'79116121', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3016, N'TATACONSUM', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(13.00000000 AS Decimal(19, 8)), CAST(773.20000000 AS Decimal(19, 8)), N'B', N'79119034', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3017, N'TITAN', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(2634.50000000 AS Decimal(19, 8)), N'B', N'79120420', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3018, N'TITAN', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2634.50000000 AS Decimal(19, 8)), N'B', N'79121216', CAST(0.00000000 AS Decimal(19, 8)), CAST(2492.75000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3019, N'TCS', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(3136.60000000 AS Decimal(19, 8)), N'B', N'79122320', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3020, N'AXISBANK', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(818.00000000 AS Decimal(19, 8)), N'B', N'3661978', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3021, N'HATSUN', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(994.00000000 AS Decimal(19, 8)), N'B', N'29031796', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3022, N'HCLTECH', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1006.75000000 AS Decimal(19, 8)), N'B', N'29034189', CAST(0.00000000 AS Decimal(19, 8)), CAST(1117.37692308 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3023, N'ICICIBANK', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(895.90000000 AS Decimal(19, 8)), N'B', N'29035142', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3024, N'CHOLAFIN', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(742.40000000 AS Decimal(19, 8)), N'B', N'3673807', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3025, N'TATACONSUM', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(772.80000000 AS Decimal(19, 8)), N'B', N'79139616', CAST(0.00000000 AS Decimal(19, 8)), CAST(766.41666667 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3026, N'DABUR', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(530.95000000 AS Decimal(19, 8)), N'B', N'29039260', CAST(0.00000000 AS Decimal(19, 8)), CAST(565.07083333 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3027, N'JUBLFOOD', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(600.30000000 AS Decimal(19, 8)), N'B', N'53486441', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3028, N'MARICO', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(514.40000000 AS Decimal(19, 8)), N'B', N'53487902', CAST(0.00000000 AS Decimal(19, 8)), CAST(513.87000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3029, N'SBIN', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(562.10000000 AS Decimal(19, 8)), N'B', N'79148138', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3030, N'GODREJCP', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(832.30000000 AS Decimal(19, 8)), N'B', N'29045685', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3031, N'RELIANCE', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2452.65000000 AS Decimal(19, 8)), N'B', N'79155648', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3032, N'INFY', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1501.15000000 AS Decimal(19, 8)), N'B', N'29051286', CAST(0.00000000 AS Decimal(19, 8)), CAST(1582.47631579 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3033, N'HDFC', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2323.85000000 AS Decimal(19, 8)), N'B', N'29052343', CAST(0.00000000 AS Decimal(19, 8)), CAST(2663.90000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3034, N'TCS', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(3137.00000000 AS Decimal(19, 8)), N'B', N'79159003', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3035, N'BAJFINANCE', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(7374.90000000 AS Decimal(19, 8)), N'B', N'3710308', CAST(0.00000000 AS Decimal(19, 8)), CAST(6583.55000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3036, N'ICICIBANK', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(897.00000000 AS Decimal(19, 8)), N'B', N'29061244', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3037, N'TCS', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(3137.50000000 AS Decimal(19, 8)), N'B', N'79170093', CAST(0.00000000 AS Decimal(19, 8)), CAST(3413.93750000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3038, N'BRITANNIA', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(3751.00000000 AS Decimal(19, 8)), N'B', N'3715380', CAST(0.00000000 AS Decimal(19, 8)), CAST(4331.90000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3039, N'ICICIBANK', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(896.75000000 AS Decimal(19, 8)), N'B', N'29068695', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3040, N'HAVELLS', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1257.45000000 AS Decimal(19, 8)), N'B', N'29154532', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3041, N'HDFCBANK', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1443.00000000 AS Decimal(19, 8)), N'B', N'29482669', CAST(0.00000000 AS Decimal(19, 8)), CAST(1623.95833333 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3042, N'ITC', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(340.50000000 AS Decimal(19, 8)), N'B', N'29551123', CAST(0.00000000 AS Decimal(19, 8)), CAST(340.78461538 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3044, N'ASIANPAINT', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(3085.80000000 AS Decimal(19, 8)), N'S', N'841950', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(3218.55000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3045, N'AXISBANK', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(13.00000000 AS Decimal(19, 8)), CAST(909.75000000 AS Decimal(19, 8)), N'S', N'843722', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(818.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3046, N'BAJFINANCE', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(7038.95000000 AS Decimal(19, 8)), N'S', N'845889', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(7374.90000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3047, N'BRITANNIA', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(3714.80000000 AS Decimal(19, 8)), N'S', N'869302', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(3751.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3048, N'CHOLAFIN', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(14.00000000 AS Decimal(19, 8)), CAST(710.25000000 AS Decimal(19, 8)), N'S', N'871129', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(742.40000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3049, N'DABUR', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(21.00000000 AS Decimal(19, 8)), CAST(540.95000000 AS Decimal(19, 8)), N'S', N'25907878', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(530.95000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3050, N'DIVISLAB', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(3619.95000000 AS Decimal(19, 8)), N'S', N'797200', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(3564.40000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3051, N'DMART', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(4238.25000000 AS Decimal(19, 8)), N'S', N'25910966', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(4141.95000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3052, N'HAVELLS', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1178.30000000 AS Decimal(19, 8)), N'S', N'644200', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1257.45000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3053, N'HDFC', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(2385.50000000 AS Decimal(19, 8)), N'S', N'25926525', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(2323.85000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3054, N'HDFCBANK', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(8.00000000 AS Decimal(19, 8)), CAST(1460.10000000 AS Decimal(19, 8)), N'S', N'25928791', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1443.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3055, N'ICICIBANK', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(929.35000000 AS Decimal(19, 8)), N'S', N'25931728', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(895.25000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3056, N'ICICIBANK', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(11.00000000 AS Decimal(19, 8)), CAST(929.35000000 AS Decimal(19, 8)), N'S', N'25931727', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(896.75000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3057, N'INFY', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1520.10000000 AS Decimal(19, 8)), N'S', N'25933199', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1500.45000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3058, N'INFY', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1520.10000000 AS Decimal(19, 8)), N'S', N'25933198', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1500.45000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3059, N'INFY', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1520.10000000 AS Decimal(19, 8)), N'S', N'25933200', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1500.45000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3060, N'INFY', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1520.10000000 AS Decimal(19, 8)), N'S', N'25933202', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1500.45000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3061, N'INFY', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1520.10000000 AS Decimal(19, 8)), N'S', N'25933201', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1500.45000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3062, N'INFY', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1520.10000000 AS Decimal(19, 8)), N'S', N'25933197', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1500.45000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3063, N'INFY', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1520.10000000 AS Decimal(19, 8)), N'S', N'25933196', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1501.15000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3064, N'GODREJCP', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(13.00000000 AS Decimal(19, 8)), CAST(824.45000000 AS Decimal(19, 8)), N'S', N'25934723', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(832.30000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3065, N'ITC', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(34.00000000 AS Decimal(19, 8)), CAST(345.60000000 AS Decimal(19, 8)), N'S', N'25934655', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(340.50000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3066, N'JUBLFOOD', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(19.00000000 AS Decimal(19, 8)), CAST(596.30000000 AS Decimal(19, 8)), N'S', N'50931539', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(600.30000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3067, N'LT', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(1952.95000000 AS Decimal(19, 8)), N'S', N'50943914', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1911.50000000 AS Decimal(19, 8)))
GO
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3068, N'MARICO', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(21.00000000 AS Decimal(19, 8)), CAST(519.05000000 AS Decimal(19, 8)), N'S', N'1364300', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(514.40000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3069, N'NAUKRI', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(3893.00000000 AS Decimal(19, 8)), N'S', N'50946230', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(3842.50000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3070, N'NAUKRI', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(3893.00000000 AS Decimal(19, 8)), N'S', N'50948400', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(3842.50000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3071, N'RELIANCE', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(2461.00000000 AS Decimal(19, 8)), N'S', N'2029200', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(2452.65000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3072, N'SBIN', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(20.00000000 AS Decimal(19, 8)), CAST(580.80000000 AS Decimal(19, 8)), N'S', N'75988255', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(562.10000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3073, N'TCS', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(3164.70000000 AS Decimal(19, 8)), N'S', N'75994315', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(3137.50000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3074, N'TITAN', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(2749.90000000 AS Decimal(19, 8)), N'S', N'75996129', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(2634.50000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3075, N'TATACONSUM', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(773.80000000 AS Decimal(19, 8)), N'S', N'1377300', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(773.20000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3076, N'HCLTECH', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(11.00000000 AS Decimal(19, 8)), CAST(1021.40000000 AS Decimal(19, 8)), N'S', N'25968838', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1006.75000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3077, N'HINDUNILVR', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(2497.95000000 AS Decimal(19, 8)), N'S', N'26001252', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(2603.60000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3079, N'TATACONSUM', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(770.95000000 AS Decimal(19, 8)), N'S', N'1636600', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(773.20000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3080, N'TATACONSUM', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(12.00000000 AS Decimal(19, 8)), CAST(770.95000000 AS Decimal(19, 8)), N'S', N'1640400', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(772.80000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3081, N'PIDILITIND', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(2594.00000000 AS Decimal(19, 8)), N'S', N'1868600', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(2705.60000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3082, N'KOTAKBANK', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(1870.75000000 AS Decimal(19, 8)), N'S', N'51172494', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1860.20000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3083, N'HATSUN', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(10.00000000 AS Decimal(19, 8)), CAST(950.00000000 AS Decimal(19, 8)), N'S', N'2439900', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(995.25000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3084, N'SRF', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(2492.15000000 AS Decimal(19, 8)), N'S', N'2476800', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(2560.25000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3085, N'HATSUN', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(949.05000000 AS Decimal(19, 8)), N'S', N'2481100', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(994.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3087, N'BRITANNIA-N3', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(28.98000000 AS Decimal(19, 8)), N'S', N'3844420', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3093, N'INDIGRID', CAST(N'2022-11-14T00:00:00.000' AS DateTime), CAST(14.00000000 AS Decimal(19, 8)), CAST(140.50000000 AS Decimal(19, 8)), N'B', N'27248415', CAST(0.00000000 AS Decimal(19, 8)), CAST(132.20000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3094, N'PGINVIT', CAST(N'2022-11-14T00:00:00.000' AS DateTime), CAST(15.00000000 AS Decimal(19, 8)), CAST(130.09000000 AS Decimal(19, 8)), N'B', N'51876547', CAST(0.00000000 AS Decimal(19, 8)), CAST(120.10000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3096, N'LODHA', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1075.00000000 AS Decimal(19, 8)), N'B', N'54013722', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3097, N'LODHA', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(11.00000000 AS Decimal(19, 8)), CAST(1075.00000000 AS Decimal(19, 8)), N'B', N'54013723', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3098, N'MOTHERSON', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(195.00000000 AS Decimal(19, 8)), CAST(75.40000000 AS Decimal(19, 8)), N'B', N'54015171', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3099, N'GODREJPROP', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(10.00000000 AS Decimal(19, 8)), CAST(1351.65000000 AS Decimal(19, 8)), N'B', N'29348927', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3100, N'POLICYBZR', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(6.00000000 AS Decimal(19, 8)), CAST(478.50000000 AS Decimal(19, 8)), N'B', N'54018320', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3101, N'POLICYBZR', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(478.50000000 AS Decimal(19, 8)), N'B', N'54018303', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3102, N'POLICYBZR', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(478.50000000 AS Decimal(19, 8)), N'B', N'54018304', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3103, N'POLICYBZR', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(478.50000000 AS Decimal(19, 8)), N'B', N'54018305', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3104, N'POLICYBZR', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(16.00000000 AS Decimal(19, 8)), CAST(478.50000000 AS Decimal(19, 8)), N'B', N'54018306', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3105, N'POLICYBZR', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(478.50000000 AS Decimal(19, 8)), N'B', N'54018319', CAST(0.00000000 AS Decimal(19, 8)), CAST(478.50000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3106, N'TRIDENT', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(385.00000000 AS Decimal(19, 8)), CAST(37.85000000 AS Decimal(19, 8)), N'B', N'79813495', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3107, N'GODREJIND', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(31.00000000 AS Decimal(19, 8)), CAST(463.60000000 AS Decimal(19, 8)), N'B', N'29358751', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3108, N'SUVENPHAR', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(30.00000000 AS Decimal(19, 8)), CAST(464.60000000 AS Decimal(19, 8)), N'B', N'79820278', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3109, N'GRAPHITE', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(36.00000000 AS Decimal(19, 8)), CAST(404.00000000 AS Decimal(19, 8)), N'B', N'29367859', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3110, N'BCG', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(404.00000000 AS Decimal(19, 8)), CAST(34.10000000 AS Decimal(19, 8)), N'B', N'3231155', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3111, N'INTELLECT', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(15.00000000 AS Decimal(19, 8)), CAST(464.50000000 AS Decimal(19, 8)), N'B', N'29375566', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3112, N'INTELLECT', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(15.00000000 AS Decimal(19, 8)), CAST(464.50000000 AS Decimal(19, 8)), N'B', N'29375565', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3113, N'GREENPANEL', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(385.00000000 AS Decimal(19, 8)), N'B', N'29379522', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3114, N'GREENPANEL', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(32.00000000 AS Decimal(19, 8)), CAST(385.00000000 AS Decimal(19, 8)), N'B', N'29379521', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3115, N'SYMPHONY', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(15.00000000 AS Decimal(19, 8)), CAST(937.15000000 AS Decimal(19, 8)), N'B', N'79843521', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3116, N'HATHWAY', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(833.00000000 AS Decimal(19, 8)), CAST(17.60000000 AS Decimal(19, 8)), N'B', N'29384886', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3117, N'NIITLTD', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(42.00000000 AS Decimal(19, 8)), CAST(335.00000000 AS Decimal(19, 8)), N'B', N'54047507', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3118, N'MASTEK', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1773.25000000 AS Decimal(19, 8)), N'B', N'54049487', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3119, N'HEMIPROP', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(42.00000000 AS Decimal(19, 8)), CAST(114.30000000 AS Decimal(19, 8)), N'B', N'29388696', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3120, N'HEMIPROP', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(20.00000000 AS Decimal(19, 8)), CAST(114.30000000 AS Decimal(19, 8)), N'B', N'29388695', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3121, N'HEMIPROP', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(80.00000000 AS Decimal(19, 8)), CAST(114.30000000 AS Decimal(19, 8)), N'B', N'29388694', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3122, N'ARVIND', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(128.00000000 AS Decimal(19, 8)), CAST(102.30000000 AS Decimal(19, 8)), N'B', N'3249114', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3123, N'ARVIND', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(17.00000000 AS Decimal(19, 8)), CAST(102.30000000 AS Decimal(19, 8)), N'B', N'3249113', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3124, N'NEWGEN', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(25.00000000 AS Decimal(19, 8)), CAST(381.45000000 AS Decimal(19, 8)), N'B', N'54055262', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3125, N'NEWGEN', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(381.45000000 AS Decimal(19, 8)), N'B', N'54055261', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3126, N'NEWGEN', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(381.45000000 AS Decimal(19, 8)), N'B', N'54055264', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3127, N'ASHOKA', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(177.00000000 AS Decimal(19, 8)), CAST(81.50000000 AS Decimal(19, 8)), N'B', N'3252644', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3128, N'HERANBA', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(537.45000000 AS Decimal(19, 8)), N'B', N'29401525', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3129, N'NEWGEN', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(6.00000000 AS Decimal(19, 8)), CAST(381.45000000 AS Decimal(19, 8)), N'B', N'54065884', CAST(0.00000000 AS Decimal(19, 8)), CAST(381.45000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3130, N'MOREPENLAB', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(468.00000000 AS Decimal(19, 8)), CAST(32.00000000 AS Decimal(19, 8)), N'B', N'54068650', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3131, N'MASTEK', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1773.25000000 AS Decimal(19, 8)), N'B', N'54070391', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3132, N'IMFA', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(54.00000000 AS Decimal(19, 8)), CAST(269.55000000 AS Decimal(19, 8)), N'B', N'29413086', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3133, N'COSMOFIRST', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(10.00000000 AS Decimal(19, 8)), CAST(827.35000000 AS Decimal(19, 8)), N'B', N'3265471', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3134, N'SPORTKING', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(781.45000000 AS Decimal(19, 8)), N'B', N'79884078', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3135, N'SPORTKING', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(15.00000000 AS Decimal(19, 8)), CAST(781.45000000 AS Decimal(19, 8)), N'B', N'79884080', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3136, N'SPORTKING', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(781.45000000 AS Decimal(19, 8)), N'B', N'79884079', CAST(0.00000000 AS Decimal(19, 8)), CAST(781.45000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3137, N'FINOPB', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(50.00000000 AS Decimal(19, 8)), CAST(241.00000000 AS Decimal(19, 8)), N'B', N'29417091', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3138, N'MASTEK', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(6.00000000 AS Decimal(19, 8)), CAST(1773.25000000 AS Decimal(19, 8)), N'B', N'54076820', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3139, N'OPTIEMUS', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(35.00000000 AS Decimal(19, 8)), CAST(258.00000000 AS Decimal(19, 8)), N'B', N'54077973', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3140, N'HERANBA', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(10.00000000 AS Decimal(19, 8)), CAST(537.45000000 AS Decimal(19, 8)), N'B', N'29424699', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3141, N'HERANBA', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(537.45000000 AS Decimal(19, 8)), N'B', N'29424701', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3142, N'HERANBA', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(537.45000000 AS Decimal(19, 8)), N'B', N'29424944', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3143, N'FINOPB', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(10.00000000 AS Decimal(19, 8)), CAST(241.30000000 AS Decimal(19, 8)), N'B', N'29426336', CAST(0.00000000 AS Decimal(19, 8)), CAST(241.30000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3144, N'HERANBA', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(14.00000000 AS Decimal(19, 8)), CAST(537.50000000 AS Decimal(19, 8)), N'B', N'29430761', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3145, N'OPTIEMUS', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(258.65000000 AS Decimal(19, 8)), N'B', N'54091157', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3146, N'OPTIEMUS', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(22.00000000 AS Decimal(19, 8)), CAST(258.65000000 AS Decimal(19, 8)), N'B', N'54091158', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3147, N'COSMOFIRST', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(828.85000000 AS Decimal(19, 8)), N'B', N'3285524', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3148, N'COSMOFIRST', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(828.85000000 AS Decimal(19, 8)), N'B', N'3285525', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3149, N'COSMOFIRST', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(828.85000000 AS Decimal(19, 8)), N'B', N'3285535', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3150, N'GALLANTT', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(164.00000000 AS Decimal(19, 8)), CAST(65.50000000 AS Decimal(19, 8)), N'B', N'29443419', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3151, N'GALLANTT', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(50.00000000 AS Decimal(19, 8)), CAST(65.50000000 AS Decimal(19, 8)), N'B', N'29443418', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3152, N'GALLANTT', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(8.00000000 AS Decimal(19, 8)), CAST(65.50000000 AS Decimal(19, 8)), N'B', N'29443417', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3153, N'TIRUMALCHM', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(33.00000000 AS Decimal(19, 8)), CAST(217.60000000 AS Decimal(19, 8)), N'B', N'79921819', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3154, N'TIRUMALCHM', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(21.00000000 AS Decimal(19, 8)), CAST(217.60000000 AS Decimal(19, 8)), N'B', N'79921818', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3155, N'TIRUMALCHM', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(16.00000000 AS Decimal(19, 8)), CAST(217.60000000 AS Decimal(19, 8)), N'B', N'79921817', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3156, N'ICIL', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(8.00000000 AS Decimal(19, 8)), CAST(140.55000000 AS Decimal(19, 8)), N'B', N'29453053', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3157, N'ICIL', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(95.00000000 AS Decimal(19, 8)), CAST(140.55000000 AS Decimal(19, 8)), N'B', N'29453052', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3158, N'ARVIND', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(50.00000000 AS Decimal(19, 8)), CAST(101.50000000 AS Decimal(19, 8)), N'S', N'1406723', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(102.30000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3159, N'ARVIND', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(101.50000000 AS Decimal(19, 8)), N'S', N'1406724', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(102.30000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3160, N'ARVIND', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(101.50000000 AS Decimal(19, 8)), N'S', N'1406725', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(102.30000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3161, N'ARVIND', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(101.50000000 AS Decimal(19, 8)), N'S', N'1406726', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(102.30000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3162, N'ARVIND', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(88.00000000 AS Decimal(19, 8)), CAST(101.50000000 AS Decimal(19, 8)), N'S', N'1406727', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(102.30000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3163, N'ASHOKA', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(177.00000000 AS Decimal(19, 8)), CAST(80.20000000 AS Decimal(19, 8)), N'S', N'1407490', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(81.50000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3164, N'BCG', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(404.00000000 AS Decimal(19, 8)), CAST(33.80000000 AS Decimal(19, 8)), N'S', N'43314800', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(34.10000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3165, N'COSMOFIRST', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(13.00000000 AS Decimal(19, 8)), CAST(827.60000000 AS Decimal(19, 8)), N'S', N'43335400', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(828.85000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3166, N'COSMOFIRST', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(827.45000000 AS Decimal(19, 8)), N'S', N'43335600', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(828.85000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3167, N'COSMOFIRST', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(827.65000000 AS Decimal(19, 8)), N'S', N'43335200', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(828.85000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3168, N'GALLANTT', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(222.00000000 AS Decimal(19, 8)), CAST(64.50000000 AS Decimal(19, 8)), N'S', N'22441400', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(65.50000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3169, N'GODREJIND', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(461.00000000 AS Decimal(19, 8)), N'S', N'2129900', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(463.60000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3170, N'GREENPANEL', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(9.00000000 AS Decimal(19, 8)), CAST(384.40000000 AS Decimal(19, 8)), N'S', N'43608200', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(385.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3171, N'GREENPANEL', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(28.00000000 AS Decimal(19, 8)), CAST(384.35000000 AS Decimal(19, 8)), N'S', N'43608500', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(385.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3172, N'GODREJIND', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(461.00000000 AS Decimal(19, 8)), N'S', N'2141500', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(463.60000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3173, N'GODREJIND', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(461.00000000 AS Decimal(19, 8)), N'S', N'2141700', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(463.60000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3174, N'HATHWAY', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(833.00000000 AS Decimal(19, 8)), CAST(17.30000000 AS Decimal(19, 8)), N'S', N'43687600', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(17.60000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3175, N'HERANBA', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(22.00000000 AS Decimal(19, 8)), CAST(531.70000000 AS Decimal(19, 8)), N'S', N'26606573', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(537.50000000 AS Decimal(19, 8)))
GO
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3176, N'HERANBA', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(531.75000000 AS Decimal(19, 8)), N'S', N'26606572', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(537.50000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3177, N'IMFA', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(54.00000000 AS Decimal(19, 8)), CAST(267.55000000 AS Decimal(19, 8)), N'S', N'22618400', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(269.55000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3178, N'HEMIPROP', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(142.00000000 AS Decimal(19, 8)), CAST(113.85000000 AS Decimal(19, 8)), N'S', N'26611644', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(114.30000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3179, N'LODHA', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(13.00000000 AS Decimal(19, 8)), CAST(1065.90000000 AS Decimal(19, 8)), N'S', N'43963100', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1075.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3180, N'INTELLECT', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(465.00000000 AS Decimal(19, 8)), N'S', N'26620375', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(464.50000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3181, N'MASTEK', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(1802.25000000 AS Decimal(19, 8)), N'S', N'43982600', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1773.25000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3182, N'MASTEK', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1802.25000000 AS Decimal(19, 8)), N'S', N'43983000', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1773.25000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3183, N'MASTEK', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(1802.25000000 AS Decimal(19, 8)), N'S', N'43982800', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1773.25000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3184, N'NEWGEN', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(18.00000000 AS Decimal(19, 8)), CAST(371.35000000 AS Decimal(19, 8)), N'S', N'44047700', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(381.45000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3185, N'NEWGEN', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(371.35000000 AS Decimal(19, 8)), N'S', N'44053400', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(381.45000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3186, N'INTELLECT', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(465.00000000 AS Decimal(19, 8)), N'S', N'26626079', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(464.50000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3187, N'INTELLECT', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(465.00000000 AS Decimal(19, 8)), N'S', N'26626384', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(464.50000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3188, N'INTELLECT', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(26.00000000 AS Decimal(19, 8)), CAST(465.00000000 AS Decimal(19, 8)), N'S', N'26627452', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(464.50000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3189, N'POLICYBZR', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(469.35000000 AS Decimal(19, 8)), N'S', N'51620410', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(478.50000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3190, N'POLICYBZR', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(22.00000000 AS Decimal(19, 8)), CAST(469.35000000 AS Decimal(19, 8)), N'S', N'51620411', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(478.50000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3191, N'POLICYBZR', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(469.50000000 AS Decimal(19, 8)), N'S', N'51620407', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(478.50000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3192, N'POLICYBZR', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(469.50000000 AS Decimal(19, 8)), N'S', N'51620409', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(478.50000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3193, N'POLICYBZR', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(469.50000000 AS Decimal(19, 8)), N'S', N'51620408', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(478.50000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3194, N'SUVENPHAR', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(10.00000000 AS Decimal(19, 8)), CAST(456.60000000 AS Decimal(19, 8)), N'S', N'76839235', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(464.60000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3195, N'SUVENPHAR', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(15.00000000 AS Decimal(19, 8)), CAST(456.50000000 AS Decimal(19, 8)), N'S', N'76839237', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(464.60000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3196, N'SUVENPHAR', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(456.55000000 AS Decimal(19, 8)), N'S', N'76839236', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(464.60000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3197, N'NEWGEN', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(20.00000000 AS Decimal(19, 8)), CAST(371.35000000 AS Decimal(19, 8)), N'S', N'44201300', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(381.45000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3198, N'TRIDENT', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(385.00000000 AS Decimal(19, 8)), CAST(37.10000000 AS Decimal(19, 8)), N'S', N'44209300', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(37.85000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3199, N'SYMPHONY', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(15.00000000 AS Decimal(19, 8)), CAST(924.90000000 AS Decimal(19, 8)), N'S', N'76849844', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(937.15000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3200, N'TIRUMALCHM', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(210.60000000 AS Decimal(19, 8)), N'S', N'44371100', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(217.60000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3201, N'MOREPENLAB', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(186.00000000 AS Decimal(19, 8)), CAST(32.25000000 AS Decimal(19, 8)), N'S', N'51631882', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(32.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3202, N'OPTIEMUS', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(58.00000000 AS Decimal(19, 8)), CAST(254.20000000 AS Decimal(19, 8)), N'S', N'51633729', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(258.65000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3203, N'MOREPENLAB', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(282.00000000 AS Decimal(19, 8)), CAST(32.25000000 AS Decimal(19, 8)), N'S', N'51634183', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(32.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3204, N'TIRUMALCHM', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(65.00000000 AS Decimal(19, 8)), CAST(210.25000000 AS Decimal(19, 8)), N'S', N'44521000', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(217.60000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3205, N'SPORTKING', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(16.00000000 AS Decimal(19, 8)), CAST(765.25000000 AS Decimal(19, 8)), N'S', N'2497300', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(781.45000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3206, N'SPORTKING', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(765.70000000 AS Decimal(19, 8)), N'S', N'2496900', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(781.45000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3207, N'SPORTKING', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(765.65000000 AS Decimal(19, 8)), N'S', N'2497100', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(781.45000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3208, N'MOTHERSON', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(195.00000000 AS Decimal(19, 8)), CAST(74.55000000 AS Decimal(19, 8)), N'S', N'3019200', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(75.40000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3209, N'ICIL', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(37.00000000 AS Decimal(19, 8)), CAST(139.35000000 AS Decimal(19, 8)), N'S', N'26652392', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(140.55000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3210, N'ICIL', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(10.00000000 AS Decimal(19, 8)), CAST(139.35000000 AS Decimal(19, 8)), N'S', N'26652393', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(140.55000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3211, N'ICIL', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(56.00000000 AS Decimal(19, 8)), CAST(139.30000000 AS Decimal(19, 8)), N'S', N'26652394', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(140.55000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3212, N'GODREJIND', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(10.00000000 AS Decimal(19, 8)), CAST(460.50000000 AS Decimal(19, 8)), N'S', N'2210200', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(463.60000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3213, N'GODREJIND', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(460.55000000 AS Decimal(19, 8)), N'S', N'2210000', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(463.60000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3214, N'GODREJIND', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(17.00000000 AS Decimal(19, 8)), CAST(460.65000000 AS Decimal(19, 8)), N'S', N'2209800', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(463.60000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3215, N'GRAPHITE', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(36.00000000 AS Decimal(19, 8)), CAST(399.05000000 AS Decimal(19, 8)), N'S', N'2382300', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(404.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3216, N'FINOPB', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(239.30000000 AS Decimal(19, 8)), N'S', N'26655263', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(241.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3217, N'FINOPB', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(35.00000000 AS Decimal(19, 8)), CAST(239.30000000 AS Decimal(19, 8)), N'S', N'26655262', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(241.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3218, N'FINOPB', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(239.25000000 AS Decimal(19, 8)), N'S', N'26655264', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(241.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3219, N'FINOPB', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(17.00000000 AS Decimal(19, 8)), CAST(239.20000000 AS Decimal(19, 8)), N'S', N'26655265', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(241.30000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3220, N'GODREJPROP', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(10.00000000 AS Decimal(19, 8)), CAST(1341.50000000 AS Decimal(19, 8)), N'S', N'26668367', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1351.65000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3221, N'NIITLTD', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(330.10000000 AS Decimal(19, 8)), N'S', N'44965700', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(335.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3222, N'NIITLTD', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(10.00000000 AS Decimal(19, 8)), CAST(330.15000000 AS Decimal(19, 8)), N'S', N'44965500', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(335.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3223, N'NIITLTD', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(30.00000000 AS Decimal(19, 8)), CAST(330.20000000 AS Decimal(19, 8)), N'S', N'44965100', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(335.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3232, N'RELIANCE', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(2649.55000000 AS Decimal(19, 8)), N'B', N'78940356', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3233, N'RELIANCE', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(2649.55000000 AS Decimal(19, 8)), N'B', N'78940094', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3234, N'TCS', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(3349.60000000 AS Decimal(19, 8)), N'B', N'78944775', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3235, N'TCS', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(3349.60000000 AS Decimal(19, 8)), N'B', N'78944774', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3236, N'HDFCBANK', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(8.00000000 AS Decimal(19, 8)), CAST(1620.00000000 AS Decimal(19, 8)), N'B', N'29379550', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3237, N'HINDUNILVR', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(2704.05000000 AS Decimal(19, 8)), N'B', N'29396174', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3238, N'ICICIBANK', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(14.00000000 AS Decimal(19, 8)), CAST(930.80000000 AS Decimal(19, 8)), N'B', N'29397223', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3239, N'SBIN', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(8.00000000 AS Decimal(19, 8)), CAST(611.75000000 AS Decimal(19, 8)), N'B', N'78969066', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3240, N'HDFC', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(2663.90000000 AS Decimal(19, 8)), N'B', N'29407118', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3241, N'BHARTIARTL', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(833.00000000 AS Decimal(19, 8)), N'B', N'3623265', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3242, N'ITC', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(19.00000000 AS Decimal(19, 8)), CAST(338.65000000 AS Decimal(19, 8)), N'B', N'29431565', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3243, N'INFY', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(7.00000000 AS Decimal(19, 8)), CAST(1620.90000000 AS Decimal(19, 8)), N'B', N'29433460', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3244, N'ASIANPAINT', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(3218.85000000 AS Decimal(19, 8)), N'B', N'3639759', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3245, N'HCLTECH', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1102.05000000 AS Decimal(19, 8)), N'B', N'29453157', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3246, N'BAJAJFINSV', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1618.95000000 AS Decimal(19, 8)), N'B', N'3668959', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3247, N'TITAN', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2585.75000000 AS Decimal(19, 8)), N'B', N'79049508', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3248, N'ADANIPORTS', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(892.35000000 AS Decimal(19, 8)), N'B', N'3690294', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3249, N'AXISBANK', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(936.45000000 AS Decimal(19, 8)), N'B', N'3695443', CAST(0.00000000 AS Decimal(19, 8)), CAST(927.51250000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3250, N'WIPRO', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(403.75000000 AS Decimal(19, 8)), N'B', N'79056812', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3251, N'JSWSTEEL', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(744.85000000 AS Decimal(19, 8)), N'B', N'54030699', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3252, N'ONGC', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(7.00000000 AS Decimal(19, 8)), CAST(142.60000000 AS Decimal(19, 8)), N'B', N'54034827', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3253, N'SUNPHARMA', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(980.60000000 AS Decimal(19, 8)), N'B', N'79065219', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3254, N'NTPC', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(10.00000000 AS Decimal(19, 8)), CAST(170.30000000 AS Decimal(19, 8)), N'B', N'54038072', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3255, N'POWERGRID', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(217.80000000 AS Decimal(19, 8)), N'B', N'54046842', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3256, N'POWERGRID', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(217.80000000 AS Decimal(19, 8)), N'B', N'54046843', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3257, N'POWERGRID', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(217.80000000 AS Decimal(19, 8)), N'B', N'54046935', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3258, N'TATAMOTORS', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(416.80000000 AS Decimal(19, 8)), N'B', N'79082702', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3259, N'TATASTEEL', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(16.00000000 AS Decimal(19, 8)), CAST(111.90000000 AS Decimal(19, 8)), N'B', N'79089954', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3260, N'SBILIFE', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1267.95000000 AS Decimal(19, 8)), N'B', N'79095397', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3261, N'M&M', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1273.95000000 AS Decimal(19, 8)), N'B', N'54068802', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3262, N'HINDALCO', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(472.10000000 AS Decimal(19, 8)), N'B', N'29567642', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3263, N'INDUSINDBK', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1191.25000000 AS Decimal(19, 8)), N'B', N'29580749', CAST(0.00000000 AS Decimal(19, 8)), CAST(1150.21250000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3264, N'TECHM', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1074.85000000 AS Decimal(19, 8)), N'B', N'79130781', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3265, N'CIPLA', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1106.95000000 AS Decimal(19, 8)), N'B', N'3777288', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3266, N'TATACONSUM', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(804.60000000 AS Decimal(19, 8)), N'B', N'79142665', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3267, N'ADANIENT', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(4023.75000000 AS Decimal(19, 8)), N'B', N'3789952', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3268, N'HDFCLIFE', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(577.95000000 AS Decimal(19, 8)), N'B', N'29607925', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3269, N'ULTRACEMCO', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(7173.65000000 AS Decimal(19, 8)), N'B', N'79185135', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3270, N'BAJFINANCE', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(6583.55000000 AS Decimal(19, 8)), N'B', N'3849306', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3271, N'LT', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(2170.20000000 AS Decimal(19, 8)), N'B', N'54178369', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3272, N'KOTAKBANK', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(1898.30000000 AS Decimal(19, 8)), N'B', N'54180148', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3273, N'ITC', CAST(N'2022-12-09T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(339.05000000 AS Decimal(19, 8)), N'B', N'29862814', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3274, N'ICICIBANK', CAST(N'2022-12-09T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(925.65000000 AS Decimal(19, 8)), N'B', N'29873163', CAST(0.00000000 AS Decimal(19, 8)), CAST(921.51052632 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3275, N'HDFCBANK', CAST(N'2022-12-09T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(1624.80000000 AS Decimal(19, 8)), N'B', N'29875192', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3276, N'ONGC', CAST(N'2022-12-09T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(141.05000000 AS Decimal(19, 8)), N'B', N'54399958', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3277, N'POWERGRID', CAST(N'2022-12-09T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(216.90000000 AS Decimal(19, 8)), N'B', N'54407234', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3278, N'INFY', CAST(N'2022-12-09T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1568.30000000 AS Decimal(19, 8)), N'B', N'29891762', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3279, N'RELIANCE', CAST(N'2022-12-09T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(2608.00000000 AS Decimal(19, 8)), N'B', N'79535750', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3280, N'BHARTIARTL', CAST(N'2022-12-09T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(830.75000000 AS Decimal(19, 8)), N'B', N'3856317', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3281, N'HINDALCO', CAST(N'2022-12-09T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(463.15000000 AS Decimal(19, 8)), N'B', N'29902283', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3282, N'JSWSTEEL', CAST(N'2022-12-09T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(740.80000000 AS Decimal(19, 8)), N'B', N'54424741', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3283, N'WIPRO', CAST(N'2022-12-09T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(392.50000000 AS Decimal(19, 8)), N'B', N'79545865', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
GO
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3284, N'GRASIM', CAST(N'2022-12-09T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1792.85000000 AS Decimal(19, 8)), N'B', N'29917815', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3285, N'KOTAKBANK', CAST(N'2022-12-09T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1885.60000000 AS Decimal(19, 8)), N'B', N'54438471', CAST(0.00000000 AS Decimal(19, 8)), CAST(1784.01250000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3286, N'TATAMOTORS', CAST(N'2022-12-09T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(412.30000000 AS Decimal(19, 8)), N'B', N'79570126', CAST(0.00000000 AS Decimal(19, 8)), CAST(412.30000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3287, N'LT', CAST(N'2022-12-09T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2152.60000000 AS Decimal(19, 8)), N'B', N'54454297', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3288, N'MARUTI', CAST(N'2022-12-09T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(8597.00000000 AS Decimal(19, 8)), N'B', N'54455267', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3289, N'SUNPHARMA', CAST(N'2022-12-09T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(985.80000000 AS Decimal(19, 8)), N'B', N'79578311', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3290, N'ADANIPORTS', CAST(N'2022-12-09T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(888.80000000 AS Decimal(19, 8)), N'B', N'3894788', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3291, N'SBIN', CAST(N'2022-12-09T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(611.70000000 AS Decimal(19, 8)), N'B', N'79583333', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3292, N'NTPC', CAST(N'2022-12-09T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(169.15000000 AS Decimal(19, 8)), N'B', N'54465837', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3293, N'TATASTEEL', CAST(N'2022-12-09T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(110.40000000 AS Decimal(19, 8)), N'B', N'79585500', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3294, N'ADANIENT', CAST(N'2022-12-28T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(3808.95000000 AS Decimal(19, 8)), N'S', N'4072900', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(4023.75000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3295, N'AXISBANK', CAST(N'2022-12-28T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(931.85000000 AS Decimal(19, 8)), N'S', N'6700800', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(936.45000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3296, N'BAJAJFINSV', CAST(N'2022-12-28T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1526.25000000 AS Decimal(19, 8)), N'S', N'2780109', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1618.95000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3297, N'BHARTIARTL', CAST(N'2022-12-28T00:00:00.000' AS DateTime), CAST(6.00000000 AS Decimal(19, 8)), CAST(807.30000000 AS Decimal(19, 8)), N'S', N'2781609', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(830.75000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3298, N'CIPLA', CAST(N'2022-12-28T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1085.95000000 AS Decimal(19, 8)), N'S', N'2035300', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1106.95000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3299, N'INDUSINDBK', CAST(N'2022-12-28T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1218.50000000 AS Decimal(19, 8)), N'S', N'4278800', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1191.25000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3300, N'HINDALCO', CAST(N'2022-12-28T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(466.55000000 AS Decimal(19, 8)), N'S', N'5410000', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(463.15000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3301, N'KOTAKBANK', CAST(N'2022-12-28T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(1823.20000000 AS Decimal(19, 8)), N'S', N'53204814', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1885.60000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3302, N'LT', CAST(N'2022-12-28T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(2132.05000000 AS Decimal(19, 8)), N'S', N'53204834', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(2152.60000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3303, N'MARUTI', CAST(N'2022-12-28T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(8433.00000000 AS Decimal(19, 8)), N'S', N'53206319', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(8597.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3304, N'ONGC', CAST(N'2022-12-28T00:00:00.000' AS DateTime), CAST(10.00000000 AS Decimal(19, 8)), CAST(144.00000000 AS Decimal(19, 8)), N'S', N'2945600', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(141.05000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3305, N'NTPC', CAST(N'2022-12-28T00:00:00.000' AS DateTime), CAST(13.00000000 AS Decimal(19, 8)), CAST(165.90000000 AS Decimal(19, 8)), N'S', N'53208245', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(169.15000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3306, N'SBILIFE', CAST(N'2022-12-28T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1245.60000000 AS Decimal(19, 8)), N'S', N'78735202', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1267.95000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3307, N'SUNPHARMA', CAST(N'2022-12-28T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(998.95000000 AS Decimal(19, 8)), N'S', N'2870800', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(985.80000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3308, N'WIPRO', CAST(N'2022-12-28T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(388.60000000 AS Decimal(19, 8)), N'S', N'5441000', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(392.50000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3309, N'ULTRACEMCO', CAST(N'2022-12-28T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(7093.00000000 AS Decimal(19, 8)), N'S', N'78742281', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(7173.65000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3310, N'POWERGRID', CAST(N'2022-12-28T00:00:00.000' AS DateTime), CAST(9.00000000 AS Decimal(19, 8)), CAST(215.80000000 AS Decimal(19, 8)), N'S', N'53217437', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(216.90000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3311, N'M&M', CAST(N'2022-12-28T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1251.80000000 AS Decimal(19, 8)), N'S', N'53219315', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1273.95000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3312, N'HDFCLIFE', CAST(N'2022-12-28T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(568.15000000 AS Decimal(19, 8)), N'S', N'5380600', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(577.95000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3313, N'GRASIM', CAST(N'2022-12-28T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1756.70000000 AS Decimal(19, 8)), N'S', N'9355600', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1792.85000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3314, N'ADANIPORTS', CAST(N'2022-12-28T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(814.25000000 AS Decimal(19, 8)), N'S', N'2802889', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(888.80000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3315, N'SBIN', CAST(N'2022-12-28T00:00:00.000' AS DateTime), CAST(9.00000000 AS Decimal(19, 8)), CAST(604.85000000 AS Decimal(19, 8)), N'S', N'78764774', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(611.70000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3316, N'TATAMOTORS', CAST(N'2022-12-28T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(393.35000000 AS Decimal(19, 8)), N'S', N'6233400', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(416.80000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3317, N'TATAMOTORS', CAST(N'2022-12-28T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(393.35000000 AS Decimal(19, 8)), N'S', N'6234000', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(416.80000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3318, N'TATAMOTORS', CAST(N'2022-12-28T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(393.15000000 AS Decimal(19, 8)), N'S', N'6234300', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(412.30000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3319, N'MANAPPURAM', CAST(N'2022-12-28T00:00:00.000' AS DateTime), CAST(45.00000000 AS Decimal(19, 8)), CAST(111.65000000 AS Decimal(19, 8)), N'B', N'53404076', CAST(0.00000000 AS Decimal(19, 8)), CAST(115.81562500 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3320, N'TATASTEEL', CAST(N'2022-12-28T00:00:00.000' AS DateTime), CAST(25.00000000 AS Decimal(19, 8)), CAST(109.85000000 AS Decimal(19, 8)), N'B', N'78970383', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3321, N'TATAMTRDVR', CAST(N'2022-12-28T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(207.25000000 AS Decimal(19, 8)), N'B', N'78973108', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3322, N'TATAMTRDVR', CAST(N'2022-12-28T00:00:00.000' AS DateTime), CAST(22.00000000 AS Decimal(19, 8)), CAST(207.25000000 AS Decimal(19, 8)), N'B', N'78973109', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3323, N'TMB', CAST(N'2022-12-28T00:00:00.000' AS DateTime), CAST(10.00000000 AS Decimal(19, 8)), CAST(481.80000000 AS Decimal(19, 8)), N'B', N'78975718', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3324, N'MARICO', CAST(N'2022-12-28T00:00:00.000' AS DateTime), CAST(8.00000000 AS Decimal(19, 8)), CAST(517.30000000 AS Decimal(19, 8)), N'B', N'53417164', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3325, N'JUBLFOOD', CAST(N'2022-12-28T00:00:00.000' AS DateTime), CAST(9.00000000 AS Decimal(19, 8)), CAST(514.70000000 AS Decimal(19, 8)), N'B', N'53417575', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3326, N'NATCOPHARM', CAST(N'2022-12-28T00:00:00.000' AS DateTime), CAST(9.00000000 AS Decimal(19, 8)), CAST(556.00000000 AS Decimal(19, 8)), N'B', N'53419609', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3327, N'MARICO', CAST(N'2022-12-28T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(517.30000000 AS Decimal(19, 8)), N'B', N'53420497', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3328, N'DABUR', CAST(N'2022-12-28T00:00:00.000' AS DateTime), CAST(8.00000000 AS Decimal(19, 8)), CAST(569.15000000 AS Decimal(19, 8)), N'B', N'28701359', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3329, N'AARTIIND', CAST(N'2022-12-28T00:00:00.000' AS DateTime), CAST(7.00000000 AS Decimal(19, 8)), CAST(618.10000000 AS Decimal(19, 8)), N'B', N'2972836', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3330, N'AARTIIND', CAST(N'2022-12-28T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(618.05000000 AS Decimal(19, 8)), N'B', N'2972835', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3331, N'CHOLAFIN', CAST(N'2022-12-28T00:00:00.000' AS DateTime), CAST(7.00000000 AS Decimal(19, 8)), CAST(724.70000000 AS Decimal(19, 8)), N'B', N'2975173', CAST(0.00000000 AS Decimal(19, 8)), CAST(724.70000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3332, N'GODREJCP', CAST(N'2022-12-28T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(896.35000000 AS Decimal(19, 8)), N'B', N'28715726', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3333, N'RELAXO', CAST(N'2022-12-28T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(912.80000000 AS Decimal(19, 8)), N'B', N'79013059', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3334, N'HATSUN', CAST(N'2022-12-28T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(900.25000000 AS Decimal(19, 8)), N'B', N'28736931', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3335, N'HATSUN', CAST(N'2022-12-28T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(900.25000000 AS Decimal(19, 8)), N'B', N'28736930', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3336, N'HATSUN', CAST(N'2022-12-28T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(900.25000000 AS Decimal(19, 8)), N'B', N'28736929', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3337, N'THANGAMAYL', CAST(N'2022-12-29T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(1069.05000000 AS Decimal(19, 8)), N'B', N'78661581', CAST(0.00000000 AS Decimal(19, 8)), CAST(1067.27500000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3338, N'JSWSTEEL', CAST(N'2022-12-29T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(768.80000000 AS Decimal(19, 8)), N'B', N'53258265', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3339, N'MUTHOOTFIN', CAST(N'2022-12-29T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1055.10000000 AS Decimal(19, 8)), N'B', N'53277671', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3340, N'TATASTEEL', CAST(N'2022-12-29T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(111.55000000 AS Decimal(19, 8)), N'B', N'78694461', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3341, N'TATASTEEL', CAST(N'2022-12-29T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(111.60000000 AS Decimal(19, 8)), N'B', N'78699524', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3342, N'TATASTEEL', CAST(N'2022-12-29T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(111.55000000 AS Decimal(19, 8)), N'B', N'78700267', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3343, N'MANAPPURAM', CAST(N'2022-12-29T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(111.40000000 AS Decimal(19, 8)), N'B', N'53290159', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3344, N'TATACONSUM', CAST(N'2022-12-29T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(771.15000000 AS Decimal(19, 8)), N'B', N'78705616', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3346, N'RECLTD', CAST(N'2022-12-30T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(116.90000000 AS Decimal(19, 8)), N'B', N'78771167', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3347, N'NIFTY', CAST(N'2022-12-30T00:00:00.000' AS DateTime), CAST(50.00000000 AS Decimal(19, 8)), CAST(211.35000000 AS Decimal(19, 8)), N'B', N'778063568', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3348, N'BRITANNIA', CAST(N'2020-05-08T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(35.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3349, N'TCS', CAST(N'2020-06-15T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(6.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3350, N'KANSAINER', CAST(N'2020-06-29T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(15.75000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3351, N'HINDUNILVR', CAST(N'2020-07-03T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(14.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3352, N'INFY', CAST(N'2020-07-03T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(38.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3353, N'RELIANCE', CAST(N'2020-07-16T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(13.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3354, N'TCS', CAST(N'2020-07-31T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(5.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3355, N'HDFC', CAST(N'2020-07-31T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(21.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3356, N'ASIANPAINT', CAST(N'2020-08-07T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(2.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3357, N'HINDUNILVR', CAST(N'2020-08-17T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(10.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3358, N'TITAN', CAST(N'2020-08-18T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(12.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3359, N'BATAINDIA', CAST(N'2020-08-19T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(4.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3360, N'HATSUN', CAST(N'2020-08-20T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(24.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3361, N'WHIRLPOOL', CAST(N'2020-08-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(5.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3362, N'BRITANNIA', CAST(N'2020-09-01T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(83.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3363, N'ITC', CAST(N'2020-09-08T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(193.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3364, N'DABUR', CAST(N'2020-09-22T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(6.40000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3365, N'BERGEPAINT', CAST(N'2020-10-06T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1.50000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3366, N'TCS', CAST(N'2020-11-03T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(12.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3367, N'INFY', CAST(N'2020-11-11T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(48.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3368, N'HINDUNILVR', CAST(N'2020-11-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(14.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3369, N'ASIANPAINT', CAST(N'2020-11-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(4.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3370, N'CROMPTON', CAST(N'2020-11-13T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(27.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3371, N'MARICO', CAST(N'2020-11-25T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(21.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3372, N'DABUR', CAST(N'2020-11-25T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(7.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3373, N'KANSAINER', CAST(N'2020-11-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(6.25000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3374, N'TCS', CAST(N'2021-02-03T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(6.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3375, N'HAVELLS', CAST(N'2021-02-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(9.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3376, N'ITC', CAST(N'2021-03-10T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(100.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3377, N'MARICO', CAST(N'2021-03-30T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(32.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3378, N'BRITANNIA', CAST(N'2021-04-16T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(62.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3379, N'BRITANNIA', CAST(N'2021-06-07T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(12.50000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3380, N'TCS', CAST(N'2021-06-14T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(15.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3381, N'INFY', CAST(N'2021-06-25T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(60.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3382, N'RELIANCE', CAST(N'2021-06-25T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(14.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3383, N'HINDUNILVR', CAST(N'2021-06-25T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(17.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3384, N'KANSAINER', CAST(N'2021-06-30T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(20.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
GO
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3385, N'ASIANPAINT', CAST(N'2021-07-02T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(14.50000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3386, N'HAVELLS', CAST(N'2021-07-14T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(10.50000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3387, N'HDFC', CAST(N'2021-07-22T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(23.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3388, N'BAJFINANCE', CAST(N'2021-07-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(10.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3389, N'CROMPTON', CAST(N'2021-07-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(22.50000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3390, N'TCS', CAST(N'2021-08-05T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(7.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3391, N'TITAN', CAST(N'2021-08-06T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(12.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3392, N'HDFCBANK', CAST(N'2021-08-10T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(20.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3393, N'VGUARD', CAST(N'2021-08-10T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(13.20000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3394, N'HATSUN', CAST(N'2021-08-11T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(24.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3395, N'ITC', CAST(N'2021-08-13T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(115.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3396, N'PIDILITIND', CAST(N'2021-08-13T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(8.50000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3397, N'BATAINDIA', CAST(N'2021-08-25T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(4.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3398, N'WHIRLPOOL', CAST(N'2021-08-25T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(5.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3399, N'KOTAKBANK', CAST(N'2021-08-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1.80000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3400, N'BERGEPAINT', CAST(N'2021-09-09T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(14.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3401, N'DABUR', CAST(N'2021-09-09T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(12.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3402, N'INDUSINDBK', CAST(N'2021-09-15T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(25.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3403, N'JUBLFOOD', CAST(N'2021-09-24T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(6.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3404, N'TCS', CAST(N'2021-11-03T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(7.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3405, N'INFY', CAST(N'2021-11-10T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(60.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3406, N'ASIANPAINT', CAST(N'2021-11-10T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(3.65000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3407, N'HINDUNILVR', CAST(N'2021-11-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(15.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3408, N'HAVELLS', CAST(N'2021-11-15T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(9.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3409, N'KANSAINER', CAST(N'2021-11-22T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(6.25000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3410, N'MARICO', CAST(N'2021-11-23T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(21.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3411, N'DABUR', CAST(N'2021-11-25T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(10.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3412, N'TCS', CAST(N'2022-07-02T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(7.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3413, N'MARICO', CAST(N'2022-02-23T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(43.75000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3414, N'HCLTECH', CAST(N'2022-05-11T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(90.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3415, N'MUTHOOTFIN', CAST(N'2022-05-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(80.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3416, N'BRITANNIA', CAST(N'2022-06-03T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1.60000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3417, N'TCS', CAST(N'2022-06-13T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(66.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3418, N'HINDUNILVR', CAST(N'2022-06-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(57.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3419, N'INFY', CAST(N'2022-06-28T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(128.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3420, N'TNPL', CAST(N'2022-06-29T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(54.45000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3421, N'ASIANPAINT', CAST(N'2022-07-01T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(47.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3422, N'HAVELLS', CAST(N'2022-07-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(31.50000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3423, N'HDFCBANK', CAST(N'2022-07-18T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(124.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3424, N'BRITANNIA', CAST(N'2022-07-22T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(113.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3425, N'TITAN', CAST(N'2022-07-29T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(37.50000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3426, N'BAJFINANCE', CAST(N'2022-07-30T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(40.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3427, N'HCLTECH', CAST(N'2022-08-02T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(70.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3428, N'TCS', CAST(N'2022-08-03T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(24.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3429, N'TECHM', CAST(N'2022-08-08T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(150.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3430, N'HATSUN', CAST(N'2022-08-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(54.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3431, N'PIDILITIND', CAST(N'2022-08-17T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(30.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3432, N'CHOLAFIN', CAST(N'2022-08-18T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(7.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3433, N'DABUR', CAST(N'2022-08-22T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(37.80000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3434, N'KOTAKBANK', CAST(N'2022-08-29T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(4.40000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3435, N'RELIANCE', CAST(N'2022-08-30T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(32.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3436, N'DIVISLAB', CAST(N'2022-08-30T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(60.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3437, N'MANAPPURAM', CAST(N'2022-08-31T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(53.25000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3438, N'ICICIBANK', CAST(N'2022-09-01T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3439, N'JUBLFOOD', CAST(N'2022-09-07T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(18.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3440, N'RELAXO', CAST(N'2022-09-20T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(15.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3441, N'HCLTECH', CAST(N'2022-11-03T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(110.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3442, N'INFY', CAST(N'2022-11-10T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(115.50000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3443, N'INDIGRID', CAST(N'2022-11-24T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(41.20000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3481, N'NIFTY', CAST(N'2023-01-03T00:00:00.000' AS DateTime), CAST(50.00000000 AS Decimal(19, 8)), CAST(150.75000000 AS Decimal(19, 8)), N'S', N'803028019', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(211.35000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3482, N'NIFTY', CAST(N'2023-01-03T00:00:00.000' AS DateTime), CAST(50.00000000 AS Decimal(19, 8)), CAST(75.70000000 AS Decimal(19, 8)), N'B', N'6920279', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3483, N'NIFTY', CAST(N'2023-01-03T00:00:00.000' AS DateTime), CAST(50.00000000 AS Decimal(19, 8)), CAST(69.45000000 AS Decimal(19, 8)), N'B', N'91631788', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3484, N'NIFTY', CAST(N'2023-01-04T00:00:00.000' AS DateTime), CAST(50.00000000 AS Decimal(19, 8)), CAST(80.65000000 AS Decimal(19, 8)), N'S', N'86022754', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(75.70000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3485, N'NIFTY', CAST(N'2023-01-04T00:00:00.000' AS DateTime), CAST(50.00000000 AS Decimal(19, 8)), CAST(86.70000000 AS Decimal(19, 8)), N'B', N'32457', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3486, N'NIFTY', CAST(N'2023-01-04T00:00:00.000' AS DateTime), CAST(50.00000000 AS Decimal(19, 8)), CAST(56.35000000 AS Decimal(19, 8)), N'B', N'86042230', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3487, N'NIFTY', CAST(N'2023-01-04T00:00:00.000' AS DateTime), CAST(50.00000000 AS Decimal(19, 8)), CAST(59.90000000 AS Decimal(19, 8)), N'S', N'86083917', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(69.45000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3488, N'NIFTY', CAST(N'2023-01-04T00:00:00.000' AS DateTime), CAST(50.00000000 AS Decimal(19, 8)), CAST(55.00000000 AS Decimal(19, 8)), N'S', N'104172', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(86.70000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3489, N'NIFTY', CAST(N'2023-01-04T00:00:00.000' AS DateTime), CAST(50.00000000 AS Decimal(19, 8)), CAST(54.15000000 AS Decimal(19, 8)), N'S', N'1675771', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(56.35000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3490, N'NIFTY', CAST(N'2023-01-05T00:00:00.000' AS DateTime), CAST(100.00000000 AS Decimal(19, 8)), CAST(114.10000000 AS Decimal(19, 8)), N'B', N'172280977', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3491, N'NIFTY', CAST(N'2023-01-05T00:00:00.000' AS DateTime), CAST(50.00000000 AS Decimal(19, 8)), CAST(120.70000000 AS Decimal(19, 8)), N'S', N'172285418', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(114.10000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3492, N'NIFTY', CAST(N'2023-01-05T00:00:00.000' AS DateTime), CAST(50.00000000 AS Decimal(19, 8)), CAST(120.75000000 AS Decimal(19, 8)), N'S', N'172285417', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(114.10000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3493, N'NIFTY', CAST(N'2023-01-05T00:00:00.000' AS DateTime), CAST(100.00000000 AS Decimal(19, 8)), CAST(83.45000000 AS Decimal(19, 8)), N'B', N'173453497', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3494, N'NIFTY', CAST(N'2023-01-05T00:00:00.000' AS DateTime), CAST(100.00000000 AS Decimal(19, 8)), CAST(82.95000000 AS Decimal(19, 8)), N'S', N'173529957', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(83.45000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3495, N'NIFTY', CAST(N'2023-01-05T00:00:00.000' AS DateTime), CAST(100.00000000 AS Decimal(19, 8)), CAST(154.40000000 AS Decimal(19, 8)), N'B', N'174431842', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3496, N'NIFTY', CAST(N'2023-01-05T00:00:00.000' AS DateTime), CAST(100.00000000 AS Decimal(19, 8)), CAST(146.70000000 AS Decimal(19, 8)), N'S', N'174447252', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(154.40000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3500, N'APOLLOHOSP', CAST(N'2023-01-10T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(4465.45000000 AS Decimal(19, 8)), N'B', N'3154039', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3501, N'DMART', CAST(N'2023-01-10T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(3879.95000000 AS Decimal(19, 8)), N'B', N'28661532', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3502, N'DIVISLAB', CAST(N'2023-01-10T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(3512.00000000 AS Decimal(19, 8)), N'B', N'28664840', CAST(0.00000000 AS Decimal(19, 8)), CAST(3129.95000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3503, N'BRITANNIA', CAST(N'2023-01-10T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(4331.90000000 AS Decimal(19, 8)), N'B', N'3169350', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3504, N'PIDILITIND', CAST(N'2023-01-10T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2530.75000000 AS Decimal(19, 8)), N'B', N'53309902', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3505, N'PIDILITIND', CAST(N'2023-01-10T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2530.75000000 AS Decimal(19, 8)), N'B', N'53309901', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3506, N'HAVELLS', CAST(N'2023-01-10T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(1183.95000000 AS Decimal(19, 8)), N'B', N'28678804', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3507, N'DEEPAKNTR', CAST(N'2023-01-10T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(1924.00000000 AS Decimal(19, 8)), N'B', N'28722846', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3546, N'MANAPPURAM', CAST(N'2023-01-13T00:00:00.000' AS DateTime), CAST(8.00000000 AS Decimal(19, 8)), CAST(121.70000000 AS Decimal(19, 8)), N'B', N'54008173', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3547, N'TATASTEEL', CAST(N'2023-01-13T00:00:00.000' AS DateTime), CAST(7.00000000 AS Decimal(19, 8)), CAST(120.50000000 AS Decimal(19, 8)), N'B', N'79180017', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3548, N'TATAMTRDVR', CAST(N'2023-01-13T00:00:00.000' AS DateTime), CAST(7.00000000 AS Decimal(19, 8)), CAST(214.40000000 AS Decimal(19, 8)), N'B', N'79182303', CAST(0.00000000 AS Decimal(19, 8)), CAST(212.39600000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3549, N'TECHM', CAST(N'2023-01-13T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(1003.25000000 AS Decimal(19, 8)), N'B', N'79187612', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3552, N'RECLTD', CAST(N'2023-01-16T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(123.15000000 AS Decimal(19, 8)), N'S', N'77058771', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(116.90000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3553, N'PGINVIT', CAST(N'2023-01-16T00:00:00.000' AS DateTime), CAST(15.00000000 AS Decimal(19, 8)), CAST(127.95000000 AS Decimal(19, 8)), N'S', N'51797587', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(130.09000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3554, N'INDIGRID', CAST(N'2023-01-16T00:00:00.000' AS DateTime), CAST(14.00000000 AS Decimal(19, 8)), CAST(140.50000000 AS Decimal(19, 8)), N'S', N'27006559', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(140.50000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3557, N'NIFTY', CAST(N'2023-01-06T00:00:00.000' AS DateTime), CAST(100.00000000 AS Decimal(19, 8)), CAST(96.30000000 AS Decimal(19, 8)), N'B', N'87737466', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3558, N'NIFTY', CAST(N'2023-01-06T00:00:00.000' AS DateTime), CAST(50.00000000 AS Decimal(19, 8)), CAST(92.90000000 AS Decimal(19, 8)), N'S', N'87816155', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(96.30000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3559, N'NIFTY', CAST(N'2023-01-06T00:00:00.000' AS DateTime), CAST(50.00000000 AS Decimal(19, 8)), CAST(92.90000000 AS Decimal(19, 8)), N'S', N'87816156', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(96.30000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3560, N'NIFTY', CAST(N'2023-01-06T00:00:00.000' AS DateTime), CAST(50.00000000 AS Decimal(19, 8)), CAST(95.40000000 AS Decimal(19, 8)), N'B', N'87854002', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3561, N'NIFTY', CAST(N'2023-01-06T00:00:00.000' AS DateTime), CAST(50.00000000 AS Decimal(19, 8)), CAST(94.55000000 AS Decimal(19, 8)), N'B', N'87862191', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3562, N'NIFTY', CAST(N'2023-01-06T00:00:00.000' AS DateTime), CAST(100.00000000 AS Decimal(19, 8)), CAST(105.80000000 AS Decimal(19, 8)), N'S', N'88093768', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(94.55000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3563, N'NIFTY', CAST(N'2023-01-09T00:00:00.000' AS DateTime), CAST(100.00000000 AS Decimal(19, 8)), CAST(151.50000000 AS Decimal(19, 8)), N'B', N'1157965', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3564, N'NIFTY', CAST(N'2023-01-09T00:00:00.000' AS DateTime), CAST(100.00000000 AS Decimal(19, 8)), CAST(165.20000000 AS Decimal(19, 8)), N'S', N'1863604', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(151.50000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3565, N'NIFTY', CAST(N'2023-01-10T00:00:00.000' AS DateTime), CAST(50.00000000 AS Decimal(19, 8)), CAST(86.25000000 AS Decimal(19, 8)), N'B', N'87777070', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3566, N'NIFTY', CAST(N'2023-01-10T00:00:00.000' AS DateTime), CAST(100.00000000 AS Decimal(19, 8)), CAST(86.25000000 AS Decimal(19, 8)), N'B', N'87777069', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
GO
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3567, N'NIFTY', CAST(N'2023-01-10T00:00:00.000' AS DateTime), CAST(150.00000000 AS Decimal(19, 8)), CAST(95.95000000 AS Decimal(19, 8)), N'S', N'87938209', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(86.25000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3568, N'NIFTY', CAST(N'2023-01-11T00:00:00.000' AS DateTime), CAST(50.00000000 AS Decimal(19, 8)), CAST(198.60000000 AS Decimal(19, 8)), N'B', N'172058640', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3569, N'NIFTY', CAST(N'2023-01-11T00:00:00.000' AS DateTime), CAST(50.00000000 AS Decimal(19, 8)), CAST(198.65000000 AS Decimal(19, 8)), N'B', N'172058641', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3570, N'NIFTY', CAST(N'2023-01-12T00:00:00.000' AS DateTime), CAST(100.00000000 AS Decimal(19, 8)), CAST(186.35000000 AS Decimal(19, 8)), N'S', N'172459841', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(198.65000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3571, N'NIFTY', CAST(N'2023-01-13T00:00:00.000' AS DateTime), CAST(100.00000000 AS Decimal(19, 8)), CAST(154.40000000 AS Decimal(19, 8)), N'B', N'87686034', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3572, N'NIFTY', CAST(N'2023-01-13T00:00:00.000' AS DateTime), CAST(50.00000000 AS Decimal(19, 8)), CAST(70.00000000 AS Decimal(19, 8)), N'B', N'89917813', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3573, N'NIFTY', CAST(N'2023-01-13T00:00:00.000' AS DateTime), CAST(50.00000000 AS Decimal(19, 8)), CAST(58.65000000 AS Decimal(19, 8)), N'S', N'92398403', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(154.40000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3574, N'NIFTY', CAST(N'2023-01-13T00:00:00.000' AS DateTime), CAST(50.00000000 AS Decimal(19, 8)), CAST(58.65000000 AS Decimal(19, 8)), N'S', N'92398402', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(154.40000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3575, N'NIFTY', CAST(N'2023-01-13T00:00:00.000' AS DateTime), CAST(50.00000000 AS Decimal(19, 8)), CAST(58.65000000 AS Decimal(19, 8)), N'S', N'92398401', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(70.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3705, N'WIPRO', CAST(N'2023-01-17T00:00:00.000' AS DateTime), CAST(9.00000000 AS Decimal(19, 8)), CAST(395.35000000 AS Decimal(19, 8)), N'B', N'78590485', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3707, N'HCLTECH', CAST(N'2023-01-17T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1110.00000000 AS Decimal(19, 8)), N'B', N'28420203', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3708, N'MUTHOOTFIN', CAST(N'2023-01-17T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(1053.40000000 AS Decimal(19, 8)), N'B', N'53431923', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3709, N'TITAN', CAST(N'2023-01-17T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2399.75000000 AS Decimal(19, 8)), N'B', N'78650753', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3710, N'BERGEPAINT', CAST(N'2023-01-17T00:00:00.000' AS DateTime), CAST(6.00000000 AS Decimal(19, 8)), CAST(564.50000000 AS Decimal(19, 8)), N'B', N'3012864', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3711, N'RELAXO', CAST(N'2023-01-17T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(889.85000000 AS Decimal(19, 8)), N'B', N'78702832', CAST(0.00000000 AS Decimal(19, 8)), CAST(859.58333333 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3712, N'GODREJCP', CAST(N'2023-01-17T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(926.85000000 AS Decimal(19, 8)), N'B', N'28479476', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3713, N'MARICO', CAST(N'2023-01-17T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(506.50000000 AS Decimal(19, 8)), N'B', N'53498931', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3714, N'TATACONSUM', CAST(N'2023-01-17T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(747.50000000 AS Decimal(19, 8)), N'B', N'78722832', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3715, N'DABUR', CAST(N'2023-01-17T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(554.50000000 AS Decimal(19, 8)), N'B', N'28492048', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3716, N'JUBLFOOD', CAST(N'2023-01-17T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(493.95000000 AS Decimal(19, 8)), N'B', N'53504874', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3717, N'TMB', CAST(N'2023-01-17T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(479.95000000 AS Decimal(19, 8)), N'B', N'78725951', CAST(0.00000000 AS Decimal(19, 8)), CAST(478.86250000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3718, N'AARTIIND', CAST(N'2023-01-17T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(572.10000000 AS Decimal(19, 8)), N'B', N'3039055', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3719, N'AARTIIND', CAST(N'2023-01-17T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(572.10000000 AS Decimal(19, 8)), N'B', N'3039056', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3720, N'NATCOPHARM', CAST(N'2023-01-17T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(545.90000000 AS Decimal(19, 8)), N'B', N'53509192', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3721, N'HATSUN', CAST(N'2023-01-17T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(892.00000000 AS Decimal(19, 8)), N'B', N'28539303', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3722, N'WIPRO', CAST(N'2023-01-17T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(396.00000000 AS Decimal(19, 8)), N'B', N'78778991', CAST(0.00000000 AS Decimal(19, 8)), CAST(396.38750000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3723, N'HATSUN', CAST(N'2023-01-17T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(891.45000000 AS Decimal(19, 8)), N'B', N'28560085', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3724, N'HCLTECH', CAST(N'2023-01-17T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1109.80000000 AS Decimal(19, 8)), N'B', N'28560274', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3725, N'GODREJCP', CAST(N'2023-01-17T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(928.90000000 AS Decimal(19, 8)), N'B', N'28562668', CAST(0.00000000 AS Decimal(19, 8)), CAST(912.11250000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3726, N'HATSUN', CAST(N'2023-01-17T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(891.45000000 AS Decimal(19, 8)), N'B', N'28564972', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3727, N'MUTHOOTFIN', CAST(N'2023-01-17T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1054.00000000 AS Decimal(19, 8)), N'B', N'53574632', CAST(0.00000000 AS Decimal(19, 8)), CAST(1053.60000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3728, N'NATCOPHARM', CAST(N'2023-01-17T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(545.10000000 AS Decimal(19, 8)), N'B', N'53587100', CAST(0.00000000 AS Decimal(19, 8)), CAST(543.38181818 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3729, N'DEEPAKNTR', CAST(N'2023-01-17T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1939.30000000 AS Decimal(19, 8)), N'B', N'28583860', CAST(0.00000000 AS Decimal(19, 8)), CAST(1939.30000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3730, N'BERGEPAINT', CAST(N'2023-01-17T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(565.60000000 AS Decimal(19, 8)), N'B', N'3118393', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3731, N'MANAPPURAM', CAST(N'2023-01-17T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(117.95000000 AS Decimal(19, 8)), N'B', N'53592667', CAST(0.00000000 AS Decimal(19, 8)), CAST(115.81562500 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3732, N'BERGEPAINT', CAST(N'2023-01-17T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(565.80000000 AS Decimal(19, 8)), N'B', N'3132398', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3733, N'BERGEPAINT', CAST(N'2023-01-17T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(565.80000000 AS Decimal(19, 8)), N'B', N'3132399', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3734, N'TECHM', CAST(N'2023-01-17T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1043.65000000 AS Decimal(19, 8)), N'B', N'78836317', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3774, N'AARTIIND', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(11.00000000 AS Decimal(19, 8)), CAST(555.80000000 AS Decimal(19, 8)), N'S', N'573964', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(572.10000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3775, N'APOLLOHOSP', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(4321.75000000 AS Decimal(19, 8)), N'S', N'575531', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(4465.45000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3776, N'BERGEPAINT', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(7.00000000 AS Decimal(19, 8)), CAST(557.95000000 AS Decimal(19, 8)), N'S', N'580890', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(565.60000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3777, N'BERGEPAINT', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(557.95000000 AS Decimal(19, 8)), N'S', N'580891', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(565.80000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3778, N'ASIANPAINT', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2784.00000000 AS Decimal(19, 8)), N'S', N'1123900', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(3218.85000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3779, N'HAVELLS', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(1172.00000000 AS Decimal(19, 8)), N'S', N'25740045', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1183.95000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3780, N'JSWSTEEL', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(7.00000000 AS Decimal(19, 8)), CAST(734.20000000 AS Decimal(19, 8)), N'S', N'50671834', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(768.80000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3781, N'JUBLFOOD', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(12.00000000 AS Decimal(19, 8)), CAST(512.00000000 AS Decimal(19, 8)), N'S', N'50673747', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(493.95000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3782, N'MANAPPURAM', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(31.00000000 AS Decimal(19, 8)), CAST(118.65000000 AS Decimal(19, 8)), N'S', N'6074800', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(111.65000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3783, N'TATASTEEL', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(31.00000000 AS Decimal(19, 8)), CAST(121.85000000 AS Decimal(19, 8)), N'S', N'78644182', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(109.85000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3784, N'TATAMTRDVR', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(16.00000000 AS Decimal(19, 8)), CAST(212.00000000 AS Decimal(19, 8)), N'S', N'4345100', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(207.25000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3785, N'TMB', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(478.50000000 AS Decimal(19, 8)), N'S', N'47204000', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(481.80000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3786, N'TMB', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(478.45000000 AS Decimal(19, 8)), N'S', N'47204200', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(481.80000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3787, N'TMB', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(478.55000000 AS Decimal(19, 8)), N'S', N'47203800', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(481.80000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3788, N'RELIANCE', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2433.15000000 AS Decimal(19, 8)), N'S', N'5910800', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(2649.55000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3789, N'RELIANCE', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(2433.15000000 AS Decimal(19, 8)), N'S', N'5911000', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(2649.55000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3790, N'RELIANCE', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2433.15000000 AS Decimal(19, 8)), N'S', N'5911200', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(2649.55000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3791, N'CHOLAFIN', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(714.00000000 AS Decimal(19, 8)), N'S', N'2745700', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(724.70000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3792, N'CHOLAFIN', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(714.00000000 AS Decimal(19, 8)), N'S', N'2745900', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(724.70000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3793, N'DEEPAKNTR', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1887.25000000 AS Decimal(19, 8)), N'S', N'5337700', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1924.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3794, N'WIPRO', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(407.30000000 AS Decimal(19, 8)), N'S', N'3041500', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(395.35000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3795, N'RELAXO', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(815.00000000 AS Decimal(19, 8)), N'S', N'9352900', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(912.80000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3796, N'RELAXO', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(815.00000000 AS Decimal(19, 8)), N'S', N'9353600', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(912.80000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3797, N'GODREJCP', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(927.00000000 AS Decimal(19, 8)), N'S', N'3000800', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(896.35000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3798, N'DMART', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(3430.00000000 AS Decimal(19, 8)), N'S', N'85248300', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(3879.95000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3799, N'DIVISLAB', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(3383.50000000 AS Decimal(19, 8)), N'S', N'28982423', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(3512.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3800, N'NATCOPHARM', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(7.00000000 AS Decimal(19, 8)), CAST(537.00000000 AS Decimal(19, 8)), N'S', N'53539632', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(556.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3801, N'ICICIBANK', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(871.60000000 AS Decimal(19, 8)), N'S', N'5325800', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(930.80000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3802, N'HINDUNILVR', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2594.10000000 AS Decimal(19, 8)), N'B', N'28998887', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3803, N'DABUR', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(564.15000000 AS Decimal(19, 8)), N'B', N'29000321', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3804, N'TATACONSUM', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(742.40000000 AS Decimal(19, 8)), N'B', N'78724113', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3805, N'MARICO', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(504.05000000 AS Decimal(19, 8)), N'B', N'53555083', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3806, N'MUTHOOTFIN', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1060.30000000 AS Decimal(19, 8)), N'S', N'2772200', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1053.40000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3807, N'KOTAKBANK', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(1786.80000000 AS Decimal(19, 8)), N'B', N'53561336', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3808, N'TCS', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(3418.30000000 AS Decimal(19, 8)), N'B', N'78737628', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3809, N'HCLTECH', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(1121.75000000 AS Decimal(19, 8)), N'B', N'29019652', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3810, N'INFY', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(1549.75000000 AS Decimal(19, 8)), N'B', N'29023539', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3811, N'VBL', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(1237.35000000 AS Decimal(19, 8)), N'B', N'78753541', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3812, N'HATSUN', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(890.35000000 AS Decimal(19, 8)), N'S', N'6770600', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(900.25000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3813, N'AXISBANK', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(934.50000000 AS Decimal(19, 8)), N'B', N'3213401', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3814, N'AXISBANK', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(6.00000000 AS Decimal(19, 8)), CAST(934.50000000 AS Decimal(19, 8)), N'B', N'3213583', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3815, N'KTKBANK', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(20.00000000 AS Decimal(19, 8)), CAST(149.10000000 AS Decimal(19, 8)), N'B', N'53589588', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3816, N'FEDERALBNK', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(21.00000000 AS Decimal(19, 8)), CAST(136.20000000 AS Decimal(19, 8)), N'B', N'29041963', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3817, N'KALYANKJIL', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(24.00000000 AS Decimal(19, 8)), CAST(120.05000000 AS Decimal(19, 8)), N'B', N'53603468', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3818, N'ITC', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(24.00000000 AS Decimal(19, 8)), CAST(337.40000000 AS Decimal(19, 8)), N'B', N'29053559', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (3819, N'THANGAMAYL', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1064.20000000 AS Decimal(19, 8)), N'S', N'48594600', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1069.05000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (4859, N'RELIANCE', CAST(N'2023-01-24T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(2414.00000000 AS Decimal(19, 8)), N'S', N'78699544', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(2608.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (4860, N'KALYANKJIL', CAST(N'2023-01-24T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(119.25000000 AS Decimal(19, 8)), N'B', N'53452649', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (4861, N'TATASTEEL', CAST(N'2023-01-24T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(120.35000000 AS Decimal(19, 8)), N'B', N'78747566', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (4862, N'FEDERALBNK', CAST(N'2023-01-24T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(135.10000000 AS Decimal(19, 8)), N'B', N'28342303', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (4863, N'KTKBANK', CAST(N'2023-01-24T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(146.75000000 AS Decimal(19, 8)), N'B', N'53459243', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (4864, N'MANAPPURAM', CAST(N'2023-01-24T00:00:00.000' AS DateTime), CAST(6.00000000 AS Decimal(19, 8)), CAST(118.45000000 AS Decimal(19, 8)), N'B', N'53464934', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (4865, N'TATASTEEL', CAST(N'2023-01-24T00:00:00.000' AS DateTime), CAST(6.00000000 AS Decimal(19, 8)), CAST(120.40000000 AS Decimal(19, 8)), N'B', N'78769083', CAST(0.00000000 AS Decimal(19, 8)), CAST(0.00000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (4866, N'KALYANKJIL', CAST(N'2023-01-24T00:00:00.000' AS DateTime), CAST(6.00000000 AS Decimal(19, 8)), CAST(119.40000000 AS Decimal(19, 8)), N'B', N'53474828', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (4867, N'KTKBANK', CAST(N'2023-01-24T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(146.60000000 AS Decimal(19, 8)), N'B', N'53481655', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (4868, N'FEDERALBNK', CAST(N'2023-01-24T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(135.05000000 AS Decimal(19, 8)), N'B', N'28370676', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (4869, N'NATCOPHARM', CAST(N'2023-01-24T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(532.70000000 AS Decimal(19, 8)), N'B', N'53487912', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (4870, N'TATAMTRDVR', CAST(N'2023-01-24T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(217.95000000 AS Decimal(19, 8)), N'B', N'78796480', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (4871, N'SBICARD', CAST(N'2023-01-25T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(724.80000000 AS Decimal(19, 8)), N'B', N'76281949', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (4872, N'SBICARD', CAST(N'2023-01-25T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(724.75000000 AS Decimal(19, 8)), N'B', N'76281948', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (4873, N'SBICARD', CAST(N'2023-01-25T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(723.20000000 AS Decimal(19, 8)), N'B', N'76502726', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (4874, N'RECLTD', CAST(N'2023-01-25T00:00:00.000' AS DateTime), CAST(24.00000000 AS Decimal(19, 8)), CAST(119.75000000 AS Decimal(19, 8)), N'B', N'76507361', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
GO
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (4923, N'INDUSINDBK', CAST(N'2023-01-27T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(1152.65000000 AS Decimal(19, 8)), N'B', N'25909772', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5010, N'THANGAMAYL', CAST(N'2023-02-06T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(18.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5011, N'TCS', CAST(N'2023-02-03T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(150.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5012, N'HCLTECH', CAST(N'2023-02-01T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5054, N'IDFCFIRSTB', CAST(N'2023-01-31T00:00:00.000' AS DateTime), CAST(67.00000000 AS Decimal(19, 8)), CAST(57.05000000 AS Decimal(19, 8)), N'B', N'26023195', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5055, N'IDFCFIRSTB', CAST(N'2023-02-06T00:00:00.000' AS DateTime), CAST(9.00000000 AS Decimal(19, 8)), CAST(59.80000000 AS Decimal(19, 8)), N'B', N'30054181', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5056, N'INFY', CAST(N'2023-02-06T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1571.90000000 AS Decimal(19, 8)), N'B', N'30059418', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5057, N'INFY', CAST(N'2023-02-06T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1571.90000000 AS Decimal(19, 8)), N'B', N'30059419', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5058, N'HINDUNILVR', CAST(N'2023-02-06T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(2638.60000000 AS Decimal(19, 8)), N'B', N'30066251', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5059, N'TECHM', CAST(N'2023-02-06T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1005.20000000 AS Decimal(19, 8)), N'B', N'79410898', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5060, N'RELAXO', CAST(N'2023-02-06T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(776.10000000 AS Decimal(19, 8)), N'B', N'79418264', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5061, N'NATCOPHARM', CAST(N'2023-02-06T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(529.85000000 AS Decimal(19, 8)), N'B', N'54018677', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5062, N'IDFCFIRSTB', CAST(N'2023-02-07T00:00:00.000' AS DateTime), CAST(10.00000000 AS Decimal(19, 8)), CAST(60.00000000 AS Decimal(19, 8)), N'B', N'29884459', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5063, N'ITC', CAST(N'2023-02-07T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(373.40000000 AS Decimal(19, 8)), N'B', N'29897512', CAST(1.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5064, N'RECLTD', CAST(N'2023-02-07T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(120.60000000 AS Decimal(19, 8)), N'B', N'79744499', CAST(0.00000000 AS Decimal(19, 8)), CAST(115.60000000 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5065, N'HCLTECH', CAST(N'2023-02-07T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(1127.75000000 AS Decimal(19, 8)), N'B', N'29902543', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5066, N'ICICIBANK', CAST(N'2023-02-07T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(852.85000000 AS Decimal(19, 8)), N'B', N'29905462', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5067, N'WIPRO', CAST(N'2023-02-07T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(400.60000000 AS Decimal(19, 8)), N'B', N'79753663', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5068, N'INFY', CAST(N'2023-02-07T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1559.85000000 AS Decimal(19, 8)), N'B', N'29912131', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5069, N'TCS', CAST(N'2023-02-07T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(3469.55000000 AS Decimal(19, 8)), N'B', N'79757992', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5070, N'THANGAMAYL', CAST(N'2023-02-07T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1061.95000000 AS Decimal(19, 8)), N'B', N'79762177', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5071, N'HDFCBANK', CAST(N'2023-02-07T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1653.10000000 AS Decimal(19, 8)), N'B', N'29922057', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5072, N'INDUSINDBK', CAST(N'2023-02-07T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1142.90000000 AS Decimal(19, 8)), N'B', N'29922842', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5073, N'AXISBANK', CAST(N'2023-02-07T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(878.60000000 AS Decimal(19, 8)), N'B', N'6730967', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5074, N'KOTAKBANK', CAST(N'2023-02-07T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1775.65000000 AS Decimal(19, 8)), N'B', N'54217144', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5075, N'NATCOPHARM', CAST(N'2023-02-07T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(528.05000000 AS Decimal(19, 8)), N'B', N'54220757', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5076, N'TECHM', CAST(N'2023-02-07T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1002.50000000 AS Decimal(19, 8)), N'B', N'79782774', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5077, N'HINDUNILVR', CAST(N'2023-02-07T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2598.40000000 AS Decimal(19, 8)), N'B', N'29945583', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5078, N'DIVISLAB', CAST(N'2023-02-07T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2747.90000000 AS Decimal(19, 8)), N'B', N'29949078', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5079, N'SBICARD', CAST(N'2023-02-07T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(750.70000000 AS Decimal(19, 8)), N'B', N'79805823', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5080, N'TMB', CAST(N'2023-02-07T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(463.85000000 AS Decimal(19, 8)), N'B', N'79806180', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5082, N'DEEPAKNTR', CAST(N'2023-02-08T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1754.45000000 AS Decimal(19, 8)), N'S', N'1095200', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1939.30000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5083, N'PIDILITIND', CAST(N'2023-02-08T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(2308.05000000 AS Decimal(19, 8)), N'S', N'730100', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(2530.75000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5084, N'RECLTD', CAST(N'2023-02-08T00:00:00.000' AS DateTime), CAST(29.00000000 AS Decimal(19, 8)), CAST(120.45000000 AS Decimal(19, 8)), N'S', N'1691200', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(120.60000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5085, N'DMART', CAST(N'2023-02-08T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(3483.00000000 AS Decimal(19, 8)), N'S', N'22665800', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(3879.95000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5086, N'HATSUN', CAST(N'2023-02-08T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(877.85000000 AS Decimal(19, 8)), N'S', N'1706800', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(900.25000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5087, N'HATSUN', CAST(N'2023-02-08T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(877.90000000 AS Decimal(19, 8)), N'S', N'1706600', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(891.45000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5088, N'TATASTEEL', CAST(N'2023-02-08T00:00:00.000' AS DateTime), CAST(32.00000000 AS Decimal(19, 8)), CAST(111.50000000 AS Decimal(19, 8)), N'S', N'2149200', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(120.40000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5090, N'NASDAQ', CAST(N'2023-01-25T00:00:00.000' AS DateTime), CAST(119.33300000 AS Decimal(19, 8)), CAST(8.37950000 AS Decimal(19, 8)), N'B', N'613138995', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5091, N'NASDAQ', CAST(N'2023-01-25T00:00:00.000' AS DateTime), CAST(2386.65800000 AS Decimal(19, 8)), CAST(8.37950000 AS Decimal(19, 8)), N'B', N'614491689', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5092, N'NASDAQ', CAST(N'2023-02-07T00:00:00.000' AS DateTime), CAST(1063.05000000 AS Decimal(19, 8)), CAST(9.13740000 AS Decimal(19, 8)), N'B', N'623983628', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5177, N'DEEPAKNI', CAST(N'2023-02-08T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1754.45000000 AS Decimal(19, 8)), N'S', N'1095200', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5179, N'INDIGRID', CAST(N'2023-02-17T00:00:00.000' AS DateTime), CAST(6.00000000 AS Decimal(19, 8)), CAST(132.20000000 AS Decimal(19, 8)), N'B', N'28459876', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5180, N'PGINVIT', CAST(N'2023-02-17T00:00:00.000' AS DateTime), CAST(7.00000000 AS Decimal(19, 8)), CAST(120.10000000 AS Decimal(19, 8)), N'B', N'53445686', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5181, N'RECLTD', CAST(N'2023-02-17T00:00:00.000' AS DateTime), CAST(7.00000000 AS Decimal(19, 8)), CAST(115.60000000 AS Decimal(19, 8)), N'B', N'78598581', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5226, N'WIPRO', CAST(N'2023-02-07T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(10.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5227, N'CHOLAFIN', CAST(N'2023-02-24T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(6.50000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5228, N'NATCOPHARM', CAST(N'2023-03-01T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(11.25000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5229, N'MANAPPURAM', CAST(N'2023-03-02T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(24.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5230, N'ITC', CAST(N'2023-03-03T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(312.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5314, N'GOLD', CAST(N'2023-03-06T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(5335.00000000 AS Decimal(19, 8)), N'S', N'77702848', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(5335.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5315, N'PGINVIT', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(119.71000000 AS Decimal(19, 8)), N'B', N'50715169', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5316, N'AXISBANK', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(8.00000000 AS Decimal(19, 8)), CAST(857.40000000 AS Decimal(19, 8)), N'S', N'1051555', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(878.60000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5317, N'BRITANNIA', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(4345.80000000 AS Decimal(19, 8)), N'S', N'1058427', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(4331.90000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5318, N'GODREJCP', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(8.00000000 AS Decimal(19, 8)), CAST(920.15000000 AS Decimal(19, 8)), N'S', N'25730096', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(928.90000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5319, N'MARICO', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(496.20000000 AS Decimal(19, 8)), N'S', N'50750800', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(517.30000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5320, N'MARICO', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(8.00000000 AS Decimal(19, 8)), CAST(496.20000000 AS Decimal(19, 8)), N'S', N'50750799', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(504.05000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5321, N'WIPRO', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(12.00000000 AS Decimal(19, 8)), CAST(390.55000000 AS Decimal(19, 8)), N'S', N'876600', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(400.60000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5322, N'HINDUNILVR', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(6.00000000 AS Decimal(19, 8)), CAST(2482.25000000 AS Decimal(19, 8)), N'S', N'25768189', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(2598.40000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5323, N'INDIGRID', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(41.00000000 AS Decimal(19, 8)), CAST(130.00000000 AS Decimal(19, 8)), N'B', N'25801919', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5324, N'PGINVIT', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(43.00000000 AS Decimal(19, 8)), CAST(119.71000000 AS Decimal(19, 8)), N'B', N'50829656', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5325, N'KOTAKBANK', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(1736.85000000 AS Decimal(19, 8)), N'S', N'877500', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1775.65000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5326, N'VBL', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(1350.00000000 AS Decimal(19, 8)), N'S', N'75918280', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1237.35000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5327, N'BAJFINANCE', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(6030.50000000 AS Decimal(19, 8)), N'S', N'1718400', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(6583.55000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5328, N'ITC', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(21.00000000 AS Decimal(19, 8)), CAST(390.45000000 AS Decimal(19, 8)), N'S', N'4569800', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(339.05000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5329, N'INFY', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(11.00000000 AS Decimal(19, 8)), CAST(1488.40000000 AS Decimal(19, 8)), N'S', N'9729200', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1549.75000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5330, N'ICICIBANK', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(867.55000000 AS Decimal(19, 8)), N'S', N'3254600', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(930.80000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5331, N'HDFCBANK', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(1628.25000000 AS Decimal(19, 8)), N'S', N'28947503', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1620.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5332, N'TCS', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(3374.05000000 AS Decimal(19, 8)), N'S', N'78530259', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(3418.30000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5333, N'HCLTECH', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1118.50000000 AS Decimal(19, 8)), N'S', N'28953138', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1102.05000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5334, N'IDFCFIRSTB', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(118.00000000 AS Decimal(19, 8)), CAST(57.40000000 AS Decimal(19, 8)), N'B', N'28968034', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5335, N'MANAPPURAM', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(71.00000000 AS Decimal(19, 8)), CAST(113.60000000 AS Decimal(19, 8)), N'B', N'53765865', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5336, N'TATASTEEL', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(110.00000000 AS Decimal(19, 8)), CAST(106.35000000 AS Decimal(19, 8)), N'B', N'78562609', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5337, N'FEDERALBNK', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(58.00000000 AS Decimal(19, 8)), CAST(135.45000000 AS Decimal(19, 8)), N'B', N'28985088', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5338, N'TATAMTRDVR', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(35.00000000 AS Decimal(19, 8)), CAST(222.85000000 AS Decimal(19, 8)), N'B', N'78597710', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5339, N'CIPLA', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(13.00000000 AS Decimal(19, 8)), CAST(875.95000000 AS Decimal(19, 8)), N'B', N'4173893', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5340, N'NATCOPHARM', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(11.00000000 AS Decimal(19, 8)), CAST(570.25000000 AS Decimal(19, 8)), N'B', N'53814908', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5341, N'CHOLAFIN', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(763.00000000 AS Decimal(19, 8)), N'B', N'4180017', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5342, N'CHOLAFIN', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(6.00000000 AS Decimal(19, 8)), CAST(763.00000000 AS Decimal(19, 8)), N'B', N'4180146', CAST(1.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5344, N'MUTHOOTFIN', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(946.40000000 AS Decimal(19, 8)), N'B', N'53830931', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5345, N'MUTHOOTFIN', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(8.00000000 AS Decimal(19, 8)), CAST(946.40000000 AS Decimal(19, 8)), N'B', N'53830932', CAST(1.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5346, N'THANGAMAYL', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(7.00000000 AS Decimal(19, 8)), CAST(1007.60000000 AS Decimal(19, 8)), N'B', N'78621879', CAST(1.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5347, N'TATACONSUM', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(7.00000000 AS Decimal(19, 8)), CAST(718.15000000 AS Decimal(19, 8)), N'B', N'78626923', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5348, N'INDUSINDBK', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(6.00000000 AS Decimal(19, 8)), CAST(1169.25000000 AS Decimal(19, 8)), N'B', N'29061756', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5349, N'TMB', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(17.00000000 AS Decimal(19, 8)), CAST(454.40000000 AS Decimal(19, 8)), N'B', N'78648507', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5350, N'DIVISLAB', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(2831.75000000 AS Decimal(19, 8)), N'B', N'29083407', CAST(1.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5351, N'KALYANKJIL', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(68.00000000 AS Decimal(19, 8)), CAST(116.40000000 AS Decimal(19, 8)), N'B', N'53876249', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5352, N'TITAN', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(2399.75000000 AS Decimal(19, 8)), N'B', N'78679201', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5353, N'KTKBANK', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(51.00000000 AS Decimal(19, 8)), CAST(151.10000000 AS Decimal(19, 8)), N'B', N'53903057', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5354, N'PGINVIT', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(486.00000000 AS Decimal(19, 8)), CAST(118.70000000 AS Decimal(19, 8)), N'B', N'54032058', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5355, N'INDIGRID', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(444.00000000 AS Decimal(19, 8)), CAST(130.00000000 AS Decimal(19, 8)), N'B', N'29275306', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5356, N'DABUR', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(12.00000000 AS Decimal(19, 8)), CAST(531.80000000 AS Decimal(19, 8)), N'S', N'29342431', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(564.15000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5357, N'RELAXO', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(761.20000000 AS Decimal(19, 8)), N'S', N'5468900', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(912.80000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5358, N'RELAXO', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(761.20000000 AS Decimal(19, 8)), N'S', N'5468700', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(912.80000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5359, N'RELAXO', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(761.20000000 AS Decimal(19, 8)), N'S', N'5470700', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(776.10000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5360, N'SBICARD', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(750.00000000 AS Decimal(19, 8)), N'S', N'79003790', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(750.70000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5361, N'PGINVIT', CAST(N'2023-03-09T00:00:00.000' AS DateTime), CAST(238.00000000 AS Decimal(19, 8)), CAST(118.93000000 AS Decimal(19, 8)), N'B', N'52220400', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5362, N'PGINVIT', CAST(N'2023-03-09T00:00:00.000' AS DateTime), CAST(50.00000000 AS Decimal(19, 8)), CAST(118.93000000 AS Decimal(19, 8)), N'B', N'52220401', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5363, N'PGINVIT', CAST(N'2023-03-09T00:00:00.000' AS DateTime), CAST(28.00000000 AS Decimal(19, 8)), CAST(118.93000000 AS Decimal(19, 8)), N'B', N'52220402', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5364, N'INDIGRID', CAST(N'2023-03-09T00:00:00.000' AS DateTime), CAST(212.00000000 AS Decimal(19, 8)), CAST(129.88000000 AS Decimal(19, 8)), N'B', N'27070634', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
GO
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5365, N'INDIGRID', CAST(N'2023-03-09T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(129.88000000 AS Decimal(19, 8)), N'B', N'27321297', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5366, N'INDIGRID', CAST(N'2023-03-09T00:00:00.000' AS DateTime), CAST(50.00000000 AS Decimal(19, 8)), CAST(129.88000000 AS Decimal(19, 8)), N'B', N'27322615', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5367, N'INDIGRID', CAST(N'2023-03-09T00:00:00.000' AS DateTime), CAST(21.00000000 AS Decimal(19, 8)), CAST(129.88000000 AS Decimal(19, 8)), N'B', N'27377228', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5412, N'FEDERALBNK', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(129.40000000 AS Decimal(19, 8)), N'S', N'25130102', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(136.20000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5413, N'FEDERALBNK', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(71.00000000 AS Decimal(19, 8)), CAST(129.35000000 AS Decimal(19, 8)), N'S', N'25139211', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(135.45000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5414, N'FEDERALBNK', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(13.00000000 AS Decimal(19, 8)), CAST(129.35000000 AS Decimal(19, 8)), N'S', N'25139210', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(135.45000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5415, N'CHOLAFIN', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(736.25000000 AS Decimal(19, 8)), N'S', N'325400', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(724.70000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5416, N'HDFC', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2570.50000000 AS Decimal(19, 8)), N'S', N'623500', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(2663.90000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5417, N'HDFC', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(2570.45000000 AS Decimal(19, 8)), N'S', N'623700', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(2663.90000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5418, N'CHOLAFIN', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(736.25000000 AS Decimal(19, 8)), N'S', N'346000', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(724.70000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5419, N'CHOLAFIN', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(736.25000000 AS Decimal(19, 8)), N'S', N'345800', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(724.70000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5420, N'HDFCBANK', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1571.75000000 AS Decimal(19, 8)), N'S', N'411000', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1620.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5421, N'HDFCBANK', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(1571.95000000 AS Decimal(19, 8)), N'S', N'436000', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1624.80000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5422, N'HDFCBANK', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1571.95000000 AS Decimal(19, 8)), N'S', N'435900', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1624.80000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5423, N'HDFCBANK', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1572.30000000 AS Decimal(19, 8)), N'S', N'472700', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1624.80000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5424, N'INDUSINDBK', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(9.00000000 AS Decimal(19, 8)), CAST(1054.45000000 AS Decimal(19, 8)), N'S', N'25249236', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1169.25000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5425, N'INFY', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(7.00000000 AS Decimal(19, 8)), CAST(1443.35000000 AS Decimal(19, 8)), N'S', N'25255231', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1559.85000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5426, N'ITC', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(27.00000000 AS Decimal(19, 8)), CAST(384.70000000 AS Decimal(19, 8)), N'S', N'459500', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(337.40000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5427, N'ITC', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(384.85000000 AS Decimal(19, 8)), N'S', N'459300', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(373.40000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5428, N'KALYANKJIL', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(99.00000000 AS Decimal(19, 8)), CAST(109.70000000 AS Decimal(19, 8)), N'S', N'12216600', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(116.40000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5429, N'KTKBANK', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(20.00000000 AS Decimal(19, 8)), CAST(142.55000000 AS Decimal(19, 8)), N'S', N'50283995', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(149.10000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5430, N'KTKBANK', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(50.00000000 AS Decimal(19, 8)), CAST(142.60000000 AS Decimal(19, 8)), N'S', N'50283994', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(151.10000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5431, N'KTKBANK', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(6.00000000 AS Decimal(19, 8)), CAST(142.55000000 AS Decimal(19, 8)), N'S', N'50283996', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(151.10000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5432, N'MANAPPURAM', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(102.00000000 AS Decimal(19, 8)), CAST(109.50000000 AS Decimal(19, 8)), N'S', N'50293134', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(113.60000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5433, N'IDFCFIRSTB', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(54.43000000 AS Decimal(19, 8)), N'S', N'945500', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(57.05000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5434, N'IDFCFIRSTB', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(40.00000000 AS Decimal(19, 8)), CAST(54.43000000 AS Decimal(19, 8)), N'S', N'945900', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(57.05000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5435, N'IDFCFIRSTB', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(8.00000000 AS Decimal(19, 8)), CAST(54.43000000 AS Decimal(19, 8)), N'S', N'947200', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(57.05000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5436, N'MUTHOOTFIN', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(11.00000000 AS Decimal(19, 8)), CAST(932.50000000 AS Decimal(19, 8)), N'S', N'307800', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(946.40000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5437, N'IDFCFIRSTB', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(54.43000000 AS Decimal(19, 8)), N'S', N'947400', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(57.05000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5438, N'IDFCFIRSTB', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(54.43000000 AS Decimal(19, 8)), N'S', N'948600', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(57.05000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5439, N'IDFCFIRSTB', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(54.43000000 AS Decimal(19, 8)), N'S', N'949200', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(57.05000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5440, N'IDFCFIRSTB', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(54.43000000 AS Decimal(19, 8)), N'S', N'949000', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(57.05000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5441, N'IDFCFIRSTB', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(10.00000000 AS Decimal(19, 8)), CAST(54.43000000 AS Decimal(19, 8)), N'S', N'948800', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(59.80000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5442, N'TATACONSUM', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(10.00000000 AS Decimal(19, 8)), CAST(692.00000000 AS Decimal(19, 8)), N'S', N'536200', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(718.15000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5443, N'TATACONSUM', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(692.00000000 AS Decimal(19, 8)), N'S', N'536400', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(718.15000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5444, N'TATAMTRDVR', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(51.00000000 AS Decimal(19, 8)), CAST(213.75000000 AS Decimal(19, 8)), N'S', N'498900', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(222.85000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5445, N'IDFCFIRSTB', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(133.00000000 AS Decimal(19, 8)), CAST(54.43000000 AS Decimal(19, 8)), N'S', N'989100', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(57.40000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5446, N'TATASTEEL', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(109.00000000 AS Decimal(19, 8)), CAST(107.40000000 AS Decimal(19, 8)), N'S', N'1036700', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(106.35000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5447, N'TCS', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(3282.55000000 AS Decimal(19, 8)), N'S', N'579100', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(3469.55000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5448, N'TECHM', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(9.00000000 AS Decimal(19, 8)), CAST(1128.10000000 AS Decimal(19, 8)), N'S', N'75340209', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1005.20000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5449, N'THANGAMAYL', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1039.30000000 AS Decimal(19, 8)), N'S', N'75345320', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1069.05000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5450, N'THANGAMAYL', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(8.00000000 AS Decimal(19, 8)), CAST(1039.30000000 AS Decimal(19, 8)), N'S', N'75345324', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1007.60000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5451, N'TITAN', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2357.05000000 AS Decimal(19, 8)), N'S', N'441300', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(2585.75000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5452, N'TITAN', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(2357.05000000 AS Decimal(19, 8)), N'S', N'441500', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(2399.75000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5453, N'ICICIBANK', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(13.00000000 AS Decimal(19, 8)), CAST(826.90000000 AS Decimal(19, 8)), N'S', N'25343760', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(852.85000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5454, N'CHOLAFIN', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(11.00000000 AS Decimal(19, 8)), CAST(736.25000000 AS Decimal(19, 8)), N'S', N'559300', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(763.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5455, N'HCLTECH', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(10.00000000 AS Decimal(19, 8)), CAST(1093.00000000 AS Decimal(19, 8)), N'S', N'1667100', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1127.75000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5456, N'TMB', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(8.00000000 AS Decimal(19, 8)), CAST(418.15000000 AS Decimal(19, 8)), N'S', N'6242800', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(463.85000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5457, N'TMB', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(417.65000000 AS Decimal(19, 8)), N'S', N'6243400', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(454.40000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5458, N'TMB', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(418.00000000 AS Decimal(19, 8)), N'S', N'6243200', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(454.40000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5459, N'TMB', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(418.25000000 AS Decimal(19, 8)), N'S', N'6242600', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(454.40000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5460, N'TMB', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(8.00000000 AS Decimal(19, 8)), CAST(418.05000000 AS Decimal(19, 8)), N'S', N'6243000', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(454.40000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5461, N'CIPLA', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(8.00000000 AS Decimal(19, 8)), CAST(873.20000000 AS Decimal(19, 8)), N'S', N'3890100', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(875.95000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5462, N'CIPLA', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(873.20000000 AS Decimal(19, 8)), N'S', N'3889900', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(875.95000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5463, N'CIPLA', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(873.20000000 AS Decimal(19, 8)), N'S', N'3890300', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(875.95000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5464, N'NATCOPHARM', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(539.15000000 AS Decimal(19, 8)), N'S', N'52407838', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(556.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5465, N'DIVISLAB', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2741.95000000 AS Decimal(19, 8)), N'S', N'3058700', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(3512.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5466, N'DIVISLAB', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2741.95000000 AS Decimal(19, 8)), N'S', N'3058900', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(2747.90000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5467, N'DIVISLAB', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2741.95000000 AS Decimal(19, 8)), N'S', N'3058500', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(2831.75000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5468, N'NATCOPHARM', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(8.00000000 AS Decimal(19, 8)), CAST(539.15000000 AS Decimal(19, 8)), N'S', N'52410310', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(570.25000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5469, N'NATCOPHARM', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(539.15000000 AS Decimal(19, 8)), N'S', N'52410405', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(570.25000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5470, N'NATCOPHARM', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(539.15000000 AS Decimal(19, 8)), N'S', N'52411958', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(570.25000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5471, N'NATCOPHARM', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(539.15000000 AS Decimal(19, 8)), N'S', N'52412713', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(570.25000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5472, N'NATCOPHARM', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(539.15000000 AS Decimal(19, 8)), N'S', N'52413172', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(570.25000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5473, N'NATCOPHARM', CAST(N'2023-03-14T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(539.15000000 AS Decimal(19, 8)), N'S', N'52413436', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(570.25000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5698, N'LIQUIDBEES', CAST(N'2022-09-21T00:00:00.000' AS DateTime), CAST(10.00000000 AS Decimal(19, 8)), CAST(1000.01000000 AS Decimal(19, 8)), N'B', N'53741942', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5699, N'LIQUIDBEES', CAST(N'2022-09-23T00:00:00.000' AS DateTime), CAST(28.00000000 AS Decimal(19, 8)), CAST(1000.00000000 AS Decimal(19, 8)), N'B', N'54427509', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5700, N'LIQUIDBEES', CAST(N'2022-09-23T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(1000.00000000 AS Decimal(19, 8)), N'B', N'54427948', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5701, N'LIQUIDBEES', CAST(N'2022-09-23T00:00:00.000' AS DateTime), CAST(90.00000000 AS Decimal(19, 8)), CAST(1000.00000000 AS Decimal(19, 8)), N'B', N'54427902', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5702, N'LIQUIDBEES', CAST(N'2022-09-23T00:00:00.000' AS DateTime), CAST(124.00000000 AS Decimal(19, 8)), CAST(1000.00000000 AS Decimal(19, 8)), N'B', N'54429138', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5703, N'LIQUIDBEES', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(36.00000000 AS Decimal(19, 8)), CAST(999.98000000 AS Decimal(19, 8)), N'S', N'53403407', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1000.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5704, N'LIQUIDBEES', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(40.00000000 AS Decimal(19, 8)), CAST(999.98000000 AS Decimal(19, 8)), N'S', N'53404920', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1000.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5705, N'LIQUIDBEES', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(999.98000000 AS Decimal(19, 8)), N'S', N'53406127', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1000.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5706, N'LIQUIDBEES', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(173.00000000 AS Decimal(19, 8)), CAST(999.98000000 AS Decimal(19, 8)), N'S', N'53406440', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1000.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5707, N'LIQUIDBEES', CAST(N'2022-10-18T00:00:00.000' AS DateTime), CAST(6.00000000 AS Decimal(19, 8)), CAST(999.98000000 AS Decimal(19, 8)), N'S', N'53406425', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1000.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5708, N'LIQUIDBEES', CAST(N'2022-10-20T00:00:00.000' AS DateTime), CAST(166.00000000 AS Decimal(19, 8)), CAST(1000.01000000 AS Decimal(19, 8)), N'B', N'53769515', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5709, N'LIQUIDBEES', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(203.00000000 AS Decimal(19, 8)), CAST(1000.00000000 AS Decimal(19, 8)), N'B', N'50995890', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5710, N'LIQUIDBEES', CAST(N'2022-10-27T00:00:00.000' AS DateTime), CAST(42.00000000 AS Decimal(19, 8)), CAST(1000.00000000 AS Decimal(19, 8)), N'B', N'51207225', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5711, N'LIQUIDBEES', CAST(N'2022-10-28T00:00:00.000' AS DateTime), CAST(60.00000000 AS Decimal(19, 8)), CAST(1000.00000000 AS Decimal(19, 8)), N'B', N'50930285', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5712, N'LIQUIDBEES', CAST(N'2022-11-04T00:00:00.000' AS DateTime), CAST(12.00000000 AS Decimal(19, 8)), CAST(1000.00000000 AS Decimal(19, 8)), N'B', N'51791862', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5713, N'LIQUIDBEES', CAST(N'2022-11-04T00:00:00.000' AS DateTime), CAST(15.00000000 AS Decimal(19, 8)), CAST(1000.00000000 AS Decimal(19, 8)), N'B', N'51792017', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5714, N'LIQUIDBEES', CAST(N'2022-11-04T00:00:00.000' AS DateTime), CAST(14.00000000 AS Decimal(19, 8)), CAST(1000.00000000 AS Decimal(19, 8)), N'B', N'51793287', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5715, N'LIQUIDBEES', CAST(N'2022-11-07T00:00:00.000' AS DateTime), CAST(10.00000000 AS Decimal(19, 8)), CAST(1000.01000000 AS Decimal(19, 8)), N'B', N'54388634', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5716, N'LIQUIDBEES', CAST(N'2022-12-05T00:00:00.000' AS DateTime), CAST(524.00000000 AS Decimal(19, 8)), CAST(999.99000000 AS Decimal(19, 8)), N'S', N'53997923', CAST(2.00000000 AS Decimal(19, 8)), NULL, CAST(1000.01000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5717, N'LIQUIDBEES', CAST(N'2022-12-06T00:00:00.000' AS DateTime), CAST(436.00000000 AS Decimal(19, 8)), CAST(1000.01000000 AS Decimal(19, 8)), N'B', N'52060057', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5718, N'LIQUIDBEES', CAST(N'2022-12-07T00:00:00.000' AS DateTime), CAST(112.00000000 AS Decimal(19, 8)), CAST(1000.00000000 AS Decimal(19, 8)), N'B', N'50690660', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5719, N'LIQUIDBEES', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(1000.00000000 AS Decimal(19, 8)), N'S', N'53880603', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1000.01000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5720, N'LIQUIDBEES', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(10.00000000 AS Decimal(19, 8)), CAST(1000.00000000 AS Decimal(19, 8)), N'S', N'53880604', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1000.01000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5721, N'LIQUIDBEES', CAST(N'2022-12-08T00:00:00.000' AS DateTime), CAST(185.00000000 AS Decimal(19, 8)), CAST(1000.00000000 AS Decimal(19, 8)), N'S', N'53881121', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1000.01000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5722, N'LIQUIDBEES', CAST(N'2022-12-29T00:00:00.000' AS DateTime), CAST(15.00000000 AS Decimal(19, 8)), CAST(1000.00000000 AS Decimal(19, 8)), N'S', N'53331537', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1000.01000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5723, N'LIQUIDBEES', CAST(N'2023-01-03T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(1000.00000000 AS Decimal(19, 8)), N'S', N'53945084', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1000.01000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5724, N'LIQUIDBEES', CAST(N'2023-01-03T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1000.00000000 AS Decimal(19, 8)), N'S', N'53945085', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1000.01000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5725, N'LIQUIDBEES', CAST(N'2023-01-10T00:00:00.000' AS DateTime), CAST(30.00000000 AS Decimal(19, 8)), CAST(1000.00000000 AS Decimal(19, 8)), N'S', N'53277087', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1000.01000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5726, N'LIQUIDBEES', CAST(N'2023-01-10T00:00:00.000' AS DateTime), CAST(12.00000000 AS Decimal(19, 8)), CAST(1000.00000000 AS Decimal(19, 8)), N'S', N'53367666', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1000.01000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5727, N'LIQUIDBEES', CAST(N'2023-01-16T00:00:00.000' AS DateTime), CAST(6.00000000 AS Decimal(19, 8)), CAST(999.99000000 AS Decimal(19, 8)), N'S', N'51776141', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1000.01000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5728, N'LIQUIDBEES', CAST(N'2023-01-16T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(999.99000000 AS Decimal(19, 8)), N'S', N'51779542', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1000.01000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5729, N'LIQUIDBEES', CAST(N'2023-01-16T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(999.99000000 AS Decimal(19, 8)), N'S', N'51803418', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1000.01000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5730, N'GOLD', CAST(N'2023-01-16T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(5335.00000000 AS Decimal(19, 8)), N'B', N'77168299', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5731, N'LIQUIDBEES', CAST(N'2023-01-17T00:00:00.000' AS DateTime), CAST(50.00000000 AS Decimal(19, 8)), CAST(1000.00000000 AS Decimal(19, 8)), N'S', N'53415327', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1000.01000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5732, N'LIQUIDBEES', CAST(N'2023-01-20T00:00:00.000' AS DateTime), CAST(228.00000000 AS Decimal(19, 8)), CAST(1000.00000000 AS Decimal(19, 8)), N'S', N'53243072', CAST(3.00000000 AS Decimal(19, 8)), NULL, CAST(1000.00000000 AS Decimal(19, 8)))
GO
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5733, N'DEEPAKNI', CAST(N'2023-01-23T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1887.25000000 AS Decimal(19, 8)), N'S', N'5337700', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5734, N'LIQUIDBEES', CAST(N'2023-02-07T00:00:00.000' AS DateTime), CAST(167.00000000 AS Decimal(19, 8)), CAST(1000.01000000 AS Decimal(19, 8)), N'B', N'54257928', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5735, N'LIQUIDBEES', CAST(N'2023-02-13T00:00:00.000' AS DateTime), CAST(22.00000000 AS Decimal(19, 8)), CAST(1000.01000000 AS Decimal(19, 8)), N'B', N'51322062', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5736, N'LIQUIDBEES', CAST(N'2023-03-08T00:00:00.000' AS DateTime), CAST(190.00000000 AS Decimal(19, 8)), CAST(999.99000000 AS Decimal(19, 8)), N'S', N'53824306', CAST(1.00000000 AS Decimal(19, 8)), NULL, CAST(1000.01000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5737, N'RECLTD', CAST(N'2023-03-15T00:00:00.000' AS DateTime), CAST(8.00000000 AS Decimal(19, 8)), CAST(116.85000000 AS Decimal(19, 8)), N'B', N'79448185', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5738, N'RECLTD', CAST(N'2023-03-15T00:00:00.000' AS DateTime), CAST(13.00000000 AS Decimal(19, 8)), CAST(116.85000000 AS Decimal(19, 8)), N'B', N'79448186', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5739, N'LIQUIDBEES', CAST(N'2023-03-21T00:00:00.000' AS DateTime), CAST(253.00000000 AS Decimal(19, 8)), CAST(1000.00000000 AS Decimal(19, 8)), N'B', N'50156608', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5740, N'LIQUIDBEES', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(253.00000000 AS Decimal(19, 8)), CAST(1000.00000000 AS Decimal(19, 8)), N'S', N'53611976', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1000.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5741, N'TATASTEEL', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(6.00000000 AS Decimal(19, 8)), CAST(104.00000000 AS Decimal(19, 8)), N'B', N'78577417', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5742, N'IDFCFIRSTB', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(44.00000000 AS Decimal(19, 8)), CAST(55.50000000 AS Decimal(19, 8)), N'B', N'28907176', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5743, N'KALYANKJIL', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(6.00000000 AS Decimal(19, 8)), CAST(105.60000000 AS Decimal(19, 8)), N'B', N'53723965', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5744, N'NATCOPHARM', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(580.45000000 AS Decimal(19, 8)), N'B', N'53736864', CAST(3.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5745, N'TATASTEEL', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(29.00000000 AS Decimal(19, 8)), CAST(103.95000000 AS Decimal(19, 8)), N'B', N'78602338', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5746, N'IDFCFIRSTB', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(183.00000000 AS Decimal(19, 8)), CAST(55.50000000 AS Decimal(19, 8)), N'B', N'28930399', CAST(18.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5747, N'KALYANKJIL', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(29.00000000 AS Decimal(19, 8)), CAST(105.60000000 AS Decimal(19, 8)), N'B', N'53757016', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5748, N'KTKBANK', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(23.00000000 AS Decimal(19, 8)), CAST(128.85000000 AS Decimal(19, 8)), N'B', N'53775271', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5749, N'NATCOPHARM', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(21.00000000 AS Decimal(19, 8)), CAST(580.60000000 AS Decimal(19, 8)), N'B', N'53780334', CAST(21.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5750, N'NATCOPHARM', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(580.60000000 AS Decimal(19, 8)), N'B', N'53780324', CAST(1.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5751, N'FEDERALBNK', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(22.00000000 AS Decimal(19, 8)), CAST(134.35000000 AS Decimal(19, 8)), N'B', N'28951243', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5752, N'ITC', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(19.00000000 AS Decimal(19, 8)), CAST(379.35000000 AS Decimal(19, 8)), N'B', N'28952039', CAST(19.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5753, N'ICICIBANK', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(16.00000000 AS Decimal(19, 8)), CAST(883.80000000 AS Decimal(19, 8)), N'B', N'28954885', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5754, N'TATAMTRDVR', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(16.00000000 AS Decimal(19, 8)), CAST(212.20000000 AS Decimal(19, 8)), N'B', N'78635475', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5755, N'HCLTECH', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(6.00000000 AS Decimal(19, 8)), CAST(1097.40000000 AS Decimal(19, 8)), N'B', N'28962880', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5756, N'HCLTECH', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(9.00000000 AS Decimal(19, 8)), CAST(1097.40000000 AS Decimal(19, 8)), N'B', N'28963101', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5757, N'INFY', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(13.00000000 AS Decimal(19, 8)), CAST(1409.40000000 AS Decimal(19, 8)), N'B', N'28966324', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5758, N'WIPRO', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(12.00000000 AS Decimal(19, 8)), CAST(367.40000000 AS Decimal(19, 8)), N'B', N'78654427', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5759, N'TECHM', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(11.00000000 AS Decimal(19, 8)), CAST(1103.00000000 AS Decimal(19, 8)), N'B', N'78654675', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5760, N'CIPLA', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(9.00000000 AS Decimal(19, 8)), CAST(892.25000000 AS Decimal(19, 8)), N'B', N'3432687', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5761, N'HDFCBANK', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(8.00000000 AS Decimal(19, 8)), CAST(1610.45000000 AS Decimal(19, 8)), N'B', N'28985208', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5762, N'TCS', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(3196.00000000 AS Decimal(19, 8)), N'B', N'78665668', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5763, N'TTKPRESTIG', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(715.60000000 AS Decimal(19, 8)), N'B', N'78670809', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5764, N'INDUSINDBK', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(1075.80000000 AS Decimal(19, 8)), N'B', N'28998427', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5765, N'CHOLAFIN', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(778.10000000 AS Decimal(19, 8)), N'B', N'3450713', CAST(3.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5766, N'MUTHOOTFIN', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(982.95000000 AS Decimal(19, 8)), N'B', N'53841434', CAST(2.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5767, N'DIVISLAB', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(2866.85000000 AS Decimal(19, 8)), N'B', N'29008639', CAST(2.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5768, N'DRREDDY', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(4645.60000000 AS Decimal(19, 8)), N'B', N'29016797', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5769, N'THANGAMAYL', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1014.90000000 AS Decimal(19, 8)), N'B', N'78693485', CAST(2.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5770, N'TMB', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(406.00000000 AS Decimal(19, 8)), N'B', N'78695193', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5771, N'TMB', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(9.00000000 AS Decimal(19, 8)), CAST(406.00000000 AS Decimal(19, 8)), N'B', N'78695194', CAST(3.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5772, N'MANAPPURAM', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(29.00000000 AS Decimal(19, 8)), CAST(125.35000000 AS Decimal(19, 8)), N'B', N'53856156', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5773, N'HDFC', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2630.10000000 AS Decimal(19, 8)), N'S', N'5057600', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(2663.90000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5774, N'TATACONSUM', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(717.10000000 AS Decimal(19, 8)), N'S', N'3019900', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(718.15000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5775, N'INFY', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1410.70000000 AS Decimal(19, 8)), N'B', N'29137080', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5776, N'NATCOPHARM', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(582.45000000 AS Decimal(19, 8)), N'B', N'53972883', CAST(1.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5777, N'TCS', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(3197.55000000 AS Decimal(19, 8)), N'B', N'78819608', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5778, N'TECHM', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1103.05000000 AS Decimal(19, 8)), N'B', N'78825333', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5779, N'WIPRO', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(367.90000000 AS Decimal(19, 8)), N'B', N'78826498', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5780, N'HCLTECH', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1097.95000000 AS Decimal(19, 8)), N'B', N'29160388', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5781, N'DIVISLAB', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2870.00000000 AS Decimal(19, 8)), N'B', N'29164142', CAST(1.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5782, N'CIPLA', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(890.60000000 AS Decimal(19, 8)), N'B', N'3602137', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5783, N'INFY', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1410.85000000 AS Decimal(19, 8)), N'B', N'29184602', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5784, N'TCS', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(3198.75000000 AS Decimal(19, 8)), N'B', N'78860368', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5785, N'NATCOPHARM', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(581.35000000 AS Decimal(19, 8)), N'B', N'54026523', CAST(1.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5786, N'NATCOPHARM', CAST(N'2023-04-03T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(581.65000000 AS Decimal(19, 8)), N'B', N'54028694', CAST(1.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5787, N'TTKPRESTIG', CAST(N'2023-04-06T00:00:00.000' AS DateTime), CAST(6.00000000 AS Decimal(19, 8)), CAST(725.00000000 AS Decimal(19, 8)), N'B', N'78581030', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5788, N'TTKPRESTIG', CAST(N'2023-04-06T00:00:00.000' AS DateTime), CAST(6.00000000 AS Decimal(19, 8)), CAST(725.00000000 AS Decimal(19, 8)), N'B', N'78582228', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5789, N'ICICIBANK', CAST(N'2023-04-06T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(875.10000000 AS Decimal(19, 8)), N'B', N'29141986', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5790, N'ICICIBANK', CAST(N'2023-04-06T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(875.10000000 AS Decimal(19, 8)), N'B', N'29141988', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5791, N'TMB', CAST(N'2023-04-06T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(401.45000000 AS Decimal(19, 8)), N'B', N'78589133', CAST(2.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5792, N'FEDERALBNK', CAST(N'2023-04-06T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(127.40000000 AS Decimal(19, 8)), N'B', N'29149917', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5793, N'KTKBANK', CAST(N'2023-04-06T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(130.15000000 AS Decimal(19, 8)), N'B', N'53175977', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5794, N'IDFCFIRSTB', CAST(N'2023-04-06T00:00:00.000' AS DateTime), CAST(24.00000000 AS Decimal(19, 8)), CAST(55.20000000 AS Decimal(19, 8)), N'B', N'29162916', CAST(24.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5795, N'HDFCBANK', CAST(N'2023-04-06T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1667.80000000 AS Decimal(19, 8)), N'B', N'29167836', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5796, N'INDUSINDBK', CAST(N'2023-04-06T00:00:00.000' AS DateTime), CAST(6.00000000 AS Decimal(19, 8)), CAST(1080.45000000 AS Decimal(19, 8)), N'B', N'29171548', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5797, N'TITAN', CAST(N'2023-04-06T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2547.10000000 AS Decimal(19, 8)), N'S', N'78665607', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(2399.75000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5798, N'TECHM', CAST(N'2023-04-06T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1093.60000000 AS Decimal(19, 8)), N'B', N'78673352', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5799, N'CIPLA', CAST(N'2023-04-06T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(892.25000000 AS Decimal(19, 8)), N'B', N'3862514', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5800, N'INFY', CAST(N'2023-04-06T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1420.90000000 AS Decimal(19, 8)), N'B', N'29235242', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5801, N'DIVISLAB', CAST(N'2023-04-06T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(2920.70000000 AS Decimal(19, 8)), N'B', N'29240681', CAST(2.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5802, N'NATCOPHARM', CAST(N'2023-04-06T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(577.00000000 AS Decimal(19, 8)), N'B', N'53254412', CAST(2.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5803, N'TCS', CAST(N'2023-04-06T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(3221.00000000 AS Decimal(19, 8)), N'B', N'78688177', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5804, N'NATCOPHARM', CAST(N'2023-04-06T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(576.45000000 AS Decimal(19, 8)), N'B', N'53255875', CAST(2.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5805, N'HCLTECH', CAST(N'2023-04-06T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1092.00000000 AS Decimal(19, 8)), N'B', N'29246027', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5806, N'TMB', CAST(N'2023-04-06T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(401.50000000 AS Decimal(19, 8)), N'B', N'78694809', CAST(2.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5807, N'DRREDDY', CAST(N'2023-04-06T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(4691.90000000 AS Decimal(19, 8)), N'B', N'29269011', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5808, N'INFY', CAST(N'2023-04-06T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1421.70000000 AS Decimal(19, 8)), N'B', N'29280240', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5809, N'WIPRO', CAST(N'2023-04-06T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(366.85000000 AS Decimal(19, 8)), N'B', N'78718904', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5810, N'ITC', CAST(N'2023-04-06T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(387.10000000 AS Decimal(19, 8)), N'B', N'29286792', CAST(1.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5811, N'NASDAQ', CAST(N'2023-04-05T00:00:00.000' AS DateTime), CAST(486.40500000 AS Decimal(19, 8)), CAST(9.25110000 AS Decimal(19, 8)), N'B', N'672828405', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5812, N'MARICO', CAST(N'2023-03-23T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(58.30000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5813, N'TMB', CAST(N'2023-03-06T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(40.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5814, N'INDIGRID', CAST(N'2023-04-11T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(135.50000000 AS Decimal(19, 8)), N'S', N'30800', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(132.20000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5815, N'INDIGRID', CAST(N'2023-04-11T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(135.50000000 AS Decimal(19, 8)), N'S', N'31100', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(132.20000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5816, N'INDIGRID', CAST(N'2023-04-11T00:00:00.000' AS DateTime), CAST(10.00000000 AS Decimal(19, 8)), CAST(135.50000000 AS Decimal(19, 8)), N'S', N'30900', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(130.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5817, N'INDIGRID', CAST(N'2023-04-11T00:00:00.000' AS DateTime), CAST(16.00000000 AS Decimal(19, 8)), CAST(135.50000000 AS Decimal(19, 8)), N'S', N'31300', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(130.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5818, N'INDIGRID', CAST(N'2023-04-11T00:00:00.000' AS DateTime), CAST(100.00000000 AS Decimal(19, 8)), CAST(135.05000000 AS Decimal(19, 8)), N'S', N'31600', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(130.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5819, N'INDIGRID', CAST(N'2023-04-11T00:00:00.000' AS DateTime), CAST(571.00000000 AS Decimal(19, 8)), CAST(135.01000000 AS Decimal(19, 8)), N'S', N'31800', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(129.88000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5820, N'PGINVIT', CAST(N'2023-04-11T00:00:00.000' AS DateTime), CAST(17.00000000 AS Decimal(19, 8)), CAST(122.52000000 AS Decimal(19, 8)), N'S', N'35400', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(119.71000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5821, N'PGINVIT', CAST(N'2023-04-11T00:00:00.000' AS DateTime), CAST(652.00000000 AS Decimal(19, 8)), CAST(122.50000000 AS Decimal(19, 8)), N'S', N'35600', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(118.93000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5822, N'PGINVIT', CAST(N'2023-04-11T00:00:00.000' AS DateTime), CAST(100.00000000 AS Decimal(19, 8)), CAST(122.56000000 AS Decimal(19, 8)), N'S', N'35200', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(118.93000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5823, N'INFY', CAST(N'2023-04-11T00:00:00.000' AS DateTime), CAST(10.00000000 AS Decimal(19, 8)), CAST(1429.40000000 AS Decimal(19, 8)), N'B', N'25756026', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5824, N'TCS', CAST(N'2023-04-11T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(3257.80000000 AS Decimal(19, 8)), N'B', N'75863454', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5825, N'TCS', CAST(N'2023-04-11T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(3256.70000000 AS Decimal(19, 8)), N'B', N'75863453', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5826, N'HCLTECH', CAST(N'2023-04-11T00:00:00.000' AS DateTime), CAST(14.00000000 AS Decimal(19, 8)), CAST(1109.65000000 AS Decimal(19, 8)), N'B', N'25761956', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5827, N'TECHM', CAST(N'2023-04-11T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1116.05000000 AS Decimal(19, 8)), N'B', N'75881139', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5828, N'TECHM', CAST(N'2023-04-11T00:00:00.000' AS DateTime), CAST(8.00000000 AS Decimal(19, 8)), CAST(1116.05000000 AS Decimal(19, 8)), N'B', N'75881524', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5829, N'WIPRO', CAST(N'2023-04-11T00:00:00.000' AS DateTime), CAST(8.00000000 AS Decimal(19, 8)), CAST(374.55000000 AS Decimal(19, 8)), N'B', N'75881999', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5830, N'CIPLA', CAST(N'2023-04-11T00:00:00.000' AS DateTime), CAST(8.00000000 AS Decimal(19, 8)), CAST(904.20000000 AS Decimal(19, 8)), N'B', N'803419', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5831, N'IDFCFIRSTB', CAST(N'2023-04-11T00:00:00.000' AS DateTime), CAST(188.00000000 AS Decimal(19, 8)), CAST(54.30000000 AS Decimal(19, 8)), N'B', N'25809292', CAST(188.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5832, N'ICICIBANK', CAST(N'2023-04-11T00:00:00.000' AS DateTime), CAST(15.00000000 AS Decimal(19, 8)), CAST(874.20000000 AS Decimal(19, 8)), N'B', N'25819777', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
GO
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5833, N'KTKBANK', CAST(N'2023-04-11T00:00:00.000' AS DateTime), CAST(19.00000000 AS Decimal(19, 8)), CAST(131.10000000 AS Decimal(19, 8)), N'B', N'50897805', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5834, N'FEDERALBNK', CAST(N'2023-04-11T00:00:00.000' AS DateTime), CAST(63.00000000 AS Decimal(19, 8)), CAST(128.20000000 AS Decimal(19, 8)), N'B', N'25859279', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5835, N'FEDERALBNK', CAST(N'2023-04-11T00:00:00.000' AS DateTime), CAST(49.00000000 AS Decimal(19, 8)), CAST(128.20000000 AS Decimal(19, 8)), N'B', N'25859280', CAST(43.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5836, N'NATCOPHARM', CAST(N'2023-04-11T00:00:00.000' AS DateTime), CAST(22.00000000 AS Decimal(19, 8)), CAST(579.30000000 AS Decimal(19, 8)), N'B', N'50927634', CAST(22.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5837, N'HDFCBANK', CAST(N'2023-04-11T00:00:00.000' AS DateTime), CAST(7.00000000 AS Decimal(19, 8)), CAST(1665.70000000 AS Decimal(19, 8)), N'B', N'25894960', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5838, N'TCS', CAST(N'2023-04-11T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(3215.00000000 AS Decimal(19, 8)), N'B', N'76981193', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5839, N'WIPRO', CAST(N'2023-04-11T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(371.40000000 AS Decimal(19, 8)), N'B', N'76983831', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5840, N'TECHM', CAST(N'2023-04-11T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1104.95000000 AS Decimal(19, 8)), N'B', N'76985290', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5841, N'INFY', CAST(N'2023-04-11T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1404.95000000 AS Decimal(19, 8)), N'B', N'26850279', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5842, N'HCLTECH', CAST(N'2023-04-11T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1096.25000000 AS Decimal(19, 8)), N'B', N'26851856', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5843, N'TCS', CAST(N'2023-04-11T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(3214.15000000 AS Decimal(19, 8)), N'B', N'76991010', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5844, N'HCLTECH', CAST(N'2023-04-11T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1096.00000000 AS Decimal(19, 8)), N'B', N'26853238', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5845, N'WIPRO', CAST(N'2023-04-11T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(371.40000000 AS Decimal(19, 8)), N'B', N'76995759', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5846, N'INFY', CAST(N'2023-04-11T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1404.95000000 AS Decimal(19, 8)), N'B', N'26857265', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5847, N'TCS', CAST(N'2023-04-11T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(3214.40000000 AS Decimal(19, 8)), N'B', N'76998538', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5848, N'INFY', CAST(N'2023-04-11T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1403.90000000 AS Decimal(19, 8)), N'B', N'26860235', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5849, N'TECHM', CAST(N'2023-04-11T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1104.60000000 AS Decimal(19, 8)), N'B', N'77006165', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5903, N'TTKPRESTIG', CAST(N'2023-04-12T00:00:00.000' AS DateTime), CAST(8.00000000 AS Decimal(19, 8)), CAST(717.50000000 AS Decimal(19, 8)), N'B', N'78898657', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5904, N'INDIGRID', CAST(N'2023-04-17T00:00:00.000' AS DateTime), CAST(13.00000000 AS Decimal(19, 8)), CAST(137.38000000 AS Decimal(19, 8)), N'S', N'26674409', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(129.88000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5905, N'RECLTD', CAST(N'2023-04-17T00:00:00.000' AS DateTime), CAST(28.00000000 AS Decimal(19, 8)), CAST(122.45000000 AS Decimal(19, 8)), N'S', N'7320700', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(116.85000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5906, N'INDIGRID', CAST(N'2023-04-17T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(137.38000000 AS Decimal(19, 8)), N'S', N'26682382', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(129.88000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5907, N'INDIGRID', CAST(N'2023-04-17T00:00:00.000' AS DateTime), CAST(61.00000000 AS Decimal(19, 8)), CAST(137.38000000 AS Decimal(19, 8)), N'S', N'26689459', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(129.88000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5908, N'PGINVIT', CAST(N'2023-04-17T00:00:00.000' AS DateTime), CAST(84.00000000 AS Decimal(19, 8)), CAST(122.00000000 AS Decimal(19, 8)), N'S', N'94300', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(118.93000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5909, N'INFY', CAST(N'2023-04-17T00:00:00.000' AS DateTime), CAST(15.00000000 AS Decimal(19, 8)), CAST(1228.80000000 AS Decimal(19, 8)), N'B', N'26712878', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5910, N'TCS', CAST(N'2023-04-17T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(3138.35000000 AS Decimal(19, 8)), N'B', N'78958824', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5911, N'TECHM', CAST(N'2023-04-17T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(1029.50000000 AS Decimal(19, 8)), N'B', N'78961171', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5912, N'HCLTECH', CAST(N'2023-04-17T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(1038.05000000 AS Decimal(19, 8)), N'B', N'30211300', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5913, N'WIPRO', CAST(N'2023-04-17T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(360.60000000 AS Decimal(19, 8)), N'B', N'78964484', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5914, N'WIPRO', CAST(N'2023-04-17T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(360.60000000 AS Decimal(19, 8)), N'B', N'78964483', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5915, N'TECHM', CAST(N'2023-04-17T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1029.15000000 AS Decimal(19, 8)), N'B', N'78965271', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5916, N'HCLTECH', CAST(N'2023-04-17T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1038.70000000 AS Decimal(19, 8)), N'B', N'30215317', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5917, N'TCS', CAST(N'2023-04-17T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(3140.25000000 AS Decimal(19, 8)), N'B', N'78966716', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5918, N'HCLTECH', CAST(N'2023-04-17T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1038.50000000 AS Decimal(19, 8)), N'B', N'30228422', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5919, N'HCLTECH', CAST(N'2023-04-17T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1039.00000000 AS Decimal(19, 8)), N'B', N'30232311', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5920, N'WIPRO', CAST(N'2023-04-17T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(360.80000000 AS Decimal(19, 8)), N'B', N'78989474', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5921, N'HCLTECH', CAST(N'2023-04-17T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1040.10000000 AS Decimal(19, 8)), N'B', N'30243150', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5922, N'TECHM', CAST(N'2023-04-17T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1029.95000000 AS Decimal(19, 8)), N'B', N'78992951', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5923, N'INFY', CAST(N'2023-04-18T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1262.90000000 AS Decimal(19, 8)), N'B', N'28623971', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5924, N'INFY', CAST(N'2023-04-18T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1262.85000000 AS Decimal(19, 8)), N'B', N'28623970', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5925, N'NASDAQ', CAST(N'2023-04-13T00:00:00.000' AS DateTime), CAST(3430.50700000 AS Decimal(19, 8)), CAST(9.32760000 AS Decimal(19, 8)), N'B', N'683370778', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5970, N'RECLTD', CAST(N'2023-04-21T00:00:00.000' AS DateTime), CAST(68.00000000 AS Decimal(19, 8)), CAST(121.95000000 AS Decimal(19, 8)), N'B', N'78321360', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5971, N'PGINVIT', CAST(N'2023-04-21T00:00:00.000' AS DateTime), CAST(68.00000000 AS Decimal(19, 8)), CAST(121.90000000 AS Decimal(19, 8)), N'B', N'53111475', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5972, N'INDIGRID', CAST(N'2023-04-21T00:00:00.000' AS DateTime), CAST(60.00000000 AS Decimal(19, 8)), CAST(138.40000000 AS Decimal(19, 8)), N'B', N'28879587', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5973, N'INDIGRID', CAST(N'2023-04-21T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(138.40000000 AS Decimal(19, 8)), N'B', N'28893182', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5974, N'RECLTD', CAST(N'2023-04-21T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(122.00000000 AS Decimal(19, 8)), N'B', N'78364779', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5975, N'PGINVIT', CAST(N'2023-04-21T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(122.00000000 AS Decimal(19, 8)), N'B', N'53139265', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (5976, N'ICICIIT', CAST(N'2023-04-18T00:00:00.000' AS DateTime), CAST(1538.60400000 AS Decimal(19, 8)), CAST(9.09870000 AS Decimal(19, 8)), N'B', N'687538597', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6021, N'TATASTEEL', CAST(N'2023-04-25T00:00:00.000' AS DateTime), CAST(10.00000000 AS Decimal(19, 8)), CAST(107.10000000 AS Decimal(19, 8)), N'S', N'79494899', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(103.95000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6022, N'TATASTEEL', CAST(N'2023-04-25T00:00:00.000' AS DateTime), CAST(22.00000000 AS Decimal(19, 8)), CAST(107.10000000 AS Decimal(19, 8)), N'S', N'79494884', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(103.95000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6023, N'TATASTEEL', CAST(N'2023-04-25T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(107.10000000 AS Decimal(19, 8)), N'S', N'79495089', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(103.95000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6024, N'TATAMTRDVR', CAST(N'2023-04-25T00:00:00.000' AS DateTime), CAST(17.00000000 AS Decimal(19, 8)), CAST(243.30000000 AS Decimal(19, 8)), N'S', N'79496306', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(212.20000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6025, N'MANAPPURAM', CAST(N'2023-04-25T00:00:00.000' AS DateTime), CAST(30.00000000 AS Decimal(19, 8)), CAST(127.55000000 AS Decimal(19, 8)), N'S', N'53631862', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(125.35000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6026, N'KALYANKJIL', CAST(N'2023-04-25T00:00:00.000' AS DateTime), CAST(36.00000000 AS Decimal(19, 8)), CAST(103.00000000 AS Decimal(19, 8)), N'S', N'102787400', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(105.60000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6027, N'IDFCFIRSTB', CAST(N'2023-04-25T00:00:00.000' AS DateTime), CAST(140.00000000 AS Decimal(19, 8)), CAST(58.55000000 AS Decimal(19, 8)), N'B', N'29743778', CAST(140.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6028, N'KTKBANK', CAST(N'2023-04-25T00:00:00.000' AS DateTime), CAST(34.00000000 AS Decimal(19, 8)), CAST(128.55000000 AS Decimal(19, 8)), N'S', N'2204300', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(131.10000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6029, N'KTKBANK', CAST(N'2023-04-25T00:00:00.000' AS DateTime), CAST(11.00000000 AS Decimal(19, 8)), CAST(128.60000000 AS Decimal(19, 8)), N'S', N'2204100', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(131.10000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6030, N'INDUSINDBK', CAST(N'2023-04-25T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1121.50000000 AS Decimal(19, 8)), N'B', N'29801440', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6031, N'HDFCBANK', CAST(N'2023-04-25T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1663.25000000 AS Decimal(19, 8)), N'B', N'29805818', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6032, N'ICICIBANK', CAST(N'2023-04-25T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(914.20000000 AS Decimal(19, 8)), N'B', N'29807418', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6178, N'LTIM', CAST(N'2023-04-28T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(4405.50000000 AS Decimal(19, 8)), N'B', N'53781264', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6179, N'TCS', CAST(N'2023-04-28T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(3211.15000000 AS Decimal(19, 8)), N'S', N'79329315', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(3196.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6180, N'HCLTECH', CAST(N'2023-04-28T00:00:00.000' AS DateTime), CAST(28.00000000 AS Decimal(19, 8)), CAST(1058.95000000 AS Decimal(19, 8)), N'S', N'29395772', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1109.65000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6181, N'FEDERALBNK', CAST(N'2023-04-28T00:00:00.000' AS DateTime), CAST(96.00000000 AS Decimal(19, 8)), CAST(134.85000000 AS Decimal(19, 8)), N'S', N'4793900', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(128.20000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6182, N'CIPLA', CAST(N'2023-04-28T00:00:00.000' AS DateTime), CAST(14.00000000 AS Decimal(19, 8)), CAST(909.70000000 AS Decimal(19, 8)), N'S', N'4449100', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(904.20000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6183, N'IDFCFIRSTB', CAST(N'2023-04-28T00:00:00.000' AS DateTime), CAST(210.00000000 AS Decimal(19, 8)), CAST(61.10000000 AS Decimal(19, 8)), N'S', N'29465047', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(55.50000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6184, N'NATCOPHARM', CAST(N'2023-04-28T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(572.80000000 AS Decimal(19, 8)), N'S', N'4046000', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(580.45000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6185, N'TMB', CAST(N'2023-04-28T00:00:00.000' AS DateTime), CAST(12.00000000 AS Decimal(19, 8)), CAST(413.50000000 AS Decimal(19, 8)), N'S', N'31605400', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(406.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6186, N'INDUSINDBK', CAST(N'2023-04-28T00:00:00.000' AS DateTime), CAST(7.00000000 AS Decimal(19, 8)), CAST(1145.00000000 AS Decimal(19, 8)), N'S', N'5792100', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1080.45000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6187, N'WIPRO', CAST(N'2023-04-28T00:00:00.000' AS DateTime), CAST(13.00000000 AS Decimal(19, 8)), CAST(382.65000000 AS Decimal(19, 8)), N'S', N'79428666', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(367.90000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6188, N'TECHM', CAST(N'2023-04-28T00:00:00.000' AS DateTime), CAST(23.00000000 AS Decimal(19, 8)), CAST(1019.10000000 AS Decimal(19, 8)), N'S', N'4019600', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1116.05000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6189, N'INFY', CAST(N'2023-04-28T00:00:00.000' AS DateTime), CAST(6.00000000 AS Decimal(19, 8)), CAST(1249.15000000 AS Decimal(19, 8)), N'B', N'29496624', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6190, N'PERSISTENT', CAST(N'2023-04-28T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(4729.95000000 AS Decimal(19, 8)), N'B', N'53880485', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6191, N'COFORGE', CAST(N'2023-04-28T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(4170.00000000 AS Decimal(19, 8)), N'B', N'3904344', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6192, N'MPHASIS', CAST(N'2023-04-28T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1805.00000000 AS Decimal(19, 8)), N'B', N'53887906', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6193, N'LTTS', CAST(N'2023-04-28T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(3793.00000000 AS Decimal(19, 8)), N'B', N'53889268', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6194, N'ICICIBANK', CAST(N'2023-04-28T00:00:00.000' AS DateTime), CAST(21.00000000 AS Decimal(19, 8)), CAST(911.90000000 AS Decimal(19, 8)), N'B', N'29531509', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6195, N'KOTAKBANK', CAST(N'2023-04-28T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1936.85000000 AS Decimal(19, 8)), N'B', N'53918240', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6196, N'BANDHANBNK', CAST(N'2023-04-28T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(229.50000000 AS Decimal(19, 8)), N'B', N'3950410', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6197, N'CUB', CAST(N'2023-04-28T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(141.50000000 AS Decimal(19, 8)), N'B', N'3954187', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6198, N'RBLBANK', CAST(N'2023-04-28T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(161.80000000 AS Decimal(19, 8)), N'B', N'79526507', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6199, N'KOTAKBANK', CAST(N'2023-04-28T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(1936.85000000 AS Decimal(19, 8)), N'B', N'53947859', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6200, N'TTKPRESTIG', CAST(N'2023-04-28T00:00:00.000' AS DateTime), CAST(8.00000000 AS Decimal(19, 8)), CAST(730.60000000 AS Decimal(19, 8)), N'B', N'79543286', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6201, N'CHOLAFIN', CAST(N'2023-04-28T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(871.80000000 AS Decimal(19, 8)), N'B', N'3993516', CAST(3.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6202, N'HDFCBANK', CAST(N'2023-04-28T00:00:00.000' AS DateTime), CAST(7.00000000 AS Decimal(19, 8)), CAST(1686.70000000 AS Decimal(19, 8)), N'B', N'29643899', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6203, N'HDFCBANK', CAST(N'2023-04-28T00:00:00.000' AS DateTime), CAST(11.00000000 AS Decimal(19, 8)), CAST(1686.80000000 AS Decimal(19, 8)), N'B', N'29643900', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6204, N'THANGAMAYL', CAST(N'2023-04-28T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1045.00000000 AS Decimal(19, 8)), N'B', N'79609339', CAST(2.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6205, N'ITC', CAST(N'2023-04-28T00:00:00.000' AS DateTime), CAST(7.00000000 AS Decimal(19, 8)), CAST(424.00000000 AS Decimal(19, 8)), N'B', N'29672632', CAST(7.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6258, N'IDFCFIRSTB', CAST(N'2023-05-02T00:00:00.000' AS DateTime), CAST(161.00000000 AS Decimal(19, 8)), CAST(63.90000000 AS Decimal(19, 8)), N'B', N'30499127', CAST(161.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6259, N'TTKPRESTIG', CAST(N'2023-05-02T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(720.80000000 AS Decimal(19, 8)), N'B', N'80272455', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6260, N'ITC', CAST(N'2023-05-02T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(424.25000000 AS Decimal(19, 8)), N'B', N'30524425', CAST(1.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6261, N'THANGAMAYL', CAST(N'2023-05-02T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1050.00000000 AS Decimal(19, 8)), N'B', N'80329359', CAST(1.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6262, N'MUTHOOTFIN', CAST(N'2023-05-02T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(1027.35000000 AS Decimal(19, 8)), N'B', N'54754722', CAST(3.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6263, N'IDFCFIRSTB', CAST(N'2023-05-02T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(63.80000000 AS Decimal(19, 8)), N'B', N'30646315', CAST(3.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6264, N'BANDHANBNK', CAST(N'2023-05-02T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(231.75000000 AS Decimal(19, 8)), N'B', N'4263173', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6321, N'MUTHOOTFIN', CAST(N'2023-05-03T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(66.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6414, N'TMB', CAST(N'2023-05-03T00:00:00.000' AS DateTime), CAST(6.00000000 AS Decimal(19, 8)), CAST(418.50000000 AS Decimal(19, 8)), N'B', N'79315062', CAST(6.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6415, N'KOTAKBANK', CAST(N'2023-05-03T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(1932.30000000 AS Decimal(19, 8)), N'B', N'54154789', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6446, N'IDFCFIRSTB', CAST(N'2023-05-05T00:00:00.000' AS DateTime), CAST(35.00000000 AS Decimal(19, 8)), CAST(63.45000000 AS Decimal(19, 8)), N'B', N'30375316', CAST(35.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6447, N'INFY', CAST(N'2023-05-05T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(1258.65000000 AS Decimal(19, 8)), N'B', N'30373807', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6448, N'TTKPRESTIG', CAST(N'2023-05-05T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(695.50000000 AS Decimal(19, 8)), N'B', N'79151203', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
GO
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6449, N'BANDHANBNK', CAST(N'2023-05-05T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(230.50000000 AS Decimal(19, 8)), N'B', N'3639719', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6450, N'CUB', CAST(N'2023-05-05T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(136.50000000 AS Decimal(19, 8)), N'B', N'3633833', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6451, N'RBLBANK', CAST(N'2023-05-05T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(149.50000000 AS Decimal(19, 8)), N'B', N'79170770', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6452, N'ITC', CAST(N'2023-05-05T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(428.95000000 AS Decimal(19, 8)), N'B', N'30394810', CAST(2.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6453, N'ICICIBANK', CAST(N'2023-05-05T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(930.65000000 AS Decimal(19, 8)), N'B', N'30402894', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6454, N'KOTAKBANK', CAST(N'2023-05-05T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1944.00000000 AS Decimal(19, 8)), N'B', N'53844572', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6455, N'NATCOPHARM', CAST(N'2023-05-05T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(606.15000000 AS Decimal(19, 8)), N'B', N'53848959', CAST(1.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6456, N'TCS', CAST(N'2023-05-05T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(3228.60000000 AS Decimal(19, 8)), N'B', N'79168190', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6457, N'HDFCBANK', CAST(N'2023-05-05T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1628.25000000 AS Decimal(19, 8)), N'B', N'30429669', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6458, N'HDFCBANK', CAST(N'2023-05-05T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1628.05000000 AS Decimal(19, 8)), N'B', N'30436346', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6459, N'IDFCFIRSTB', CAST(N'2023-05-05T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(63.40000000 AS Decimal(19, 8)), N'B', N'30477834', CAST(3.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6460, N'INFY', CAST(N'2023-05-05T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1259.10000000 AS Decimal(19, 8)), N'B', N'30492064', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6461, N'CUB', CAST(N'2023-05-05T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(136.45000000 AS Decimal(19, 8)), N'B', N'3693659', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6462, N'HDFCBANK', CAST(N'2023-05-05T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1625.45000000 AS Decimal(19, 8)), N'B', N'30507748', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6463, N'FEDERALBNK', CAST(N'2023-05-05T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(127.95000000 AS Decimal(19, 8)), N'B', N'30512492', CAST(3.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6464, N'RBLBANK', CAST(N'2023-05-05T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(149.25000000 AS Decimal(19, 8)), N'B', N'79225249', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6465, N'HCLTECH', CAST(N'2023-05-05T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1054.50000000 AS Decimal(19, 8)), N'B', N'30534520', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6466, N'WIPRO', CAST(N'2023-05-05T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(379.50000000 AS Decimal(19, 8)), N'B', N'79236425', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6467, N'TMB', CAST(N'2023-05-05T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(425.65000000 AS Decimal(19, 8)), N'B', N'79243938', CAST(1.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6468, N'HDFCBANK', CAST(N'2023-05-05T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1623.60000000 AS Decimal(19, 8)), N'B', N'30570885', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (6469, N'INDUSINDBK', CAST(N'2023-05-05T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1068.45000000 AS Decimal(19, 8)), N'B', N'30590704', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (7992, N'HCLTECH', CAST(N'2023-05-09T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(828.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (7993, N'RECLTD', CAST(N'2023-05-10T00:00:00.000' AS DateTime), CAST(15.00000000 AS Decimal(19, 8)), CAST(131.40000000 AS Decimal(19, 8)), N'B', N'78169221', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (7994, N'PGINVIT', CAST(N'2023-05-10T00:00:00.000' AS DateTime), CAST(7.00000000 AS Decimal(19, 8)), CAST(122.80000000 AS Decimal(19, 8)), N'B', N'53266480', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (7995, N'PGINVIT', CAST(N'2023-05-10T00:00:00.000' AS DateTime), CAST(9.00000000 AS Decimal(19, 8)), CAST(122.80000000 AS Decimal(19, 8)), N'B', N'53266481', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (7996, N'INDIGRID', CAST(N'2023-05-10T00:00:00.000' AS DateTime), CAST(14.00000000 AS Decimal(19, 8)), CAST(140.75000000 AS Decimal(19, 8)), N'B', N'28631131', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (7997, N'RECLTD', CAST(N'2023-05-10T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(131.40000000 AS Decimal(19, 8)), N'B', N'78188994', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (7998, N'INDIGRID', CAST(N'2023-05-16T00:00:00.000' AS DateTime), CAST(95.00000000 AS Decimal(19, 8)), CAST(140.25000000 AS Decimal(19, 8)), N'B', N'29450029', CAST(59.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (7999, N'PGINVIT', CAST(N'2023-05-16T00:00:00.000' AS DateTime), CAST(108.00000000 AS Decimal(19, 8)), CAST(122.97000000 AS Decimal(19, 8)), N'B', N'53963642', CAST(71.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8000, N'RECLTD', CAST(N'2023-05-16T00:00:00.000' AS DateTime), CAST(99.00000000 AS Decimal(19, 8)), CAST(134.30000000 AS Decimal(19, 8)), N'B', N'79183702', CAST(65.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8001, N'PGINVIT', CAST(N'2023-05-16T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(122.97000000 AS Decimal(19, 8)), N'B', N'53973097', CAST(1.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8002, N'INFY', CAST(N'2023-05-17T00:00:00.000' AS DateTime), CAST(62.00000000 AS Decimal(19, 8)), CAST(1254.50000000 AS Decimal(19, 8)), N'S', N'26402158', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1259.10000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8003, N'TCS', CAST(N'2023-05-17T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(3237.05000000 AS Decimal(19, 8)), N'S', N'76276673', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(3196.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8004, N'TCS', CAST(N'2023-05-17T00:00:00.000' AS DateTime), CAST(15.00000000 AS Decimal(19, 8)), CAST(3237.05000000 AS Decimal(19, 8)), N'S', N'76276889', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(3138.35000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8005, N'TCS', CAST(N'2023-05-17T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(3237.05000000 AS Decimal(19, 8)), N'S', N'76276629', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(3228.60000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8006, N'TECHM', CAST(N'2023-05-17T00:00:00.000' AS DateTime), CAST(11.00000000 AS Decimal(19, 8)), CAST(1054.55000000 AS Decimal(19, 8)), N'S', N'1008600', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1029.95000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8007, N'WIPRO', CAST(N'2023-05-17T00:00:00.000' AS DateTime), CAST(23.00000000 AS Decimal(19, 8)), CAST(384.00000000 AS Decimal(19, 8)), N'S', N'76281895', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(360.60000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8008, N'WIPRO', CAST(N'2023-05-17T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(384.00000000 AS Decimal(19, 8)), N'S', N'76281896', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(379.50000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8009, N'LTIM', CAST(N'2023-05-17T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(4728.25000000 AS Decimal(19, 8)), N'S', N'1533300', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(4405.50000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8010, N'PERSISTENT', CAST(N'2023-05-17T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(4765.00000000 AS Decimal(19, 8)), N'S', N'524900', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(4729.95000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8011, N'COFORGE', CAST(N'2023-05-17T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(4185.35000000 AS Decimal(19, 8)), N'S', N'1168320', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(4170.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8012, N'MPHASIS', CAST(N'2023-05-17T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1860.90000000 AS Decimal(19, 8)), N'S', N'737800', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1805.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8013, N'LTTS', CAST(N'2023-05-17T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(3840.50000000 AS Decimal(19, 8)), N'S', N'919800', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(3793.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8014, N'HCLTECH', CAST(N'2023-05-17T00:00:00.000' AS DateTime), CAST(8.00000000 AS Decimal(19, 8)), CAST(1078.25000000 AS Decimal(19, 8)), N'S', N'5245700', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1038.05000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8015, N'HCLTECH', CAST(N'2023-05-17T00:00:00.000' AS DateTime), CAST(6.00000000 AS Decimal(19, 8)), CAST(1078.25000000 AS Decimal(19, 8)), N'S', N'5245900', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1038.50000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8016, N'HCLTECH', CAST(N'2023-05-17T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(1078.15000000 AS Decimal(19, 8)), N'S', N'5267500', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1054.50000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8017, N'HDFCBANK', CAST(N'2023-05-17T00:00:00.000' AS DateTime), CAST(42.00000000 AS Decimal(19, 8)), CAST(1644.90000000 AS Decimal(19, 8)), N'S', N'26444803', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1623.60000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8018, N'ICICIBANK', CAST(N'2023-05-17T00:00:00.000' AS DateTime), CAST(60.00000000 AS Decimal(19, 8)), CAST(941.95000000 AS Decimal(19, 8)), N'S', N'1020700', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(930.65000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8019, N'INDUSINDBK', CAST(N'2023-05-17T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(1241.90000000 AS Decimal(19, 8)), N'S', N'26449725', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1080.45000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8020, N'INDUSINDBK', CAST(N'2023-05-17T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(1241.90000000 AS Decimal(19, 8)), N'S', N'26451882', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1068.45000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8021, N'KOTAKBANK', CAST(N'2023-05-17T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1922.95000000 AS Decimal(19, 8)), N'S', N'51273875', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1936.85000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8022, N'KOTAKBANK', CAST(N'2023-05-17T00:00:00.000' AS DateTime), CAST(8.00000000 AS Decimal(19, 8)), CAST(1922.95000000 AS Decimal(19, 8)), N'S', N'51273876', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(1944.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8023, N'BANDHANBNK', CAST(N'2023-05-17T00:00:00.000' AS DateTime), CAST(7.00000000 AS Decimal(19, 8)), CAST(243.35000000 AS Decimal(19, 8)), N'S', N'2438000', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(230.50000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8024, N'CUB', CAST(N'2023-05-17T00:00:00.000' AS DateTime), CAST(6.00000000 AS Decimal(19, 8)), CAST(139.95000000 AS Decimal(19, 8)), N'S', N'1016000', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(136.45000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8025, N'RBLBANK', CAST(N'2023-05-17T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(148.05000000 AS Decimal(19, 8)), N'S', N'2568600', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(149.25000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8092, N'RECLTD', CAST(N'2023-05-19T00:00:00.000' AS DateTime), CAST(118.00000000 AS Decimal(19, 8)), CAST(127.60000000 AS Decimal(19, 8)), N'S', N'1591100', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(134.30000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8093, N'PGINVIT', CAST(N'2023-05-19T00:00:00.000' AS DateTime), CAST(121.00000000 AS Decimal(19, 8)), CAST(125.20000000 AS Decimal(19, 8)), N'S', N'51135408', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(122.97000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8094, N'INDIGRID', CAST(N'2023-05-19T00:00:00.000' AS DateTime), CAST(110.00000000 AS Decimal(19, 8)), CAST(138.25000000 AS Decimal(19, 8)), N'S', N'26346520', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(140.25000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8095, N'INDIGRID', CAST(N'2023-05-19T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(138.25000000 AS Decimal(19, 8)), N'S', N'26365594', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(140.25000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8096, N'PGINVIT', CAST(N'2023-05-19T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(125.27000000 AS Decimal(19, 8)), N'S', N'51173758', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(122.97000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8097, N'RECLTD', CAST(N'2023-05-19T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(128.70000000 AS Decimal(19, 8)), N'S', N'1919700', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(134.30000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8098, N'NAVIBANK', CAST(N'2023-05-19T00:00:00.000' AS DateTime), CAST(219.39900000 AS Decimal(19, 8)), CAST(11.39420000 AS Decimal(19, 8)), N'B', N'714723178', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8128, N'ICICIIT', CAST(N'2023-05-17T00:00:00.000' AS DateTime), CAST(106.64800000 AS Decimal(19, 8)), CAST(9.37620000 AS Decimal(19, 8)), N'B', N'714052192', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8129, N'BANKNIFTY', CAST(N'2023-05-22T00:00:00.000' AS DateTime), CAST(4020.22300000 AS Decimal(19, 8)), CAST(12.43650000 AS Decimal(19, 8)), N'B', N'717737705', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8130, N'ICICIIT', CAST(N'2023-05-22T00:00:00.000' AS DateTime), CAST(5137.75000000 AS Decimal(19, 8)), CAST(9.73140000 AS Decimal(19, 8)), N'B', N'717735984', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8514, N'COFORGE', CAST(N'2023-05-20T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(19.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8515, N'INDIGRID', CAST(N'2023-05-25T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(549.35000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8516, N'DRREDDY', CAST(N'2023-05-26T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(4530.65000000 AS Decimal(19, 8)), N'S', N'29183380', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(4691.90000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8517, N'DIVISLAB', CAST(N'2023-05-26T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(3513.05000000 AS Decimal(19, 8)), N'B', N'29491404', CAST(1.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8518, N'DIVISLAB', CAST(N'2023-05-26T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(3513.10000000 AS Decimal(19, 8)), N'B', N'29491405', CAST(1.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8519, N'CIPLA', CAST(N'2023-05-29T00:00:00.000' AS DateTime), CAST(6.00000000 AS Decimal(19, 8)), CAST(955.10000000 AS Decimal(19, 8)), N'S', N'3869667', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(904.20000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8520, N'CIPLA', CAST(N'2023-05-29T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(955.10000000 AS Decimal(19, 8)), N'S', N'3869668', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(904.20000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8521, N'FEDERALBNK', CAST(N'2023-05-29T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(125.55000000 AS Decimal(19, 8)), N'B', N'29778532', CAST(5.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8522, N'TMB', CAST(N'2023-05-29T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(413.10000000 AS Decimal(19, 8)), N'B', N'79517162', CAST(5.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8523, N'FEDERALBNK', CAST(N'2023-05-29T00:00:00.000' AS DateTime), CAST(12.00000000 AS Decimal(19, 8)), CAST(125.55000000 AS Decimal(19, 8)), N'B', N'29787640', CAST(12.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8524, N'MUTHOOTFIN', CAST(N'2023-05-29T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1116.55000000 AS Decimal(19, 8)), N'B', N'54312796', CAST(1.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8525, N'ITC', CAST(N'2023-05-29T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(448.80000000 AS Decimal(19, 8)), N'B', N'29839874', CAST(4.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8526, N'NASDAQ', CAST(N'2023-05-25T00:00:00.000' AS DateTime), CAST(7485.95300000 AS Decimal(19, 8)), CAST(10.01240000 AS Decimal(19, 8)), N'S', N'718875176', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(9.32760000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8529, N'INDIGRID', CAST(N'2023-05-30T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(134.01000000 AS Decimal(19, 8)), N'B', N'28359500', CAST(4.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8530, N'FEDERALBNK', CAST(N'2023-05-30T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(125.25000000 AS Decimal(19, 8)), N'B', N'29936099', CAST(4.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8531, N'TMB', CAST(N'2023-05-30T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(414.95000000 AS Decimal(19, 8)), N'B', N'79567368', CAST(1.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8598, N'FEDERALBNK', CAST(N'2023-06-07T00:00:00.000' AS DateTime), CAST(26.00000000 AS Decimal(19, 8)), CAST(126.30000000 AS Decimal(19, 8)), N'B', N'29874330', CAST(26.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8599, N'WIPRO', CAST(N'2023-06-07T00:00:00.000' AS DateTime), CAST(11.00000000 AS Decimal(19, 8)), CAST(402.65000000 AS Decimal(19, 8)), N'B', N'80869430', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8600, N'TECHM', CAST(N'2023-06-07T00:00:00.000' AS DateTime), CAST(10.00000000 AS Decimal(19, 8)), CAST(1095.05000000 AS Decimal(19, 8)), N'B', N'80878037', CAST(10.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8601, N'INFY', CAST(N'2023-06-07T00:00:00.000' AS DateTime), CAST(9.00000000 AS Decimal(19, 8)), CAST(1288.95000000 AS Decimal(19, 8)), N'B', N'29893711', CAST(9.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8602, N'TCS', CAST(N'2023-06-07T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(3274.20000000 AS Decimal(19, 8)), N'B', N'80923266', CAST(1.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8603, N'TCS', CAST(N'2023-06-07T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(3274.20000000 AS Decimal(19, 8)), N'B', N'80923267', CAST(1.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8604, N'TCS', CAST(N'2023-06-07T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(3274.20000000 AS Decimal(19, 8)), N'B', N'80923268', CAST(1.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8605, N'HCLTECH', CAST(N'2023-06-07T00:00:00.000' AS DateTime), CAST(7.00000000 AS Decimal(19, 8)), CAST(1128.95000000 AS Decimal(19, 8)), N'B', N'29946402', CAST(7.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8606, N'HCLTECH', CAST(N'2023-06-07T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1128.95000000 AS Decimal(19, 8)), N'B', N'29968577', CAST(1.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8607, N'KTKBANK', CAST(N'2023-06-07T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(150.50000000 AS Decimal(19, 8)), N'B', N'54596212', CAST(3.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8608, N'KARURVYSYA', CAST(N'2023-06-07T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(108.50000000 AS Decimal(19, 8)), N'B', N'54605810', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8632, N'DRREDDY', CAST(N'2023-06-08T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(4646.20000000 AS Decimal(19, 8)), N'B', N'29441114', CAST(2.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8633, N'KALYANKJIL', CAST(N'2023-06-08T00:00:00.000' AS DateTime), CAST(70.00000000 AS Decimal(19, 8)), CAST(110.95000000 AS Decimal(19, 8)), N'B', N'54438818', CAST(70.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8634, N'MANAPPURAM', CAST(N'2023-06-08T00:00:00.000' AS DateTime), CAST(26.00000000 AS Decimal(19, 8)), CAST(112.55000000 AS Decimal(19, 8)), N'B', N'54445800', CAST(26.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8778, N'PERSISTENT', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(4977.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8779, N'HATSUN', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(913.50000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8780, N'RBLBANK', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(177.90000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8781, N'PIDILITIND', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(2647.65000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8782, N'BRITANNIA', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(4902.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
GO
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8783, N'DEEPAKNTR', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(2031.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8784, N'CIPLA', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(960.50000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8785, N'DIVISLAB', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(3438.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8786, N'LTIM', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(4905.35000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8787, N'LTTS', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(3890.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8788, N'ICICIBANK', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(936.70000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8789, N'COFORGE', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(4501.95000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8790, N'CHOLAFIN', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1074.70000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8791, N'MUTHOOTFIN', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1135.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8792, N'HINDUNILVR', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(2649.80000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8793, N'HDFCBANK', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1600.90000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8794, N'HDFC', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(2642.75000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8795, N'KTKBANK', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(146.40000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8796, N'BAJFINANCE', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(7107.90000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8797, N'SBICARD', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(925.50000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8798, N'RECLTD', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(154.70000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8799, N'DABUR', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(553.65000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8800, N'CUB', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(124.50000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8801, N'KOTAKBANK', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1877.20000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8802, N'ITC', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(437.50000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8803, N'BANDHANBNK', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(257.25000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8804, N'HCLTECH', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1137.80000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8805, N'TATACONSUM', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(801.85000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8806, N'TATAMTRDVR', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(299.50000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8807, N'TATASTEEL', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(109.55000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8808, N'TCS', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(3248.40000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8809, N'TECHM', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1075.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8810, N'THANGAMAYL', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1444.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8811, N'TITAN', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(2857.40000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8812, N'TMB', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(410.80000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8813, N'TTKPRESTIG', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(721.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8814, N'VBL', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1599.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8815, N'WIPRO', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(395.65000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8816, N'TATACHEM', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(989.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8817, N'KARURVYSYA', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(112.50000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8818, N'COROMANDEL', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(932.15000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8819, N'DRREDDY', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(4675.95000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8820, N'FEDERALBNK', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(125.20000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8821, N'IDFCFIRSTB', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(72.90000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8822, N'INFY', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1292.65000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8823, N'KALYANKJIL', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(109.40000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8824, N'MANAPPURAM', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(118.75000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8825, N'NATCOPHARM', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(622.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8826, N'INDUSINDBK', CAST(N'2023-06-12T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1332.50000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8827, N'PGINVIT', CAST(N'2023-06-08T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(200.00000000 AS Decimal(19, 8)), N'D', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8828, N'PGINVIT', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(116.92000000 AS Decimal(19, 8)), N'P', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8829, N'INDIGRID', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(134.52000000 AS Decimal(19, 8)), N'P', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8830, N'ICICIIT', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(9.58000000 AS Decimal(19, 8)), N'P', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8831, N'BANKNIFTY', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(12.43000000 AS Decimal(19, 8)), N'P', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8832, N'NAVIBANK', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(11.39000000 AS Decimal(19, 8)), N'P', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8833, N'CHOLAFIN', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1096.25250000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8834, N'CHOLAFIN', CAST(N'2023-06-14T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1099.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8835, N'DIVISLAB', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(3459.85500000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8836, N'DIVISLAB', CAST(N'2023-06-14T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(3473.75000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8837, N'DRREDDY', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(4701.12984000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8838, N'DRREDDY', CAST(N'2023-06-14T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(4701.60000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8839, N'FEDERALBNK', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(124.25072000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8840, N'FEDERALBNK', CAST(N'2023-06-14T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(124.40000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8841, N'HCLTECH', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1142.37032000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8842, N'HCLTECH', CAST(N'2023-06-14T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1136.80000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8843, N'IDFCFIRSTB', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(78.13954500 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8844, N'IDFCFIRSTB', CAST(N'2023-06-14T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(76.45000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8845, N'INFY', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1292.31696000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8846, N'INFY', CAST(N'2023-06-14T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1298.55000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8847, N'ITC', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(446.10660000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8848, N'ITC', CAST(N'2023-06-14T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(445.75000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8849, N'KALYANKJIL', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(110.63759000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8850, N'KALYANKJIL', CAST(N'2023-06-14T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(112.70000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8851, N'KARURVYSYA', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(117.78018000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8852, N'KARURVYSYA', CAST(N'2023-06-14T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(115.80000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8853, N'KTKBANK', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(150.61824000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8854, N'KTKBANK', CAST(N'2023-06-14T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(148.95000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8855, N'MANAPPURAM', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(120.70037000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8856, N'MANAPPURAM', CAST(N'2023-06-14T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(121.10000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8857, N'MUTHOOTFIN', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1144.41792000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8858, N'MUTHOOTFIN', CAST(N'2023-06-14T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1150.40000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8859, N'NATCOPHARM', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(619.44200000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8860, N'NATCOPHARM', CAST(N'2023-06-14T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(620.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8861, N'RECLTD', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(152.11850000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8862, N'RECLTD', CAST(N'2023-06-14T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(153.50000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8863, N'TCS', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(3261.18148000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8864, N'TCS', CAST(N'2023-06-14T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(3252.40000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8865, N'TECHM', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1080.48997500 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8866, N'TECHM', CAST(N'2023-06-14T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1079.95000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8867, N'THANGAMAYL', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1474.61401500 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8868, N'THANGAMAYL', CAST(N'2023-06-14T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1470.35000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8869, N'TMB', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(411.35199000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8870, N'TMB', CAST(N'2023-06-14T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(410.90000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8871, N'TTKPRESTIG', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(723.85512500 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8872, N'TTKPRESTIG', CAST(N'2023-06-14T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(722.05000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8873, N'WIPRO', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(394.84432000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8874, N'WIPRO', CAST(N'2023-06-14T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(395.20000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8875, N'PGINVIT', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(116.84000000 AS Decimal(19, 8)), N'B', N'54472583', CAST(2.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8876, N'TTKPRESTIG', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(10.00000000 AS Decimal(19, 8)), CAST(722.50000000 AS Decimal(19, 8)), N'S', N'80618824', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(725.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8877, N'TTKPRESTIG', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(10.00000000 AS Decimal(19, 8)), CAST(722.50000000 AS Decimal(19, 8)), N'S', N'80635192', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(717.50000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8878, N'TTKPRESTIG', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(722.50000000 AS Decimal(19, 8)), N'S', N'80636004', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(717.50000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8879, N'TTKPRESTIG', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(16.00000000 AS Decimal(19, 8)), CAST(722.50000000 AS Decimal(19, 8)), N'S', N'80636912', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(695.50000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8880, N'BAJFINANCE', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(7164.00000000 AS Decimal(19, 8)), N'B', N'3918727', CAST(1.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8881, N'COROMANDEL', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(936.70000000 AS Decimal(19, 8)), N'B', N'3974081', CAST(1.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8882, N'TATACHEM', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(999.95000000 AS Decimal(19, 8)), N'B', N'80782036', CAST(2.00000000 AS Decimal(19, 8)), NULL, NULL)
GO
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8883, N'INDUSINDBK', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1333.70000000 AS Decimal(19, 8)), N'B', N'30365270', CAST(1.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8884, N'DEEPAKNTR', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2071.90000000 AS Decimal(19, 8)), N'B', N'30369112', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8885, N'HDFCBANK', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1607.50000000 AS Decimal(19, 8)), N'B', N'30389729', CAST(1.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8886, N'WIPRO', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(395.35000000 AS Decimal(19, 8)), N'B', N'80829310', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8887, N'ICICIBANK', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(945.20000000 AS Decimal(19, 8)), N'B', N'30417767', CAST(1.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8888, N'MANAPPURAM', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(10.00000000 AS Decimal(19, 8)), CAST(121.50000000 AS Decimal(19, 8)), N'B', N'55226801', CAST(10.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8889, N'FEDERALBNK', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(10.00000000 AS Decimal(19, 8)), CAST(124.70000000 AS Decimal(19, 8)), N'B', N'30470860', CAST(10.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8890, N'INFY', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1304.80000000 AS Decimal(19, 8)), N'B', N'30479088', CAST(1.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8891, N'INDIGRID', CAST(N'2023-06-14T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(136.00000000 AS Decimal(19, 8)), N'P', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8892, N'PGINVIT', CAST(N'2023-06-14T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(116.48000000 AS Decimal(19, 8)), N'P', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8893, N'BAJFINANCE', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(7031.31187500 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8894, N'BAJFINANCE', CAST(N'2023-06-14T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(7098.75000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8895, N'COROMANDEL', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(958.87000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8896, N'COROMANDEL', CAST(N'2023-06-14T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(947.50000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8897, N'DEEPAKNTR', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(2163.82160000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8898, N'DEEPAKNTR', CAST(N'2023-06-14T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(2116.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8899, N'HDFCBANK', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1602.46911500 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8900, N'HDFCBANK', CAST(N'2023-06-14T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1602.95000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8901, N'ICICIBANK', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(936.42800000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8902, N'ICICIBANK', CAST(N'2023-06-14T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(940.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8903, N'INDUSINDBK', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1314.15125500 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8904, N'INDUSINDBK', CAST(N'2023-06-14T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1325.15000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8905, N'TATACHEM', CAST(N'2023-06-13T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(954.91984000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8906, N'TATACHEM', CAST(N'2023-06-14T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(977.20000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8907, N'MANAPPURAM', CAST(N'2023-06-14T00:00:00.000' AS DateTime), CAST(15.00000000 AS Decimal(19, 8)), CAST(121.15000000 AS Decimal(19, 8)), N'B', N'54076870', CAST(15.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8908, N'KARURVYSYA', CAST(N'2023-06-14T00:00:00.000' AS DateTime), CAST(10.00000000 AS Decimal(19, 8)), CAST(115.90000000 AS Decimal(19, 8)), N'B', N'54078879', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8909, N'KALYANKJIL', CAST(N'2023-06-14T00:00:00.000' AS DateTime), CAST(10.00000000 AS Decimal(19, 8)), CAST(112.55000000 AS Decimal(19, 8)), N'B', N'54091480', CAST(10.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8910, N'KALYANKJIL', CAST(N'2023-06-14T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(112.70000000 AS Decimal(19, 8)), N'B', N'54105132', CAST(2.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8911, N'KARURVYSYA', CAST(N'2023-06-14T00:00:00.000' AS DateTime), CAST(8.00000000 AS Decimal(19, 8)), CAST(115.85000000 AS Decimal(19, 8)), N'B', N'54113646', CAST(0.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8912, N'BAJFINANCE', CAST(N'2023-06-15T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(7121.85000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8913, N'CHOLAFIN', CAST(N'2023-06-15T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1111.50000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8914, N'COROMANDEL', CAST(N'2023-06-15T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(940.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8915, N'DEEPAKNTR', CAST(N'2023-06-15T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(2137.55000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8916, N'DIVISLAB', CAST(N'2023-06-15T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(3580.15000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8917, N'DRREDDY', CAST(N'2023-06-15T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(4801.80000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8918, N'FEDERALBNK', CAST(N'2023-06-15T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(122.10000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8919, N'HCLTECH', CAST(N'2023-06-15T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1143.45000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8920, N'HDFCBANK', CAST(N'2023-06-15T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1580.80000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8921, N'ICICIBANK', CAST(N'2023-06-15T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(926.95000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8922, N'IDFCFIRSTB', CAST(N'2023-06-15T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(79.10000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8923, N'INDUSINDBK', CAST(N'2023-06-15T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1298.20000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8924, N'INFY', CAST(N'2023-06-15T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1286.50000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8925, N'ITC', CAST(N'2023-06-15T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(448.10000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8926, N'KALYANKJIL', CAST(N'2023-06-15T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(116.30000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8927, N'KARURVYSYA', CAST(N'2023-06-15T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(119.45000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8928, N'KTKBANK', CAST(N'2023-06-15T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(151.90000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8929, N'MANAPPURAM', CAST(N'2023-06-15T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(119.75000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8930, N'MUTHOOTFIN', CAST(N'2023-06-15T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1155.80000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8931, N'NATCOPHARM', CAST(N'2023-06-15T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(640.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8932, N'RECLTD', CAST(N'2023-06-15T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(152.15000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8933, N'TATACHEM', CAST(N'2023-06-15T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(960.20000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8934, N'TCS', CAST(N'2023-06-15T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(3216.85000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8935, N'TECHM', CAST(N'2023-06-15T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1081.35000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8936, N'THANGAMAYL', CAST(N'2023-06-15T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1460.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8937, N'TMB', CAST(N'2023-06-15T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(415.95000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8938, N'WIPRO', CAST(N'2023-06-15T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(389.30000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8939, N'BAJFINANCE', CAST(N'2023-06-16T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(7200.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8940, N'CHOLAFIN', CAST(N'2023-06-16T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1129.70000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8941, N'COROMANDEL', CAST(N'2023-06-16T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(936.70000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8942, N'DEEPAKNTR', CAST(N'2023-06-16T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(2163.75000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8943, N'DIVISLAB', CAST(N'2023-06-16T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(3575.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8944, N'DRREDDY', CAST(N'2023-06-16T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(4900.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8945, N'FEDERALBNK', CAST(N'2023-06-16T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(123.75000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8946, N'HCLTECH', CAST(N'2023-06-16T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1147.05000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8947, N'HDFCBANK', CAST(N'2023-06-16T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1602.50000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8948, N'ICICIBANK', CAST(N'2023-06-16T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(934.05000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8949, N'IDFCFIRSTB', CAST(N'2023-06-16T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(81.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8950, N'INDUSINDBK', CAST(N'2023-06-16T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1310.90000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8951, N'INFY', CAST(N'2023-06-16T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1290.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8952, N'ITC', CAST(N'2023-06-16T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(453.50000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8953, N'KALYANKJIL', CAST(N'2023-06-16T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(133.80000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8954, N'KARURVYSYA', CAST(N'2023-06-16T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(127.90000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8955, N'KTKBANK', CAST(N'2023-06-16T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(155.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8956, N'MANAPPURAM', CAST(N'2023-06-16T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(125.10000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8957, N'MUTHOOTFIN', CAST(N'2023-06-16T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1169.50000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8958, N'NATCOPHARM', CAST(N'2023-06-16T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(631.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8959, N'RECLTD', CAST(N'2023-06-16T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(152.80000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8960, N'TATACHEM', CAST(N'2023-06-16T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(970.90000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8961, N'TCS', CAST(N'2023-06-16T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(3177.30000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8962, N'TECHM', CAST(N'2023-06-16T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1079.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8963, N'THANGAMAYL', CAST(N'2023-06-16T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1482.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8964, N'TMB', CAST(N'2023-06-16T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(420.45000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8965, N'WIPRO', CAST(N'2023-06-16T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(380.40000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8966, N'PGINVIT', CAST(N'2023-06-16T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(115.86000000 AS Decimal(19, 8)), N'P', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8967, N'INDIGRID', CAST(N'2023-06-16T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(135.83000000 AS Decimal(19, 8)), N'P', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8968, N'PGINVIT', CAST(N'2023-06-22T00:00:00.000' AS DateTime), CAST(21.00000000 AS Decimal(19, 8)), CAST(115.92000000 AS Decimal(19, 8)), N'B', N'50294720', CAST(21.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8969, N'IDFCFIRSTB', CAST(N'2023-06-22T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(81.40000000 AS Decimal(19, 8)), N'B', N'25316299', CAST(1.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8970, N'BAJFINANCE', CAST(N'2023-06-22T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(6955.78789500 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8971, N'BAJFINANCE', CAST(N'2023-06-23T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(6992.85000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8972, N'CHOLAFIN', CAST(N'2023-06-22T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1079.86300000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8973, N'CHOLAFIN', CAST(N'2023-06-23T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1090.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8974, N'COROMANDEL', CAST(N'2023-06-22T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(906.24082500 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8975, N'COROMANDEL', CAST(N'2023-06-23T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(928.05000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8976, N'DEEPAKNTR', CAST(N'2023-06-22T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(2165.71950000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8977, N'DEEPAKNTR', CAST(N'2023-06-23T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(2216.25000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8978, N'DIVISLAB', CAST(N'2023-06-22T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(3393.78480000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8979, N'DIVISLAB', CAST(N'2023-06-23T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(3468.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8980, N'DRREDDY', CAST(N'2023-06-22T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(5092.14762500 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8981, N'DRREDDY', CAST(N'2023-06-23T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(4994.75000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8982, N'FEDERALBNK', CAST(N'2023-06-22T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(120.82017000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
GO
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8983, N'FEDERALBNK', CAST(N'2023-06-23T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(122.30000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8984, N'HCLTECH', CAST(N'2023-06-22T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1170.13357500 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8985, N'HCLTECH', CAST(N'2023-06-23T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1166.75000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8986, N'HDFCBANK', CAST(N'2023-06-22T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1645.85129000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8987, N'HDFCBANK', CAST(N'2023-06-23T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1644.70000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8988, N'ICICIBANK', CAST(N'2023-06-22T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(921.90991500 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8989, N'ICICIBANK', CAST(N'2023-06-23T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(923.85000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8990, N'IDFCFIRSTB', CAST(N'2023-06-22T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(77.89772500 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8991, N'IDFCFIRSTB', CAST(N'2023-06-23T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(77.75000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8992, N'INDUSINDBK', CAST(N'2023-06-22T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1347.62985000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8993, N'INDUSINDBK', CAST(N'2023-06-23T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1309.65000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8994, N'INFY', CAST(N'2023-06-22T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1249.68125000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8995, N'INFY', CAST(N'2023-06-23T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1265.50000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8996, N'ITC', CAST(N'2023-06-22T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(441.48260500 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8997, N'ITC', CAST(N'2023-06-23T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(444.55000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8998, N'KALYANKJIL', CAST(N'2023-06-22T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(129.48120000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (8999, N'KALYANKJIL', CAST(N'2023-06-23T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(126.20000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9000, N'KARURVYSYA', CAST(N'2023-06-22T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(118.72865000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9001, N'KARURVYSYA', CAST(N'2023-06-23T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(120.50000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9002, N'KTKBANK', CAST(N'2023-06-22T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(147.24302500 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9003, N'KTKBANK', CAST(N'2023-06-23T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(151.75000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9004, N'MANAPPURAM', CAST(N'2023-06-22T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(121.54684000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9005, N'MANAPPURAM', CAST(N'2023-06-23T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(123.80000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9006, N'MUTHOOTFIN', CAST(N'2023-06-22T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1236.15786000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9007, N'MUTHOOTFIN', CAST(N'2023-06-23T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1222.95000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9008, N'NATCOPHARM', CAST(N'2023-06-22T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(730.36231000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9009, N'NATCOPHARM', CAST(N'2023-06-23T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(676.70000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9010, N'RECLTD', CAST(N'2023-06-22T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(153.00480000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9011, N'RECLTD', CAST(N'2023-06-23T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(156.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9012, N'TATACHEM', CAST(N'2023-06-22T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(956.08800000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9013, N'TATACHEM', CAST(N'2023-06-23T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(980.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9014, N'TCS', CAST(N'2023-06-22T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(3195.76780000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9015, N'TCS', CAST(N'2023-06-23T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(3217.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9016, N'TECHM', CAST(N'2023-06-22T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1110.56376000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9017, N'TECHM', CAST(N'2023-06-23T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1114.80000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9018, N'THANGAMAYL', CAST(N'2023-06-22T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1460.01985000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9019, N'THANGAMAYL', CAST(N'2023-06-23T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1492.10000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9020, N'TMB', CAST(N'2023-06-22T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(438.75682500 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9021, N'TMB', CAST(N'2023-06-23T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(437.75000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9022, N'WIPRO', CAST(N'2023-06-22T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(377.50663000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9023, N'WIPRO', CAST(N'2023-06-23T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(379.90000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9024, N'BAJFINANCE', CAST(N'2023-06-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(6931.56800000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9025, N'BAJFINANCE', CAST(N'2023-06-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(6965.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9026, N'CHOLAFIN', CAST(N'2023-06-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1082.32589000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9027, N'CHOLAFIN', CAST(N'2023-06-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1079.95000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9028, N'COROMANDEL', CAST(N'2023-06-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(959.02180000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9029, N'COROMANDEL', CAST(N'2023-06-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(947.65000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9030, N'DEEPAKNTR', CAST(N'2023-06-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(2232.55000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9031, N'DEEPAKNTR', CAST(N'2023-06-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(2232.55000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9032, N'DIVISLAB', CAST(N'2023-06-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(3603.97620000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9033, N'DIVISLAB', CAST(N'2023-06-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(3569.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9034, N'DRREDDY', CAST(N'2023-06-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(5111.32647000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9035, N'DRREDDY', CAST(N'2023-06-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(5076.30000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9036, N'FEDERALBNK', CAST(N'2023-06-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(122.70760000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9037, N'FEDERALBNK', CAST(N'2023-06-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(122.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9038, N'HCLTECH', CAST(N'2023-06-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1158.46430000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9039, N'HCLTECH', CAST(N'2023-06-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1163.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9040, N'HDFCBANK', CAST(N'2023-06-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1651.60339500 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9041, N'HDFCBANK', CAST(N'2023-06-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1643.55000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9042, N'ICICIBANK', CAST(N'2023-06-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(923.17181000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9043, N'ICICIBANK', CAST(N'2023-06-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(925.30000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9044, N'IDFCFIRSTB', CAST(N'2023-06-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(80.57470000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9045, N'IDFCFIRSTB', CAST(N'2023-06-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(79.15000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9046, N'INDUSINDBK', CAST(N'2023-06-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1293.78476500 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9047, N'INDUSINDBK', CAST(N'2023-06-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1304.35000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9048, N'INFY', CAST(N'2023-06-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1285.38931500 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9049, N'INFY', CAST(N'2023-06-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1277.85000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9050, N'ITC', CAST(N'2023-06-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(443.48850000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9051, N'ITC', CAST(N'2023-06-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(444.60000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9052, N'KALYANKJIL', CAST(N'2023-06-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(134.32632500 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9053, N'KALYANKJIL', CAST(N'2023-06-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(132.25000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9054, N'KARURVYSYA', CAST(N'2023-06-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(121.30735000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9055, N'KARURVYSYA', CAST(N'2023-06-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(120.50000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9056, N'KTKBANK', CAST(N'2023-06-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(156.65007000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9057, N'KTKBANK', CAST(N'2023-06-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(153.85000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9058, N'MANAPPURAM', CAST(N'2023-06-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(128.51050500 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9059, N'MANAPPURAM', CAST(N'2023-06-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(127.15000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9060, N'MUTHOOTFIN', CAST(N'2023-06-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1213.31804500 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9061, N'MUTHOOTFIN', CAST(N'2023-06-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1225.45000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9062, N'NATCOPHARM', CAST(N'2023-06-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(682.71074000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9063, N'NATCOPHARM', CAST(N'2023-06-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(689.05000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9064, N'RECLTD', CAST(N'2023-06-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(160.47189000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9065, N'RECLTD', CAST(N'2023-06-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(158.35000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9066, N'TATACHEM', CAST(N'2023-06-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1009.11140000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9067, N'TATACHEM', CAST(N'2023-06-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1001.50000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9068, N'TCS', CAST(N'2023-06-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(3195.47334000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9069, N'TCS', CAST(N'2023-06-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(3192.60000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9070, N'TECHM', CAST(N'2023-06-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1105.22435000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9071, N'TECHM', CAST(N'2023-06-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1108.55000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9072, N'THANGAMAYL', CAST(N'2023-06-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1502.61342000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9073, N'THANGAMAYL', CAST(N'2023-06-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1493.80000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9074, N'TMB', CAST(N'2023-06-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(436.86671500 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9075, N'TMB', CAST(N'2023-06-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(434.65000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9076, N'WIPRO', CAST(N'2023-06-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(384.32170000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9077, N'WIPRO', CAST(N'2023-06-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(382.60000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9078, N'BANKNIFTY', CAST(N'2023-06-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(12.39950000 AS Decimal(19, 8)), N'P', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9079, N'ICICIIT', CAST(N'2023-06-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(9.63600000 AS Decimal(19, 8)), N'P', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9080, N'NAVIBANK', CAST(N'2023-06-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(11.33950000 AS Decimal(19, 8)), N'P', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9081, N'PGINVIT', CAST(N'2023-06-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(114.70000000 AS Decimal(19, 8)), N'P', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9082, N'INDIGRID', CAST(N'2023-06-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(135.44000000 AS Decimal(19, 8)), N'P', N'', NULL, NULL, NULL)
GO
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9083, N'BAJFINANCE', CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(7234.03317000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9084, N'BAJFINANCE', CAST(N'2023-06-30T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(7161.70000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9085, N'CHOLAFIN', CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1161.40081500 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9086, N'CHOLAFIN', CAST(N'2023-06-30T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1144.35000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9087, N'COROMANDEL', CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(952.35348000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9088, N'COROMANDEL', CAST(N'2023-06-30T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(947.05000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9089, N'DEEPAKNTR', CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(2172.82500000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9090, N'DEEPAKNTR', CAST(N'2023-06-30T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(2175.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9091, N'DIVISLAB', CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(3564.82619000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9092, N'DIVISLAB', CAST(N'2023-06-30T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(3583.10000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9093, N'DRREDDY', CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(5231.12920000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9094, N'DRREDDY', CAST(N'2023-06-30T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(5169.10000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9095, N'FEDERALBNK', CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(130.49200000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9096, N'FEDERALBNK', CAST(N'2023-06-30T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(126.25000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9097, N'HCLTECH', CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1207.04060000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9098, N'HCLTECH', CAST(N'2023-06-30T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1188.50000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9099, N'HDFCBANK', CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1729.50108000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9100, N'HDFCBANK', CAST(N'2023-06-30T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1702.60000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9101, N'ICICIBANK', CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(931.60305000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9102, N'ICICIBANK', CAST(N'2023-06-30T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(934.50000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9103, N'IDFCFIRSTB', CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(79.00086000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9104, N'IDFCFIRSTB', CAST(N'2023-06-30T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(79.35000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9105, N'INDUSINDBK', CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1414.49889000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9106, N'INDUSINDBK', CAST(N'2023-06-30T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1373.70000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9107, N'INFY', CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1377.98700000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9108, N'INFY', CAST(N'2023-06-30T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1335.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9109, N'ITC', CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(454.38036000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9110, N'ITC', CAST(N'2023-06-30T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(451.85000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9111, N'KALYANKJIL', CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(153.37822500 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9112, N'KALYANKJIL', CAST(N'2023-06-30T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(147.55000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9113, N'KARURVYSYA', CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(123.26496000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9114, N'KARURVYSYA', CAST(N'2023-06-30T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(124.80000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9115, N'KTKBANK', CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(209.67034000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9116, N'KTKBANK', CAST(N'2023-06-30T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(189.85000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9117, N'MANAPPURAM', CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(135.73476000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9118, N'MANAPPURAM', CAST(N'2023-06-30T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(132.45000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9119, N'MUTHOOTFIN', CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1232.60970000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9120, N'MUTHOOTFIN', CAST(N'2023-06-30T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1240.05000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9121, N'NATCOPHARM', CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(692.37684000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9122, N'NATCOPHARM', CAST(N'2023-06-30T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(692.10000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9123, N'RECLTD', CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(162.47666000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9124, N'RECLTD', CAST(N'2023-06-30T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(164.60000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9125, N'TATACHEM', CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1006.60728000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9126, N'TATACHEM', CAST(N'2023-06-30T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1001.40000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9127, N'TCS', CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(3396.82761000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9128, N'TCS', CAST(N'2023-06-30T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(3304.95000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9129, N'TECHM', CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1154.03242500 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9130, N'TECHM', CAST(N'2023-06-30T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1130.85000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9131, N'THANGAMAYL', CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1550.92300000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9132, N'THANGAMAYL', CAST(N'2023-06-30T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1523.50000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9133, N'TMB', CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(438.01265000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9134, N'TMB', CAST(N'2023-06-30T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(437.75000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9135, N'WIPRO', CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(396.42990000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9136, N'WIPRO', CAST(N'2023-06-30T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(389.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9137, N'BANKNIFTY', CAST(N'2023-06-30T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(12.58920000 AS Decimal(19, 8)), N'P', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9138, N'NAVIBANK', CAST(N'2023-06-30T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(11.51600000 AS Decimal(19, 8)), N'P', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9139, N'ICICIIT', CAST(N'2023-06-30T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(9.71780000 AS Decimal(19, 8)), N'P', N'', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9140, N'BAJFINANCE', CAST(N'2023-07-05T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(7701.57444000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9141, N'BAJFINANCE', CAST(N'2023-07-06T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(7769.95000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9142, N'CHOLAFIN', CAST(N'2023-07-05T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1136.63150000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9143, N'CHOLAFIN', CAST(N'2023-07-06T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1161.25000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9144, N'COROMANDEL', CAST(N'2023-07-05T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(989.13750000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9145, N'COROMANDEL', CAST(N'2023-07-06T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(975.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9146, N'DEEPAKNTR', CAST(N'2023-07-05T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(2131.10000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9147, N'DEEPAKNTR', CAST(N'2023-07-06T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(2131.10000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9148, N'DIVISLAB', CAST(N'2023-07-05T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(3707.52069000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9149, N'DIVISLAB', CAST(N'2023-07-06T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(3727.65000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9150, N'DRREDDY', CAST(N'2023-07-05T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(5281.47403000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9151, N'DRREDDY', CAST(N'2023-07-06T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(5229.70000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9152, N'FEDERALBNK', CAST(N'2023-07-05T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(137.32950000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9153, N'FEDERALBNK', CAST(N'2023-07-06T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(135.30000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9154, N'HCLTECH', CAST(N'2023-07-05T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1173.44310000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9155, N'HCLTECH', CAST(N'2023-07-06T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1184.10000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9156, N'HDFCBANK', CAST(N'2023-07-05T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1680.00330000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9157, N'HDFCBANK', CAST(N'2023-07-06T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1676.65000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9158, N'ICICIBANK', CAST(N'2023-07-05T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(961.03520000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9159, N'ICICIBANK', CAST(N'2023-07-06T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(959.50000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9160, N'IDFCFIRSTB', CAST(N'2023-07-05T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(80.44824000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9161, N'IDFCFIRSTB', CAST(N'2023-07-06T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(80.40000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9162, N'INDUSINDBK', CAST(N'2023-07-05T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1378.91992000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9163, N'INDUSINDBK', CAST(N'2023-07-06T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1389.20000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9164, N'INFY', CAST(N'2023-07-05T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1338.98623500 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9165, N'INFY', CAST(N'2023-07-06T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1343.15000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9166, N'ITC', CAST(N'2023-07-05T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(471.30720000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9167, N'ITC', CAST(N'2023-07-06T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(473.20000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9168, N'KALYANKJIL', CAST(N'2023-07-05T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(158.50822000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9169, N'KALYANKJIL', CAST(N'2023-07-06T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(153.40000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9170, N'KARURVYSYA', CAST(N'2023-07-05T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(128.97941000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9171, N'KARURVYSYA', CAST(N'2023-07-06T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(131.05000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9172, N'KTKBANK', CAST(N'2023-07-05T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(196.30701500 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9173, N'KTKBANK', CAST(N'2023-07-06T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(197.95000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9174, N'MANAPPURAM', CAST(N'2023-07-05T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(130.24800000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9175, N'MANAPPURAM', CAST(N'2023-07-06T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(129.60000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9176, N'MUTHOOTFIN', CAST(N'2023-07-05T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1262.61135000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9177, N'MUTHOOTFIN', CAST(N'2023-07-06T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1261.35000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9178, N'NATCOPHARM', CAST(N'2023-07-05T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(706.94368500 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9179, N'NATCOPHARM', CAST(N'2023-07-06T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(693.15000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9180, N'RECLTD', CAST(N'2023-07-05T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(165.50200000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9181, N'RECLTD', CAST(N'2023-07-06T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(166.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9182, N'TATACHEM', CAST(N'2023-07-05T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1016.05031000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
GO
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9183, N'TATACHEM', CAST(N'2023-07-06T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1011.70000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9184, N'TCS', CAST(N'2023-07-05T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(3325.25808000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9185, N'TCS', CAST(N'2023-07-06T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(3322.60000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9186, N'TECHM', CAST(N'2023-07-05T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1187.46036000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9187, N'TECHM', CAST(N'2023-07-06T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1181.20000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9188, N'THANGAMAYL', CAST(N'2023-07-05T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1572.55500000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9189, N'THANGAMAYL', CAST(N'2023-07-06T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1537.50000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9190, N'TMB', CAST(N'2023-07-05T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(435.88909500 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9191, N'TMB', CAST(N'2023-07-06T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(433.85000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9192, N'WIPRO', CAST(N'2023-07-05T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(396.10600000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9193, N'WIPRO', CAST(N'2023-07-06T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(395.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9194, N'WIPRO', CAST(N'2023-07-06T00:00:00.000' AS DateTime), CAST(15.00000000 AS Decimal(19, 8)), CAST(394.90000000 AS Decimal(19, 8)), N'S', N'60264615', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(395.35000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9195, N'KARURVYSYA', CAST(N'2023-07-06T00:00:00.000' AS DateTime), CAST(22.00000000 AS Decimal(19, 8)), CAST(131.70000000 AS Decimal(19, 8)), N'S', N'178200', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(115.85000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9196, N'BANKNIFTY', CAST(N'2023-07-04T00:00:00.000' AS DateTime), CAST(4020.22300000 AS Decimal(19, 8)), CAST(12.86140000 AS Decimal(19, 8)), N'S', N'757165311', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(12.43650000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9197, N'ICICIIT', CAST(N'2023-07-04T00:00:00.000' AS DateTime), CAST(6783.00200000 AS Decimal(19, 8)), CAST(10.01340000 AS Decimal(19, 8)), N'S', N'757165351', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(9.73140000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9198, N'NAVIBANK', CAST(N'2023-07-04T00:00:00.000' AS DateTime), CAST(219.39900000 AS Decimal(19, 8)), CAST(11.76580000 AS Decimal(19, 8)), N'S', N'757165105', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(11.39420000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9199, N'BAJFINANCE', CAST(N'2023-07-07T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(7655.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9200, N'CHOLAFIN', CAST(N'2023-07-07T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1175.65000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9201, N'COROMANDEL', CAST(N'2023-07-07T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(965.20000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9202, N'DEEPAKNTR', CAST(N'2023-07-07T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(2073.05000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9203, N'DIVISLAB', CAST(N'2023-07-07T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(3697.70000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9204, N'DRREDDY', CAST(N'2023-07-07T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(5188.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9205, N'FEDERALBNK', CAST(N'2023-07-07T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(135.80000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9206, N'HCLTECH', CAST(N'2023-07-07T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1158.80000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9207, N'HDFCBANK', CAST(N'2023-07-07T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1664.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9208, N'ICICIBANK', CAST(N'2023-07-07T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(948.75000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9209, N'IDFCFIRSTB', CAST(N'2023-07-07T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(79.85000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9210, N'INDUSINDBK', CAST(N'2023-07-07T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1361.90000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9211, N'INFY', CAST(N'2023-07-07T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1336.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9212, N'ITC', CAST(N'2023-07-07T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(469.50000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9213, N'KALYANKJIL', CAST(N'2023-07-07T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(163.80000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9214, N'KTKBANK', CAST(N'2023-07-07T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(192.90000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9215, N'MANAPPURAM', CAST(N'2023-07-07T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(130.10000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9216, N'MUTHOOTFIN', CAST(N'2023-07-07T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1271.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9217, N'NATCOPHARM', CAST(N'2023-07-07T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(684.40000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9218, N'RECLTD', CAST(N'2023-07-07T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(166.20000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9219, N'TATACHEM', CAST(N'2023-07-07T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1006.40000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9220, N'TCS', CAST(N'2023-07-07T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(3340.45000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9221, N'TECHM', CAST(N'2023-07-07T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1161.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9222, N'THANGAMAYL', CAST(N'2023-07-07T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1633.35000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9223, N'TMB', CAST(N'2023-07-07T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(434.85000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9224, N'THANGAMAYL', CAST(N'2023-07-21T00:00:00.000' AS DateTime), CAST(6.00000000 AS Decimal(19, 8)), CAST(0.00000001 AS Decimal(19, 8)), N'B', N'', CAST(6.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9225, N'KTKBANK', CAST(N'2023-07-07T00:00:00.000' AS DateTime), CAST(10.00000000 AS Decimal(19, 8)), CAST(192.95000000 AS Decimal(19, 8)), N'B', N'45390359', CAST(10.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9226, N'MANAPPURAM', CAST(N'2023-07-07T00:00:00.000' AS DateTime), CAST(10.00000000 AS Decimal(19, 8)), CAST(129.60000000 AS Decimal(19, 8)), N'B', N'45408753', CAST(10.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9227, N'COROMANDEL', CAST(N'2023-07-07T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(964.15000000 AS Decimal(19, 8)), N'B', N'4233918', CAST(3.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9228, N'TATACHEM', CAST(N'2023-07-07T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1004.20000000 AS Decimal(19, 8)), N'B', N'65785315', CAST(2.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9229, N'BAJFINANCE', CAST(N'2023-07-20T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(7575.37960000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9230, N'BAJFINANCE', CAST(N'2023-07-21T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(7586.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9231, N'CHOLAFIN', CAST(N'2023-07-20T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1121.28605000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9232, N'CHOLAFIN', CAST(N'2023-07-21T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1139.75000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9233, N'COROMANDEL', CAST(N'2023-07-20T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1004.23027500 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9234, N'COROMANDEL', CAST(N'2023-07-21T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(984.25000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9235, N'DEEPAKNTR', CAST(N'2023-07-20T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1972.08832000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9236, N'DEEPAKNTR', CAST(N'2023-07-21T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1981.60000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9237, N'DIVISLAB', CAST(N'2023-07-20T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(3718.86781500 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9238, N'DIVISLAB', CAST(N'2023-07-21T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(3692.65000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9239, N'DRREDDY', CAST(N'2023-07-20T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(5232.79350000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9240, N'DRREDDY', CAST(N'2023-07-21T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(5285.65000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9241, N'FEDERALBNK', CAST(N'2023-07-20T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(130.62490000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9242, N'FEDERALBNK', CAST(N'2023-07-21T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(133.70000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9243, N'HCLTECH', CAST(N'2023-07-20T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1064.75413000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9244, N'HCLTECH', CAST(N'2023-07-21T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1109.35000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9245, N'HDFCBANK', CAST(N'2023-07-20T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1671.53149000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9246, N'HDFCBANK', CAST(N'2023-07-21T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1680.10000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9247, N'ICICIBANK', CAST(N'2023-07-20T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(995.25091000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9248, N'ICICIBANK', CAST(N'2023-07-21T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(995.45000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9249, N'IDFCFIRSTB', CAST(N'2023-07-20T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(84.42536000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9250, N'IDFCFIRSTB', CAST(N'2023-07-21T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(82.90000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9251, N'INDUSINDBK', CAST(N'2023-07-20T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1395.44237500 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9252, N'INDUSINDBK', CAST(N'2023-07-21T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1410.25000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9253, N'INFY', CAST(N'2023-07-20T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1211.22820500 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9254, N'INFY', CAST(N'2023-07-21T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1325.05000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9255, N'ITC', CAST(N'2023-07-20T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(482.91750000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9256, N'ITC', CAST(N'2023-07-21T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(487.50000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9257, N'KALYANKJIL', CAST(N'2023-07-20T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(178.33773500 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9258, N'KALYANKJIL', CAST(N'2023-07-21T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(174.55000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9259, N'KTKBANK', CAST(N'2023-07-20T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(206.04960000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9260, N'KTKBANK', CAST(N'2023-07-21T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(209.40000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9261, N'MANAPPURAM', CAST(N'2023-07-20T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(131.40123000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9262, N'MANAPPURAM', CAST(N'2023-07-21T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(128.85000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9263, N'MUTHOOTFIN', CAST(N'2023-07-20T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1281.83806500 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9264, N'MUTHOOTFIN', CAST(N'2023-07-21T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1288.15000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9265, N'NATCOPHARM', CAST(N'2023-07-20T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(777.24000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9266, N'NATCOPHARM', CAST(N'2023-07-21T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(765.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9267, N'RECLTD', CAST(N'2023-07-20T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(162.24300000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9268, N'RECLTD', CAST(N'2023-07-21T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(162.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9269, N'TATACHEM', CAST(N'2023-07-20T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(978.80586000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9270, N'TATACHEM', CAST(N'2023-07-21T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(986.60000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9271, N'TCS', CAST(N'2023-07-20T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(3290.82732000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9272, N'TCS', CAST(N'2023-07-21T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(3375.90000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9273, N'TECHM', CAST(N'2023-07-20T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1141.74933000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9274, N'TECHM', CAST(N'2023-07-21T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1196.05000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9275, N'THANGAMAYL', CAST(N'2023-07-20T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(840.99400000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9276, N'THANGAMAYL', CAST(N'2023-07-21T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(860.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9277, N'TMB', CAST(N'2023-07-20T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(427.33093000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9278, N'TMB', CAST(N'2023-07-21T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(430.30000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9279, N'BAJFINANCE', CAST(N'2023-07-25T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(7343.95240000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9280, N'BAJFINANCE', CAST(N'2023-07-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(7474.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9281, N'CHOLAFIN', CAST(N'2023-07-25T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1158.29140000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9282, N'CHOLAFIN', CAST(N'2023-07-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1142.75000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
GO
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9283, N'COROMANDEL', CAST(N'2023-07-25T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1013.46636000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9284, N'COROMANDEL', CAST(N'2023-07-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(990.10000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9285, N'DEEPAKNTR', CAST(N'2023-07-25T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(2002.19300000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9286, N'DEEPAKNTR', CAST(N'2023-07-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(2005.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9287, N'DIVISLAB', CAST(N'2023-07-25T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(3643.08570000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9288, N'DIVISLAB', CAST(N'2023-07-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(3681.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9289, N'DRREDDY', CAST(N'2023-07-25T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(5525.72322000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9290, N'DRREDDY', CAST(N'2023-07-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(5475.35000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9291, N'FEDERALBNK', CAST(N'2023-07-25T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(135.82382000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9292, N'FEDERALBNK', CAST(N'2023-07-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(134.20000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9293, N'HCLTECH', CAST(N'2023-07-25T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1116.45080000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9294, N'HCLTECH', CAST(N'2023-07-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1114.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9295, N'HDFCBANK', CAST(N'2023-07-25T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1682.03601000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9296, N'HDFCBANK', CAST(N'2023-07-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1689.30000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9297, N'ICICIBANK', CAST(N'2023-07-25T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(997.64422500 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9298, N'ICICIBANK', CAST(N'2023-07-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(996.15000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9299, N'IDFCFIRSTB', CAST(N'2023-07-25T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(86.08035500 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9300, N'IDFCFIRSTB', CAST(N'2023-07-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(84.55000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9301, N'INDUSINDBK', CAST(N'2023-07-25T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1434.54750000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9302, N'INDUSINDBK', CAST(N'2023-07-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1425.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9303, N'INFY', CAST(N'2023-07-25T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1360.38552000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9304, N'INFY', CAST(N'2023-07-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1347.45000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9305, N'ITC', CAST(N'2023-07-25T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(482.69832000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9306, N'ITC', CAST(N'2023-07-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(472.40000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9307, N'KALYANKJIL', CAST(N'2023-07-25T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(173.45014500 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9308, N'KALYANKJIL', CAST(N'2023-07-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(173.85000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9309, N'KTKBANK', CAST(N'2023-07-25T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(206.92368000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9310, N'KTKBANK', CAST(N'2023-07-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(205.20000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9311, N'MANAPPURAM', CAST(N'2023-07-25T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(140.28784000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9312, N'MANAPPURAM', CAST(N'2023-07-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(135.10000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9313, N'MUTHOOTFIN', CAST(N'2023-07-25T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1307.64200000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9314, N'MUTHOOTFIN', CAST(N'2023-07-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1310.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9315, N'NATCOPHARM', CAST(N'2023-07-25T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(806.63960000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9316, N'NATCOPHARM', CAST(N'2023-07-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(793.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9317, N'RECLTD', CAST(N'2023-07-25T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(174.76822000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9318, N'RECLTD', CAST(N'2023-07-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(173.45000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9319, N'TATACHEM', CAST(N'2023-07-25T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1019.20633500 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9320, N'TATACHEM', CAST(N'2023-07-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(997.95000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9321, N'TCS', CAST(N'2023-07-25T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(3388.90900000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9322, N'TCS', CAST(N'2023-07-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(3394.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9323, N'TECHM', CAST(N'2023-07-25T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1131.64480000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9324, N'TECHM', CAST(N'2023-07-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1144.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9325, N'THANGAMAYL', CAST(N'2023-07-25T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1215.04400000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9326, N'THANGAMAYL', CAST(N'2023-07-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1124.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9327, N'TMB', CAST(N'2023-07-25T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(444.39440000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9328, N'TMB', CAST(N'2023-07-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(446.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9329, N'INFY', CAST(N'2023-07-21T00:00:00.000' AS DateTime), CAST(9.00000000 AS Decimal(19, 8)), CAST(1325.85000000 AS Decimal(19, 8)), N'B', N'26184582', CAST(9.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9330, N'TCS', CAST(N'2023-07-21T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(3376.35000000 AS Decimal(19, 8)), N'B', N'66043587', CAST(3.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9331, N'HCLTECH', CAST(N'2023-07-21T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(1110.05000000 AS Decimal(19, 8)), N'B', N'26195448', CAST(5.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9332, N'HCLTECH', CAST(N'2023-07-21T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(1110.05000000 AS Decimal(19, 8)), N'B', N'26195662', CAST(3.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9333, N'HCLTECH', CAST(N'2023-07-21T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(1110.05000000 AS Decimal(19, 8)), N'B', N'26195851', CAST(3.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9334, N'TECHM', CAST(N'2023-07-21T00:00:00.000' AS DateTime), CAST(10.00000000 AS Decimal(19, 8)), CAST(1195.60000000 AS Decimal(19, 8)), N'B', N'66058918', CAST(10.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9335, N'INFY', CAST(N'2023-07-21T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1325.80000000 AS Decimal(19, 8)), N'B', N'26208192', CAST(2.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9336, N'HCLTECH', CAST(N'2023-07-21T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1110.05000000 AS Decimal(19, 8)), N'B', N'26209239', CAST(1.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9337, N'FEDERALBNK', CAST(N'2023-07-21T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(133.70000000 AS Decimal(19, 8)), N'B', N'26244441', CAST(3.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9338, N'IDFC', CAST(N'2023-07-24T00:00:00.000' AS DateTime), CAST(200.00000000 AS Decimal(19, 8)), CAST(115.80000000 AS Decimal(19, 8)), N'B', N'21722523', CAST(200.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9339, N'DEEPAKNTR', CAST(N'2023-07-26T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2009.90000000 AS Decimal(19, 8)), N'S', N'20575774', CAST(0.00000000 AS Decimal(19, 8)), NULL, CAST(2071.90000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9340, N'EXIDEIND', CAST(N'2023-07-26T00:00:00.000' AS DateTime), CAST(39.00000000 AS Decimal(19, 8)), CAST(250.95000000 AS Decimal(19, 8)), N'B', N'20628743', CAST(39.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9341, N'AMARAJABAT', CAST(N'2023-07-26T00:00:00.000' AS DateTime), CAST(15.00000000 AS Decimal(19, 8)), CAST(630.10000000 AS Decimal(19, 8)), N'B', N'750551', CAST(15.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9342, N'EXIDEIND', CAST(N'2023-07-26T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(251.05000000 AS Decimal(19, 8)), N'B', N'20644910', CAST(5.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9343, N'AMARAJABAT', CAST(N'2023-07-26T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(629.70000000 AS Decimal(19, 8)), N'B', N'762327', CAST(1.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9344, N'EXIDEIND', CAST(N'2023-07-26T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(251.05000000 AS Decimal(19, 8)), N'B', N'20657065', CAST(1.00000000 AS Decimal(19, 8)), NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9345, N'AMARAJABAT', CAST(N'2023-07-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(637.32285000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9346, N'AMARAJABAT', CAST(N'2023-07-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(635.10000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9347, N'BAJFINANCE', CAST(N'2023-07-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(7437.45000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9348, N'CHOLAFIN', CAST(N'2023-07-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1140.50000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9349, N'COROMANDEL', CAST(N'2023-07-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1020.10000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9350, N'DIVISLAB', CAST(N'2023-07-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(3746.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9351, N'DRREDDY', CAST(N'2023-07-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(5576.75000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9352, N'EXIDEIND', CAST(N'2023-07-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(258.84748500 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9353, N'EXIDEIND', CAST(N'2023-07-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(255.45000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9354, N'FEDERALBNK', CAST(N'2023-07-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(134.60000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9355, N'HCLTECH', CAST(N'2023-07-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1110.15000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9356, N'HDFCBANK', CAST(N'2023-07-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1689.95000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9357, N'ICICIBANK', CAST(N'2023-07-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(996.65000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9358, N'IDFC', CAST(N'2023-07-26T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(114.30495000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9359, N'IDFC', CAST(N'2023-07-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(115.25000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9360, N'IDFCFIRSTB', CAST(N'2023-07-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(83.10000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9361, N'INDUSINDBK', CAST(N'2023-07-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1418.55000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9362, N'INFY', CAST(N'2023-07-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1356.10000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9363, N'ITC', CAST(N'2023-07-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(471.40000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9364, N'KALYANKJIL', CAST(N'2023-07-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(176.15000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9365, N'KTKBANK', CAST(N'2023-07-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(205.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9366, N'MANAPPURAM', CAST(N'2023-07-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(138.50000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9367, N'MUTHOOTFIN', CAST(N'2023-07-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1332.70000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9368, N'NATCOPHARM', CAST(N'2023-07-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(815.90000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9369, N'RECLTD', CAST(N'2023-07-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(187.25000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9370, N'TATACHEM', CAST(N'2023-07-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(992.10000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9371, N'TCS', CAST(N'2023-07-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(3390.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9372, N'TECHM', CAST(N'2023-07-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1109.30000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9373, N'THANGAMAYL', CAST(N'2023-07-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(1162.00000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
INSERT [dbo].[dm_asset_core_lot] ([dm_asset_core_lot_id], [Symbol], [RecordDate], [NumberOfShares], [SharePrice], [LotType], [RefID], [BalanceShares], [AvgPrice], [BuyPrice]) VALUES (9374, N'TMB', CAST(N'2023-07-27T00:00:00.000' AS DateTime), CAST(0.00000000 AS Decimal(19, 8)), CAST(445.15000000 AS Decimal(19, 8)), N'P', N'0', NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[dm_asset_core_lot] OFF
GO
INSERT [dbo].[dm_asset_core_lot_share] ([Symbol], [NumberOfShares], [SharePrice], [Amount], [PL], [PLPercent], [BuyAmount], [SellAmount], [CurrentMarketValue], [XIRR], [UnRealizedPL]) VALUES (N'AMARAJABAT', CAST(16.00000000 AS Decimal(19, 8)), CAST(630.07500000 AS Decimal(19, 8)), CAST(10081.20000000 AS Decimal(19, 8)), NULL, NULL, NULL, NULL, NULL, CAST(1716.35441180 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot_share] ([Symbol], [NumberOfShares], [SharePrice], [Amount], [PL], [PLPercent], [BuyAmount], [SellAmount], [CurrentMarketValue], [XIRR], [UnRealizedPL]) VALUES (N'BAJFINANCE', CAST(1.00000000 AS Decimal(19, 8)), CAST(7164.00000000 AS Decimal(19, 8)), CAST(7164.00000000 AS Decimal(19, 8)), NULL, NULL, NULL, NULL, NULL, CAST(35.11252937 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot_share] ([Symbol], [NumberOfShares], [SharePrice], [Amount], [PL], [PLPercent], [BuyAmount], [SellAmount], [CurrentMarketValue], [XIRR], [UnRealizedPL]) VALUES (N'CHOLAFIN', CAST(7.00000000 AS Decimal(19, 8)), CAST(816.10000000 AS Decimal(19, 8)), CAST(5712.70000000 AS Decimal(19, 8)), NULL, NULL, NULL, NULL, NULL, CAST(48.04823782 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot_share] ([Symbol], [NumberOfShares], [SharePrice], [Amount], [PL], [PLPercent], [BuyAmount], [SellAmount], [CurrentMarketValue], [XIRR], [UnRealizedPL]) VALUES (N'COROMANDEL', CAST(4.00000000 AS Decimal(19, 8)), CAST(957.28750000 AS Decimal(19, 8)), CAST(3829.15000000 AS Decimal(19, 8)), NULL, NULL, NULL, NULL, NULL, CAST(144.02364768 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot_share] ([Symbol], [NumberOfShares], [SharePrice], [Amount], [PL], [PLPercent], [BuyAmount], [SellAmount], [CurrentMarketValue], [XIRR], [UnRealizedPL]) VALUES (N'DIVISLAB', CAST(8.00000000 AS Decimal(19, 8)), CAST(3037.87500000 AS Decimal(19, 8)), CAST(24303.00000000 AS Decimal(19, 8)), NULL, NULL, NULL, NULL, NULL, CAST(31.48500056 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot_share] ([Symbol], [NumberOfShares], [SharePrice], [Amount], [PL], [PLPercent], [BuyAmount], [SellAmount], [CurrentMarketValue], [XIRR], [UnRealizedPL]) VALUES (N'DRREDDY', CAST(2.00000000 AS Decimal(19, 8)), CAST(4646.20000000 AS Decimal(19, 8)), CAST(9292.40000000 AS Decimal(19, 8)), NULL, NULL, NULL, NULL, NULL, CAST(74.36880769 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot_share] ([Symbol], [NumberOfShares], [SharePrice], [Amount], [PL], [PLPercent], [BuyAmount], [SellAmount], [CurrentMarketValue], [XIRR], [UnRealizedPL]) VALUES (N'EXIDEIND', CAST(45.00000000 AS Decimal(19, 8)), CAST(250.96333333 AS Decimal(19, 8)), CAST(11293.34999985 AS Decimal(19, 8)), NULL, NULL, NULL, NULL, NULL, CAST(64302.98806113 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot_share] ([Symbol], [NumberOfShares], [SharePrice], [Amount], [PL], [PLPercent], [BuyAmount], [SellAmount], [CurrentMarketValue], [XIRR], [UnRealizedPL]) VALUES (N'FEDERALBNK', CAST(106.00000000 AS Decimal(19, 8)), CAST(127.01603774 AS Decimal(19, 8)), CAST(13463.70000044 AS Decimal(19, 8)), NULL, NULL, NULL, NULL, NULL, CAST(19.81990913 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot_share] ([Symbol], [NumberOfShares], [SharePrice], [Amount], [PL], [PLPercent], [BuyAmount], [SellAmount], [CurrentMarketValue], [XIRR], [UnRealizedPL]) VALUES (N'HCLTECH', CAST(20.00000000 AS Decimal(19, 8)), CAST(1117.61000000 AS Decimal(19, 8)), CAST(22352.20000000 AS Decimal(19, 8)), NULL, NULL, NULL, NULL, NULL, CAST(-6.93869348 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot_share] ([Symbol], [NumberOfShares], [SharePrice], [Amount], [PL], [PLPercent], [BuyAmount], [SellAmount], [CurrentMarketValue], [XIRR], [UnRealizedPL]) VALUES (N'HDFCBANK', CAST(1.00000000 AS Decimal(19, 8)), CAST(1607.50000000 AS Decimal(19, 8)), CAST(1607.50000000 AS Decimal(19, 8)), NULL, NULL, NULL, NULL, NULL, CAST(12.66535320 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot_share] ([Symbol], [NumberOfShares], [SharePrice], [Amount], [PL], [PLPercent], [BuyAmount], [SellAmount], [CurrentMarketValue], [XIRR], [UnRealizedPL]) VALUES (N'ICICIBANK', CAST(1.00000000 AS Decimal(19, 8)), CAST(945.20000000 AS Decimal(19, 8)), CAST(945.20000000 AS Decimal(19, 8)), NULL, NULL, NULL, NULL, NULL, CAST(31.86673686 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot_share] ([Symbol], [NumberOfShares], [SharePrice], [Amount], [PL], [PLPercent], [BuyAmount], [SellAmount], [CurrentMarketValue], [XIRR], [UnRealizedPL]) VALUES (N'IDFC', CAST(200.00000000 AS Decimal(19, 8)), CAST(115.80000000 AS Decimal(19, 8)), CAST(23160.00000000 AS Decimal(19, 8)), NULL, NULL, NULL, NULL, NULL, CAST(-43.96763943 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot_share] ([Symbol], [NumberOfShares], [SharePrice], [Amount], [PL], [PLPercent], [BuyAmount], [SellAmount], [CurrentMarketValue], [XIRR], [UnRealizedPL]) VALUES (N'IDFCFIRSTB', CAST(573.00000000 AS Decimal(19, 8)), CAST(58.81474695 AS Decimal(19, 8)), CAST(33700.85000235 AS Decimal(19, 8)), NULL, NULL, NULL, NULL, NULL, CAST(218.73701928 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot_share] ([Symbol], [NumberOfShares], [SharePrice], [Amount], [PL], [PLPercent], [BuyAmount], [SellAmount], [CurrentMarketValue], [XIRR], [UnRealizedPL]) VALUES (N'INDIGRID', CAST(63.00000000 AS Decimal(19, 8)), CAST(139.85380952 AS Decimal(19, 8)), CAST(8810.78999976 AS Decimal(19, 8)), NULL, NULL, NULL, NULL, NULL, CAST(41.71382682 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot_share] ([Symbol], [NumberOfShares], [SharePrice], [Amount], [PL], [PLPercent], [BuyAmount], [SellAmount], [CurrentMarketValue], [XIRR], [UnRealizedPL]) VALUES (N'INDUSINDBK', CAST(1.00000000 AS Decimal(19, 8)), CAST(1333.70000000 AS Decimal(19, 8)), CAST(1333.70000000 AS Decimal(19, 8)), NULL, NULL, NULL, NULL, NULL, CAST(68.32944553 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot_share] ([Symbol], [NumberOfShares], [SharePrice], [Amount], [PL], [PLPercent], [BuyAmount], [SellAmount], [CurrentMarketValue], [XIRR], [UnRealizedPL]) VALUES (N'INFY', CAST(21.00000000 AS Decimal(19, 8)), CAST(1309.02857143 AS Decimal(19, 8)), CAST(27489.60000003 AS Decimal(19, 8)), NULL, NULL, NULL, NULL, NULL, CAST(-7.91320984 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot_share] ([Symbol], [NumberOfShares], [SharePrice], [Amount], [PL], [PLPercent], [BuyAmount], [SellAmount], [CurrentMarketValue], [XIRR], [UnRealizedPL]) VALUES (N'ITC', CAST(35.00000000 AS Decimal(19, 8)), CAST(400.38571429 AS Decimal(19, 8)), CAST(14013.50000015 AS Decimal(19, 8)), NULL, NULL, NULL, NULL, NULL, CAST(55.47922288 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot_share] ([Symbol], [NumberOfShares], [SharePrice], [Amount], [PL], [PLPercent], [BuyAmount], [SellAmount], [CurrentMarketValue], [XIRR], [UnRealizedPL]) VALUES (N'KALYANKJIL', CAST(82.00000000 AS Decimal(19, 8)), CAST(111.18780488 AS Decimal(19, 8)), CAST(9117.40000016 AS Decimal(19, 8)), NULL, NULL, NULL, NULL, NULL, CAST(293.77716644 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot_share] ([Symbol], [NumberOfShares], [SharePrice], [Amount], [PL], [PLPercent], [BuyAmount], [SellAmount], [CurrentMarketValue], [XIRR], [UnRealizedPL]) VALUES (N'KTKBANK', CAST(13.00000000 AS Decimal(19, 8)), CAST(183.15384615 AS Decimal(19, 8)), CAST(2380.99999995 AS Decimal(19, 8)), NULL, NULL, NULL, NULL, NULL, CAST(-26.17487639 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot_share] ([Symbol], [NumberOfShares], [SharePrice], [Amount], [PL], [PLPercent], [BuyAmount], [SellAmount], [CurrentMarketValue], [XIRR], [UnRealizedPL]) VALUES (N'MANAPPURAM', CAST(61.00000000 AS Decimal(19, 8)), CAST(118.92704918 AS Decimal(19, 8)), CAST(7254.54999998 AS Decimal(19, 8)), NULL, NULL, NULL, NULL, NULL, CAST(102.49165990 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot_share] ([Symbol], [NumberOfShares], [SharePrice], [Amount], [PL], [PLPercent], [BuyAmount], [SellAmount], [CurrentMarketValue], [XIRR], [UnRealizedPL]) VALUES (N'MUTHOOTFIN', CAST(7.00000000 AS Decimal(19, 8)), CAST(1015.84285714 AS Decimal(19, 8)), CAST(7110.89999998 AS Decimal(19, 8)), NULL, NULL, NULL, NULL, NULL, CAST(8.45813380 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot_share] ([Symbol], [NumberOfShares], [SharePrice], [Amount], [PL], [PLPercent], [BuyAmount], [SellAmount], [CurrentMarketValue], [XIRR], [UnRealizedPL]) VALUES (N'NATCOPHARM', CAST(55.00000000 AS Decimal(19, 8)), CAST(580.32090909 AS Decimal(19, 8)), CAST(31917.64999995 AS Decimal(19, 8)), NULL, NULL, NULL, NULL, NULL, CAST(154.83723495 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot_share] ([Symbol], [NumberOfShares], [SharePrice], [Amount], [PL], [PLPercent], [BuyAmount], [SellAmount], [CurrentMarketValue], [XIRR], [UnRealizedPL]) VALUES (N'PGINVIT', CAST(95.00000000 AS Decimal(19, 8)), CAST(121.28252632 AS Decimal(19, 8)), CAST(11521.84000040 AS Decimal(19, 8)), NULL, NULL, NULL, NULL, NULL, CAST(26.71693528 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot_share] ([Symbol], [NumberOfShares], [SharePrice], [Amount], [PL], [PLPercent], [BuyAmount], [SellAmount], [CurrentMarketValue], [XIRR], [UnRealizedPL]) VALUES (N'RECLTD', CAST(65.00000000 AS Decimal(19, 8)), CAST(134.30000000 AS Decimal(19, 8)), CAST(8729.50000000 AS Decimal(19, 8)), NULL, NULL, NULL, NULL, NULL, CAST(192.63927624 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot_share] ([Symbol], [NumberOfShares], [SharePrice], [Amount], [PL], [PLPercent], [BuyAmount], [SellAmount], [CurrentMarketValue], [XIRR], [UnRealizedPL]) VALUES (N'TATACHEM', CAST(4.00000000 AS Decimal(19, 8)), CAST(1002.07500000 AS Decimal(19, 8)), CAST(4008.30000000 AS Decimal(19, 8)), NULL, NULL, NULL, NULL, NULL, CAST(-10.79936523 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot_share] ([Symbol], [NumberOfShares], [SharePrice], [Amount], [PL], [PLPercent], [BuyAmount], [SellAmount], [CurrentMarketValue], [XIRR], [UnRealizedPL]) VALUES (N'TCS', CAST(6.00000000 AS Decimal(19, 8)), CAST(3325.27500000 AS Decimal(19, 8)), CAST(19951.65000000 AS Decimal(19, 8)), NULL, NULL, NULL, NULL, NULL, CAST(12.24619243 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot_share] ([Symbol], [NumberOfShares], [SharePrice], [Amount], [PL], [PLPercent], [BuyAmount], [SellAmount], [CurrentMarketValue], [XIRR], [UnRealizedPL]) VALUES (N'TECHM', CAST(20.00000000 AS Decimal(19, 8)), CAST(1145.32500000 AS Decimal(19, 8)), CAST(22906.50000000 AS Decimal(19, 8)), NULL, NULL, NULL, NULL, NULL, CAST(-27.45644493 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot_share] ([Symbol], [NumberOfShares], [SharePrice], [Amount], [PL], [PLPercent], [BuyAmount], [SellAmount], [CurrentMarketValue], [XIRR], [UnRealizedPL]) VALUES (N'THANGAMAYL', CAST(12.00000000 AS Decimal(19, 8)), CAST(514.78333334 AS Decimal(19, 8)), CAST(6177.40000008 AS Decimal(19, 8)), NULL, NULL, NULL, NULL, NULL, CAST(458.23250425 AS Decimal(19, 8)), NULL)
INSERT [dbo].[dm_asset_core_lot_share] ([Symbol], [NumberOfShares], [SharePrice], [Amount], [PL], [PLPercent], [BuyAmount], [SellAmount], [CurrentMarketValue], [XIRR], [UnRealizedPL]) VALUES (N'TMB', CAST(20.00000000 AS Decimal(19, 8)), CAST(412.05000000 AS Decimal(19, 8)), CAST(8241.00000000 AS Decimal(19, 8)), NULL, NULL, NULL, NULL, NULL, CAST(-9.11139480 AS Decimal(19, 8)), NULL)
GO
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'NAVIBANK', CAST(N'2024-03-31T00:00:00.000' AS DateTime), CAST(219.39900000 AS Decimal(19, 8)), CAST(11.40600000 AS Decimal(19, 8)), CAST(2502.46499400 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'CIPLA', CAST(N'2024-03-31T00:00:00.000' AS DateTime), CAST(7.00000000 AS Decimal(19, 8)), CAST(955.55000000 AS Decimal(19, 8)), CAST(6688.85000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'PGINVIT', CAST(N'2024-03-31T00:00:00.000' AS DateTime), CAST(72.00000000 AS Decimal(19, 8)), CAST(125.27000000 AS Decimal(19, 8)), CAST(9019.44000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'DIVISLAB', CAST(N'2024-03-31T00:00:00.000' AS DateTime), CAST(6.00000000 AS Decimal(19, 8)), CAST(3479.05000000 AS Decimal(19, 8)), CAST(20874.30000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'ICICIIT', CAST(N'2024-03-31T00:00:00.000' AS DateTime), CAST(6783.00200000 AS Decimal(19, 8)), CAST(9.84740000 AS Decimal(19, 8)), CAST(66794.93389480 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'FEDERALBNK', CAST(N'2024-03-31T00:00:00.000' AS DateTime), CAST(46.00000000 AS Decimal(19, 8)), CAST(125.55000000 AS Decimal(19, 8)), CAST(5775.30000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'CHOLAFIN', CAST(N'2024-03-31T00:00:00.000' AS DateTime), CAST(7.00000000 AS Decimal(19, 8)), CAST(1056.15000000 AS Decimal(19, 8)), CAST(7393.05000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'DRREDDY', CAST(N'2024-03-31T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(4557.65000000 AS Decimal(19, 8)), CAST(9115.30000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'NASDAQ', CAST(N'2024-03-31T00:00:00.000' AS DateTime), CAST(7485.95300000 AS Decimal(19, 8)), CAST(10.01240000 AS Decimal(19, 8)), CAST(74952.35581720 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'INDIGRID', CAST(N'2024-03-31T00:00:00.000' AS DateTime), CAST(59.00000000 AS Decimal(19, 8)), CAST(138.25000000 AS Decimal(19, 8)), CAST(8156.75000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'TMB', CAST(N'2024-03-31T00:00:00.000' AS DateTime), CAST(14.00000000 AS Decimal(19, 8)), CAST(413.05000000 AS Decimal(19, 8)), CAST(5782.70000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'GODREJCP', CAST(N'2020-03-31T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(449.20000000 AS Decimal(19, 8)), CAST(1796.80000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'DABUR', CAST(N'2020-03-31T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(410.10000000 AS Decimal(19, 8)), CAST(1640.40000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'INFY', CAST(N'2020-03-31T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(528.25000000 AS Decimal(19, 8)), CAST(2113.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'BAJFINANCE', CAST(N'2020-03-31T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2364.60000000 AS Decimal(19, 8)), CAST(2364.60000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'VIPIND', CAST(N'2020-03-31T00:00:00.000' AS DateTime), CAST(8.00000000 AS Decimal(19, 8)), CAST(208.60000000 AS Decimal(19, 8)), CAST(1668.80000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'RELIANCE', CAST(N'2020-03-31T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(883.80000000 AS Decimal(19, 8)), CAST(1767.60000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'CROMPTON', CAST(N'2020-03-31T00:00:00.000' AS DateTime), CAST(9.00000000 AS Decimal(19, 8)), CAST(190.20000000 AS Decimal(19, 8)), CAST(1711.80000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'ITC', CAST(N'2020-03-31T00:00:00.000' AS DateTime), CAST(19.00000000 AS Decimal(19, 8)), CAST(151.50000000 AS Decimal(19, 8)), CAST(2878.50000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'MARICO', CAST(N'2020-03-31T00:00:00.000' AS DateTime), CAST(7.00000000 AS Decimal(19, 8)), CAST(237.95000000 AS Decimal(19, 8)), CAST(1665.65000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'INDUSINDBK', CAST(N'2020-03-31T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(341.85000000 AS Decimal(19, 8)), CAST(1709.25000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'HAVELLS', CAST(N'2020-03-31T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(500.05000000 AS Decimal(19, 8)), CAST(1500.15000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'HINDUNILVR', CAST(N'2020-03-31T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1861.30000000 AS Decimal(19, 8)), CAST(1861.30000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'VGUARD', CAST(N'2020-03-31T00:00:00.000' AS DateTime), CAST(11.00000000 AS Decimal(19, 8)), CAST(160.95000000 AS Decimal(19, 8)), CAST(1770.45000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'HDFCBANK', CAST(N'2020-03-31T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(767.60000000 AS Decimal(19, 8)), CAST(2302.80000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'KANSAINER', CAST(N'2020-03-31T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(313.95000000 AS Decimal(19, 8)), CAST(1569.75000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'HATSUN', CAST(N'2020-03-31T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(477.10000000 AS Decimal(19, 8)), CAST(1431.30000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'WHIRLPOOL', CAST(N'2021-03-31T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1800.00000000 AS Decimal(19, 8)), CAST(1800.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'GODREJCP', CAST(N'2021-03-31T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(729.65000000 AS Decimal(19, 8)), CAST(2918.60000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'DABUR', CAST(N'2021-03-31T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(540.50000000 AS Decimal(19, 8)), CAST(2162.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'PIDILITIND', CAST(N'2021-03-31T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1219.60000000 AS Decimal(19, 8)), CAST(1219.60000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'BERGEPAINT', CAST(N'2021-03-31T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(765.00000000 AS Decimal(19, 8)), CAST(3825.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'INFY', CAST(N'2021-03-31T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(1368.05000000 AS Decimal(19, 8)), CAST(5472.20000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'TCS', CAST(N'2021-03-31T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1651.00000000 AS Decimal(19, 8)), CAST(1651.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'BAJFINANCE', CAST(N'2021-03-31T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(5149.85000000 AS Decimal(19, 8)), CAST(5149.85000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'VIPIND', CAST(N'2021-03-31T00:00:00.000' AS DateTime), CAST(8.00000000 AS Decimal(19, 8)), CAST(208.60000000 AS Decimal(19, 8)), CAST(1668.80000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'RELIANCE', CAST(N'2021-03-31T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(883.80000000 AS Decimal(19, 8)), CAST(1767.60000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'KOTAKBANK', CAST(N'2021-03-31T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1753.00000000 AS Decimal(19, 8)), CAST(3506.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'CROMPTON', CAST(N'2021-03-31T00:00:00.000' AS DateTime), CAST(9.00000000 AS Decimal(19, 8)), CAST(392.50000000 AS Decimal(19, 8)), CAST(3532.50000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'TITAN', CAST(N'2021-03-31T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(863.45000000 AS Decimal(19, 8)), CAST(2590.35000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'HDFC', CAST(N'2021-03-31T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2498.10000000 AS Decimal(19, 8)), CAST(2498.10000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'ITC', CAST(N'2021-03-31T00:00:00.000' AS DateTime), CAST(20.00000000 AS Decimal(19, 8)), CAST(218.50000000 AS Decimal(19, 8)), CAST(4370.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'MARICO', CAST(N'2021-03-31T00:00:00.000' AS DateTime), CAST(7.00000000 AS Decimal(19, 8)), CAST(411.30000000 AS Decimal(19, 8)), CAST(2879.10000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'INDUSINDBK', CAST(N'2021-03-31T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(954.45000000 AS Decimal(19, 8)), CAST(4772.25000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'HAVELLS', CAST(N'2021-03-31T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(1050.40000000 AS Decimal(19, 8)), CAST(3151.20000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'JUBLFOOD', CAST(N'2021-03-31T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(582.19000000 AS Decimal(19, 8)), CAST(582.19000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'BATAINDIA', CAST(N'2021-03-31T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1406.20000000 AS Decimal(19, 8)), CAST(1406.20000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'ASIANPAINT', CAST(N'2021-03-31T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2537.40000000 AS Decimal(19, 8)), CAST(2537.40000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'HINDUNILVR', CAST(N'2021-03-31T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2431.50000000 AS Decimal(19, 8)), CAST(2431.50000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'VGUARD', CAST(N'2021-03-31T00:00:00.000' AS DateTime), CAST(11.00000000 AS Decimal(19, 8)), CAST(160.95000000 AS Decimal(19, 8)), CAST(1770.45000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'HDFCBANK', CAST(N'2021-03-31T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(1493.65000000 AS Decimal(19, 8)), CAST(4480.95000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'KANSAINER', CAST(N'2021-03-31T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(601.05000000 AS Decimal(19, 8)), CAST(3005.25000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'BRITANNIA', CAST(N'2021-03-31T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(3625.05000000 AS Decimal(19, 8)), CAST(3625.05000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'HATSUN', CAST(N'2021-03-31T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(711.56000000 AS Decimal(19, 8)), CAST(2134.68000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'MUTHOOTFIN', CAST(N'2022-03-31T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(1396.25000000 AS Decimal(19, 8)), CAST(4188.75000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'HCLTECH', CAST(N'2022-03-31T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(1126.00000000 AS Decimal(19, 8)), CAST(3378.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'GODREJCP', CAST(N'2022-03-31T00:00:00.000' AS DateTime), CAST(8.00000000 AS Decimal(19, 8)), CAST(720.65000000 AS Decimal(19, 8)), CAST(5765.20000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'DABUR', CAST(N'2022-03-31T00:00:00.000' AS DateTime), CAST(8.00000000 AS Decimal(19, 8)), CAST(507.30000000 AS Decimal(19, 8)), CAST(4058.40000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'PIDILITIND', CAST(N'2022-03-31T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(2279.00000000 AS Decimal(19, 8)), CAST(4558.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'BERGEPAINT', CAST(N'2022-03-31T00:00:00.000' AS DateTime), CAST(7.00000000 AS Decimal(19, 8)), CAST(652.70000000 AS Decimal(19, 8)), CAST(4568.90000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'INFY', CAST(N'2022-03-31T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(1689.65000000 AS Decimal(19, 8)), CAST(8448.25000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'TCS', CAST(N'2022-03-31T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(3500.10000000 AS Decimal(19, 8)), CAST(7000.20000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'BAJFINANCE', CAST(N'2022-03-31T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(5149.85000000 AS Decimal(19, 8)), CAST(5149.85000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'TATAMOTORS', CAST(N'2022-03-31T00:00:00.000' AS DateTime), CAST(10.00000000 AS Decimal(19, 8)), CAST(428.60000000 AS Decimal(19, 8)), CAST(4286.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'RELIANCE', CAST(N'2022-03-31T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(2245.85000000 AS Decimal(19, 8)), CAST(6737.55000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'KOTAKBANK', CAST(N'2022-03-31T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(1757.35000000 AS Decimal(19, 8)), CAST(5272.05000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'CROMPTON', CAST(N'2022-03-31T00:00:00.000' AS DateTime), CAST(13.00000000 AS Decimal(19, 8)), CAST(396.55000000 AS Decimal(19, 8)), CAST(5155.15000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'TITAN', CAST(N'2022-03-31T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(2380.70000000 AS Decimal(19, 8)), CAST(9522.80000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'TATACONSUM', CAST(N'2022-03-31T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(673.90000000 AS Decimal(19, 8)), CAST(3369.50000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'TECHM', CAST(N'2022-03-31T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1402.20000000 AS Decimal(19, 8)), CAST(2804.40000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'RELAXO', CAST(N'2022-03-31T00:00:00.000' AS DateTime), CAST(3.00000000 AS Decimal(19, 8)), CAST(1137.00000000 AS Decimal(19, 8)), CAST(3411.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'MARICO', CAST(N'2022-03-31T00:00:00.000' AS DateTime), CAST(13.00000000 AS Decimal(19, 8)), CAST(505.30000000 AS Decimal(19, 8)), CAST(6568.90000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'HAVELLS', CAST(N'2022-03-31T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(1150.15000000 AS Decimal(19, 8)), CAST(4600.60000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'JUBLFOOD', CAST(N'2022-03-31T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(2710.75000000 AS Decimal(19, 8)), CAST(5421.50000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'DIVISLAB', CAST(N'2022-03-31T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(3943.70000000 AS Decimal(19, 8)), CAST(3943.70000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'BATAINDIA', CAST(N'2022-03-31T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(1745.00000000 AS Decimal(19, 8)), CAST(3490.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'ASIANPAINT', CAST(N'2022-03-31T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(2739.90000000 AS Decimal(19, 8)), CAST(5479.80000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'CHOLAFIN', CAST(N'2022-03-31T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(666.45000000 AS Decimal(19, 8)), CAST(3332.25000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'HINDUNILVR', CAST(N'2022-03-31T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(2046.75000000 AS Decimal(19, 8)), CAST(4093.50000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'HDFCBANK', CAST(N'2022-03-31T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(1350.80000000 AS Decimal(19, 8)), CAST(5403.20000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'BRITANNIA', CAST(N'2022-03-31T00:00:00.000' AS DateTime), CAST(2.00000000 AS Decimal(19, 8)), CAST(3219.80000000 AS Decimal(19, 8)), CAST(6439.60000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'ICICIBANK', CAST(N'2022-03-31T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(693.80000000 AS Decimal(19, 8)), CAST(3469.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'HATSUN', CAST(N'2022-03-31T00:00:00.000' AS DateTime), CAST(5.00000000 AS Decimal(19, 8)), CAST(1105.00000000 AS Decimal(19, 8)), CAST(5525.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'AARTIIND', CAST(N'2022-03-31T00:00:00.000' AS DateTime), CAST(4.00000000 AS Decimal(19, 8)), CAST(798.00000000 AS Decimal(19, 8)), CAST(3192.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'MUTHOOTFIN', CAST(N'2023-03-31T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(932.50000000 AS Decimal(19, 8)), CAST(932.50000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'IDFCFIRSTB', CAST(N'2023-03-31T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(54.43000000 AS Decimal(19, 8)), CAST(54.43000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'HCLTECH', CAST(N'2023-03-31T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1093.00000000 AS Decimal(19, 8)), CAST(1093.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'TATAMTRDVR', CAST(N'2023-03-31T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(213.75000000 AS Decimal(19, 8)), CAST(213.75000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'KTKBANK', CAST(N'2023-03-31T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(142.55000000 AS Decimal(19, 8)), CAST(142.55000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'RECLTD', CAST(N'2023-03-31T00:00:00.000' AS DateTime), CAST(28.00000000 AS Decimal(19, 8)), CAST(116.85000000 AS Decimal(19, 8)), CAST(3271.80000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'THANGAMAYL', CAST(N'2023-03-31T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1039.30000000 AS Decimal(19, 8)), CAST(1039.30000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'INFY', CAST(N'2023-03-31T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1443.35000000 AS Decimal(19, 8)), CAST(1443.35000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'TCS', CAST(N'2023-03-31T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(3282.55000000 AS Decimal(19, 8)), CAST(3282.55000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'MANAPPURAM', CAST(N'2023-03-31T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(109.50000000 AS Decimal(19, 8)), CAST(109.50000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'TITAN', CAST(N'2023-03-31T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2357.05000000 AS Decimal(19, 8)), CAST(2357.05000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'HDFC', CAST(N'2023-03-31T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2570.45000000 AS Decimal(19, 8)), CAST(2570.45000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'TATACONSUM', CAST(N'2023-03-31T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(692.00000000 AS Decimal(19, 8)), CAST(692.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'TECHM', CAST(N'2023-03-31T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1128.10000000 AS Decimal(19, 8)), CAST(1128.10000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'NATCOPHARM', CAST(N'2023-03-31T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(539.15000000 AS Decimal(19, 8)), CAST(539.15000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'ITC', CAST(N'2023-03-31T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(384.85000000 AS Decimal(19, 8)), CAST(384.85000000 AS Decimal(19, 8)))
GO
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'CIPLA', CAST(N'2023-03-31T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(873.20000000 AS Decimal(19, 8)), CAST(873.20000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'PGINVIT', CAST(N'2023-03-31T00:00:00.000' AS DateTime), CAST(853.00000000 AS Decimal(19, 8)), CAST(118.93000000 AS Decimal(19, 8)), CAST(101447.29000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'INDUSINDBK', CAST(N'2023-03-31T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1054.45000000 AS Decimal(19, 8)), CAST(1054.45000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'DIVISLAB', CAST(N'2023-03-31T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(2741.95000000 AS Decimal(19, 8)), CAST(2741.95000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'FEDERALBNK', CAST(N'2023-03-31T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(129.35000000 AS Decimal(19, 8)), CAST(129.35000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'CHOLAFIN', CAST(N'2023-03-31T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(736.25000000 AS Decimal(19, 8)), CAST(736.25000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'NASDAQ', CAST(N'2023-03-31T00:00:00.000' AS DateTime), CAST(3569.04100000 AS Decimal(19, 8)), CAST(9.13740000 AS Decimal(19, 8)), CAST(32611.75523340 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'INDIGRID', CAST(N'2023-03-31T00:00:00.000' AS DateTime), CAST(776.00000000 AS Decimal(19, 8)), CAST(129.88000000 AS Decimal(19, 8)), CAST(100786.88000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'TATASTEEL', CAST(N'2023-03-31T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(107.40000000 AS Decimal(19, 8)), CAST(107.40000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'TMB', CAST(N'2023-03-31T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(418.05000000 AS Decimal(19, 8)), CAST(418.05000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'LIQUIDBEES', CAST(N'2023-03-31T00:00:00.000' AS DateTime), CAST(253.00000000 AS Decimal(19, 8)), CAST(1000.00000000 AS Decimal(19, 8)), CAST(253000.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'HDFCBANK', CAST(N'2023-03-31T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(1572.30000000 AS Decimal(19, 8)), CAST(1572.30000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'ICICIBANK', CAST(N'2023-03-31T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(826.90000000 AS Decimal(19, 8)), CAST(826.90000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'KALYANKJIL', CAST(N'2023-03-31T00:00:00.000' AS DateTime), CAST(1.00000000 AS Decimal(19, 8)), CAST(109.70000000 AS Decimal(19, 8)), CAST(109.70000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'MUTHOOTFIN', CAST(N'2024-03-31T00:00:00.000' AS DateTime), CAST(6.00000000 AS Decimal(19, 8)), CAST(1115.00000000 AS Decimal(19, 8)), CAST(6690.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'BANKNIFTY', CAST(N'2024-03-31T00:00:00.000' AS DateTime), CAST(4020.22300000 AS Decimal(19, 8)), CAST(12.47370000 AS Decimal(19, 8)), CAST(50147.05563510 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'TTKPRESTIG', CAST(N'2024-03-31T00:00:00.000' AS DateTime), CAST(37.00000000 AS Decimal(19, 8)), CAST(698.00000000 AS Decimal(19, 8)), CAST(25826.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'IDFCFIRSTB', CAST(N'2024-03-31T00:00:00.000' AS DateTime), CAST(572.00000000 AS Decimal(19, 8)), CAST(70.15000000 AS Decimal(19, 8)), CAST(40125.80000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'RECLTD', CAST(N'2024-03-31T00:00:00.000' AS DateTime), CAST(65.00000000 AS Decimal(19, 8)), CAST(135.95000000 AS Decimal(19, 8)), CAST(8836.75000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'THANGAMAYL', CAST(N'2024-03-31T00:00:00.000' AS DateTime), CAST(6.00000000 AS Decimal(19, 8)), CAST(1335.00000000 AS Decimal(19, 8)), CAST(8010.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'NATCOPHARM', CAST(N'2024-03-31T00:00:00.000' AS DateTime), CAST(55.00000000 AS Decimal(19, 8)), CAST(632.00000000 AS Decimal(19, 8)), CAST(34760.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_lot_year] ([Symbol], [AsOfDate], [NumberOfShares], [Price], [TotalAmount]) VALUES (N'ITC', CAST(N'2024-03-31T00:00:00.000' AS DateTime), CAST(31.00000000 AS Decimal(19, 8)), CAST(449.20000000 AS Decimal(19, 8)), CAST(13925.20000000 AS Decimal(19, 8)))
GO
SET IDENTITY_INSERT [dbo].[dm_asset_core_symbol] ON 

INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (2210, N'')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (1, N'AARTIIND')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (2, N'ADANIENT')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (3, N'ADANIPORTS')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (4, N'APOLLOHOSP')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (5, N'ARVIND')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (6, N'ASHOKA')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (7, N'ASIANPAINT')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (171, N'AUBANK')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (8, N'AXISBANK')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (157, N'BAJAJ-AUTO')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (9, N'BAJAJFINSV')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (10, N'BAJFINANCE')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (11, N'BALKRISIND')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (172, N'BANDHANBNK')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (169, N'BANKBARODA')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (2084, N'BANKNIFTY')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (12, N'BATAINDIA')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (13, N'BCG')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (14, N'BERGEPAINT')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (15, N'BHARTIARTL')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (162, N'BPCL')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (16, N'BRITANNIA')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (17, N'BRITANNIA-N3')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (18, N'CHOLAFIN')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (19, N'CIPLA')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (159, N'COALINDIA')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (228, N'COFORGE')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (216, N'COLPAL')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (2410, N'COROMANDEL')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (20, N'COSMOFIRST')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (21, N'CROMPTON')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (2038, N'CUB')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (22, N'DABUR')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (23, N'DEEPAKFERT')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (24, N'DEEPAKNTR')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (25, N'DIVISLAB')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (26, N'DMART')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (150, N'DRREDDY')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (151, N'EICHERMOT')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (218, N'EMAMILTD')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (170, N'FEDERALBNK')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (27, N'FINOPB')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (28, N'GALLANTT')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (29, N'GODREJCP')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (30, N'GODREJIND')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (31, N'GODREJPROP')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (32, N'GOLD')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (33, N'GRAPHITE')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (34, N'GRASIM')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (35, N'GREENPANEL')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (36, N'HATHWAY')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (37, N'HATSUN')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (38, N'HAVELLS')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (39, N'HCLTECH')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (40, N'HDFC')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (201, N'HDFCAMC')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (41, N'HDFCBANK')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (42, N'HDFCLIFE')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (43, N'HEMIPROP')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (44, N'HERANBA')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (161, N'HEROMOTOCO')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (45, N'HINDALCO')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (46, N'HINDUNILVR')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (47, N'IBULHSGFIN-NE')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (48, N'ICICIBANK')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (199, N'ICICIGI')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (2097, N'ICICIIT')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (202, N'ICICIPRULI')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (49, N'ICIL')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (173, N'IDFCFIRSTB')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (206, N'IEX')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (50, N'IMFA')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (2135, N'INDIGRID')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (51, N'INDIGRID-IV')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (52, N'INDUSINDBK')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (53, N'INFY')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (54, N'INTELLECT')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (55, N'ITC')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (56, N'JSWSTEEL')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (57, N'JUBLFOOD')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (271, N'KALYANKJIL')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (58, N'KANSAINER')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (2317, N'KARURVYSYA')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (59, N'KOTAKBANK')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (270, N'KTKBANK')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (60, N'LIQUIDBEES')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (61, N'LODHA')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (62, N'LT')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (225, N'LTIM')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (229, N'LTTS')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (63, N'M&M')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (64, N'MANAPPURAM')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (65, N'MARICO')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (66, N'MARUTI')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (67, N'MASTEK')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (215, N'MCDOWELL-N')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (68, N'MOREPENLAB')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (69, N'MOTHERSON')
GO
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (227, N'MPHASIS')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (70, N'MUTHOOTFIN')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (1701, N'NASDAQ')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (71, N'NATCOPHARM')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (72, N'NAUKRI')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (2154, N'NAVIBANK')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (141, N'NESTLEIND')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (73, N'NEWGEN')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (74, N'NIFTY')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (75, N'NIITLTD')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (76, N'NTPC')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (77, N'ONGC')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (78, N'OPTIEMUS')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (226, N'PERSISTENT')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (203, N'PFC')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (2136, N'PGINVIT')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (79, N'PGINVIT-IV')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (80, N'PIDILITIND')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (174, N'PNB')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (81, N'POLICYBZR')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (82, N'POWERGRID')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (219, N'RADICO')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (2039, N'RBLBANK')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (83, N'RECLTD')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (84, N'RELAXO')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (85, N'RELIANCE')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (200, N'SBICARD')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (86, N'SBILIFE')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (87, N'SBIN')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (197, N'SHRIRAMFIN')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (88, N'SPORTKING')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (89, N'SRF')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (90, N'SUNPHARMA')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (91, N'SUVENPHAR')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (92, N'SYMPHONY')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (2249, N'TATACHEM')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (93, N'TATACONSUM')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (94, N'TATAMOTORS')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (95, N'TATAMTRDVR')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (96, N'TATASTEEL')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (97, N'TCS')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (98, N'TECHM')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (99, N'THANGAMAYL')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (100, N'TIRUMALCHM')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (101, N'TITAN')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (102, N'TMB')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (103, N'TNPL')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (104, N'TRIDENT')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (1849, N'TTKPRESTIG')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (217, N'UBL')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (105, N'ULTRACEMCO')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (160, N'UPL')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (213, N'VBL')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (106, N'VGUARD')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (107, N'VIPIND')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (108, N'WHIRLPOOL')
INSERT [dbo].[dm_asset_core_symbol] ([dm_asset_core_symbol_id], [Symbol]) VALUES (109, N'WIPRO')
SET IDENTITY_INSERT [dbo].[dm_asset_core_symbol] OFF
GO
INSERT [dbo].[dm_asset_core_symbol_index] ([dm_asset_core_index_id], [Symbol], [Value]) VALUES (5, N'BAJFINANCE', CAST(4.16666667 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_symbol_index] ([dm_asset_core_index_id], [Symbol], [Value]) VALUES (5, N'CHOLAFIN', CAST(4.16666667 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_symbol_index] ([dm_asset_core_index_id], [Symbol], [Value]) VALUES (5, N'COROMANDEL', CAST(4.16666667 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_symbol_index] ([dm_asset_core_index_id], [Symbol], [Value]) VALUES (5, N'DEEPAKNTR', CAST(4.16666667 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_symbol_index] ([dm_asset_core_index_id], [Symbol], [Value]) VALUES (5, N'DIVISLAB', CAST(4.16666667 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_symbol_index] ([dm_asset_core_index_id], [Symbol], [Value]) VALUES (5, N'DRREDDY', CAST(4.16666667 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_symbol_index] ([dm_asset_core_index_id], [Symbol], [Value]) VALUES (5, N'FEDERALBNK', CAST(4.16666667 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_symbol_index] ([dm_asset_core_index_id], [Symbol], [Value]) VALUES (5, N'HCLTECH', CAST(4.16666667 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_symbol_index] ([dm_asset_core_index_id], [Symbol], [Value]) VALUES (5, N'HDFCBANK', CAST(4.16666667 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_symbol_index] ([dm_asset_core_index_id], [Symbol], [Value]) VALUES (5, N'ICICIBANK', CAST(4.16666667 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_symbol_index] ([dm_asset_core_index_id], [Symbol], [Value]) VALUES (5, N'IDFCFIRSTB', CAST(4.16666667 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_symbol_index] ([dm_asset_core_index_id], [Symbol], [Value]) VALUES (5, N'INDUSINDBK', CAST(4.16666667 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_symbol_index] ([dm_asset_core_index_id], [Symbol], [Value]) VALUES (5, N'INFY', CAST(4.16666667 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_symbol_index] ([dm_asset_core_index_id], [Symbol], [Value]) VALUES (5, N'ITC', CAST(4.16666667 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_symbol_index] ([dm_asset_core_index_id], [Symbol], [Value]) VALUES (5, N'KALYANKJIL', CAST(4.16666667 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_symbol_index] ([dm_asset_core_index_id], [Symbol], [Value]) VALUES (5, N'KTKBANK', CAST(4.17000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_symbol_index] ([dm_asset_core_index_id], [Symbol], [Value]) VALUES (5, N'MANAPPURAM', CAST(4.16666667 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_symbol_index] ([dm_asset_core_index_id], [Symbol], [Value]) VALUES (5, N'MUTHOOTFIN', CAST(4.16666667 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_symbol_index] ([dm_asset_core_index_id], [Symbol], [Value]) VALUES (5, N'NATCOPHARM', CAST(4.16666667 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_symbol_index] ([dm_asset_core_index_id], [Symbol], [Value]) VALUES (5, N'TATACHEM', CAST(4.16666667 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_symbol_index] ([dm_asset_core_index_id], [Symbol], [Value]) VALUES (5, N'TCS', CAST(4.16666667 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_symbol_index] ([dm_asset_core_index_id], [Symbol], [Value]) VALUES (5, N'TECHM', CAST(4.16666667 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_symbol_index] ([dm_asset_core_index_id], [Symbol], [Value]) VALUES (5, N'THANGAMAYL', CAST(4.17000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_symbol_index] ([dm_asset_core_index_id], [Symbol], [Value]) VALUES (5, N'TMB', CAST(4.17000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_symbol_index] ([dm_asset_core_index_id], [Symbol], [Value]) VALUES (7, N'INDIGRID', CAST(0.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_symbol_index] ([dm_asset_core_index_id], [Symbol], [Value]) VALUES (7, N'PGINVIT', CAST(0.00000000 AS Decimal(19, 8)))
INSERT [dbo].[dm_asset_core_symbol_index] ([dm_asset_core_index_id], [Symbol], [Value]) VALUES (7, N'RECLTD', CAST(0.00000000 AS Decimal(19, 8)))
GO
INSERT [dbo].[dm_Calendar_Month] ([MonthID], [Name], [ShortName]) VALUES (1, N'January', N'Jan')
INSERT [dbo].[dm_Calendar_Month] ([MonthID], [Name], [ShortName]) VALUES (2, N'Feburary', N'Feb')
INSERT [dbo].[dm_Calendar_Month] ([MonthID], [Name], [ShortName]) VALUES (3, N'March', N'Mar')
INSERT [dbo].[dm_Calendar_Month] ([MonthID], [Name], [ShortName]) VALUES (4, N'April', N'Apr')
INSERT [dbo].[dm_Calendar_Month] ([MonthID], [Name], [ShortName]) VALUES (5, N'May', N'May')
INSERT [dbo].[dm_Calendar_Month] ([MonthID], [Name], [ShortName]) VALUES (6, N'June', N'Jun')
INSERT [dbo].[dm_Calendar_Month] ([MonthID], [Name], [ShortName]) VALUES (7, N'July', N'Jul')
INSERT [dbo].[dm_Calendar_Month] ([MonthID], [Name], [ShortName]) VALUES (8, N'August', N'Aug')
INSERT [dbo].[dm_Calendar_Month] ([MonthID], [Name], [ShortName]) VALUES (9, N'September', N'Sep')
INSERT [dbo].[dm_Calendar_Month] ([MonthID], [Name], [ShortName]) VALUES (10, N'October', N'Oct')
INSERT [dbo].[dm_Calendar_Month] ([MonthID], [Name], [ShortName]) VALUES (11, N'November', N'Nov')
INSERT [dbo].[dm_Calendar_Month] ([MonthID], [Name], [ShortName]) VALUES (12, N'December', N'Dec')
GO
INSERT [dbo].[dm_Calendar_Quarter] ([QuarterID], [Name], [QuarterPeriod]) VALUES (1, N'Quarter 1', N'Jan - Mar')
INSERT [dbo].[dm_Calendar_Quarter] ([QuarterID], [Name], [QuarterPeriod]) VALUES (2, N'Quarter 2', N'Apr - Jun')
INSERT [dbo].[dm_Calendar_Quarter] ([QuarterID], [Name], [QuarterPeriod]) VALUES (3, N'Quarter 3', N'Jul - Sep')
INSERT [dbo].[dm_Calendar_Quarter] ([QuarterID], [Name], [QuarterPeriod]) VALUES (4, N'Quarter 4', N'Oct - Dec')
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Unique_Symbol]    Script Date: 7/27/2023 12:05:05 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [Unique_Symbol] ON [dbo].[dm_asset_core_symbol]
(
	[Symbol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[PROC_CALC_dm_asset_core_index]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--USE [onpepper-willowridge-12102022]
--GO
--/****** Object:  StoredProcedure [dbo].[PROC_CALC_dm_asset_core_index]    Script Date: 5/30/2023 3:08:57 PM ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
CREATE PROCEDURE [dbo].[PROC_CALC_dm_asset_core_index]
AS  
declare @TempIndex as Table
(
	ID INT IDENTITY(1, 1),
	dm_asset_core_index_id int NOT NULL,
	[Name] varchar(max) NOT NULL,
	[TotalAmount] decimal(19,8) NULL,
	[CurrentAmount] decimal(19,8) NULL,
	[PL] decimal(19,8) NULL,
	[PLPercent] decimal(19,8) NULL
);

declare @TempSymbol as Table
(
	ID INT IDENTITY(1, 1),
	dm_asset_core_index_id int NOT NULL,
	Symbol varchar(max) NOT NULL,
	NumberOfShares decimal(19,8) NULL,
	AvgPrice decimal(19,8) NULL,
	Amount decimal(19,8) NULL,
	CurrentPrice decimal(19,8) NULL,
	CurrentAmount decimal(19,8) NULL
);
 

insert into @TempIndex([dm_asset_core_index_id],[Name])
select dm_asset_core_index_id,[Name] from dm_asset_core_index   

DECLARE @z int; DECLARE @zmaxid int; DECLARE @zngrp int;
SET @zmaxid = (SELECT MAX(ID) FROM @TempIndex);
SET @zngrp = (SELECT COUNT(*) FROM @TempIndex); 
SET @z = 1;
IF @zngrp > 0
 WHILE (@z <= @zmaxid)
    BEGIN
		DECLARE @dm_asset_core_index_id varchar(max);
		select @dm_asset_core_index_id = dm_asset_core_index_id from @TempIndex WHERE ID = @z;

		delete from @TempSymbol; 
		 
		insert into @TempSymbol(Symbol,dm_asset_core_index_id,NumberOfShares,AvgPrice)
		select  
		si.Symbol,si.dm_asset_core_index_id,isnull(lot.NumberOfShares,0) as NumberOfShares,isnull(lot.SharePrice,0) as SharePrice
		from dm_asset_core_symbol_index si
		join dm_asset_core_lot_share lot on lot.Symbol = si.Symbol
		where si.dm_asset_core_index_id = @dm_asset_core_index_id
		--and isnull(si.[Value],0) > 0

		DECLARE @i int = 0; DECLARE @maxTempGroupID int = 0; DECLARE @numrowsGroup int = 0;
		SET @maxTempGroupID = (SELECT MAX(ID) FROM @TempSymbol);
		SET @numrowsGroup = (SELECT COUNT(*) FROM @TempSymbol);
		--select 'TotalRows:' + cast(@numrowsGroup as varchar(max));
		SET @i = 1;
		IF @numrowsGroup > 0
			WHILE (@i <= @maxTempGroupID)
			BEGIN
				DECLARE @symbol varchar(max) = '';
				select @symbol = Symbol from @TempSymbol WHERE ID = @i;

				declare @currentprice decimal(19,8) = 0;
				select top 1 @currentprice = isnull(lot.SharePrice,0) from dm_asset_core_lot lot 
				where lot.Symbol = @symbol order by lot.RecordDate desc,lot.dm_asset_core_lot_id desc

				update @TempSymbol set CurrentAmount = NumberOfShares * @currentprice,CurrentPrice = @currentprice,Amount = NumberOfShares * AvgPrice where ID = @i;
				 
				SET @i = @i + 1
			END
		
		--select * from @TempSymbol 

		declare @totalamount decimal(19,8) = 0;
		declare @currentamount decimal(19,8) = 0;
		declare @pl decimal(19,8) = 0;
		declare @plpercent decimal(19,8) = 0;

		select 
		@totalamount = isnull(sum(isnull(Amount,0)),0) 
		,@currentamount = isnull(sum(isnull(CurrentAmount,0)),0)
		from @TempSymbol 

		set @pl = @currentamount - @totalamount;
		set @plpercent = case when @totalamount > 0 then (@pl / @totalamount) * 100  else 0 end;

		update @TempIndex set TotalAmount = @totalamount,CurrentAmount = @currentamount,PL = @pl,PLPercent = @plpercent where ID = @z;

        SET @z = @z + 1
    END

declare @all_total decimal(19,8) = 0;
declare @all_current  decimal(19,8) = 0;
select @all_total = isnull(sum(isnull(TotalAmount,0)),0),@all_current = isnull(sum(isnull(CurrentAmount,0)),0) from @TempIndex 

--select @all_total as 'Total',@all_current as 'Current'
--,(@all_current - @all_total) as 'PL'
--,case when @all_total > 0 then ((@all_current - @all_total) / @all_total) * 100 else 0 end as 'PLPercent';

select sum(isnull(Amount,0)) as 'Total'
,sum(isnull(CurrentMarketValue,0)) as 'Current' 
,sum(isnull(CurrentMarketValue,0)) - sum(isnull(Amount,0)) as 'PL'
,((sum(isnull(CurrentMarketValue,0)) - sum(isnull(Amount,0))) / sum(isnull(Amount,0))) * 100 as 'PLPercent'
from (
 select
 lot.Symbol
,lot.NumberOfShares
,lot.SharePrice
,lot.Amount
,lot.XIRR
,(lot.NumberOfShares * (select top 1 isnull(cp.SharePrice,0) as CurrentPrice from dm_asset_core_lot cp where cp.Symbol = lot.Symbol and cp.LotType != 'D' order by cp.RecordDate desc,cp.dm_asset_core_lot_id desc)) as CurrentMarketValue
,(select top 1 isnull(cp.SharePrice,0) as CurrentPrice from dm_asset_core_lot cp where cp.Symbol = lot.Symbol and cp.LotType != 'D' order by cp.RecordDate desc,cp.dm_asset_core_lot_id desc) as CurrentPrice 
,((lot.NumberOfShares * (select top 1 isnull(cp.SharePrice,0) as CurrentPrice from dm_asset_core_lot cp where cp.Symbol = lot.Symbol and cp.LotType != 'D' order by cp.RecordDate desc,cp.dm_asset_core_lot_id desc)) - (lot.NumberOfShares * lot.SharePrice)) as PL
,(((lot.NumberOfShares * (select top 1 isnull(cp.SharePrice,0) as CurrentPrice from dm_asset_core_lot cp where cp.Symbol = lot.Symbol and cp.LotType != 'D' order by cp.RecordDate desc,cp.dm_asset_core_lot_id desc)) - (lot.NumberOfShares * lot.SharePrice)) / (lot.NumberOfShares * lot.SharePrice)) * 100 as PLPercent
,si.[Value] as [Value]
 from dm_asset_core_lot_share lot
join dm_asset_core_symbol_index si on si.symbol = lot.symbol
 where lot.Symbol != '' 
 ) as tbl
 

select * from @TempIndex where TotalAmount > 0 order by PLPercent desc
GO
/****** Object:  StoredProcedure [dbo].[PROC_CALC_XIRR]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PROC_CALC_XIRR]
   @dealId int,@asOfDate datetime
AS  
DECLARE @xIRRtable AS dbo.UD_XIRRTableType

declare @TempXIRR as Table
(
	ID INT IDENTITY(1, 1),
	[Fund] [varchar](max) NULL,
	[DealNumber] [varchar](max) NULL,
	[DealName] [varchar](max) NULL,
	[PayDate] [datetime] NULL,
	[Payment] [money] NULL,
	[Description] [varchar](max) NULL,
	[SortOrder] [int] NULL,
	[UnderlyingFund] [varchar](max) NULL,
	[Direct] [varchar](max) NULL,
	[Symbol] [varchar](max) NULL,
	[DealID] [int] NULL,
	[UnderlyingFundID] [int] NULL,
	[IssuerID] [int] NULL,
	[SecurityTypeID] [int] NULL,
	[SecurityID] [int] NULL,
	[EntityCode] [varchar](max) NULL,
	[PartitionNumber] [int] NULL,
	[RowNumber] [int] NULL
); 

insert into @TempXIRR(Fund,DealNumber,DealName,PayDate,Payment,[Description],SortOrder,UnderlyingFund,Direct,Symbol,DealID,UnderlyingFundID,IssuerID,SecurityTypeID,SecurityID,EntityCode,PartitionNumber,RowNumber)
exec [PROC_XIRR_DataPoints] @dealId,@asOfDate;

insert into @xIRRtable
select [PayDate],[Payment],[Description],[SortOrder] from @TempXIRR 
order by [PayDate]

--select * from @TempXIRR

declare @xirr as decimal(38, 9);
set @xirr = dbo.xirr(@xIRRtable,0.1)

select (@xirr * 100) as 'XIRR';
GO
/****** Object:  StoredProcedure [dbo].[PROC_CALC_XIRR_Year]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PROC_CALC_XIRR_Year]
 @entityId int,@fundId int,@dealId int,@underlyingFundId int,@securityTypeId int,@securityId int,@issuerId int,@asOfDate datetime
AS  

--declare @entityId int,@fundId int,@dealId int,@underlyingFundId int,@securityTypeId int,@securityId int,@issuerId int,@asOfDate datetime
--set @entityId = 9;
--set @dealId = 2681;
--set @asOfDate = '2018-12-31'; -- getdate();

declare @TempXIRR as Table
(
	ID INT IDENTITY(1, 1),
	[Fund] [varchar](max) NULL,
	[DealNumber] [varchar](max) NULL,
	[DealName] [varchar](max) NULL,
	[PayDate] [datetime] NULL,
	[Payment] [money] NULL,
	[Description] [varchar](max) NULL,
	[SortOrder] [int] NULL,
	[UnderlyingFund] [varchar](max) NULL,
	[Direct] [varchar](max) NULL,
	[Symbol] [varchar](max) NULL,
	[DealID] [int] NULL,
	[UnderlyingFundID] [int] NULL,
	[IssuerID] [int] NULL,
	[SecurityTypeID] [int] NULL,
	[SecurityID] [int] NULL,
	[EntityCode] [varchar](max) NULL,
	[PartitionNumber] [int] NULL,
	[RowNumber] [int] NULL
); 

insert into @TempXIRR(Fund,DealNumber,DealName,PayDate,Payment,[Description],SortOrder,UnderlyingFund,Direct,Symbol,DealID,UnderlyingFundID,IssuerID,SecurityTypeID,SecurityID,EntityCode,PartitionNumber,RowNumber)
select max(tbl2.[Fund]) as Fund,
	max(tbl2.[DealNumber]) as DealNumber,
	max(tbl2.[DealName]) as DealName,
	max(tbl2.[CalculationDate]) as [Date],
	sum(isnull(tbl2.[Amount],0)) as Amount,
	tbl2.[Description],
	max(tbl2.[SortOrder]) as SortOrder,
	max(tbl2.[UnderlyingFund]) as UnderlyingFund,
	max(tbl2.[Direct]) as Direct,
	max(tbl2.[Symbol]) as Symbol,
	tbl2.[DealID],
	tbl2.[UnderlyingFundID],
	tbl2.[IssuerID],
	tbl2.[SecurityTypeID],
	tbl2.[SecurityID],
	max(tbl2.[EntityCode]) as EntityCode,
	max(tbl2.[PartitionNumber]) as PartitionNumber,
	max(tbl2.[RowNumber]) As RowNumber
from (
select dp.*
,dp.[Date] as CalculationDate
,0 as RowNumber from [dm_vw_XIRR_DataPoints] dp
where EntityID = @entityId 
and (FundID = @fundId or @fundId is null)
and (DealID = @dealId or @dealId is null)
and (UnderlyingFundID = @underlyingFundId or @underlyingFundId is null)
and (SecurityTypeID = @securityTypeId or @securityTypeId is null)
and (SecurityID = @securityId or @securityId is null)
and (IssuerID = @issuerId or @issuerId is null)
and ([Date] <= @asOfDate or @asOfDate is null)
--and [Date] <= @dateof
--and isnull(PartitionNumber,0) = 0
--and isnull(Amount,0) != 0
) as tbl2 
group by tbl2.DealID,tbl2.UnderlyingFundID,tbl2.IssuerID,tbl2.SecurityTypeID,tbl2.SecurityID,tbl2.[CalculationDate],tbl2.[Description]
order by tbl2.[CalculationDate] asc

declare @TempYear as Table
(
	ID INT IDENTITY(1, 1), 
	[Year] INT NOT NULL,
	[XIRR] decimal(19,8)
); 

DECLARE @currentYear INT;
select @currentYear = YEAR(GETDATE());
DECLARE @minYear INT;
select @minYear = YEAR(min(PayDate)) from @TempXIRR;
if @minYear < 2014
	begin
		set @minYear = 2014;
	end
DECLARE @cnt INT = 10;
WHILE @cnt >= 0
BEGIN
   if @minYear <= @currentYear - @cnt
	begin
		insert into @TempYear([Year]) values (@currentYear - @cnt);
	end
   SET @cnt = @cnt - 1;
END;  

--select * from @TempXIRR
--select * from @TempXIRR order by PartitionNumber asc

DECLARE @xIRRtable AS dbo.UD_XIRRTableType
DECLARE @i int; DECLARE @maxTempGroupID int; DECLARE @numrowsGroup int;
SET @maxTempGroupID = (SELECT MAX(ID) FROM @TempYear);
SET @numrowsGroup = (SELECT COUNT(*) FROM @TempYear);
--select 'TotalRows:' + cast(@numrowsGroup as varchar(max));
SET @i = 1;
IF @numrowsGroup > 0
    WHILE (@i <= @maxTempGroupID)
    BEGIN
		
		declare @year int;
		set @year = 0;
		select @year = [Year] from @TempYear where ID = @i;
		
		declare @dateof datetime;
		set @dateof = CONVERT(datetime,cast(@year as varchar) + '-12-31');

		if @currentYear = @year
			begin
				set @dateof = getdate();
			end
		--select cast(@year as varchar(max)) + '-12-31' as dt,@dateof as '@dateof';
		delete from @xIRRtable; 
		--select @dateof as 'dateof';
		insert into @xIRRtable
		select [PayDate],[Payment],[Description],[SortOrder] 
		from @TempXIRR 
		where [PayDate] <= @dateof
		and isnull(PartitionNumber,0) = 0
		and isnull([Payment],0) != 0
		union all
		select @dateof as [PayDate],tbl.[Payment],tbl.[Description],tbl.[SortOrder] from (
		select [Payment],[Description],[SortOrder] 
		,ROW_NUMBER() OVER (PARTITION BY dp.DealID,dp.UnderlyingFundID,dp.IssuerID,dp.SecurityTypeID,dp.SecurityID ORDER BY dp.[PayDate] desc) as RowNumber
		from @TempXIRR dp
		where [PayDate] <= @dateof
		and isnull(PartitionNumber,0) > 0
		and isnull([Payment],0) != 0
		) tbl where tbl.RowNumber = 1
		order by [PayDate]

		--select * from @xIRRtable

		declare @xirr as decimal(19,8);
		BEGIN TRY  
		   set @xirr = dbo.xirr(@xIRRtable,0.1)
		END TRY 
		BEGIN CATCH  
		END CATCH  
		--update @TempYear set [XIRR] = (isnull(@xirr,0) * 100) where ID = @i;
		update @TempYear set [XIRR] = isnull(@xirr,0) where ID = @i;

		--end

        SET @i = @i + 1
    END
/******************** END LOOP *****************/
 
select * from @TempYear
GO
/****** Object:  StoredProcedure [dbo].[PROC_dm_asset_core_lot_share]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--USE [onpepper-willowridge-12102022]
--GO
--/****** Object:  StoredProcedure [dbo].[PROC_dm_asset_core_lot_share]    Script Date: 5/30/2023 2:46:29 PM ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
CREATE PROCEDURE [dbo].[PROC_dm_asset_core_lot_share]
AS  
 declare @TempSymbol as Table
(
	ID INT IDENTITY(1, 1),
	Symbol varchar(max) NOT NULL
);

insert into @TempSymbol(
Symbol
)
select  
Symbol 
from dm_asset_core_lot  
where LotType in ('B','S')   
--and Symbol in ('NASDAQ')
--and Symbol in ('ITC')
group by Symbol


--select * from @TempSymbol order by symbol 

declare @Temp as Table
(
	ID INT IDENTITY(1, 1),
	dm_asset_core_lot_id int NOT NULL,
	Symbol varchar(max) NOT NULL,
	RecordDate datetime NOT NULL,
	NumberOfShares decimal(19,8) NOT NULL,
	LotType varchar(1) NOT NULL,
	Amount decimal(19,8) NOT NULL,
	BalanceShares decimal(19,8) NULL,
	AvgPrice  decimal(19,8) NULL,
	TotalAmount  decimal(19,8) NULL,
	SharePrice decimal(19,8) NULL
);

declare @TempPrevious as Table
(
	ID INT IDENTITY(1, 1),
	dm_asset_core_lot_id int NOT NULL,
	RecordDate datetime NOT NULL,
	NumberOfShares decimal(19,8) NOT NULL,
	LotType varchar(1) NOT NULL,
	SharePrice decimal(19,8) NULL
);


DECLARE @i int; DECLARE @maxTempGroupID int; DECLARE @numrowsGroup int;
SET @maxTempGroupID = (SELECT MAX(ID) FROM @TempSymbol);
SET @numrowsGroup = (SELECT COUNT(*) FROM @TempSymbol);
--select 'TotalRows:' + cast(@numrowsGroup as varchar(max));
SET @i = 1;
IF @numrowsGroup > 0
    WHILE (@i <= @maxTempGroupID)
    BEGIN
		DECLARE @symbol varchar(max);
		select @symbol = Symbol from @TempSymbol WHERE ID = @i;

		update dm_asset_core_lot set BalanceShares = NumberOfShares where Symbol = @symbol and LotType = 'B';
		update dm_asset_core_lot set BalanceShares = NULL where Symbol = @symbol and LotType != 'B';
	 
		delete from @Temp;

		insert into @Temp(
		dm_asset_core_lot_id,
		Symbol,
		RecordDate,
		NumberOfShares,
		LotType,
		Amount,
		SharePrice
		)
		select 
		dm_asset_core_lot_id,
		Symbol,
		RecordDate,
		NumberOfShares,-- case when LotType = 'B' then NumberOfShares else NumberOfShares * -1 end as NumberOfShares,
		LotType,
		NumberOfShares * SharePrice, --case when LotType = 'B' then NumberOfShares * SharePrice else (NumberOfShares * SharePrice) * -1 end as Amount
		SharePrice
		from dm_asset_core_lot
		where Symbol = @symbol and LotType in ('B','S')
		order by RecordDate asc,LotType asc,dm_asset_core_lot_id asc

		--select * from @Temp 

		--select lot.*,case when lot.LotType = 'B' then NumberOfShares * SharePrice else (NumberOfShares * SharePrice) * -1 end as FMV 
		--from @Temp  lot

		--select sum(case when lot.LotType = 'B' then NumberOfShares * SharePrice else (NumberOfShares * SharePrice) * -1 end) as pl 
		--from @Temp  lot 

		DECLARE @x int = 0; DECLARE @ztempgroupid int = 0; DECLARE @znrgroup int = 0;
		SET @ztempgroupid = (SELECT MAX(ID) FROM @Temp);
		SET @znrgroup = (SELECT COUNT(*) FROM @Temp);
		--select 'Total:' + cast(@znrgroup as varchar(max));
		SET @x = 1;
		
		IF @znrgroup > 0
			WHILE (@x <= @ztempgroupid)
			BEGIN

				declare @sellshares decimal(19,8) = 0; 
				declare @lottype varchar(max) = '';
				declare @sell_id int = 0;
				select @sellshares = isnull(NumberOfShares,0),@lottype = LotType,@sell_id = dm_asset_core_lot_id from @Temp WHERE ID = @x;

				if @lottype = 'S'
					begin

						delete from @TempPrevious;

						insert into @TempPrevious(
						dm_asset_core_lot_id,
						RecordDate,
						NumberOfShares,
						LotType,
						SharePrice
						)
						select 
						dm_asset_core_lot_id,
						RecordDate,
						NumberOfShares,
						LotType,
						SharePrice
						from @Temp
						where Symbol = @symbol and LotType in ('B')
						and ID <= @x
						order by RecordDate asc,LotType asc,dm_asset_core_lot_id asc

						--select * from @TempPrevious 
						--select @sellshares as '@sellshares'

						DECLARE @p int = 0; DECLARE @pgid int = 0; DECLARE @pgr int = 0;
						SET @pgid = (SELECT MAX(ID) FROM @TempPrevious);
						SET @pgr = (SELECT COUNT(*) FROM @TempPrevious);
						--select 'Total @pgr:' + cast(@pgr as varchar(max));
						SET @p = 1;
		
						IF @pgr > 0
							WHILE (@p <= @pgid)
								BEGIN
									if  @sellshares > 0 
										begin
											declare @dm_asset_core_lot_id int = 0;
											declare @currentshares decimal(19,8) = 0;
											declare @temp_currentshares decimal(19,8) = 0;
											declare @buyprice decimal(19,8) = 0;

											select @dm_asset_core_lot_id = dm_asset_core_lot_id
											,@currentshares = isnull(NumberOfShares,0)
											,@temp_currentshares = isnull(NumberOfShares,0)
											,@buyprice = isnull(SharePrice,0)
											from @TempPrevious WHERE ID = @p;

											--select '@currentshares:' + cast(@currentshares as varchar(max)) + ',sellshares=' + cast(@sellshares as varchar(max)) + ',balance=' + cast((@currentshares - @sellshares) as varchar(max));

											set @currentshares = @currentshares - @sellshares;

											if isnull(@currentshares,0) <= 0
												begin
													set @currentshares = 0;
												end

											--select '@currentshares2:' + cast(@currentshares as varchar(max));

											if @sellshares <= @temp_currentshares	
												begin
													set @sellshares = 0;
												end

											if @sellshares > @temp_currentshares	
												begin
													set @sellshares = @sellshares - @temp_currentshares;
												end


									

											--update @Temp set NumberOfShares = 0 where ID = @x
											update @TempPrevious set NumberOfShares = @currentshares where dm_asset_core_lot_id = @dm_asset_core_lot_id
											update @Temp set NumberOfShares = @currentshares where dm_asset_core_lot_id = @dm_asset_core_lot_id
											update dm_asset_core_lot set BalanceShares = @currentshares where dm_asset_core_lot_id = @dm_asset_core_lot_id
											update dm_asset_core_lot set BuyPrice = @buyprice,BalanceShares = @sellshares where dm_asset_core_lot_id = @sell_id
										end

									SET @p = @p + 1
								END
					end

				SET @x = @x + 1
			END
		/******************** END LOOP *****************/

		declare @totalamount decimal(19,8) = 0;
		declare @totalshares decimal(19,8) = 0;
		declare @lastid int = 0;

		select @lastid = max(@dm_asset_core_lot_id),@totalshares = sum(isnull(BalanceShares,0)),@totalamount = sum(isnull(BalanceShares,0) * isnull(SharePrice,0)) from dm_asset_core_lot
		where Symbol = @symbol
		and LotType = 'B'

		declare @avgprice decimal(19,8) = 0;
		set @avgprice = case when @totalshares > 0 then @totalamount / @totalshares else 0 end;

		--select @totalshares as '@totalshares',@totalamount as '@totalamount',@avgprice as '@avgprice';

		--update dm_asset_core_lot set BalanceShares = NULL,AvgPrice = NULL 
		--where symbol = @symbol and dm_asset_core_lot_id != @lastid

		--update dm_asset_core_lot set AvgPrice = @avgprice 
		--where symbol = @symbol and dm_asset_core_lot_id = @lastid

		delete from dm_asset_core_lot_share where Symbol = @symbol

		if @totalshares > 0
			begin
				insert into dm_asset_core_lot_share(Symbol,NumberOfShares,SharePrice,Amount) values (@symbol,@totalshares,@avgprice,(@totalshares * @avgprice))
			end

        SET @i = @i + 1
    END
/******************** END LOOP *****************/

--select * from @Temp 
GO
/****** Object:  StoredProcedure [dbo].[PROC_dm_asset_core_lot_year]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--USE [onpepper-willowridge-12102022]
--GO
--/****** Object:  StoredProcedure [dbo].[PROC_dm_asset_core_lot_share]    Script Date: 5/29/2023 4:11:29 PM ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
CREATE PROCEDURE [dbo].[PROC_dm_asset_core_lot_year]
AS  

declare @TempFinancialYears as Table
(
	ID INT IDENTITY(1, 1),
	FinancialEndDate datetime
);

insert into @TempFinancialYears (FinancialEndDate) values ('2020-03-31')
,('2021-03-31')
,('2022-03-31')
,('2023-03-31')
,('2024-03-31')
--,('2025-03-31')
--,('2026-03-31')

--select * from @TempFinancialYears 

 declare @TempSymbol as Table
(
	ID INT IDENTITY(1, 1),
	Symbol varchar(max) NOT NULL
);

insert into @TempSymbol(
Symbol
)
select  
Symbol 
from dm_asset_core_lot  
where LotType in ('B','S')   
--and Symbol in ('ITC')
group by Symbol


--select * from @TempSymbol order by symbol 

declare @Temp as Table
(
	ID INT IDENTITY(1, 1),
	dm_asset_core_lot_id int NOT NULL,
	Symbol varchar(max) NOT NULL,
	RecordDate datetime NOT NULL,
	NumberOfShares decimal(19,8) NOT NULL,
	LotType varchar(1) NOT NULL,
	Amount decimal(19,8) NOT NULL,
	BalanceShares decimal(19,8) NULL,
	AvgPrice  decimal(19,8) NULL,
	TotalAmount  decimal(19,8) NULL
);

declare @TempPrevious as Table
(
	ID INT IDENTITY(1, 1),
	dm_asset_core_lot_id int NOT NULL,
	RecordDate datetime NOT NULL,
	NumberOfShares decimal(19,8) NOT NULL,
	LotType varchar(1) NOT NULL
);

--declare @TempFinal as Table
--(
--	ID INT IDENTITY(1, 1),
--	Symbol varchar(max) NOT NULL,
--	AsOfDate datetime NOT NULL,
--	NumberOfShares decimal(19,8) NOT NULL,
--	Price  decimal(19,8) NULL,
--	TotalAmount  decimal(19,8) NULL
--);



DECLARE @finindex int; DECLARE @fin_maxTempGroupID int; DECLARE @fin_numrowsGroup int;
SET @fin_maxTempGroupID = (SELECT MAX(ID) FROM @TempFinancialYears);
SET @fin_numrowsGroup = (SELECT COUNT(*) FROM @TempFinancialYears);
--select 'TotalRows:' + cast(@numrowsGroup as varchar(max));
SET @finindex = 1;
IF @fin_numrowsGroup > 0
    WHILE (@finindex <= @fin_maxTempGroupID)
		BEGIN
			declare @asofdate datetime;
			set @asofdate = '01/01/1900';
			select @asofdate = FinancialEndDate from @TempFinancialYears WHERE ID = @finindex;

			--select @asofdate as '@asofdate';

			delete from @Temp;
			delete from @TempPrevious;

			DECLARE @i int = 0; DECLARE @maxTempGroupID int = 0; DECLARE @numrowsGroup int = 0;
			SET @maxTempGroupID = (SELECT MAX(ID) FROM @TempSymbol);
			SET @numrowsGroup = (SELECT COUNT(*) FROM @TempSymbol);
			--select 'TotalRows:' + cast(@numrowsGroup as varchar(max));
			SET @i = 1;
			IF @numrowsGroup > 0
				WHILE (@i <= @maxTempGroupID)
				BEGIN
					DECLARE @symbol varchar(max);
					select @symbol = Symbol from @TempSymbol WHERE ID = @i;
	 
					delete from @Temp;

					--select @asofdate as 'asofdate';

					insert into @Temp(
					dm_asset_core_lot_id,
					Symbol,
					RecordDate,
					NumberOfShares,
					LotType,
					Amount
					)
					select 
					dm_asset_core_lot_id,
					Symbol,
					RecordDate,
					NumberOfShares,-- case when LotType = 'B' then NumberOfShares else NumberOfShares * -1 end as NumberOfShares,
					LotType,
					NumberOfShares * SharePrice --case when LotType = 'B' then NumberOfShares * SharePrice else (NumberOfShares * SharePrice) * -1 end as Amount
					from dm_asset_core_lot
					where Symbol = @symbol and LotType in ('B','S')
					and RecordDate <= @asofdate
					order by RecordDate asc,LotType asc,dm_asset_core_lot_id asc

					--select * from @Temp 

					--select lot.*,case when lot.LotType = 'B' then NumberOfShares * SharePrice else (NumberOfShares * SharePrice) * -1 end as FMV 
					--from @Temp  lot

					--select sum(case when lot.LotType = 'B' then NumberOfShares * SharePrice else (NumberOfShares * SharePrice) * -1 end) as pl 
					--from @Temp  lot 

					DECLARE @x int = 0; DECLARE @ztempgroupid int = 0; DECLARE @znrgroup int = 0;
					SET @ztempgroupid = (SELECT MAX(ID) FROM @Temp);
					SET @znrgroup = (SELECT COUNT(*) FROM @Temp);
					--select 'Total:' + cast(@znrgroup as varchar(max));
					SET @x = 1;

					declare @totalsellcount int = 0;
					select @totalsellcount = isnull(count(*),0) from @Temp;
		
					IF @znrgroup > 0
						WHILE (@x <= @ztempgroupid)
						BEGIN

							declare @sellshares int = 0; 
							declare @lottype varchar(max) = '';
							select @sellshares = isnull(NumberOfShares,0),@lottype = LotType from @Temp WHERE ID = @x;

							--select @sellshares as 'sellshares',@lottype as 'lottype';

							if @lottype = 'S'
								begin

									delete from @TempPrevious;

									insert into @TempPrevious(
									dm_asset_core_lot_id,
									RecordDate,
									NumberOfShares,
									LotType
									)
									select 
									dm_asset_core_lot_id,
									RecordDate,
									NumberOfShares,
									LotType
									from @Temp
									where Symbol = @symbol and LotType in ('B')
									and ID <= @x
									order by RecordDate asc,LotType asc,dm_asset_core_lot_id asc

									--select * from @TempPrevious 
									--select @sellshares as '@sellshares'

									DECLARE @p int = 0; DECLARE @pgid int = 0; DECLARE @pgr int = 0;
									SET @pgid = (SELECT MAX(ID) FROM @TempPrevious);
									SET @pgr = (SELECT COUNT(*) FROM @TempPrevious);
									--select 'Total @pgr:' + cast(@pgr as varchar(max));
									SET @p = 1;
		
									IF @pgr > 0
										WHILE (@p <= @pgid)
											BEGIN
												if  @sellshares > 0 
													begin
														declare @dm_asset_core_lot_id int = 0;
														declare @currentshares decimal(19,8) = 0;
														declare @temp_currentshares decimal(19,8) = 0;

														select @dm_asset_core_lot_id = dm_asset_core_lot_id
														,@currentshares = isnull(NumberOfShares,0)
														,@temp_currentshares = isnull(NumberOfShares,0)
														from @TempPrevious WHERE ID = @p;

														--select '@currentshares:' + cast(@currentshares as varchar(max)) + ',sellshares=' + cast(@sellshares as varchar(max)) + ',balance=' + cast((@currentshares - @sellshares) as varchar(max));

														set @currentshares = @currentshares - @sellshares;

														if isnull(@currentshares,0) <= 0
															begin
																set @currentshares = 0;
															end

														--select '@currentshares2:' + cast(@currentshares as varchar(max));

														if @sellshares <= @temp_currentshares	
															begin
																set @sellshares = 0;
															end

														if @sellshares > @temp_currentshares	
															begin
																set @sellshares = @sellshares - @temp_currentshares;
															end


									

														--update @Temp set NumberOfShares = 0 where ID = @x
														update @TempPrevious set NumberOfShares = @currentshares where dm_asset_core_lot_id = @dm_asset_core_lot_id
														update @Temp set NumberOfShares = @currentshares where dm_asset_core_lot_id = @dm_asset_core_lot_id 
													end

												SET @p = @p + 1
											END
								end

							SET @x = @x + 1
						END
					/******************** END LOOP *****************/

					declare @totalamount decimal(19,8) = 0;
					declare @totalshares decimal(19,8) = 0;
					declare @lastid int = 0;

			        select @totalshares = sum(isnull(NumberOfShares,0)) 
					from @Temp
					where Symbol = @symbol
					and LotType = 'B'

					--select @totalshares as '@totalshares',@totalamount as '@totalamount',@avgprice as '@avgprice';

					--update dm_asset_core_lot set BalanceShares = NULL,AvgPrice = NULL 
					--where symbol = @symbol and dm_asset_core_lot_id != @lastid

					--update dm_asset_core_lot set AvgPrice = @avgprice 
					--where symbol = @symbol and dm_asset_core_lot_id = @lastid

					delete from dm_asset_core_lot_year where Symbol = @symbol and AsOfDate = @asofdate

					declare @price decimal(19,8);

					select top 1 @price = isnull(shareprice,0) from dm_asset_core_lot where Symbol = @symbol and RecordDate <= @asofdate and LotType in ('P','B','S')
					order by RecordDate desc,dm_asset_core_lot_id desc

					if @totalshares > 0
						begin
							insert into dm_asset_core_lot_year(Symbol,NumberOfShares,AsOfDate,Price,TotalAmount) values (@symbol,@totalshares,@asofdate,@price,(@totalshares * @price))
						end

					SET @i = @i + 1
				END
			/******************** END LOOP *****************/

	SET @finindex = @finindex + 1
END

--select * from dm_asset_core_lot_year
GO
/****** Object:  StoredProcedure [dbo].[PROC_dm_asset_core_partition]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--USE [onpepper-willowridge-12102022]
--GO
--/****** Object:  StoredProcedure [dbo].[PROC_dm_asset_core_partition]    Script Date: 5/24/2023 3:17:05 PM ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
----USE [onpepper-willowridge-12102022]
----GO
----/****** Object:  StoredProcedure [dbo].[PROC_dm_asset_core_partition]    Script Date: 5/24/2023 3:00:53 PM ******/
----SET ANSI_NULLS ON
----GO
----SET QUOTED_IDENTIFIER ON
----GO
CREATE PROCEDURE [dbo].[PROC_dm_asset_core_partition]
	@total decimal(19,8) 
AS  

--declare @total decimal(19,8) = 0;--903605;
--declare @attional_amount decimal(19,8) = 30000;
--declare @minimumPercentage decimal(19,8) = 0;

declare @TempSymbol as Table
(
	ID INT IDENTITY(1, 1),
	Symbol varchar(max) NOT NULL,
	Price  decimal(19,8) NULL,
	Total decimal(19,8) NULL
);

insert into @TempSymbol(Symbol,Price)
select Symbol,(select top 1 lot.SharePrice from dm_asset_core_lot lot where lot.Symbol = i.Symbol order by lot.RecordDate desc,lot.dm_asset_core_lot_id desc) as Price
from dm_asset_core_symbol_index i
where isnull(i.[Value],0) > 0
group by Symbol

declare @TempIndex as Table
(
	ID INT IDENTITY(1, 1),
	[IndexID] int NOT NULL,
	[Name] varchar(max) NOT NULL,
	[Value] decimal(19,8) NULL,
	[Allocation] decimal(19,8) NULL,
	[CurrentAmount] decimal(19,8) NULL,
	[BalanceAmount] decimal(19,8) NULL
);

insert into @TempIndex([IndexID],[Name],[Value],[Allocation],[CurrentAmount],[BalanceAmount])
select tbl.*,tbl.Allocation - tbl.CurrentAmount as Balance from (
select di.dm_asset_core_index_id,di.[Name],di.[Value]
,(@total * isnull(di.[Value],0))/100 as Allocation
,(select sum(isnull(ls.Amount,0)) from dm_asset_core_lot_share ls 
  join dm_asset_core_symbol_index si on si.Symbol = ls.Symbol 
 where si.dm_asset_core_index_id = di.dm_asset_core_index_id) as CurrentAmount
from dm_asset_core_index di
where isnull(di.[Value],0) > 0
) as tbl

--select @total = sum(isnull([CurrentAmount],0)) from @TempIndex

--set @total = @total + @attional_amount

print @total;

delete from @TempIndex;

insert into @TempIndex([IndexID],[Name],[Value],[Allocation],[CurrentAmount],[BalanceAmount])
select tbl.*,tbl.Allocation - tbl.CurrentAmount as Balance from (
select di.dm_asset_core_index_id,di.[Name],di.[Value]
,(@total * isnull(di.[Value],0))/100 as Allocation
,(select sum(isnull(ls.Amount,0)) from dm_asset_core_lot_share ls 
  join dm_asset_core_symbol_index si on si.Symbol = ls.Symbol 
 where si.dm_asset_core_index_id = di.dm_asset_core_index_id) as CurrentAmount
from dm_asset_core_index di
where isnull(di.[Value],0) > 0
) as tbl

--select @total as total;

--select * from @TempIndex 

declare @TempSymbolIndex as Table
(
	ID INT IDENTITY(1, 1),
	Symbol varchar(max) NOT NULL,
	IndexID int NOT NULL,
	[Value] decimal(19,8),
	Total decimal(19,8) NULL,
	AllocationAmount decimal(19,8) NULL
);


insert into @TempSymbolIndex([Symbol],[IndexID],[Value],[Total],[AllocationAmount])
select si.Symbol,si.dm_asset_core_index_id,si.[Value]
,(isnull(t.Allocation,0) * isnull(si.[Value],0))/100 as Total
,isnull(t.Allocation,0)
from dm_asset_core_symbol_index si
join @TempIndex t on t.IndexID = si.dm_asset_core_index_id

declare @totalAmount decimal(19,8);
set @totalAmount = 0;
select @totalAmount = sum(isnull(Total,0)) from (
select tbl.*,isnull(tbl.Total,0) / isnull(tbl.Price,0) as RequireShares
,(isnull(tbl.Total,0) / isnull(tbl.Price,0)) - isnull(tbl.CurrentShares,0) as Balance
from (
select Symbol
,sum(Total) as Total 
,isnull((select top 1 isnull(lot.SharePrice,0) from dm_asset_core_lot lot where lot.Symbol = ts.Symbol order by lot.RecordDate desc,lot.dm_asset_core_lot_id desc),0) as Price
,isnull((select isnull(lot.NumberOfShares,0) from dm_asset_core_lot_share lot where lot.Symbol = ts.Symbol),0) as CurrentShares
from 
@TempSymbolIndex ts
group by ts.Symbol 
) as tbl
) as tbl2 

 

select tbl.*,isnull(tbl.Total,0) / isnull(tbl.Price,0) as RequireShares
,(isnull(tbl.Total,0) / isnull(tbl.Price,0)) - isnull(tbl.CurrentShares,0) as Balance
,(isnull(tbl.Total,0) / @totalAmount) * 100 as [Percentage]
from (
select Symbol
,sum(Total) as Total 
,isnull((select top 1 isnull(lot.SharePrice,0) from dm_asset_core_lot lot where lot.Symbol = ts.Symbol order by lot.RecordDate desc,lot.dm_asset_core_lot_id desc),0) as Price
,isnull((select isnull(lot.NumberOfShares,0) from dm_asset_core_lot_share lot where lot.Symbol = ts.Symbol),0) as CurrentShares
from 
@TempSymbolIndex ts
group by ts.Symbol 
) as tbl order by Total desc

--select * from (
--select i.Symbol
--,sum(isnull(i.[Total],0)) as Total 
--,max(isnull(ts.Price,0)) as Price
--,case when max(isnull(ts.Price,0)) > 0 then sum(isnull(i.[Total],0)) / max(isnull(ts.Price,0)) else -1 end as NoOfShares
--,i.IndexID 
--,max(isnull(i.[Value],0)) as [Value]
--from @TempSymbolIndex i
--join @TempSymbol ts on ts.Symbol = i.Symbol 
--join @TempIndex tempi on tempi.IndexID = i.IndexID 
--group by i.Symbol,i.IndexID  
--) as tbl 
--order by tbl.[Value] desc,tbl.NoOfShares desc

--declare @totalpercentage decimal(19,8) = 0;
--select @totalpercentage = sum(isnull([Value],0)) 
--from ( 
--select i.Symbol
--,sum(isnull(i.[Total],0)) as Total 
--,max(isnull(ts.Price,0)) as Price
--,case when max(isnull(ts.Price,0)) > 0 then sum(isnull(i.[Total],0)) / max(isnull(ts.Price,0)) else -1 end as NoOfShares
--,i.IndexID 
--,max(isnull(i.[Value],0)) as [Value]
--from @TempSymbolIndex i
--join @TempSymbol ts on ts.Symbol = i.Symbol 
--join @TempIndex tempi on tempi.IndexID = i.IndexID 
--group by i.Symbol,i.IndexID  
--) as tbl 

--declare @TempCalculate as Table
--(
--	ID INT IDENTITY(1, 1),
--	Symbol varchar(max) NOT NULL,
--	IndexID int NOT NULL,
--	Total decimal(19,8) NULL,
--	Price decimal(19,8) NULL,
--	NoOfShares  decimal(19,8) NULL,
--	[Value] decimal(19,8),
--	[NewValue] decimal(19,8) NULL
--);

--select @totalpercentage as '@totalpercentage'

----select * from @TempSymbolIndex 
----order by [Total] desc

--select * from ( 
--select i.Symbol
----,sum(isnull(i.[Total],0)) as Total 
--,((max(isnull(i.[AllocationAmount],0)) * ((max(isnull(i.[Value],0)) / @totalpercentage) * 100))/100) as Total
--,max(isnull(ts.Price,0)) as Price
--,case when max(isnull(ts.Price,0)) > 0 then ((max(isnull(i.[AllocationAmount],0)) * ((max(isnull(i.[Value],0)) / @totalpercentage) * 100))/100) / max(isnull(ts.Price,0)) else -1 end as NoOfShares
--,i.IndexID 
--,((max(isnull(i.[Value],0)) / @totalpercentage) * 100) as [Value]
--from @TempSymbolIndex i
--join @TempSymbol ts on ts.Symbol = i.Symbol 
--join @TempIndex tempi on tempi.IndexID = i.IndexID 
--group by i.Symbol,i.IndexID  
--) as tbl 
--order by tbl.[Value] desc 
----order by tbl.NoOfShares desc

--select distinct Symbol from ( 
--select i.Symbol
----,sum(isnull(i.[Total],0)) as Total 
--,((max(isnull(i.[AllocationAmount],0)) * ((max(isnull(i.[Value],0)) / @totalpercentage) * 100))/100) as Total
--,max(isnull(ts.Price,0)) as Price
--,case when max(isnull(ts.Price,0)) > 0 then ((max(isnull(i.[AllocationAmount],0)) * ((max(isnull(i.[Value],0)) / @totalpercentage) * 100))/100) / max(isnull(ts.Price,0)) else -1 end as NoOfShares
--,i.IndexID 
--,((max(isnull(i.[Value],0)) / @totalpercentage) * 100) as [Value]
--from @TempSymbolIndex i
--join @TempSymbol ts on ts.Symbol = i.Symbol 
--join @TempIndex tempi on tempi.IndexID = i.IndexID 
--group by i.Symbol,i.IndexID  
--) as tbl  
GO
/****** Object:  StoredProcedure [dbo].[PROC_dm_deal_xirr]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[PROC_dm_deal_xirr]
   @dealId int,@asOfDate datetime
AS  
DECLARE @xIRRtable AS dbo.UD_XIRRTableType

declare @TempXIRR as Table
(
	ID INT,
	[Fund] [varchar](max) NULL,
	[DealNumber] [varchar](max) NULL,
	[DealName] [varchar](max) NULL,
	[PayDate] [datetime] NULL,
	[Payment] [money] NULL,
	[Description] [varchar](max) NULL,
	[SortOrder] [int] NULL,
	[UnderlyingFund] [varchar](max) NULL,
	[Direct] [varchar](max) NULL,
	[Symbol] [varchar](max) NULL,
	[FundID] [int] NULL,
	[DealID] [int] NULL,
	[UnderlyingFundID] [int] NULL,
	[IssuerID] [int] NULL,
	[SecurityTypeID] [int] NULL,
	[SecurityID] [int] NULL,
	[EntityID] [int] NULL,
	[EntityCode] [varchar](max) NULL,
	[PartitionNumber] [int] NULL,
	[KeyID] varchar(max)
); 

insert into @TempXIRR(ID,Fund,DealNumber,DealName,PayDate,Payment,[Description],SortOrder,UnderlyingFund,Direct,Symbol,FundID,DealID,UnderlyingFundID,IssuerID,SecurityTypeID,SecurityID,[EntityID],EntityCode,PartitionNumber,[KeyID])
exec [PROC_Get_Deal_XIRR_DataPoints] @dealId,@asOfDate;

insert into @xIRRtable
select [PayDate],[Payment],[Description],[SortOrder] from @TempXIRR 
order by [PayDate],[SortOrder],[Payment]

--select * from @TempXIRR

declare @xirr as decimal(38, 9);
set @xirr = 0;
BEGIN TRY  
	set @xirr = dbo.xirr(@xIRRtable,0.1)
END TRY  
BEGIN CATCH  
	-- select @dealId as 'ErrorDealID';
	set @xirr = 0;
END CATCH


--select @dealId as '@dealId',@asOfDate as '@asOfDate',@xirr as '@xirr';

delete from dm_deal_xirr where dealid = @dealid and xirrdate = @asOfDate;

insert into dm_deal_xirr(DealID,XIRRDate,XIRR,LastUpdatedDate) values (@dealId,@asOfDate,@xirr,getdate());

--select (@xirr * 100) as 'XIRR';
GO
/****** Object:  StoredProcedure [dbo].[PROC_dm_security_lot]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--USE [onpepper-willowridge-12102022]
--GO
--/****** Object:  StoredProcedure [dbo].[PROC_dm_asset_core_lot_share]    Script Date: 5/30/2023 2:46:29 PM ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
CREATE PROCEDURE [dbo].[PROC_dm_security_lot]
AS  
 declare @TempSymbol as Table
(
	ID INT IDENTITY(1, 1),
	Symbol varchar(max) NOT NULL
);

insert into @TempSymbol(
Symbol
)
select  
Symbol 
from dm_asset_core_lot  
where LotType in ('B','S')   
--and Symbol in ('NASDAQ')
--and Symbol in ('ITC')
group by Symbol


--select * from @TempSymbol order by symbol 

declare @Temp as Table
(
	ID INT IDENTITY(1, 1),
	dm_asset_core_lot_id int NOT NULL,
	Symbol varchar(max) NOT NULL,
	RecordDate datetime NOT NULL,
	NumberOfShares decimal(19,8) NOT NULL,
	LotType varchar(1) NOT NULL,
	Amount decimal(19,8) NOT NULL,
	BalanceShares decimal(19,8) NULL,
	AvgPrice  decimal(19,8) NULL,
	TotalAmount  decimal(19,8) NULL,
	SharePrice decimal(19,8) NOT NULL
);

declare @TempPrevious as Table
(
	ID INT IDENTITY(1, 1),
	dm_asset_core_lot_id int NOT NULL,
	RecordDate datetime NOT NULL,
	NumberOfShares decimal(19,8) NOT NULL,
	LotType varchar(1) NOT NULL,
	SharePrice decimal(19,8) NOT NULL
);


DECLARE @i int; DECLARE @maxTempGroupID int; DECLARE @numrowsGroup int;
SET @maxTempGroupID = (SELECT MAX(ID) FROM @TempSymbol);
SET @numrowsGroup = (SELECT COUNT(*) FROM @TempSymbol);
--select 'TotalRows:' + cast(@numrowsGroup as varchar(max));
SET @i = 1;
IF @numrowsGroup > 0
    WHILE (@i <= @maxTempGroupID)
    BEGIN
		DECLARE @symbol varchar(max);
		select @symbol = Symbol from @TempSymbol WHERE ID = @i;

		update dm_asset_core_lot set BalanceShares = NumberOfShares where Symbol = @symbol and LotType = 'B';
		update dm_asset_core_lot set BalanceShares = NULL where Symbol = @symbol and LotType != 'B';
	 
		delete from @Temp;

		insert into @Temp(
		dm_asset_core_lot_id,
		Symbol,
		RecordDate,
		NumberOfShares,
		LotType,
		Amount,
		SharePrice
		)
		select 
		dm_asset_core_lot_id,
		Symbol,
		RecordDate,
		NumberOfShares,-- case when LotType = 'B' then NumberOfShares else NumberOfShares * -1 end as NumberOfShares,
		LotType,
		NumberOfShares * SharePrice, --case when LotType = 'B' then NumberOfShares * SharePrice else (NumberOfShares * SharePrice) * -1 end as Amount
		SharePrice
		from dm_asset_core_lot
		where Symbol = @symbol and LotType in ('B','S')
		order by RecordDate asc,LotType asc,dm_asset_core_lot_id asc

		--select * from @Temp 

		--select lot.*,case when lot.LotType = 'B' then NumberOfShares * SharePrice else (NumberOfShares * SharePrice) * -1 end as FMV 
		--from @Temp  lot

		--select sum(case when lot.LotType = 'B' then NumberOfShares * SharePrice else (NumberOfShares * SharePrice) * -1 end) as pl 
		--from @Temp  lot 

		DECLARE @x int = 0; DECLARE @ztempgroupid int = 0; DECLARE @znrgroup int = 0;
		SET @ztempgroupid = (SELECT MAX(ID) FROM @Temp);
		SET @znrgroup = (SELECT COUNT(*) FROM @Temp);
		--select 'Total:' + cast(@znrgroup as varchar(max));
		SET @x = 1;
		
		IF @znrgroup > 0
			WHILE (@x <= @ztempgroupid)
			BEGIN

				declare @sellshares decimal(19,8) = 0; 
				declare @lottype varchar(max) = '';
				declare @sell_id int;
				select @sellshares = isnull(NumberOfShares,0),@lottype = LotType,@sell_id = dm_asset_core_lot_id from @Temp WHERE ID = @x;

				if @lottype = 'S'
					begin

						delete from @TempPrevious;

						insert into @TempPrevious(
						dm_asset_core_lot_id,
						RecordDate,
						NumberOfShares,
						LotType,
						SharePrice
						)
						select 
						dm_asset_core_lot_id,
						RecordDate,
						NumberOfShares,
						LotType,
						SharePrice
						from @Temp
						where Symbol = @symbol and LotType in ('B')
						and ID <= @x
						order by RecordDate asc,LotType asc,dm_asset_core_lot_id asc

						--select * from @TempPrevious 
						--select @sellshares as '@sellshares'

						DECLARE @p int = 0; DECLARE @pgid int = 0; DECLARE @pgr int = 0;
						SET @pgid = (SELECT MAX(ID) FROM @TempPrevious);
						SET @pgr = (SELECT COUNT(*) FROM @TempPrevious);
						--select 'Total @pgr:' + cast(@pgr as varchar(max));
						SET @p = 1;
		
						IF @pgr > 0
							WHILE (@p <= @pgid)
								BEGIN
									if  @sellshares > 0 
										begin
											declare @dm_asset_core_lot_id int = 0;
											declare @currentshares decimal(19,8) = 0;
											declare @temp_currentshares decimal(19,8) = 0;
											declare @buyprice decimal(19,8) = 0;

											select @dm_asset_core_lot_id = dm_asset_core_lot_id
											,@currentshares = isnull(NumberOfShares,0)
											,@temp_currentshares = isnull(NumberOfShares,0)
											,@buyprice = isnull(SharePrice,0)
											from @TempPrevious WHERE ID = @p;

											--select '@currentshares:' + cast(@currentshares as varchar(max)) + ',sellshares=' + cast(@sellshares as varchar(max)) + ',balance=' + cast((@currentshares - @sellshares) as varchar(max));

											set @currentshares = @currentshares - @sellshares;

											if isnull(@currentshares,0) <= 0
												begin
													set @currentshares = 0;
												end

											--select '@currentshares2:' + cast(@currentshares as varchar(max));

											if @sellshares <= @temp_currentshares	
												begin
													set @sellshares = 0;
												end

											if @sellshares > @temp_currentshares	
												begin
													set @sellshares = @sellshares - @temp_currentshares;
												end


									

											--update @Temp set NumberOfShares = 0 where ID = @x
											update @TempPrevious set NumberOfShares = @currentshares where dm_asset_core_lot_id = @dm_asset_core_lot_id
											update @Temp set NumberOfShares = @currentshares where dm_asset_core_lot_id = @dm_asset_core_lot_id
											update dm_asset_core_lot set BalanceShares = @currentshares where dm_asset_core_lot_id = @dm_asset_core_lot_id
											update dm_asset_core_lot set BuyPrice = @buyprice where dm_asset_core_lot_id = @sell_id
										end

									SET @p = @p + 1
								END
					end

				SET @x = @x + 1
			END
		/******************** END LOOP *****************/

		declare @totalamount decimal(19,8) = 0;
		declare @totalshares decimal(19,8) = 0;
		declare @lastid int = 0;

		select @lastid = max(@dm_asset_core_lot_id),@totalshares = sum(isnull(BalanceShares,0)),@totalamount = sum(isnull(BalanceShares,0) * isnull(SharePrice,0)) from dm_asset_core_lot
		where Symbol = @symbol
		and LotType = 'B'

		declare @avgprice decimal(19,8) = 0;
		set @avgprice = case when @totalshares > 0 then @totalamount / @totalshares else 0 end;

		--select @totalshares as '@totalshares',@totalamount as '@totalamount',@avgprice as '@avgprice';

		--update dm_asset_core_lot set BalanceShares = NULL,AvgPrice = NULL 
		--where symbol = @symbol and dm_asset_core_lot_id != @lastid

		--update dm_asset_core_lot set AvgPrice = @avgprice 
		--where symbol = @symbol and dm_asset_core_lot_id = @lastid

		delete from dm_asset_core_lot_share where Symbol = @symbol

		if @totalshares > 0
			begin
				insert into dm_asset_core_lot_share(Symbol,NumberOfShares,SharePrice,Amount) values (@symbol,@totalshares,@avgprice,(@totalshares * @avgprice))
			end

        SET @i = @i + 1
    END
/******************** END LOOP *****************/

--select * from @Temp 
GO
/****** Object:  StoredProcedure [dbo].[PROC_Get_Deal_XIRR_DataPoints]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PROC_Get_Deal_XIRR_DataPoints]
 @asOfDate datetime
AS  
--declare @dealId varchar(max) = '3298';
--declare @fundId varchar(max) = '164';
--declare @underlyingFundId varchar(max) = '57950';
--declare @securityTypeId varchar(max) = null;
--declare @securityId varchar(max) = null;
--declare @issuerId varchar(max) = null;
--declare @asofdate datetime;
--set @asofdate = cast(getdate() as date);

--Start the query
--Don't change this table structure. Its affect [PROC_XIRR_DataPoints] stored procedure. Please check and change both
declare @TempXIRR as Table
(
	ID INT IDENTITY(1, 1),
	[Symbol] [varchar](max) NULL,
	[PayDate] [datetime] NULL,
	[Payment] [money] NULL,
	[Description] [varchar](max) NULL,
	[SortOrder] [int] NULL
); 

--insert into @TempXIRR(Fund,DealNumber,DealName,PayDate,Payment,[Description],SortOrder,UnderlyingFund,Direct,Symbol,FundID,DealID,UnderlyingFundID,IssuerID,SecurityTypeID,SecurityID,[EntityID],EntityCode,PartitionNumber,[KeyID],[IsExceptDealView],[IsFunding])
select * from @TempXIRR
GO
/****** Object:  StoredProcedure [dbo].[PROC_XIRR_DataPoints]    Script Date: 7/27/2023 12:05:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[PROC_XIRR_DataPoints]
   @dealId int,@asOfDate datetime
AS  
select max(tbl2.[Fund]) as Fund,
	max(tbl2.[DealNumber]) as DealNumber,
	max(tbl2.[DealName]) as DealName,
	max(tbl2.[CalculationDate]) as [Date],
	sum(isnull(tbl2.[Amount],0)) as Amount,
	tbl2.[Description],
	max(tbl2.[SortOrder]) as SortOrder,
	max(tbl2.[UnderlyingFund]) as UnderlyingFund,
	max(tbl2.[Direct]) as Direct,
	max(tbl2.[Symbol]) as Symbol,
	tbl2.[DealID],
	tbl2.[UnderlyingFundID],
	tbl2.[IssuerID],
	tbl2.[SecurityTypeID],
	tbl2.[SecurityID],
	max(tbl2.[EntityCode]) as EntityCode,
	max(tbl2.[PartitionNumber]) as PartitionNumber,
	max(tbl2.[RowNumber]) As RowNumber
from (
select dp.*
,dp.[Date] as CalculationDate
,0 as RowNumber from [dm_vw_XIRR_DataPoints] dp
where dealid = @dealId 
and [Date] <= @asOfDate 
and isnull(PartitionNumber,0) = 0
and isnull(Amount,0) != 0
union all
select * from (
select dp.*
,(case when isnull(@asOfDate,'01/01/1900') > '01/01/1900' then @asOfDate else getdate() end) as CalculationDate
,ROW_NUMBER() OVER (PARTITION BY dp.DealID,dp.UnderlyingFundID,dp.IssuerID,dp.SecurityTypeID,dp.SecurityID ORDER BY dp.[Date] desc) as RowNumber 
from [dm_vw_XIRR_DataPoints] dp
where dealid = @dealId 
and [Date] <= @asOfDate 
and isnull(PartitionNumber,0) > 0
and isnull(Amount,0) != 0
) as tbl where isnull(RowNumber,0) = 1
) as tbl2 
group by tbl2.DealID,tbl2.UnderlyingFundID,tbl2.IssuerID,tbl2.SecurityTypeID,tbl2.SecurityID,tbl2.[CalculationDate],tbl2.[Description]
order by tbl2.[CalculationDate] asc
GO
