declare @entityId int;
declare @dealid int;
declare @fundid int;
declare @ufid int;
declare @startdate datetime;
declare @enddate datetime;
declare @fromdate datetime;
declare @mindate datetime;
declare @investorid int;
declare @companyid int;
declare @securityid int;
declare @todate datetime;
declare @typeid int; 
declare @securitytypeid int;
declare @purchasetypeid int;
declare @sellertypeid int;
declare @underlyingfundid int;
declare @issuerid int;
declare @underlyingfundtypeid int;
declare @vintage int;
declare @viewtype varchar(max);
declare @asofdate datetime;
declare @isaccounting bit;
declare @fundids varchar(max);
declare @strategyids varchar(max);
declare @iscashtype bit;
declare @feestype varchar(max);
declare @periodtypeid int;
declare @aggregationtypeid int;
declare @strategyid int;
declare @expensetype varchar(max);
declare @assettypeid int;
declare @isall bit;
declare @dealids varchar(max);

set @entityId = 9;
set @fundid = {FUNDID};
set @dealid = {DEALID};
--set @ufid = 54839;
--set @underlyingfundid = @ufid;
--set @periodtypeid = 2;
--set @aggregationtypeid = 1;
--set @securityid = 4013;
set @fromdate = '12/30/2020';
set @asofdate = @fromdate;
set @dealids = @dealid;
set @fundids = @fundid;

-- start the query

DECLARE @FundParamTable TABLE
(
ParamValues VARCHAR(100)
)
DECLARE @DealParamTable TABLE
(
ParamValues VARCHAR(100)
)

DECLARE @SQL VARCHAR(3000)
SELECT @SQL = 'SELECT ''' + REPLACE (@fundids,',',''' UNION SELECT ''') + ''''

INSERT INTO @FundParamTable
(ParamValues)
EXEC (@SQL)

SET @SQL = '';
if isnull(@dealids,'') != ''
	begin
		SELECT @SQL = 'SELECT ''' + REPLACE (@dealids,',',''' UNION SELECT ''') + ''''
		INSERT INTO @DealParamTable
		(ParamValues)
		EXEC (@SQL)
	end


declare @SearchDeal as Table
    (
		ID INT IDENTITY(1, 1),
        DealID int,
		FundID int
    );

if isnull(@dealids,'') != ''
	begin
		insert into @SearchDeal(DealID,FundID)
		select DealID,FundID from Deal d
		where d.EntityID = isnull(@entityId,0)
		and (d.DealID in (SELECT ParamValues FROM @DealParamTable) or isnull(@dealids,'') = '')
    end
else
	begin
		insert into @SearchDeal(DealID,FundID)
		select DealID,FundID from Deal d
		where d.EntityID = isnull(@entityId,0)
		and (d.FundID in (SELECT ParamValues FROM @FundParamTable) or isnull(@fundids,'') = '')
		and (d.DealID in (SELECT ParamValues FROM @DealParamTable) or isnull(@dealids,'') = '')
		and (isnull(@fundids,'') != '' or isnull(@dealids,'') != '')
    end

--select * from @SearchDeal 

declare @TempNAV as Table
    (
		ID INT IDENTITY(1, 1),
        DealID int,
		UnderlyingFundID int,
		LastUnderlyingFundNAV decimal(38,18),
		TerminationDate datetime
    );

insert into @TempNAV(DealID,UnderlyingFundID,LastUnderlyingFundNAV,TerminationDate)
select DealID,UnderlyingFundID,NAV,TerminationDate from (
select 
ROW_NUMBER() OVER (PARTITION BY tbl.DealID,tbl.UnderlyingFundID ORDER BY tbl.[Date] desc,tbl.NAVType desc) as PartitionNumber
,tbl.* from (
select 
nav.DealID
,nav.UnderlyingFundID
,nav.FundNAV as NAV
,nav.FundNAVDate as [Date] 
,1 as NAVType
,isnull(uf.TerminationDate,'01/01/1900') as TerminationDate
from underlyingfundnav nav
join dealunderlyingfund duf on duf.dealid = nav.dealid and duf.underlyingfundid = nav.underlyingfundid
join underlyingfund uf on uf.underlyingfundid = duf.underlyingfundid
--left outer join InKindUnderlyingFundDistributionInDeal dufink on dufink.DealUnderlyingFundID = duf.DealUnderlyingFundID 
join dealclosing dc on duf.dealclosingid = dc.dealclosingid
join deal d on d.dealid = nav.dealid
join @SearchDeal sd on sd.DealID = d.DealID
where d.EntityID = isnull(@entityId,0)
and (dc.closedate <= @asofdate or (isnull(duf.EffectiveDate,'01/01/1900') <= @asofdate and isnull(duf.EffectiveDate,'01/01/1900') > '01/01/1900'))
and nav.fundnavdate <= @asofdate
--and isnull(dufink.InKindUnderlyingFundDistributionInDealID,0) <= 0
union all
select 
duf.DealID
,duf.UnderlyingFundID
,duf.originaladjustednav as NAV 
,duf.RecordDate as [Date]
,0 as NAVType
,isnull(uf.TerminationDate,'01/01/1900') as TerminationDate
from DealUnderlyingFund duf
join underlyingfund uf on uf.underlyingfundid = duf.underlyingfundid
--left outer join InKindUnderlyingFundDistributionInDeal dufink on dufink.DealUnderlyingFundID = duf.DealUnderlyingFundID 
join dealclosing dc on duf.dealclosingid = dc.dealclosingid
join deal d on d.dealid = duf.dealid
join @SearchDeal sd on sd.DealID = d.DealID 
where d.EntityID = isnull(@entityId,0)
and (dc.closedate <= @asofdate or (isnull(duf.EffectiveDate,'01/01/1900') <= @asofdate and isnull(duf.EffectiveDate,'01/01/1900') > '01/01/1900'))
--and isnull(dufink.InKindUnderlyingFundDistributionInDealID,0) <= 0
) as tbl) as tbl2 where PartitionNumber = 1 --and (isnull(TerminationDate,'01/01/1900') = '01/01/1900' or isnull(TerminationDate,'01/01/1900') >= @asofdate or @asofdate is null)

--select * from @TempNAV
 
declare @TempDealUnderlyingFund as Table
(
	ID INT IDENTITY(1, 1),
    DealUnderlyingFundID int,
	IsPrimary bit,
	DealID int,
	FundID int,
	UnderlyingFundID int,
	TerminationDate datetime
);
insert into @TempDealUnderlyingFund(DealUnderlyingFundID,IsPrimary,DealID,FundID,UnderlyingFundID,TerminationDate)
select DealUnderlyingFundID,IsPrimary,DealID,FundID,UnderlyingFundID,TerminationDate from (
select 
dufc.DealUnderlyingFundID,isnull(duf.IsPrimary,0) as IsPrimary,d.DealID,d.FundID,uf.UnderlyingFundID
,isnull(uf.TerminationDate,'01/01/1900') as TerminationDate
from DealUnderlyingFundClosing dufc
join dealunderlyingfund duf on duf.dealunderlyingfundid = dufc.dealunderlyingfundid
join underlyingfund uf on uf.underlyingfundid = duf.underlyingfundid
join deal d on d.dealid = duf.dealid
--left outer join InKindUnderlyingFundDistributionInDeal dufink on dufink.DealUnderlyingFundID = duf.DealUnderlyingFundID
join dealclosing dc on dc.dealclosingid = dufc.dealclosingid
join @SearchDeal sd on sd.DealID = d.DealID 
where duf.DealClosingID > 0
and isnull(duf.IsMultipleClose,0) = 1
and isnull(dc.CloseDate,'01/01/1900') <= @asofdate --or (isnull(duf.EffectiveDate,'01/01/1900') <= @asofdate and isnull(duf.EffectiveDate,'01/01/1900') > '01/01/1900'))
--and isnull(dufink.InKindUnderlyingFundDistributionInDealID,0) <= 0
union all
select duf.DealUnderlyingFundID,isnull(duf.IsPrimary,0) as IsPrimary,d.DealID,d.FundID,uf.UnderlyingFundID
,isnull(uf.TerminationDate,'01/01/1900') as TerminationDate
from dealunderlyingfund duf 
join underlyingfund uf on uf.underlyingfundid = duf.underlyingfundid
join deal d on d.dealid = duf.dealid
join @SearchDeal sd on sd.DealID = d.DealID 
join dealclosing dc on duf.DealClosingID = dc.DealClosingID 
--left outer join InKindUnderlyingFundDistributionInDeal dufink on dufink.DealUnderlyingFundID = duf.DealUnderlyingFundID
where duf.DealClosingID > 0
and isnull(duf.IsMultipleClose,0) = 0
and (isnull(dc.CloseDate,'01/01/1900') <= @asofdate or (isnull(duf.EffectiveDate,'01/01/1900') <= @asofdate and isnull(duf.EffectiveDate,'01/01/1900') > '01/01/1900'))
--and isnull(dufink.InKindUnderlyingFundDistributionInDealID,0) <= 0
) as tbl 
--where (isnull(tbl.TerminationDate,'01/01/1900') = '01/01/1900' or isnull(tbl.TerminationDate,'01/01/1900') >= @asofdate or @asofdate is null)
group by DealUnderlyingFundID,IsPrimary,DealID,FundID,UnderlyingFundID,TerminationDate

--select * from @TempDealUnderlyingFund

declare @Temp as Table
    (
		ID INT IDENTITY(1, 1),
        DealID int,
		--EstimatedNAV decimal(38,18),
		RolledForwardNAV decimal(38,18),
		FMV decimal(38,18), -- Total FMV
		DirectFMV decimal(38,18),
		DirectDiscountNAV decimal(38,18),
		DividendDistribution_Base decimal(38,18),
		TotalCapitalCall decimal(38,18),

		RegularDistribution decimal(38,18),
		STND_Distribution decimal(38,18),
		Deemed_Distribution decimal(38,18),
		STND_UnderlyingFundStockDistribution  decimal(38,18),
		Regular_UnderlyingFundStockDistribution  decimal(38,18),
		Realized_UnderlyingFundStockDistribution_FMV decimal(38,18),

		UnderlyingFund_Sale decimal(38,18),
		DealUnderlyingDirect_Sale decimal(38,18),
		DealUnderlyingDirect_STND_Sale decimal(38,18),
		DividendDistribution decimal(38,18),
		DirectDistribution decimal(38,18),
		DealFundExpense decimal(38,18),

		--TotalDistribution decimal(38,18),
		ClosingCosts decimal(38,18),
		NetPurchasePrice decimal(38,18),
		GrossPurchasePrice decimal(38,18),
		IncludeDiscountGPP decimal(38,18),
		DiscountNAV decimal(38,18),
		CurrentExpectedUnfundedAmount decimal(38,18),
		CurrentAdjustedExpectedUnfundedAmount decimal(38,18),
		DeferredPaymentAmount decimal(38,18),
		DeferredPaymentDate datetime,
		ClosingRecordCount int,
		DeemedCapitalCall decimal(38,18),
		--DeemedDistribution decimal(38,18),
		StockDistribution decimal(38,18),
		StockSales decimal(38,18),
		RecordDateNAV decimal(38,18),
		IncludeDiscountRFNAV decimal(38,18), 
		DealUnderlyingFundCount int,
		DealUnderlyingDirectCount int,
		SecondaryAsset varchar(max),
		ReferenceDateCount int,

		PostCloseDistribution decimal(38,18),
		PostCloseContribution decimal(38,18),
		PaidInCapital decimal(38,18),
		TotalValue decimal(38,18),
		GrossDPI decimal(38,18),
		Multiple decimal(38,18),
		NetCostAtCurrent decimal(38,18),
		RecycledMultiple decimal(38,18),
		ComparableNAV decimal(38,18),
		EstimatedNAV decimal(38,18),
		ReferenceDateDiscount decimal(38,18),
		ReferenceDateNAV decimal(38,18),
		ClosingDateDiscount decimal(38,18),
		TotalDiscountNAV decimal(38,18),
		UnderlyingFundCount [int] NULL,
		DirectCount [int] NULL,
		ReferenceDate [varchar](max) NULL,
		CostAsOfClosingDate decimal(38,18),
		OriginalAdjustedExpectedUnfundedAmount decimal(38,18),
		DealSize decimal(38,18),
		AccruedInterestDistribution decimal(38,18),
		Appreciation_Depreciation decimal(38,18),
		Appreciation_Depreciation_Percentage decimal(38,18),
		TotalSTND decimal(38,18),
		UFS_STNDSale decimal(38,18),
		RowNumber int
    );

insert into @Temp(DealID
,RolledForwardNAV
,FMV
,DirectFMV,DirectDiscountNAV,DividendDistribution_Base,TotalCapitalCall
,RegularDistribution
,STND_Distribution
,Deemed_Distribution
,STND_UnderlyingFundStockDistribution
,Regular_UnderlyingFundStockDistribution
,Realized_UnderlyingFundStockDistribution_FMV
,UnderlyingFund_Sale
,DealUnderlyingDirect_Sale
,DealUnderlyingDirect_STND_Sale
,DividendDistribution
,DirectDistribution 
,DealFundExpense

,ClosingCosts,NetPurchasePrice,ClosingRecordCount,DeemedCapitalCall
--,DeemedDistribution
,StockDistribution,StockSales,RecordDateNAV,IncludeDiscountRFNAV
,DealUnderlyingFundCount
,SecondaryAsset
,DealUnderlyingDirectCount
,GrossPurchasePrice
,IncludeDiscountGPP
,DiscountNAV
,CurrentExpectedUnfundedAmount
,CurrentAdjustedExpectedUnfundedAmount
,DeferredPaymentAmount
,DeferredPaymentDate
,ReferenceDateCount
,PostCloseDistribution
,PostCloseContribution
,PaidInCapital
,TotalValue
,GrossDPI
,Multiple
,NetCostAtCurrent
,RecycledMultiple
,ComparableNAV
,EstimatedNAV
,ReferenceDateDiscount
,ReferenceDateNAV
,ClosingDateDiscount
,TotalDiscountNAV
,UnderlyingFundCount
,DirectCount
,ReferenceDate
,CostAsOfClosingDate
,OriginalAdjustedExpectedUnfundedAmount
,DealSize
,AccruedInterestDistribution
,Appreciation_Depreciation
,Appreciation_Depreciation_Percentage
,TotalSTND
,UFS_STNDSale
,RowNumber
)
select * from (
select fedeal.DealID -- DealID Column
,0 as RolledForwardNAV -- RolledForwardNAV Column
,0 as FMV -- FMV Column
,0 as DirectFMV -- DirectFMV Column
,0 as DirectDiscountNAV -- DirectDiscountNAV Column
,0 as DividendDistribution_Base --DividendDistribution Column
,0 as TotalCapitalCall -- TotalCapitalCall Column
,0 as RegularDistribution
,0 as STND_Distribution
,0 as Deemed_Distribution
,0 as STND_UnderlyingFundStockDistribution
,0 as Regular_UnderlyingFundStockDistribution
,0 as Realized_UnderlyingFundStockDistribution_FMV
,0 as UnderlyingFund_Sale
,0 as DealUnderlyingDirect_Sale
,0 as DealUnderlyingDirect_STND_Sale
,0 as DividendDistribution
,0 as DirectDistribution
,0 as DealFundExpense
,0 as ClosingCosts -- ClosingCosts Column
,0  as NetPurchasePrice 
,1 as ClosingRecordCount -- ClosingRecordCount Column
,0 as DeemedCapitalCall -- DeemedCapitalCall Column
,0 as StockDistribution -- StockDistribution column
,0 as StockSales -- StockSales Column
,0 as RecordDateNAV  --  RecordDateNAV Column
,0 as IncludeDiscountRFNAV  --  IncludeDiscountRFNAV Column
,0 as DealUnderlyingFundCount --  DealUnderlyingFundCount Column
,isnull(cdeal.SecondaryAsset,'') as SecondaryAsset
,0 as DealUnderlyingDirectCount  --  DealUnderlyingDirectCount Column
,cdeal.GrossPurchasePrice --GrossPurchasePrice
,0 as IncludeDiscountGPP --IncludeDiscountGPP
,0 as DiscountNAV --DiscountNAV
,cdeal.CurrentExpectedUnfundedAmount as CurrentExpectedUnfundedAmount 
,0 as CurrentAdjustedExpectedUnfundedAmount
,cdeal.DeferredPaymentAmount
,cdeal.DeferredPaymentDate
,0 as ReferenceDateCount
,cdeal.PostCloseDistribution
,cdeal.PostCloseContribution
,cdeal.PaidInCapital
,0 as TotalValue
,cdeal.GrossDPI
,0 as Multiple
,cdeal.NetCostAtCurrent
,0 as RecycledMultiple
,0 as ComparableNAV
,(select 
sum(isnull(RolledForwardNAV_Base,0)) as RolledForwardNAV_Base 
from (
select 
ROW_NUMBER() OVER (PARTITION BY core.DealID,core.UnderlyingFundID,core.SecurityTypeID,core.SecurityID
ORDER BY core.TransactionDate desc,core.dm_asset_core_id desc) as RowNumber
--,core.NetPurchasePrice
,(case when isnull(rfnav.RolledForwardNAV_Base,0) > 0 then isnull(rfnav.RolledForwardNAV_Base,0) else 0 end)
 * 
 (case when isnull(core.UnderlyingFundID,0) > 0 then 
    isnull((select top 1 case when isnull(fx.ConversionFactor,0) = 0 then 1 else isnull(fx.ConversionFactor,0) end from FXConversionRate fx 
												join Entity ent on ent.EntityID = fx.EntityID 
												where fx.EntityID = uf.EntityID 
												--and isnull(fx.IsDefault,0) = 1 
												and ent.CurrencyID = fx.DestinationCurrencyID
												and fx.SourceCurrencyID = uf.CurrencyID
												and fx.EffectiveDate <= (CASE WHEN YEAR(@asofdate) > 1900 THEN @asofdate ELSE GETDATE() end)
												order by fx.EffectiveDate desc,fx.FXConversionRateID desc,isnull(fx.IsDefault,0) desc),1) 
	else 
	isnull((select top 1 case when isnull(fx.ConversionFactor,0) = 0 then 1 else isnull(fx.ConversionFactor,0) end from FXConversionRate fx 
												join Entity ent on ent.EntityID = fx.EntityID 
												where fx.EntityID = d.EntityID
												--and isnull(fx.IsDefault,0) = 1 
												and ent.CurrencyID = fx.DestinationCurrencyID
												and fx.SourceCurrencyID = sym.CurrencyID
												and fx.EffectiveDate <= (CASE WHEN YEAR(@asofdate) > 1900 THEN @asofdate ELSE GETDATE() end)
												order by fx.EffectiveDate desc,fx.FXConversionRateID desc,isnull(fx.IsDefault,0) desc),1) 
	end)
as RolledForwardNAV_Base
from dm_asset_core core
join dm_rolled_forward_nav rfnav on rfnav.dm_rolled_forward_nav_id = core.dm_rolled_forward_nav_id 
join dm_asset_core_deal cd on cd.dm_asset_core_id = core.dm_asset_core_id and cd.dealid = core.dealid 
join deal d on d.dealid = core.dealid 
join fund f on f.FundID = d.FundID 
left outer join underlyingfund uf on uf.UnderlyingFundID = core.UnderlyingFundID 
left outer join SecuritySymbol sym on sym.SecurityTypeID = core.SecurityTypeID and sym.SecurityID = core.SecurityID
where core.dealid = @dealid 
and core.TransactionDate <= @asofdate 
) as tbl 
where tbl.RowNumber = 1) - isnull(cdeal.DividendDistribution,0) as EstimatedNAV
,cdeal.ReferenceDateDiscount
,cdeal.ReferenceDateNAV
,cdeal.ClosingDateDiscount
,cdeal.TotalDiscountNAV
,cdeal.UnderlyingFundCount
,cdeal.DirectCount
,cdeal.ReferenceDate
,cdeal.CostAsOfClosingDate
,cdeal.OriginalAdjustedExpectedUnfundedAmount
,cdeal.DealSize
,cdeal.AccruedInterestDistribution
,0 as Appreciation_Depreciation
,0 as Appreciation_Depreciation_Percentage
,cdeal.TotalSTND
,cdeal.UFS_STNDSale
,ROW_NUMBER() OVER (PARTITION BY core.DealID ORDER BY core.TransactionDate desc,core.dm_asset_core_id desc) as RowNumber
from deal fedeal
join dm_asset_core core on core.dealid = fedeal.dealid 
join dm_asset_core_deal cdeal on cdeal.dm_asset_core_id = core.dm_asset_core_id
left outer join dm_rolled_forward_nav rfnav on rfnav.dm_rolled_forward_nav_id = core.dm_rolled_forward_nav_id 
left outer join underlyingfund uf on core.UnderlyingFundID = uf.UnderlyingFundID 
left outer join SecuritySymbol sym on sym.SecurityTypeID = sym.SecurityID 
join @SearchDeal sd on sd.DealID = fedeal.DealID
where fedeal.EntityID = isnull(@entityId,0)
and core.TransactionDate <= @asofdate 
) as tbl where tbl.RowNumber = 1

update @Temp 
set 
TotalValue = (isnull(EstimatedNAV,0)+isnull(PostCloseDistribution,0))
,Multiple = (case when isnull(PaidInCapital,0) > 0 then ((isnull(EstimatedNAV,0)+isnull(PostCloseDistribution,0)) / isnull(PaidInCapital,0)) else 0 end)
,RecycledMultiple = case when (isnull(PaidInCapital,0) - isnull(TotalSTND,0) - isnull(UFS_STNDSale,0)) > 0 then ((isnull(EstimatedNAV,0)+isnull(PostCloseDistribution,0)) - isnull(TotalSTND,0) - isnull(UFS_STNDSale,0)) / (isnull(PaidInCapital,0) - isnull(TotalSTND,0) - isnull(UFS_STNDSale,0)) else 0 end
,ComparableNAV = (isnull(EstimatedNAV,0) + isnull(PostCloseDistribution,0) - isnull(PostCloseContribution,0))
,Appreciation_Depreciation = ((isnull(EstimatedNAV,0) + isnull(PostCloseDistribution,0) - isnull(PostCloseContribution,0)) - isnull(TotalDiscountNAV,0))
,Appreciation_Depreciation_Percentage = case when isnull(TotalDiscountNAV,0) > 0 then (((isnull(EstimatedNAV,0) + isnull(PostCloseDistribution,0) - isnull(PostCloseContribution,0)) - isnull(TotalDiscountNAV,0)) / isnull(TotalDiscountNAV,0)) * 100 else 0 end
-- End @Temp Table Record

--select * from @Temp;

declare @TempAllocation as Table
(
	ID INT IDENTITY(1, 1),
    DealID int,
	AttributeImplementationTypeID int,
	AttributeImplementationID int,
	AttributeTypeID int,
	AttributeID int,
	AttributeName varchar(max),
	[Value] decimal(38,18),
	CalcValue decimal(38,18),
	AttributeEntityID int
	--,TotalValue  decimal(38,18) NULL
);

insert into @TempAllocation (DealID,AttributeImplementationTypeID,AttributeImplementationID,AttributeTypeID,AttributeID,AttributeName,[Value],CalcValue
,AttributeEntityID
)
--select d.DealID,sa.AttributeImplementationTypeID,sa.AttributeImplementationID,sa.AttributeTypeID,sa.AttributeID,s.StrategyName,sa.[Value]
--,(isnull(dufs.LastUnderlyingFundNAV,0) * isnull(sa.[Value],0)) as CalcValue
--,sa.EntityID
----,(select sum(isnull(LastUnderlyingFundNAV,0)) from @TempNAV where DealID = d.DealID)
--from deal d
--join Fund fund on d.FundID = fund.FundID
--join @TempNAV dufs on dufs.dealid = d.dealid
--join AttributeAllocation sa on dufs.UnderlyingFundID = sa.AttributeImplementationID
--join strategy s on s.StrategyID = sa.AttributeID
--where fund.EntityID = isnull(@entityId,0)
--AND (fund.FundID = @fundids or @fundids is null)
--AND (d.DealID = @dealid or @dealid is null)
--And sa.AttributeImplementationTypeID = 1
--AND sa.AttributeTypeID = 3
--union all
select d.DealID,sa.AttributeImplementationTypeID,sa.AttributeImplementationID,sa.AttributeTypeID,sa.AttributeID,s.DisplayName,sa.[Value] 
,(isnull(dufs.LastUnderlyingFundNAV,0) * isnull(sa.[Value],0)) as CalcValue
,s.EntityID 
--,(select sum(isnull(LastUnderlyingFundNAV,0)) from @TempNAV where DealID = d.DealID)
from deal d
join @SearchDeal sd on sd.DealID = d.DealID 
join Fund fund on d.FundID = fund.FundID
join @TempNAV dufs on dufs.dealid = d.dealid
join AttributeAllocation sa on dufs.UnderlyingFundID = sa.AttributeImplementationID
join [Geography] s on s.GeographyID = sa.AttributeID
where fund.EntityID = isnull(@entityId,0)
And sa.AttributeImplementationTypeID = 1
AND sa.AttributeTypeID = 1
union all
select d.DealID,sa.AttributeImplementationTypeID,sa.AttributeImplementationID,sa.AttributeTypeID,sa.AttributeID
,(case when sa.AttributeTypeID = 3 then s.StrategyName else (case when sa.AttributeTypeID = 2 then ind.Title else geo.DisplayName end) end) as [AttributeName]
,max(isnull(sa.[Value],0)) as [Value]
,((select sum(isnull(LastUnderlyingFundNAV,0)) from @TempNAV where DealID = d.DealID) * max(isnull(sa.[Value],0))) as CalcValue
,max(sa.EntityID) as EntityID
--,(select sum(isnull(LastUnderlyingFundNAV,0)) from @TempNAV where DealID = d.DealID)
from deal d
join @SearchDeal sd on sd.DealID = d.DealID 
join Fund fund on d.FundID = fund.FundID
--join @TempNAV dufs on dufs.dealid = d.dealid
join AttributeAllocation sa on  d.DealID = sa.AttributeImplementationID
left outer join strategy s on s.StrategyID = sa.AttributeID and sa.AttributeTypeID = 3
left outer join industry ind on ind.IndustryID = sa.AttributeID and sa.AttributeTypeID = 2
left outer join geography geo on geo.GeographyID = sa.AttributeID and sa.AttributeTypeID = 1
where fund.EntityID = isnull(@entityId,0)
And sa.AttributeImplementationTypeID = 13
AND sa.AttributeTypeID in (1,2,3)
group by d.DealID,sa.AttributeImplementationTypeID,sa.AttributeImplementationID,sa.AttributeTypeID,sa.AttributeID,s.StrategyName,ind.Title,geo.DisplayName,s.EntityID 

declare @TempAllocationGroup as Table
(
	ID INT IDENTITY(1, 1),
    DealID int,
	AttributeTypeID int,
	AttributeID int,
	AttributeName varchar(max),
	TotalCalcValue decimal(38,18),
	TotalNAV decimal(38,18),
	[Percentage] decimal(38,18)
);

declare @TempDealAllocationGroup as Table
(
	ID INT IDENTITY(1, 1),
    DealID int,
	AttributeTypeID int,
	AttributeID int,
	AttributeName varchar(max),
	TotalCalcValue decimal(38,18),
	TotalNAV decimal(38,18),
	[Percentage] decimal(38,18)
);


--select * from @TempNAV
--select * from @TempAllocation

declare @TAG2 as Table
(
	ID INT IDENTITY(1, 1),
    DealID int,
	AttributeTypeID int,
	AttributeID int,
	AttributeName varchar(max),
	TotalCalcValue decimal(38,18),
	TotalNAV decimal(38,18),
	[Percentage] decimal(38,18)
);


insert into @TAG2(DealID,AttributeTypeID,AttributeID,AttributeName,TotalCalcValue,TotalNAV,[Percentage])
select DealID,AttributeTypeID,AttributeID,AttributeName,max(TotalCalcValue),max(TotalNAV)
,case when max(isnull(TotalNAV,0)) > 0 then sum(isnull(TotalCalcValue,0))/max(isnull(TotalNAV,0)) else 0 end as [Percentage] 
from (
select a.DealID,a.AttributeTypeID,a.AttributeID,a.AttributeName
,sum(a.CalcValue) as TotalCalcValue
,(select sum(isnull(LastUnderlyingFundNAV,0)) from @TempNAV where DealID = a.DealID and UnderlyingFundID in(select AttributeImplementationID from  @TempAllocation where AttributeImplementationTypeID = 1)) as TotalNAV
from @TempAllocation a
where a.AttributeImplementationTypeID != 13
group by a.DealID,a.AttributeTypeID,a.AttributeID,a.AttributeName
) as tbl group by DealID,AttributeTypeID,AttributeID,AttributeName
order by AttributeName

--select ROW_NUMBER () over(order by ID asc) As Row,* from @Temp where ClosingRecordCount > 0;
insert into @TAG2(DealID,AttributeTypeID,AttributeID,AttributeName,TotalCalcValue,TotalNAV,[Percentage])
--union all
select de.DealID,3,s.StrategyID,s.StrategyName,0,0,0  from Strategy s
left outer join @Temp de on de.DealID > 0
where (s.EntityID = @entityId and s.StrategyID in (select AttributeID from @TempAllocation where AttributeTypeID = 3 and AttributeImplementationTypeID != 13))
or (s.EntityID = 1 and s.StrategyID in (select AttributeID from @TempAllocation where AttributeTypeID = 3 and AttributeImplementationTypeID != 13))
--and s.StrategyID not in(select AttributeID from @TAG2 where AttributeTypeID = 3)

insert into @TAG2(DealID,AttributeTypeID,AttributeID,AttributeName,TotalCalcValue,TotalNAV,[Percentage])
--union all
select de.DealID,2,ind.IndustryID,ind.Title,0,0,0  from Industry ind
left outer join @Temp de on de.DealID > 0
where (ind.EntityID = @entityId and ind.IndustryID in (select AttributeID from @TempAllocation where AttributeTypeID = 2 and AttributeImplementationTypeID != 13))
or (ind.EntityID = 1 and ind.IndustryID in (select AttributeID from @TempAllocation where AttributeTypeID = 2 and AttributeImplementationTypeID != 13))
--and s.StrategyID not in(select AttributeID from @TAG2 where AttributeTypeID = 3)

insert into @TAG2(DealID,AttributeTypeID,AttributeID,AttributeName,TotalCalcValue,TotalNAV,[Percentage])
select de.DealID,1,s.GeographyID,s.DisplayName,0,0,0  from [Geography] s
left outer join @Temp de on de.DealID > 0
where (s.EntityID = @entityId and s.GeographyID in (select AttributeID from @TempAllocation where AttributeTypeID = 1 and AttributeImplementationTypeID != 13))
or (s.EntityID = 1 and s.GeographyID in (select AttributeID from @TempAllocation where AttributeTypeID = 1 and AttributeImplementationTypeID != 13))
--and s.GeographyID not in(select AttributeID from @TAG2 where AttributeTypeID = 1)

insert into @TempAllocationGroup(DealID,AttributeTypeID,AttributeID,AttributeName,TotalCalcValue,TotalNAV,[Percentage])
select DealID,AttributeTypeID,max(isnull(AttributeID,0)),max(isnull(AttributeName,'')),max(isnull(TotalCalcValue,0)),max(isnull(TotalNAV,0)),max(isnull([Percentage],0)) from @TAG2
group by DealID,AttributeTypeID,AttributeName 
order by DealID,AttributeTypeID,AttributeName
--select sum(LastUnderlyingFundNAV) from @TempNAV
--select * from @TempNAV
--select * from @TempAllocation
--select * from @TempAllocationGroup
--select * from @TAG2 order by DealID,AttributeTypeID,AttributeName 
--select * from @TempAllocationGroup order by DealID,AttributeTypeID,AttributeName 
--order by AttributeTypeID,AttributeName 
--order by dealid asc

--- Start Deal wise strategy 
-- Clear temp
delete from @TAG2;

insert into @TAG2(DealID,AttributeTypeID,AttributeID,AttributeName,TotalCalcValue,TotalNAV,[Percentage])
select DealID,AttributeTypeID,AttributeID,AttributeName,max(TotalCalcValue),max(TotalNAV)
,case when max(isnull(TotalNAV,0)) > 0 then sum(isnull(TotalCalcValue,0))/max(isnull(TotalNAV,0)) else 0 end as [Percentage] 
from (
select a.DealID,a.AttributeTypeID,a.AttributeID,a.AttributeName
,sum(a.CalcValue) as TotalCalcValue
--,(select sum(isnull(LastUnderlyingFundNAV,0)) from @TempNAV where DealID = a.DealID and UnderlyingFundID in(select AttributeImplementationID from  @TempAllocation where AttributeImplementationTypeID = 1)) as TotalNAV
,(select sum(isnull(LastUnderlyingFundNAV,0)) from @TempNAV where DealID = a.DealID) as TotalNAV
from @TempAllocation a
where a.AttributeImplementationTypeID = 13
group by a.DealID,a.AttributeTypeID,a.AttributeID,a.AttributeName
) as tbl group by DealID,AttributeTypeID,AttributeID,AttributeName
order by AttributeName

--select ROW_NUMBER () over(order by ID asc) As Row,* from @Temp where ClosingRecordCount > 0;
insert into @TAG2(DealID,AttributeTypeID,AttributeID,AttributeName,TotalCalcValue,TotalNAV,[Percentage])
--union all
select de.DealID,3,s.StrategyID,s.StrategyName,0,0,0  from Strategy s
left outer join @Temp de on de.DealID > 0
where (s.EntityID = @entityId and s.StrategyID in (select AttributeID from @TempAllocation where AttributeTypeID = 3 and AttributeImplementationTypeID = 13))
or (s.EntityID = 1 and s.StrategyID in (select AttributeID from @TempAllocation where AttributeTypeID = 3 and AttributeImplementationTypeID = 13))
--and s.StrategyID not in(select AttributeID from @TAG2 where AttributeTypeID = 3)

--select ROW_NUMBER () over(order by ID asc) As Row,* from @Temp where ClosingRecordCount > 0;
insert into @TAG2(DealID,AttributeTypeID,AttributeID,AttributeName,TotalCalcValue,TotalNAV,[Percentage])
--union all
select de.DealID,2,ind.IndustryID,ind.Title,0,0,0  from Industry ind
left outer join @Temp de on de.DealID > 0
where (ind.EntityID = @entityId and ind.IndustryID in (select AttributeID from @TempAllocation where AttributeTypeID = 2 and AttributeImplementationTypeID = 13))
or (ind.EntityID = 1 and ind.IndustryID in (select AttributeID from @TempAllocation where AttributeTypeID = 2 and AttributeImplementationTypeID = 13))
--and s.StrategyID not in(select AttributeID from @TAG2 where AttributeTypeID = 3)

--select ROW_NUMBER () over(order by ID asc) As Row,* from @Temp where ClosingRecordCount > 0;
insert into @TAG2(DealID,AttributeTypeID,AttributeID,AttributeName,TotalCalcValue,TotalNAV,[Percentage])
--union all
select de.DealID,1,geo.GeographyID,geo.DisplayName,0,0,0  from Geography geo
left outer join @Temp de on de.DealID > 0
where (geo.EntityID = @entityId and geo.GeographyID in (select AttributeID from @TempAllocation where AttributeTypeID = 1 and AttributeImplementationTypeID = 13))
or (geo.EntityID = 1 and geo.GeographyID in (select AttributeID from @TempAllocation where AttributeTypeID = 1 and AttributeImplementationTypeID = 13))

insert into @TempDealAllocationGroup(DealID,AttributeTypeID,AttributeID,AttributeName,TotalCalcValue,TotalNAV,[Percentage])
select DealID,AttributeTypeID,max(isnull(AttributeID,0)),max(isnull(AttributeName,'')),max(isnull(TotalCalcValue,0)),max(isnull(TotalNAV,0)),max(isnull([Percentage],0)) from @TAG2
group by DealID,AttributeTypeID,AttributeName 
order by DealID,AttributeTypeID,AttributeName

--select * from @TempDealAllocationGroup
--- End Deal wise strategy 


declare @TempFinal as Table
(
	[ID] INT IDENTITY(1, 1),
    DealID int NULL,
	DealNumber int NULL,
	[Name] varchar(max),
	[Value] varchar(max),
	[Category] varchar(1),
	[SortOrder] int NULL
);

----Pivot Table Start----

insert into @TempFinal(DealID,DealNumber,[Name],[Value],[Category],[SortOrder])
SELECT dealid, DealNumber, name, value, 'A' as category
--, ROW_NUMBER () over(order by DealNumber,dealid asc) As Row
,ROW_NUMBER () over(order by DealNumber,dealid asc) as SortOrder
FROM (

------Pivot Table END----
select 
deal.DealID
, deal.DealNumber
,CAST(deal.DealName AS NVARCHAR(MAX)) AS [Deal Name]
,CAST(deal.DealNumber AS NVARCHAR(MAX)) AS [Deal Number]
,CAST(max(isnull(dealDetail.UnderlyingFundCount,0)) as NVARCHAR(MAX)) as [Underlying Fund Count]
,CAST(max(isnull(dealDetail.DirectCount,0)) as NVARCHAR(MAX)) as [Direct Count]
,case when max(isnull(dealDetail.DirectCount,0)) > 0 and CAST(max(SecondaryAsset) as NVARCHAR(MAX)) = 'Yes' then 'Mixed' else CAST(max(SecondaryAsset) as NVARCHAR(MAX)) end as [Included in deal Discount]

,CAST(CONVERT(NVARCHAR(10), max(isnull(dealDetail.ReferenceDate,'01/01/1900')), 101) as NVARCHAR(MAX)) as [Reference Date]

,CAST(CAST(max(isnull(dealDetail.ReferenceDateDiscount,0)) AS BIGINT) as NVARCHAR(MAX)) as [Reference Date Discount]
,CAST(max(isnull(dealDetail.ReferenceDateNAV,0)) AS NVARCHAR(MAX)) AS [Reference Date Nav]
,CAST(ROUND(max(isnull(dealDetail.GrossPurchasePrice,0)),2) as NVARCHAR(MAX)) as [Gross Purchase Price]

,CAST((case when (select isnull(count(*),0) as cnt from DealClosing dc where dc.DealID = deal.DealID) <= 0 then '' else (case when (select count(*) as cnt from DealClosing dc where dc.DealID = deal.DealID) > 1 then 'Various' 
else (select top 1 CONVERT(VARCHAR(10),dc.CloseDate,101) as CloseDate from DealClosing dc where dc.DealID = deal.DealID order by dc.TotalPaid desc) end) end) as NVARCHAR(MAX)) as [Closing Date]

,CAST(CAST(Round(max(isnull(dealDetail.ClosingDateDiscount,0)),0) AS BIGINT) as NVARCHAR(MAX)) AS [Closing Date Discount]
,CAST((case when max(isnull(dealDetail.TotalDiscountNAV,0)) > 0 then max(isnull(dealDetail.TotalDiscountNAV,0)) else 0 end)  AS NVARCHAR(MAX)) as [NAV as of Closing Date]
,CAST(ROUND(max(isnull(dealDetail.CostAsOfClosingDate,0)),2) as NVARCHAR(MAX)) as [Cost As Of Closing Date]
,CAST(case when max(isnull(dealDetail.OriginalAdjustedExpectedUnfundedAmount,0)) > 0 then max(isnull(dealDetail.OriginalAdjustedExpectedUnfundedAmount,0)) else 0 end AS NVARCHAR(MAX)) AS [Expected Unfunded at Closing]
,CAST(case when max(isnull(dealDetail.CurrentExpectedUnfundedAmount,0)) > 0 then max(isnull(dealDetail.CurrentExpectedUnfundedAmount,0)) else 0 end AS NVARCHAR(MAX)) AS [Expected Unfunded at Current]
,CAST(case when max(isnull(dealDetail.DealSize,0)) > 0 then max(isnull(dealDetail.DealSize,0)) else 0 end AS NVARCHAR(MAX)) AS [Deal Size]
,CAST((case when max(isnull(dealDetail.DeferredPaymentAmount,0)) > 0 then max(isnull(dealDetail.DeferredPaymentAmount,0)) else 0 end)  AS NVARCHAR(MAX)) as [Deferred Payment Amount]
,case when max(isnull(dealDetail.DeferredPaymentDate,'01/01/1900')) > '01/01/1900' then CAST(CONVERT(NVARCHAR(10), max(isnull(dealDetail.DeferredPaymentDate,'01/01/1900')), 101) as NVARCHAR(MAX)) else '' end as [Deferred Payment Date]
,CAST((case when max(isnull(AccruedInterestDistribution,0)) > 0 then max(isnull(AccruedInterestDistribution,0)) else 0 end)  AS NVARCHAR(MAX)) as [Accrued Interest]
,CAST(ROUND(max(isnull(dealDetail.PostCloseDistribution,0)),2) as NVARCHAR(MAX)) as [Post Close Distributions]
,CAST(ROUND(max(isnull(dealDetail.PostCloseContribution,0)),2) as NVARCHAR(MAX)) as [Post Close Capital Calls]
,CAST(case when max(isnull(dealDetail.NetCostAtCurrent,0)) > 0 then ROUND(max(isnull(dealDetail.NetCostAtCurrent,0)),2) else 0 end as NVARCHAR(MAX)) as [Net Cost At Current]
,CAST(ROUND(max(isnull(dealDetail.EstimatedNAV,0)),2) as NVARCHAR(MAX)) as [Estimated Nav As Of Current]
,CAST(ROUND(max(isnull(dealDetail.PaidInCapital,0)),2) as NVARCHAR(MAX)) as [Paid In Capital]

,CAST(ROUND(max(isnull(dealDetail.TotalValue,0)),2) as NVARCHAR(MAX)) as [Total Value]

,CAST(cast(ROUND(max(isnull(dealDetail.GrossDPI,0)),2) as decimal(38,2)) as NVARCHAR(MAX)) as [Gross DPI]
,CAST(cast(ROUND(max(isnull(dealDetail.Multiple,0)),2) as decimal(38,2)) as NVARCHAR(MAX)) as [Multiple]
,CAST(cast(ROUND(max(isnull(dealDetail.RecycledMultiple,0)),2) as decimal(38,2)) as NVARCHAR(MAX)) as [Recycled Multiple]
,CAST(ROUND(max(isnull(dealDetail.ComparableNAV,0)),2) as NVARCHAR(MAX)) as [Comparable NAV]
,CAST(ROUND(max(isnull(dealDetail.Appreciation_Depreciation,0)),2) as NVARCHAR(MAX)) as [Appreciation/Depreciation]
,CAST(cast(ROUND(max(isnull(dealDetail.Appreciation_Depreciation_Percentage,0)),2) as decimal(38,2)) as NVARCHAR(MAX)) as [Appreciation/Depreciation %]
,CAST(isnull(STUFF((SELECT ',' + stype.SellerType 
	FROM DealSeller ds
	join SellerType stype on stype.SellerTypeID = ds.SellerTypeID
	WHERE ds.DealID = deal.DealID
	FOR XML PATH('')), 1, 1, ''),'') as NVARCHAR(MAX)) as [Seller Type]
,CAST(isnull((select top 1 geo.DisplayName from DealSeller ds
	left outer join [Geography] geo on geo.GeographyID = ds.SellerGeographyID
	where ds.DealID = deal.DealID
	),'') as NVARCHAR(MAX))  as [Seller Geography] 
,CAST((select top 1 case when isnull(xrr.XIRR,0) != 0 then CAST((isnull(xrr.XIRR,0) * 100) AS decimal(38,2)) else 0 end as IRR from dm_deal_xirr xrr
	where xrr.DealID = deal.DealID
	and ((xrr.XIRRDate <= @asofdate) or @asofdate is null)
	order by xrr.XIRRDate desc,xrr.LastUpdatedDate desc) as NVARCHAR(MAX)) as IRR
from Deal deal
join @SearchDeal sd on sd.DealID = deal.DealID 
join @Temp dealDetail on deal.DealID = dealDetail.DealID
join Fund fund on deal.FundID = fund.FundID
--left outer join DealUnderlyingFund dufs on deal.DealID = dufs.DealID and isnull(dufs.DealClosingID,0) > 0
--left outer join dealclosing dc on dufs.dealclosingid = dc.dealclosingid and dc.closedate <= @asofdate
where fund.EntityID = isnull(@entityId,0)
--and (dc.closedate <= @asofdate or (isnull(dufs.EffectiveDate,'01/01/1900') <= @asofdate and isnull(dufs.EffectiveDate,'01/01/1900') > '01/01/1900'))
AND dealDetail.ClosingRecordCount > 0
group by deal.DealID, fund.FundName, deal.DealNumber,deal.DealName
--------Pivot Table Start----

) p UNPIVOT (value FOR name IN 
([Deal Name]
,[Deal Number]
,[Underlying Fund Count]
,[Direct Count]
,[Included in deal Discount]
,[Reference Date]
,[Reference Date Discount]
,[Reference Date NAV]
--,[RecordDateNAV]
--,[DealDetailFMV]
,[Gross Purchase Price]
,[Closing Date]
,[Closing Date Discount]
,[NAV as of Closing Date]
,[Cost As Of Closing Date]
,[Expected Unfunded at Closing]
,[Expected Unfunded at Current]
,[Deal Size]
,[Deferred Payment Amount]
,[Deferred Payment Date]
,[Accrued Interest]
--,[Net Purchase Price]
,[Post Close Distributions]
,[Post Close Capital Calls]
,[Net Cost At Current]
--,[RolledForward NAV As Of Current]
--,[FMV As Of Current]
,[Estimated Nav As Of Current]
,[Paid In Capital]
,[Total Value]
,[Gross DPI]
,[Multiple]
,[Recycled Multiple]
,[Comparable NAV]
,[Appreciation/Depreciation]
,[Appreciation/Depreciation %]
,[Seller Type]
,[Seller Geography]
--,[As-Of Date Strategy]
--,[As-Of Date Geography]
,[IRR]
--,[Recycled MOIC]
--,[Recycled Discount]
--,[Reference Date PP]
--,[MOIC]
--,[Direct Count]
--,[Deemed Capital Call],[Deemed Distribution],[Stock Distribution],[Stock Sales]
)
) AS unpvt 
where ([name] not in('Deemed Capital Call','Deemed Distribution','Stock Distribution','Stock Sales') and isnull(@isaccounting,0) = 0) or isnull(@isaccounting,0) = 1
----- Deal starategy 
 union all
 select a.DealID,d.DealNumber,a.AttributeName
 ,CASE WHEN isnull(a.[Percentage],0) > 0 THEN CAST(CAST(ROUND(isnull(a.[Percentage],0),0) as BIGINT) AS nvarchar(max)) + '%' ELSE '0%' END as [value]
 ,'B' as Category
 ,1 as SortOrder
 --,ROW_NUMBER() OVER (ORDER BY a.AttributeName asc)
 from @TempDealAllocationGroup a
 join @Temp te on te.DealID = a.DealID and te.ClosingRecordCount > 0
 left outer join deal d on d.dealid = te.dealid
 where a.AttributeTypeID = 3 --and a.[Percentage] > 0
 --- Deal starategy total
 union all
 select a.DealID,d.DealNumber,'Total %'
 ,CASE WHEN sum(isnull(a.[Percentage],0)) > 0 THEN CAST(CAST(ROUND(sum(isnull(a.[Percentage],0)),0) as BIGINT) AS nvarchar(max)) + '%' ELSE '0%' END as [value]
 ,'B' as Category
 ,2 as SortOrder
 --, count(a.DealID) + 1
 from @TempDealAllocationGroup a
 join @Temp te on te.DealID = a.DealID and te.ClosingRecordCount > 0
 left outer join deal d on d.dealid = te.dealid
 where a.AttributeTypeID = 3 --and a.[Percentage] > 0
 group by a.DealID,d.DealNumber

 --- Deal industry 
 union all
 select a.DealID,d.DealNumber,a.AttributeName
 ,CASE WHEN isnull(a.[Percentage],0) > 0 THEN CAST(CAST(ROUND(isnull(a.[Percentage],0),0) as BIGINT) AS nvarchar(max)) + '%' ELSE '0%' END as [value]
 ,'C' as Category
 ,3 as SortOrder
 --,ROW_NUMBER() OVER (ORDER BY a.AttributeName asc)
 from @TempDealAllocationGroup a
 join @Temp te on te.DealID = a.DealID and te.ClosingRecordCount > 0
 left outer join deal d on d.dealid = te.dealid
 where a.AttributeTypeID = 2 --and a.[Percentage] > 0
 --- Deal starategy total
 union all
 select a.DealID,d.DealNumber,'Total %'
 ,CASE WHEN sum(isnull(a.[Percentage],0)) > 0 THEN CAST(CAST(ROUND(sum(isnull(a.[Percentage],0)),0) as BIGINT) AS nvarchar(max)) + '%' ELSE '0%' END as [value]
 ,'C' as Category
 ,4 as SortOrder
 --, count(a.DealID) + 1
 from @TempDealAllocationGroup a
 join @Temp te on te.DealID = a.DealID and te.ClosingRecordCount > 0
 left outer join deal d on d.dealid = te.dealid
 where a.AttributeTypeID = 2 --and a.[Percentage] > 0
 group by a.DealID,d.DealNumber

 --- Deal Geography 
 union all
 select a.DealID,d.DealNumber,a.AttributeName
 ,CASE WHEN isnull(a.[Percentage],0) > 0 THEN CAST(CAST(ROUND(isnull(a.[Percentage],0),0) as BIGINT) AS nvarchar(max)) + '%' ELSE '0%' END as [value]
 ,'E' as Category
 ,5 as SortOrder
 --,ROW_NUMBER() OVER (ORDER BY a.AttributeName asc)
 from @TempDealAllocationGroup a
 join @Temp te on te.DealID = a.DealID and te.ClosingRecordCount > 0
 left outer join deal d on d.dealid = te.dealid
 where a.AttributeTypeID = 1 --and a.[Percentage] > 0
 --- Deal Geography total
 union all
 select a.DealID,d.DealNumber,'Total %'
 ,CASE WHEN sum(isnull(a.[Percentage],0)) > 0 THEN CAST(CAST(ROUND(sum(isnull(a.[Percentage],0)),0) as BIGINT) AS nvarchar(max)) + '%' ELSE '0%' END as [value]
 ,'E' as Category
 ,6 as SortOrder
 --, count(a.DealID) + 1
 from @TempDealAllocationGroup a
 join @Temp te on te.DealID = a.DealID and te.ClosingRecordCount > 0
 left outer join deal d on d.dealid = te.dealid
 where a.AttributeTypeID = 1 --and a.[Percentage] > 0
 group by a.DealID,d.DealNumber

--- Asset starategy 
 --union all
 --select a.DealID,d.DealNumber,a.AttributeName
 --,CASE WHEN isnull(a.[Percentage],0) > 0 THEN CAST(CAST(ROUND(isnull(a.[Percentage],0),0) as BIGINT) AS nvarchar(max)) + '%' ELSE '0%' END as [value]
 --,'C' as Category
 --,3 as SortOrder
 ----,ROW_NUMBER() OVER (ORDER BY a.AttributeName asc)
 --from @TempAllocationGroup a
 --join @Temp te on te.DealID = a.DealID and te.ClosingRecordCount > 0
 --left outer join deal d on d.dealid = te.dealid
 --where a.AttributeTypeID = 3 --and a.[Percentage] > 0
 ----- Asset starategy total
 --union all
 --select a.DealID,d.DealNumber,'Total %'
 --,CASE WHEN sum(isnull(a.[Percentage],0)) > 0 THEN CAST(CAST(ROUND(sum(isnull(a.[Percentage],0)),0) as BIGINT) AS nvarchar(max)) + '%' ELSE '0%' END as [value]
 --,'C' as Category
 --,4 as SortOrder
 ----, count(a.DealID) + 1
 --from @TempAllocationGroup a
 --join @Temp te on te.DealID = a.DealID and te.ClosingRecordCount > 0
 --left outer join deal d on d.dealid = te.dealid
 --where a.AttributeTypeID = 3 --and a.[Percentage] > 0
 --group by a.DealID,d.DealNumber

 --- Asset geograpy
 union all
 select a.DealID,d.DealNumber,a.AttributeName
 ,CASE WHEN isnull(a.[Percentage],0) > 0 THEN CAST(CAST(ROUND(isnull(a.[Percentage],0),0) as BIGINT) AS nvarchar(max)) + '%' ELSE '0%' END as [value]
 ,'D' as Category
 ,7 as SortOrder
 --,ROW_NUMBER() OVER (ORDER BY a.AttributeName asc)
 from @TempAllocationGroup a
 join @Temp te on te.DealID = a.DealID and te.ClosingRecordCount > 0
 left outer join deal d on d.dealid = te.dealid
 where a.AttributeTypeID = 1 --and a.[Percentage] > 0
 --- Asset geograpy total
 union all
 select a.DealID,d.DealNumber,'Total %'
 ,CASE WHEN sum(isnull(a.[Percentage],0)) > 0 THEN CAST(CAST(ROUND(sum(isnull(a.[Percentage],0)),0) as BIGINT) AS nvarchar(max)) + '%' ELSE '0%' END as [value]
 ,'D' as Category
 ,8 as SortOrder
 --, count(a.DealID) + 1
 from @TempAllocationGroup a
 join @Temp te on te.DealID = a.DealID and te.ClosingRecordCount > 0
 left outer join deal d on d.dealid = te.dealid
 where a.AttributeTypeID = 1 --and a.[Percentage] > 0
 group by a.DealID,d.DealNumber
 
 
 select * from @TempFinal
 order by DealNumber,DealID,[Category],[SortOrder]--,[Category],[Name]

------Pivot Table End----