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

--select * from @DealParamTable 

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

declare @TempDealUnderlyingFundAdjustment as Table
    (
		ID INT IDENTITY(1, 1),
        DealID int,
		UnderlyingFundID int,
		UnderlyingFundName varchar(max),
		CurrentExpectedUnfundedAmount decimal(38,18),
		OriginalAdjustedExpectedUnfundedAmount decimal(38,18),
		PartitionNumber int
    );
insert into @TempDealUnderlyingFundAdjustment(DealID,UnderlyingFundID,UnderlyingFundName,CurrentExpectedUnfundedAmount,OriginalAdjustedExpectedUnfundedAmount,PartitionNumber)
select DealID,UnderlyingFundID,UnderlyingFundName,CurrentExpectedUnfundedAmount,OriginalAdjustedExpectedUnfundedAmount,PartitionNumber from 
(select 
--top 1 isnull(dufadj.CurrentExpectedUnfundedAmount,0) 
ROW_NUMBER() OVER (PARTITION BY dufadj.dealunderlyingfundid ORDER BY dufadj.EffectiveDate desc,dufadj.DealUnderlyingFundAdjustmentID desc) as PartitionNumber
,duf.DealID
,duf.UnderlyingFundID
,uf.FundName as UnderlyingFundName
,isnull(dufadj.CurrentExpectedUnfundedAmount,0)  as CurrentExpectedUnfundedAmount
,isnull(duf.OriginalAdjustedExpectedUnfundedAmount,0) as OriginalAdjustedExpectedUnfundedAmount
from 
dealunderlyingfundadjustment dufadj
join dealunderlyingfund duf on duf.dealunderlyingfundid = dufadj.dealunderlyingfundid
join deal d on d.dealid = duf.dealid
join underlyingfund uf on uf.underlyingfundid = duf.underlyingfundid
--left outer join InKindUnderlyingFundDistributionInDeal dufink on dufink.DealUnderlyingFundID = duf.DealUnderlyingFundID
join DealClosing dc on dc.DealClosingID = duf.DealClosingID
join @SearchDeal sd on sd.DealID = d.DealID 
where d.EntityID = isnull(@entityId,0)
and duf.dealclosingid > 0
and (
 (dufadj.DealUnderlyingFundAdjustmentReasonID = 4 and (isnull(dc.CloseDate,'01/01/1900') <= @asofdate or (isnull(duf.EffectiveDate,'01/01/1900') <= @asofdate and isnull(duf.EffectiveDate,'01/01/1900') > '01/01/1900')))
or
 (isnull(dufadj.EffectiveDate,'01/01/1900') <= @asofdate and dufadj.DealUnderlyingFundAdjustmentReasonID != 4)
)
--and isnull(dufink.InKindUnderlyingFundDistributionInDealID,0) <= 0
--and (isnull(uf.TerminationDate,'01/01/1900') = '01/01/1900' or isnull(uf.TerminationDate,'01/01/1900') >= @asofdate or @asofdate is null)
) as tbl where tbl.PartitionNumber = 1

--select * from @TempDealUnderlyingFundAdjustment

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
		AccruedInterestDistribution decimal(38,18),
		ReferenceDateCount int
    );

insert into @Temp(DealID,RolledForwardNAV,FMV,DirectFMV,DirectDiscountNAV,DividendDistribution_Base,TotalCapitalCall

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
,AccruedInterestDistribution
,ReferenceDateCount
)
select fedeal.DealID -- DealID Column
 
,(select isnull(sum(isnull(RolledForwardNAV,0)),0) from (
select ROW_NUMBER() OVER (PARTITION BY rfv.DealID,rfv.AssetTypeID,rfv.AssetID ORDER BY rfv.RolledForwardNAVDate desc,rfv.dm_rolled_forward_nav_id desc) as PartitionNumber
,(case when isnull(rfv.RolledForwardNAV_Base,0) <= 0 then 0 else isnull(rfv.RolledForwardNAV_Base,0) end  * isnull((select top 1 case when isnull(fx.ConversionFactor,0) = 0 then 1 else isnull(fx.ConversionFactor,0) end from FXConversionRate fx 
												join Entity ent on ent.EntityID = fx.EntityID 
												where fx.EntityID = uf.EntityID 
												--and isnull(fx.IsDefault,0) = 1 
												and ent.CurrencyID = fx.DestinationCurrencyID
												and fx.SourceCurrencyID = uf.CurrencyID
												and fx.EffectiveDate <= (CASE WHEN YEAR(@asofdate) > 1900 THEN @asofdate ELSE GETDATE() end)
												order by fx.EffectiveDate desc,fx.FXConversionRateID desc,isnull(fx.IsDefault,0) desc),1)) as RolledForwardNAV
from [dm_rolled_forward_nav] rfv 
join underlyingfund uf on uf.underlyingfundid = rfv.assetid and rfv.assettypeid = 1
join dealunderlyingfund duf on duf.dealid = rfv.dealid and duf.UnderlyingFundID = uf.UnderlyingFundID 
--left outer join InKindUnderlyingFundDistributionInDeal dufink on dufink.DealUnderlyingFundID = duf.DealUnderlyingFundID 
join DealClosing dc on dc.DealClosingID = duf.DealClosingID 
where rfv.DealID = fedeal.DealID
AND rfv.rolledforwardnavdate <= @asofdate
AND rfv.AssetTypeID = 1
--AND isnull(dufink.InKindUnderlyingFundDistributionInDealID,0) <= 0
and (isnull(uf.TerminationDate,'01/01/1900') = '01/01/1900' or isnull(uf.TerminationDate,'01/01/1900') >= @asofdate or @asofdate is null)
) as tbl2 where PartitionNumber = 1) as RolledForwardNAV -- RolledForwardNAV Column

,(
select isnull(sum(isnull(FMV,0)),0) from (
select 
ROW_NUMBER() OVER (PARTITION BY his.DealID,his.SecurityTypeID,his.SecurityID ORDER BY his.RecordDate desc) as PartitionNumber
,isnull(his.NumberOfSharesUnSold,0) * (select top 1 udlp.lastprice 
		    from UnderlyingDirectLastPriceHistory udlp where 
			udlp.dealid = his.DealID 
			and udlp.securityid = his.SecurityID and udlp.securitytypeid = his.SecurityTypeID 
			and udlp.LastPriceDate <= @asofdate
			order by udlp.LastPriceDate desc,udlp.LastPrice desc,udlp.UnderlyingDirectLastPriceID desc) as FMV
,his.* from SecurityLotSharesHistory his
where his.DealID = fedeal.DealID and his.RecordDate <= @asofdate
) as tbl3 where PartitionNumber = 1
) as FMV -- FMV Column

,(
select isnull(sum(isnull(FMV,0)),0) from (
select 
ROW_NUMBER() OVER (PARTITION BY his.DealID,his.SecurityTypeID,his.SecurityID ORDER BY his.RecordDate desc) as PartitionNumber
,isnull(his.NumberOfSharesUnSold,0) * (select top 1 udlp.lastprice 
		    from UnderlyingDirectLastPriceHistory udlp where 
			udlp.dealid = his.DealID 
			and udlp.securityid = his.SecurityID and udlp.securitytypeid = his.SecurityTypeID 
			and udlp.LastPriceDate <= @asofdate
			order by udlp.LastPriceDate desc,udlp.LastPrice desc,udlp.UnderlyingDirectLastPriceID desc) as FMV
,his.* from SecurityLotSharesHistory his
join SecurityLotHistory rootHis on rootHis.SecurityLotHistoryID = his.SecurityLotHistoryID
join SecurityLot lot on lot.SecurityLotNumber = rootHis.SecurityLotNumber --and lot.SecurityAcquisitionTypeID != 2
where his.DealID = fedeal.DealID and his.RecordDate <= @asofdate
) as tbl3 where PartitionNumber = 1
) as DirectFMV -- DirectFMV Column

,(
select isnull(sum(isnull(TotalCost,0)),0) from (
select isnull(dir.TotalCost,0) as TotalCost from DealUnderlyingDirect dir
where dir.DealID = fedeal.DealID and dir.RecordDate <= @asofdate and isnull(dir.IsSecurityConversionDetail,0) = 0 and isnull(dir.IsFollowOn,0) = 0
) as tbl) as DirectDiscountNAV -- DirectDiscountNAV Column

,(select (select sum(isnull(Amount,0)/(case when isnull(fcr.conversionfactor,0)=0 then 1 else isnull(fcr.conversionfactor,0) end)) from DividendDistribution divd 
		left outer join fxtransaction fxt on fxt.fxtransactionsourceid = divd.DividendDistributionID and fxt.fxtransactionsourcetypeid = 13 
		left outer join fxconversionrate fcr on fcr.fxconversionrateid = fxt.fxconversionrateid
		where 
		dealid = fedeal.DealID
		and isnull(UnderlyingDirectDividendDistributionID,0) > 0
		and isnull(DistributionDate,'01/01/1900') <= @asofdate
	)) as DividendDistribution --DividendDistribution Column

,(
select isnull(sum(item.totalamount),0) from [UnderlyingFundCapitalCallLineItem] item
	join underlyingfund uf on uf.underlyingfundid = item.underlyingfundid
    join [UnderlyingFundCapitalCall] ufcc on ufcc.UnderlyingFundCapitalCallID = item.UnderlyingFundCapitalCallID
	where item.DealID = fedeal.DealID
	and isnull(item.receiveddate,'01/01/1900') <= @asofdate
	and item.UnderlyingFundCapitalCallID IS NOT NULL
	--and (isnull(uf.TerminationDate,'01/01/1900') = '01/01/1900' or isnull(uf.TerminationDate,'01/01/1900') >= @asofdate or @asofdate is null)
	--and isnull(ufcc.IsDeemedCapitalCall,0) = 0
) as TotalCapitalCall -- TotalCapitalCall Column

,(select isnull(sum(cd.Amount),0) from [CashDistribution] cd
	join underlyingfund uf on uf.underlyingfundid = cd.underlyingfundid
	join underlyingfundcashdistribution ufcd on ufcd.underlyingfundcashdistributionid = cd.underlyingfundcashdistributionid
	where cd.DealID = fedeal.DealID
	and cd.UnderlyingFundCashDistributionID IS NOT NULL
	and isnull(ufcd.receiveddate,'01/01/1900') <= @asofdate
	and cd.CashDistributionTypeID = 3
	--and (isnull(uf.TerminationDate,'01/01/1900') = '01/01/1900' or isnull(uf.TerminationDate,'01/01/1900') >= @asofdate or @asofdate is null)
	) as RegularDistribution

,(select isnull(sum(cd.Amount),0) from [CashDistribution] cd
	join underlyingfund uf on uf.underlyingfundid = cd.underlyingfundid
	join underlyingfundcashdistribution ufcd on ufcd.underlyingfundcashdistributionid = cd.underlyingfundcashdistributionid
	where cd.DealID = fedeal.DealID
	and cd.UnderlyingFundCashDistributionID IS NOT NULL
	and isnull(ufcd.receiveddate,'01/01/1900') <= @asofdate
	and cd.CashDistributionTypeID in (2,4,5,6)
	--and (isnull(uf.TerminationDate,'01/01/1900') = '01/01/1900' or isnull(uf.TerminationDate,'01/01/1900') >= @asofdate or @asofdate is null)
	) as STND_Distribution

,(select isnull(sum(cd.Amount),0) from [CashDistribution] cd
	join underlyingfund uf on uf.underlyingfundid = cd.underlyingfundid
	join underlyingfundcashdistribution ufcd on ufcd.underlyingfundcashdistributionid = cd.underlyingfundcashdistributionid
	where cd.DealID = fedeal.DealID
	and cd.UnderlyingFundCashDistributionID IS NOT NULL
	and isnull(ufcd.receiveddate,'01/01/1900') <= @asofdate
	and cd.CashDistributionTypeID = 1
	--and (isnull(uf.TerminationDate,'01/01/1900') = '01/01/1900' or isnull(uf.TerminationDate,'01/01/1900') >= @asofdate or @asofdate is null)
	) as Deemed_Distribution

,(select isnull(sum(his.finalsaleamount),0)
			from underlyingfundstockdistributionlineitem ufitem
			join underlyingfundstockdistribution ufsd on ufsd.underlyingfundstockdistributionid = ufitem.underlyingfundstockdistributionid
			join underlyingfund uf on uf.underlyingfundid = ufsd.underlyingfundid
			join securitylot lot on lot.securityacquisitionid = ufitem.underlyingfundstockdistributionlineitemid and lot.securityacquisitiontypeid = 2
			join securitylothistory his on his.securitylotnumber = lot.securitylotnumber and his.securitylothistoryreason = 3
			join deal d on d.dealid = ufitem.dealid
			where ufitem.dealid = fedeal.dealid
			and his.securitylothistoryreason = 3
			and his.SecurityDistributionTypeID in (2,5,6,7)
			and isnull(ufitem.IsSecurityConversionDetail,0) = 0
			and isnull(ufitem.UnderlyingFundStockDistributionID,0) > 0
			and isnull(his.RecordDate,'01/01/1900') <= @asofdate
			--and (isnull(uf.TerminationDate,'01/01/1900') = '01/01/1900' or isnull(uf.TerminationDate,'01/01/1900') >= @asofdate or @asofdate is null)
			) as STND_UnderlyingFundStockDistribution

,(select isnull(sum(isnull(his.finalsaleamount,0)),0)
			from underlyingfundstockdistributionlineitem ufitem
			join underlyingfundstockdistribution ufsd on ufsd.underlyingfundstockdistributionid = ufitem.underlyingfundstockdistributionid
			join underlyingfund uf on uf.underlyingfundid = ufsd.underlyingfundid
			join securitylot lot on lot.securityacquisitionid = ufitem.underlyingfundstockdistributionlineitemid and lot.securityacquisitiontypeid = 2
			join securitylothistory his on his.securitylotnumber = lot.securitylotnumber and his.securitylothistoryreason = 3
			join deal d on d.dealid = ufitem.dealid
			where ufitem.dealid = fedeal.DealID
			and his.securitylothistoryreason = 3
			and his.SecurityDistributionTypeID in (1,4)
			and isnull(ufitem.IsSecurityConversionDetail,0) = 0
			and isnull(ufitem.UnderlyingFundStockDistributionID,0) > 0
			and isnull(his.RecordDate,'01/01/1900') <= @asofdate
			--and (isnull(uf.TerminationDate,'01/01/1900') = '01/01/1900' or isnull(uf.TerminationDate,'01/01/1900') >= @asofdate or @asofdate is null)
			) as Regular_UnderlyingFundStockDistribution

,(select sum(isnull(tbl.FMV,0) + isnull(tbl.Realized,0)) as FMV from ( 
select isnull(ufsditem.FMV,0) as FMV
					,(select sum(isnull(tbl3.Amount,0)) from (select (isnull(his.numberofsharessold,0) * (isnull(his.sellprice,0) - isnull(ufsd.PurchasePrice,0)) - isnull(his.fees,0)) as Amount from securitylot lot 
					join securitylothistory his on his.securitylotnumber = lot.securitylotnumber and his.securitylothistoryreason = 3
				    where lot.securityacquisitionid = ufsditem.underlyingfundstockdistributionlineitemid and lot.securityacquisitiontypeid = 2
					and isnull(his.RecordDate,'01/01/1900') <= @asofdate
					) as tbl3) as Realized
					--,(select sum(isnull(tbl3.Amount,0)) from (select isnull(his.numberofsharessold,0) as Amount from securitylot lot 
					--join securitylothistory his on his.securitylotnumber = lot.securitylotnumber and his.securitylothistoryreason = 3
				 --   where lot.securityacquisitionid = ufsditem.underlyingfundstockdistributionlineitemid and lot.securityacquisitiontypeid = 2
					--and isnull(his.RecordDate,'01/01/1900') <= @asofdate
					--) as tbl3) as SoldShares
					--,ufsd.PurchasePrice 
					--,ufsditem.*
	 from UnderlyingFundStockDistributionLineItem ufsditem 
	 join underlyingfundstockdistribution ufsd on ufsd.underlyingfundstockdistributionid = ufsditem.underlyingfundstockdistributionid
	 join underlyingfund uf on uf.underlyingfundid = ufsd.underlyingfundid
	 where ufsditem.DealID = fedeal.DealID
	 and isnull(ufsditem.IsSecurityConversionDetail,0) = 0
	 and ufsditem.UnderlyingFundStockDistributionID IS NOT NULL
	 and isnull(ufsd.DistributionDate,'01/01/1900') <= @asofdate
	 --and (isnull(uf.TerminationDate,'01/01/1900') = '01/01/1900' or isnull(uf.TerminationDate,'01/01/1900') >= @asofdate or @asofdate is null)
	 ) as tbl
	 ) as Realized_UnderlyingFundStockDistribution_FMV

,(select isnull(sum(isnull(ufsl.netsellprice,0)),0)
			from underlyingfundsalelineitem ufsl
			join underlyingfundsale ufs on ufs.underlyingfundsaleid = ufsl.underlyingfundsaleid
			join underlyingfund uf on uf.underlyingfundid = ufs.underlyingfundid
			join deal d on d.dealid = ufsl.dealid
			where ufsl.dealid = fedeal.dealid
			and isnull(ufs.[SellDate],'01/01/1900') <=  @asofdate
			--and (isnull(uf.TerminationDate,'01/01/1900') = '01/01/1900' or isnull(uf.TerminationDate,'01/01/1900') >= @asofdate or @asofdate is null)
			) as UnderlyingFund_Sale

,(select isnull(sum(isnull(finalsaleamount,0)),0) from securitylothistory his
		join securitylot lot on lot.securitylotnumber = his.securitylotnumber
		where lot.dealid = fedeal.dealid
		and his.securitylothistoryreason = 3
		and his.SecurityDistributionTypeID in (1,4)
		and lot.securityacquisitiontypeid = 1 
		and isnull(his.recorddate,'01/01/1900') <=  @asofdate
		) as DealUnderlyingDirect_Sale

,(select isnull(sum(isnull(finalsaleamount,0)),0) from securitylothistory his
		join securitylot lot on lot.securitylotnumber = his.securitylotnumber
		where lot.dealid = fedeal.dealid
		and his.securitylothistoryreason = 3
		and his.SecurityDistributionTypeID in (2,5,6,7)
		and lot.securityacquisitiontypeid = 1
		and isnull(his.recorddate,'01/01/1900') <=  @asofdate) as DealUnderlyingDirect_STND_Sale

,(select isnull(sum(isnull(Amount,0)),0) from DividendDistribution 
		where 
        dealid = fedeal.dealid 
		and isnull(UnderlyingDirectDividendDistributionID,0) > 0
		and isnull(DistributionDate,'01/01/1900') <= @asofdate) as DividendDistribution

,(select isnull(sum(FMV),0) from (
   	select 
   	isnull(dditem.FMV,0) as FMV
   	from [DirectDistributionLineItem] dditem
   	join DirectDistribution dd on dd.DirectDistributionID = dditem.DirectDistributionID
   	where dditem.dealid = fedeal.dealid 
   	and isnull(dd.DistributionDate,'01/01/1900') <= @asofdate
   	) as tbl5) as DirectDistribution

,(select isnull(sum(isnull(fe.amount,0)),0)
			from fundexpense fe
			join deal d on d.dealid = fe.dealid
			where fe.dealid = fedeal.dealid
			and isnull(fe.IsReceived,0) = 1
			and isnull(fe.[Date],'01/01/1900') <= @asofdate) as DealFundExpense

,(select isnull(sum(isnull(dc.Amount,0)),0) from DealClosingCost dc where dc.DealID = fedeal.dealid and dc.[Date] <= @asofdate) as ClosingCosts -- ClosingCosts Column

--,(select sum(isnull(Amount,0)) from (
--select isnull(item.Amount,0) as Amount from DealClosingCostDistributionLineItem item
--join DealClosingCostDistribution dist on dist.DealClosingCostDistributionID = item.DealClosingCostDistributionID
--join DealClosingCost dc on dc.DealClosingCostID = dist.DealClosingCostID
--join DealUnderlyingFund duf on duf.DealUnderlyingFundID = item.DealUnderlyingFundID 
--where duf.DealID = fedeal.dealid
--and item.DistributionDate <= @asofdate
--and duf.DealUnderlyingFundID in (
--select DealUnderlyingFundID from (
--select 
--dufc.DealUnderlyingFundID
--from DealUnderlyingFundClosing dufc
--join dealunderlyingfund duf on duf.dealunderlyingfundid = dufc.dealunderlyingfundid
--join dealclosing dc on dc.dealclosingid = dufc.dealclosingid
--where duf.DealID = fedeal.dealid
--and duf.DealClosingID > 0
--and isnull(duf.IsMultipleClose,0) = 1
--and isnull(dc.CloseDate,'01/01/1900') <= @asofdate
--union all
--select duf.DealUnderlyingFundID from dealunderlyingfund duf 
--	join dealclosing dc on duf.DealClosingID = dc.DealClosingID 
--	where duf.dealid = fedeal.dealid
--	and duf.DealClosingID > 0
--	and isnull(duf.IsMultipleClose,0) = 0
--	and isnull(dc.CloseDate,'01/01/1900') <= @asofdate
--) as tbl group by DealUnderlyingFundID	
--)
--union all
--select isnull(item.Amount,0) as Amount from DealClosingCostDistributionLineItem item
--join DealClosingCostDistribution dist on dist.DealClosingCostDistributionID = item.DealClosingCostDistributionID
--join DealClosingCost dc on dc.DealClosingCostID = dist.DealClosingCostID
--join DealUnderlyingDirect dud on dud.DealUnderlyingDirectID = item.DealUnderlyingDirectID 
--where dud.DealID = fedeal.dealid
--and item.DistributionDate <= @asofdate
--and dud.DealUnderlyingDirectID in (
--select DealUnderlyingDirectID from (
--select 
--dufc.DealUnderlyingDirectID
--from DealUnderlyingDirectClosing dufc
--join DealUnderlyingDirect duf on duf.DealUnderlyingDirectid = dufc.DealUnderlyingDirectid
--join dealclosing dc on dc.dealclosingid = dufc.dealclosingid
--where duf.DealID = fedeal.dealid
--and duf.DealClosingID > 0
--and isnull(duf.IsMultipleClose,0) = 1
--and isnull(dc.CloseDate,'01/01/1900') <= @asofdate
--union all
--select duf.DealUnderlyingDirectID from DealUnderlyingDirect duf 
--	join dealclosing dc on duf.DealClosingID = dc.DealClosingID 
--	where duf.dealid = fedeal.dealid
--	and duf.DealClosingID > 0
--	and isnull(duf.IsMultipleClose,0) = 0
--	and isnull(dc.CloseDate,'01/01/1900') <= @asofdate
--) as tbl group by DealUnderlyingDirectID	
--)
--) as tbl2) as ClosingCosts_New -- ClosingCosts Column
 

--- START NET PURCHASE PRICE --
,(select sum(isnull(NetPurchasePrice,0)) from (
select 
--npp_fund.FundName
--,npp_deal.DealNumber
--,npp_deal.DealName
--,npp_uf.FundName as UnderlyingFund
--,'' as Direct
--,'' as Symbol
--,isnull(npp_duf.IsMultipleClose,0) as MultiClose

--,isnull(npp_duf.OriginalGrossPurchasePrice,0) as OriginalGrossPurchasePrice

--,(select isnull(sum(isnull(followon.GrossPurchasePrice,0)),0) from DealUnderlyingFundFollowOn followon where followon.dealid = npp_deal.dealid and followon.underlyingfundid = npp_duf.UnderlyingFundID and followon.recorddate <= @asofdate) as FollowOnGPP

--,(select isnull(sum(item.totalamount),0) from underlyingfundcapitalcalllineitem item
--where item.DealID = npp_deal.DealID 
--and isnull(item.UnderlyingFundCapitalCallID,0) <= 0
--and isnull(item.receiveddate,'01/01/1900') <= @asofdate) as PostRecordCapitalCall

--,(select isnull(sum(item.Amount),0) from cashdistribution item
--where item.DealID =  npp_deal.DealID 
--and item.UnderlyingFundID = npp_duf.UnderlyingFundID 
--and isnull(item.UnderlyingFundCashDistributionID,0) <= 0
--and isnull(item.distributiondate,'01/01/1900') <= @asofdate) as PostRecordCashDistribution

--,0 as FMV
--,0 as PostRecordCashFlow
--,

(
(
isnull(npp_duf.OriginalGrossPurchasePrice,0)
+
(select isnull(sum(isnull(GrossPurchasePrice,0)),0) from DealUnderlyingFundFollowOn followon where followon.dealid = npp_deal.dealid and followon.underlyingfundid = npp_duf.UnderlyingFundID and followon.recorddate <= @asofdate)
+
0
)
+
(select isnull(sum(item.totalamount),0) from underlyingfundcapitalcalllineitem item
where item.DealID = npp_deal.DealID 
and item.UnderlyingFundID = npp_duf.UnderlyingFundID
and isnull(item.UnderlyingFundCapitalCallID,0) <= 0
and isnull(item.receiveddate,'01/01/1900') <= @asofdate)
-
(select isnull(sum(item.Amount),0) from cashdistribution item
where item.DealID =  npp_deal.DealID 
and item.UnderlyingFundID = npp_duf.UnderlyingFundID 
and isnull(item.UnderlyingFundCashDistributionID,0) <= 0
and isnull(item.distributiondate,'01/01/1900') <= @asofdate)
-
0
) as NetPurchasePrice 

from DealUnderlyingFund npp_duf
join underlyingfund uf on uf.underlyingfundid = npp_duf.underlyingfundid
--left outer join InKindUnderlyingFundDistributionInDeal dufink on dufink.DealUnderlyingFundID = npp_duf.DealUnderlyingFundID 
join Deal npp_deal on npp_deal.DealID = npp_duf.DealID
join Fund npp_fund on npp_deal.FundID = npp_fund.FundID
join UnderlyingFund npp_uf on npp_duf.UnderlyingFundID = npp_uf.UnderlyingFundID
join DealClosing npp_dealclose on npp_dealclose.DealClosingID = npp_duf.DealClosingID 
where npp_duf.DealID = fedeal.DealID 
and isnull(npp_duf.IsMultipleClose,0) = 0
--and isnull(dufink.InKindUnderlyingFundDistributionInDealID,0) <= 0
and (isnull(npp_dealclose.CloseDate,'01/01/1900') <= @asofdate or (isnull(npp_duf.EffectiveDate,'01/01/1900') <= @asofdate and isnull(npp_duf.EffectiveDate,'01/01/1900') > '01/01/1900'))
--and (isnull(uf.TerminationDate,'01/01/1900') = '01/01/1900' or isnull(uf.TerminationDate,'01/01/1900') >= @asofdate or @asofdate is null)
union all
select 
--npp_fund.FundName
--,npp_deal.DealNumber
--,npp_deal.DealName
--,npp_uf.FundName as UnderlyingFund
--,'' as Direct
--,'' as Symbol
--,isnull(npp_duf.IsMultipleClose,0) as MultiClose

--,0 as OriginalGrossPurchasePrice

--,(select isnull(sum(isnull(followon.GrossPurchasePrice,0)),0) from DealUnderlyingFundFollowOn followon where followon.dealid = npp_deal.dealid and followon.underlyingfundid = npp_duf.UnderlyingFundID and followon.recorddate <= @asofdate) as FollowOnGPP

--,isnull(dufclosing.PostRecordDateCapitalCall,0) as PostRecordCapitalCall

--,isnull(dufclosing.PostRecordDateDistribution,0) as PostRecordCashDistribution

--,0 as FMV
--,0 as PostRecordCashFlow
--,
dufclosing.NetPurchasePrice  as NetPurchasePrice 

from DealUnderlyingFund npp_duf
join underlyingfund uf on uf.underlyingfundid = npp_duf.underlyingfundid
--left outer join InKindUnderlyingFundDistributionInDeal dufink on dufink.DealUnderlyingFundID = npp_duf.DealUnderlyingFundID 
join Deal npp_deal on npp_deal.DealID = npp_duf.DealID
join Fund npp_fund on npp_deal.FundID = npp_fund.FundID
join UnderlyingFund npp_uf on npp_duf.UnderlyingFundID = npp_uf.UnderlyingFundID
join DealUnderlyingFundClosing dufclosing on dufclosing.DealUnderlyingFundID = npp_duf.DealUnderlyingFundID 
join DealClosing npp_dealclose on npp_dealclose.DealClosingID = dufclosing.DealClosingID 

where npp_duf.DealID = fedeal.DealID 
and isnull(npp_duf.IsMultipleClose,0) = 1
and npp_dealclose.CloseDate <= @asofdate 
--and isnull(dufink.InKindUnderlyingFundDistributionInDealID,0) <= 0
--and (isnull(uf.TerminationDate,'01/01/1900') = '01/01/1900' or isnull(uf.TerminationDate,'01/01/1900') >= @asofdate or @asofdate is null)
union all

select 
--npp_fund.FundName
--,npp_deal.DealNumber
--,npp_deal.DealName
--,'' UnderlyingFund
--,npp_iss.[Name] as Direct
--,npp_eq.Symbol as Symbol
--,isnull(npp_dud.IsMultipleClose,0) as MultiClose
--,0 as OriginalGrossPurchasePrice
--,0 as FollowOnGPP
--,0 as PostRecordCapitalCall
--,0 as PostRecordCashDistribution

--,isnull(npp_dud.FMV,0) as FMV

--,(select isnull(sum(item.Amount),0) from PostRecordCashFlow item
--where item.DealID = npp_dud.DealID
--and item.SecurityTypeID = npp_dud.SecurityTypeID
--and item.SecurityID = npp_dud.SecurityID
--and isnull(item.RecordDate,'01/01/1900') <= @asofdate) as PostRecordCashFlow
--,

(
(
isnull(npp_dud.TotalCost,0) 
)
+
0
-
0
-
(select isnull(sum(item.Amount),0) from PostRecordCashFlow item
where item.DealID = npp_dud.DealID
and item.SecurityTypeID = npp_dud.SecurityTypeID
and item.SecurityID = npp_dud.SecurityID
and isnull(item.RecordDate,'01/01/1900') <= @asofdate)
) as NetPurchasePrice 

from DealUnderlyingDirect npp_dud
join Deal npp_deal on npp_deal.DealID = npp_dud.DealID
join Fund npp_fund on npp_deal.FundID = npp_fund.FundID
join SecuritySymbol npp_sym on npp_sym.SecurityTypeID = npp_dud.SecurityTypeID and npp_sym.SecurityID = npp_dud.SecurityID
join DealClosing dudclose on dudclose.DealClosingID = npp_dud.DealClosingID 
left outer join SecurityConversionDetail secdet on secdet.OldSecurityConversionTypeID = 2 and secdet.OldSecurityConversionSourceID = npp_dud.DealUnderlyingDirectID
left outer join SecurityConversion sec on sec.SecurityConversionID = secdet.SecurityConversionID and sec.ConversionDate <= @asofdate
where npp_dud.DealID = fedeal.DealID
and isnull(npp_dud.IsMultipleClose,0) = 0
and (isnull(dudclose.CloseDate,'01/01/1900') <= @asofdate or (isnull(npp_dud.RecordDate,'01/01/1900') <= @asofdate and isnull(npp_dud.RecordDate,'01/01/1900') > '01/01/1900'))
and isnull(secdet.SecurityConversionDetailID,0) <= 0
 
union all

select 
--npp_fund.FundName
--,npp_deal.DealNumber
--,npp_deal.DealName
--,'' UnderlyingFund
--,npp_iss.[Name] as Direct
--,npp_eq.Symbol as Symbol
--,isnull(npp_dud.IsMultipleClose,0) as MultiClose
--,0 as OriginalGrossPurchasePrice
--,0 as FollowOnGPP
--,0 as PostRecordCapitalCall
--,0 as PostRecordCashDistribution

--,(isnull(dudclosing.ClosedNumberOfShares,0) * isnull(npp_dud.PurchasePrice,0)) as FMV

--,isnull(dudclosing.PostRecordDateCashFlow,0) as PostRecordCashFlow
--,
(isnull(dudclosing.ClosedNumberOfShares,0) * isnull(npp_dud.PurchasePrice,0)) - isnull(dudclosing.PostRecordDateCashFlow,0)  as NetPurchasePrice 

from DealUnderlyingDirect npp_dud
join Deal npp_deal on npp_deal.DealID = npp_dud.DealID
join Fund npp_fund on npp_deal.FundID = npp_fund.FundID
join SecuritySymbol npp_sym on npp_sym.SecurityTypeID = npp_dud.SecurityTypeID and npp_sym.SecurityID = npp_dud.SecurityID
join DealUnderlyingDirectClosing dudclosing on dudclosing.DealUnderlyingDirectID = npp_dud.DealUnderlyingDirectID 
join DealClosing dudclose on dudclose.DealClosingID = dudclosing.DealClosingID 
left outer join SecurityConversionDetail secdet on secdet.OldSecurityConversionTypeID = 2 and secdet.OldSecurityConversionSourceID = npp_dud.DealUnderlyingDirectID 
left outer join SecurityConversion sec on sec.SecurityConversionID = secdet.SecurityConversionID and sec.ConversionDate <= @asofdate
where npp_dud.DealID = fedeal.DealID
and isnull(npp_dud.IsMultipleClose,0) = 1
and dudclose.CloseDate <= @asofdate 
and isnull(secdet.SecurityConversionDetailID,0) <= 0

) as npp_tbl) as NetPurchasePrice

-- END NET PURCHASE PRICE --

,(
select sum(isnull(cnt,0)) as cnt from (
	(select count(*) as cnt from (
select DealUnderlyingFundID from (
select 
dufc.DealUnderlyingFundID
from DealUnderlyingFundClosing dufc
join dealunderlyingfund duf on duf.dealunderlyingfundid = dufc.dealunderlyingfundid
--left outer join InKindUnderlyingFundDistributionInDeal dufink on dufink.DealUnderlyingFundID = duf.DealUnderlyingFundID
join dealclosing dc on dc.dealclosingid = dufc.dealclosingid
where duf.DealID = fedeal.dealid  
and duf.DealClosingID > 0
and isnull(duf.IsMultipleClose,0) = 1
and isnull(dc.CloseDate,'01/01/1900') <= @asofdate --or (isnull(duf.EffectiveDate,'01/01/1900') <= @asofdate and isnull(duf.EffectiveDate,'01/01/1900') > '01/01/1900'))
--and isnull(dufink.InKindUnderlyingFundDistributionInDealID,0) <= 0
union all
select duf.DealUnderlyingFundID from dealunderlyingfund duf 
	join dealclosing dc on duf.DealClosingID = dc.DealClosingID 
	--left outer join InKindUnderlyingFundDistributionInDeal dufink on dufink.DealUnderlyingFundID = duf.DealUnderlyingFundID
	where duf.dealid = fedeal.dealid 
	and duf.DealClosingID > 0
	and isnull(duf.IsMultipleClose,0) = 0
	--and isnull(dufink.InKindUnderlyingFundDistributionInDealID,0) <= 0
	and (isnull(dc.CloseDate,'01/01/1900') <= @asofdate or (isnull(duf.EffectiveDate,'01/01/1900') <= @asofdate and isnull(duf.EffectiveDate,'01/01/1900') > '01/01/1900'))
) as tbl group by DealUnderlyingFundID	
) as tbl2) 
union all
(select count(*) as cnt from (
select IssuerID from (
select 
dud_sym.IssuerID as IssuerID  
from dealunderlyingdirectclosing dudc
join dealunderlyingdirect dud on dud.dealunderlyingdirectid = dudc.dealunderlyingdirectid
join SecuritySymbol dud_sym on dud_sym.SecurityTypeID = dud.SecurityTypeID and dud_sym.SecurityID = dud.SecurityID
join dealclosing dc on dc.dealclosingid = dudc.dealclosingid
where dud.DealID = fedeal.dealid   
and dud.DealclosingID > 0
and isnull(dud.IsMultipleClose,0) = 1
and isnull(dc.CloseDate,'01/01/1900') <= @asofdate
union all
select dud_sym.IssuerID as IssuerID  from dealunderlyingdirect dud 
	join dealclosing dc on dud.DealclosingID = dc.DealclosingID 
	join SecuritySymbol dud_sym on dud_sym.SecurityTypeID = dud.SecurityTypeID and dud_sym.SecurityID = dud.SecurityID
	where dud.dealid = fedeal.dealid  
	and dud.DealclosingID > 0
	and isnull(dud.IsMultipleClose,0) = 0
	and (isnull(dc.CloseDate,'01/01/1900') <= @asofdate or (isnull(dud.RecordDate,'01/01/1900') <= @asofdate and isnull(dud.RecordDate,'01/01/1900') > '01/01/1900'))
) as tbl group by IssuerID	
) as tbl2)
union all
select isnull(count(*),0) from SecurityLotSharesHistory slsh
where slsh.dealid = fedeal.dealid
and slsh.recorddate <= @asofdate
) as tblClosing) as ClosingRecordCount -- ClosingRecordCount Column

,(
select isnull(sum(item.totalamount),0) from [UnderlyingFundCapitalCallLineItem] item
	join underlyingfund uf on uf.underlyingfundid = item.underlyingfundid
    join [UnderlyingFundCapitalCall] ufcc on ufcc.UnderlyingFundCapitalCallID = item.UnderlyingFundCapitalCallID
	where item.DealID = fedeal.DealID
	and isnull(item.receiveddate,'01/01/1900') <= @asofdate
	and item.UnderlyingFundCapitalCallID IS NOT NULL
	and isnull(ufcc.IsDeemedCapitalCall,0) = 1
	--and (isnull(uf.TerminationDate,'01/01/1900') = '01/01/1900' or isnull(uf.TerminationDate,'01/01/1900') >= @asofdate or @asofdate is null)
) as DeemedCapitalCall -- DeemedCapitalCall Column

--,(select isnull(sum(cd.Amount),0) from [CashDistribution] cd
--	join underlyingfund uf on uf.underlyingfundid = cd.underlyingfundid
--	join underlyingfundcashdistribution ufcd on ufcd.underlyingfundcashdistributionid = cd.underlyingfundcashdistributionid
--	where cd.DealID = fedeal.DealID
--	and cd.UnderlyingFundCashDistributionID IS NOT NULL
--	and isnull(ufcd.receiveddate,'01/01/1900') <= @asofdate
--	and cd.CashDistributionTypeID = 1
--	--and (isnull(uf.TerminationDate,'01/01/1900') = '01/01/1900' or isnull(uf.TerminationDate,'01/01/1900') >= @asofdate or @asofdate is null)
--	) as DeemedDistribution --DeemedDistribution Column

,(select isnull(sum(ufsditem.FMV),0) from UnderlyingFundStockDistributionLineItem ufsditem 
	 join underlyingfund uf on uf.underlyingfundid = ufsditem.underlyingfundid
	 join underlyingfundstockdistribution ufsd on ufsd.underlyingfundstockdistributionid = ufsditem.underlyingfundstockdistributionid
	 where ufsditem.DealID = fedeal.DealID
	 and isnull(ufsditem.IsSecurityConversionDetail,0) = 0
	 and ufsditem.UnderlyingFundStockDistributionID IS NOT NULL
	 and isnull(ufsd.DistributionDate,'01/01/1900') <= @asofdate
	 --and (isnull(uf.TerminationDate,'01/01/1900') = '01/01/1900' or isnull(uf.TerminationDate,'01/01/1900') >= @asofdate or @asofdate is null)
	 ) as StockDistribution -- StockDistribution column

,(select isnull(sum(isnull(finalsaleamount,0)),0) from securitylothistory his
		join securitylot lot on lot.securitylotnumber = his.securitylotnumber
		where lot.dealid = fedeal.dealid
		and his.securitylothistoryreason = 3
		and isnull(his.recorddate,'01/01/1900') <=  @asofdate) as StockSales -- StockSales Column


,(select sum(isnull(duf.RecordDateNAV,0)) from dealunderlyingfund duf 
	join underlyingfund uf on uf.underlyingfundid = duf.underlyingfundid
	--left outer join InKindUnderlyingFundDistributionInDeal dufink on dufink.DealUnderlyingFundID = duf.DealUnderlyingFundID
	join DealClosing dc on dc.DealClosingID = duf.DealClosingID
	where duf.dealid = fedeal.dealid and duf.dealclosingid > 0
	--and isnull(dufink.InKindUnderlyingFundDistributionInDealID,0) <= 0
	and (isnull(dc.CloseDate,'01/01/1900') <= @asofdate or (isnull(duf.EffectiveDate,'01/01/1900') <= @asofdate and isnull(duf.EffectiveDate,'01/01/1900') > '01/01/1900'))
	--and (isnull(uf.TerminationDate,'01/01/1900') = '01/01/1900' or isnull(uf.TerminationDate,'01/01/1900') >= @asofdate or @asofdate is null)
	) as RecordDateNAV  --  RecordDateNAV Column

,(select sum(isnull(duf.RecordDateNAV,0)) from dealunderlyingfund duf 
	join underlyingfund uf on uf.underlyingfundid = duf.underlyingfundid
	--left outer join InKindUnderlyingFundDistributionInDeal dufink on dufink.DealUnderlyingFundID = duf.DealUnderlyingFundID
	join DealClosing dc on dc.DealClosingID = duf.DealClosingID
	where duf.dealid = fedeal.dealid and duf.dealclosingid > 0
	--and isnull(dufink.InKindUnderlyingFundDistributionInDealID,0) <= 0
	and (isnull(dc.CloseDate,'01/01/1900') <= @asofdate or (isnull(duf.EffectiveDate,'01/01/1900') <= @asofdate and isnull(duf.EffectiveDate,'01/01/1900') > '01/01/1900'))
	and isnull(duf.IsIncludeDiscountCalc,0) = 1
	--and (isnull(uf.TerminationDate,'01/01/1900') = '01/01/1900' or isnull(uf.TerminationDate,'01/01/1900') >= @asofdate or @asofdate is null)
	) as IncludeDiscountRFNAV  --  IncludeDiscountRFNAV Column

,(select count(*) as cnt from (select distinct DealUnderlyingFundID from @TempDealUnderlyingFund duf where duf.DealID = fedeal.dealid) as tbl) as DealUnderlyingFundCount --  DealUnderlyingFundCount Column
,case when 
(select count(*) as cnt from (select distinct DealUnderlyingFundID from @TempDealUnderlyingFund duf where duf.DealID = fedeal.dealid and isnull(duf.isprimary,0) = 1) as tbl) > 0
and
(select count(*) as cnt from (select distinct DealUnderlyingFundID from @TempDealUnderlyingFund duf where duf.DealID = fedeal.dealid and isnull(duf.isprimary,0) = 0) as tbl) > 0 then 'Mixed' else 
case when (select count(*) as cnt from (select distinct DealUnderlyingFundID from @TempDealUnderlyingFund duf where duf.DealID = fedeal.dealid and isnull(duf.isprimary,0) = 0) as tbl) > 0 then 'Yes' else 'No' end 
end
as SecondaryAsset

,(select count(*) as cnt from (
select IssuerID from (
select 
dud_sym.IssuerID as IssuerID  
from dealunderlyingdirectclosing dudc
join dealunderlyingdirect dud on dud.dealunderlyingdirectid = dudc.dealunderlyingdirectid
left outer join SecuritySymbol dud_sym on dud_sym.SecurityTypeID = dud.SecurityTypeID and dud_sym.SecurityID = dud.SecurityID
join dealclosing dc on dc.dealclosingid = dudc.dealclosingid
where dud.DealID = fedeal.dealid  
and dud.DealclosingID > 0
and isnull(dud.IsMultipleClose,0) = 1
and isnull(dc.CloseDate,'01/01/1900') <= @asofdate --or (isnull(dud.RecordDate,'01/01/1900') <= @asofdate and isnull(dud.RecordDate,'01/01/1900') > '01/01/1900'))
union all
select dud_sym.IssuerID as IssuerID  from dealunderlyingdirect dud 
	join dealclosing dc on dud.DealclosingID = dc.DealclosingID 
	left outer join SecuritySymbol dud_sym on dud_sym.SecurityTypeID = dud.SecurityTypeID and dud_sym.SecurityID = dud.SecurityID
	where dud.dealid = fedeal.dealid 
	and dud.DealclosingID > 0
	and isnull(dud.IsMultipleClose,0) = 0
	and (isnull(dc.CloseDate,'01/01/1900') <= @asofdate or (isnull(dud.RecordDate,'01/01/1900') <= @asofdate and isnull(dud.RecordDate,'01/01/1900') > '01/01/1900'))
union all
select ufsd_sym.IssuerID as IssuerID  from UnderlyingFundStockDistribution ufsd 
	join UnderlyingFundStockDistributionLineItem item on item.UnderlyingFundStockDistributionID = ufsd.UnderlyingFundStockDistributionID 
	left outer join SecuritySymbol ufsd_sym on ufsd_sym.SecurityTypeID = ufsd.SecurityTypeID and ufsd_sym.SecurityID = ufsd.SecurityID
	where item.dealid = fedeal.dealid 
	and (isnull(ufsd.DistributionDate,'01/01/1900') <= @asofdate or (isnull(ufsd.DistributionDate,'01/01/1900') <= @asofdate and isnull(ufsd.DistributionDate,'01/01/1900') > '01/01/1900')) 
	union all
select ufsd_sym.IssuerID as IssuerID  from DirectDistribution ufsd 
	join DirectDistributionLineItem item on item.DirectDistributionID = ufsd.DirectDistributionID 
	left outer join SecuritySymbol ufsd_sym on ufsd_sym.SecurityTypeID = ufsd.SecurityTypeID and ufsd_sym.SecurityID = ufsd.SecurityID
	where item.dealid = fedeal.dealid 
	and (isnull(ufsd.DistributionDate,'01/01/1900') <= @asofdate or (isnull(ufsd.DistributionDate,'01/01/1900') <= @asofdate and isnull(ufsd.DistributionDate,'01/01/1900') > '01/01/1900')) 
) as tbl group by IssuerID	
) as tbl2) as DealUnderlyingDirectCount  --  DealUnderlyingDirectCount Column

,(select isnull(sum(isnull(duf.GrossPurchasePrice,0)),0) from dealunderlyingfund duf
join underlyingfund uf on uf.underlyingfundid = duf.underlyingfundid
--left outer join InKindUnderlyingFundDistributionInDeal dufink on dufink.DealUnderlyingFundID = duf.DealUnderlyingFundID
join DealClosing dc on dc.DealClosingID = duf.DealClosingID
where duf.dealid = fedeal.dealid and duf.dealclosingid > 0
and (isnull(dc.CloseDate,'01/01/1900') <= @asofdate or (isnull(duf.EffectiveDate,'01/01/1900') <= @asofdate and isnull(duf.EffectiveDate,'01/01/1900') > '01/01/1900'))
--and isnull(dufink.InKindUnderlyingFundDistributionInDealID,0) <= 0
--and (isnull(uf.TerminationDate,'01/01/1900') = '01/01/1900' or isnull(uf.TerminationDate,'01/01/1900') >= @asofdate or @asofdate is null)
) as GrossPurchasePrice --GrossPurchasePrice

,(select isnull(sum(isnull(duf.GrossPurchasePrice,0)),0) from dealunderlyingfund duf
join underlyingfund uf on uf.underlyingfundid = duf.underlyingfundid
--left outer join InKindUnderlyingFundDistributionInDeal dufink on dufink.DealUnderlyingFundID = duf.DealUnderlyingFundID
join DealClosing dc on dc.DealClosingID = duf.DealClosingID
where duf.dealid = fedeal.dealid and duf.dealclosingid > 0
and (isnull(dc.CloseDate,'01/01/1900') <= @asofdate or (isnull(duf.EffectiveDate,'01/01/1900') <= @asofdate and isnull(duf.EffectiveDate,'01/01/1900') > '01/01/1900'))
--and isnull(dufink.InKindUnderlyingFundDistributionInDealID,0) <= 0
and isnull(duf.IsIncludeDiscountCalc,0) = 1
--and (isnull(uf.TerminationDate,'01/01/1900') = '01/01/1900' or isnull(uf.TerminationDate,'01/01/1900') >= @asofdate or @asofdate is null)
) as IncludeDiscountGPP --IncludeDiscountGPP

,(select isnull(sum(isnull(duf.DiscountNAV,0)),0) from dealunderlyingfund duf
join underlyingfund uf on uf.underlyingfundid = duf.underlyingfundid
--left outer join InKindUnderlyingFundDistributionInDeal dufink on dufink.DealUnderlyingFundID = duf.DealUnderlyingFundID
join DealClosing dc on dc.DealClosingID = duf.DealClosingID
where duf.dealid = fedeal.dealid and duf.dealclosingid > 0
and (isnull(dc.CloseDate,'01/01/1900') <= @asofdate or (isnull(duf.EffectiveDate,'01/01/1900') <= @asofdate and isnull(duf.EffectiveDate,'01/01/1900') > '01/01/1900'))
--and isnull(dufink.InKindUnderlyingFundDistributionInDealID,0) <= 0
--and (isnull(uf.TerminationDate,'01/01/1900') = '01/01/1900' or isnull(uf.TerminationDate,'01/01/1900') >= @asofdate or @asofdate is null)
) as DiscountNAV --DiscountNAV

--,((select isnull(sum(case when isnull(duf.ExpectedUnfundedAmount,0) > 0  then isnull(duf.ExpectedUnfundedAmount,0) else 0 end),0) from dealunderlyingfund duf
--join underlyingfund uf on uf.underlyingfundid = duf.underlyingfundid
--left outer join InKindUnderlyingFundDistributionInDeal dufink on dufink.DealUnderlyingFundID = duf.DealUnderlyingFundID
--join DealClosing dc on dc.DealClosingID = duf.DealClosingID
--where duf.dealid = fedeal.dealid and duf.dealclosingid > 0
--and (isnull(dc.CloseDate,'01/01/1900') <= @asofdate or (isnull(duf.EffectiveDate,'01/01/1900') <= @asofdate and isnull(duf.EffectiveDate,'01/01/1900') > '01/01/1900'))
--and isnull(dufink.InKindUnderlyingFundDistributionInDealID,0) <= 0
--and (isnull(uf.TerminationDate,'01/01/1900') = '01/01/1900' or isnull(uf.TerminationDate,'01/01/1900') >= @asofdate or @asofdate is null)) -
--(select sum(isnull(prcc.amount,0)) from underlyingfundcapitalcalllineitem prcc 
--where prcc.dealid = fedeal.dealid 
----and prcc.underlyingfundid = duf.underlyingfundid 
--and isnull(prcc.underlyingfundcapitalcallid,0) <= 0 
--and (prcc.capitalcalldate <= @asofdate or @asofdate is null))
--) as CurrentExpectedUnfundedAmount2
 
,(select sum(isnull(dufadj.OriginalAdjustedExpectedUnfundedAmount,0)) 
from @TempDealUnderlyingFundAdjustment dufadj where dufadj.dealid = fedeal.dealid) as CurrentExpectedUnfundedAmount
--,0 as CurrentAdjustedExpectedUnfundedAmount
,(select sum(isnull(dufadj.CurrentExpectedUnfundedAmount,0)) 
from @TempDealUnderlyingFundAdjustment dufadj where dufadj.dealid = fedeal.dealid) as CurrentAdjustedExpectedUnfundedAmount

,(select  sum(isnull(tbldp.DeferredPaymentAmount,0)) from (
select dp.*,(select top 1 diffc.CloseDate from DealClosing diffc where diffc.dealid = dp.DealID order by diffc.CloseDate asc) as CloseDate from DealDeferredPayment dp
where dp.DealID = fedeal.dealid  
) as tbldp  where (isnull(tbldp.CloseDate,'01/01/1900') <= @asofdate and isnull(tbldp.CloseDate,'01/01/1900') > '01/01/1900')) as DeferredPaymentAmount

,(select max(isnull(tbldp.DeferredPaymentDate,'01/01/1900')) from (
select dp.*,(select top 1 diffc.CloseDate from DealClosing diffc where diffc.dealid = dp.DealID order by diffc.CloseDate asc) as CloseDate from DealDeferredPayment dp
where dp.DealID = fedeal.dealid  
) as tbldp  where (isnull(tbldp.CloseDate,'01/01/1900') <= @asofdate and isnull(tbldp.CloseDate,'01/01/1900') > '01/01/1900')) as DeferredPaymentDate

,(select isnull(sum(isnull(ad.Amount,0)),0) from AccruedInterestDistribution ad
		where 
        ad.dealid = fedeal.dealid 
		and isnull(ad.UnderlyingDirectAccruedInterestDistributionID,0) > 0
		and (isnull(ad.EndDate,'01/01/1900') <= @asofdate or @asofdate is null)
		--and ((@asofdate between isnull(StartDate,'01/01/1900') and isnull(EndDate,'01/01/1900')) or @asofdate is null)
		) as AccruedInterestDistribution
		,(select isnull(count(*),0) as cnt from (select isnull(RecordDate,'01/01/1900') as RecordDate from 
		(select duf.RecordDate as RecordDate from dealunderlyingfund duf 
--left outer join InKindUnderlyingFundDistributionInDeal ink on ink.DealUnderlyingFundID = duf.DealUnderlyingFundID 
where duf.dealid = fedeal.dealid and duf.recorddate <= @asofdate 
--and isnull(ink.InKindUnderlyingFundDistributionInDealID,0) <= 0
union all
select dud.RecordDate as RecordDate from dealunderlyingdirect dud 
where dud.dealid = fedeal.dealid and dud.recorddate <= @asofdate
) as tbl group by isnull(RecordDate,'01/01/1900')) as tbl3) as ReferenceDateCount

from deal fedeal
join @SearchDeal sd on sd.DealID = fedeal.DealID
where fedeal.EntityID = isnull(@entityId,0)

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

select DealID, DealNumber
,CAST(DealName AS NVARCHAR(MAX)) AS [Deal Name]
,CAST(DealNumber AS NVARCHAR(MAX)) AS [Deal Number]
,CAST(CostAsOfClosingDate AS NVARCHAR(MAX)) AS [Cost As Of Closing Date]
--,CAST(TotalNetPurchasePrice AS NVARCHAR(MAX)) AS [Net Purchase Price]


,RegularDistribution
,STND_Distribution
,STND_UnderlyingFundStockDistribution
,Regular_UnderlyingFundStockDistribution
,UnderlyingFund_Sale
,DealUnderlyingDirect_Sale
,DealUnderlyingDirect_STND_Sale
,DividendDistribution
,DirectDistribution 
,DealFundExpense
,TotalDistribution

,DeemedCapitalCall
,Deemed_Distribution
,StockDistribution
,StockSales

,CAST(PostCloseDistributions AS NVARCHAR(MAX)) AS [Post Close Distributions]


,CAST(PostCloseContributions AS NVARCHAR(MAX)) AS [Post Close Capital Calls]
,CAST((CostAsOfClosingDate + PostCloseContributions) AS NVARCHAR(MAX)) AS [Paid In Capital]
,CAST((EstimatedNAV + PostCloseDistributions) AS NVARCHAR(MAX)) AS [Total Value]

,CAST(CAST(ROUND((case when (CostAsOfClosingDate + PostCloseContributions) > 0 then (PostCloseDistributions / (CostAsOfClosingDate + PostCloseContributions)) else 0 end),2) as decimal(38,2)) as NVARCHAR(MAX)) as [Gross DPI]

,CAST(CAST(ROUND((case when (CostAsOfClosingDate + PostCloseContributions) > 0 then ((EstimatedNAV + PostCloseDistributions) / (CostAsOfClosingDate + PostCloseContributions)) else 0 end),2) as decimal(38,2)) as NVARCHAR(MAX)) as [Multiple]

,CAST((case when ROUND((CostAsOfClosingDate-PostCloseDistributions+PostCloseContributions),2) > 0 then ROUND((CostAsOfClosingDate-PostCloseDistributions+PostCloseContributions),2) else 0 end) AS NVARCHAR(MAX)) as [Net Cost At Current]  

--,CAST(CAST(ROUND((case when ROUND(((CostAsOfClosingDate-PostCloseDistributions)+PostCloseContributions),2) > 0 then (EstimatedNAV / ROUND(((CostAsOfClosingDate-PostCloseDistributions)+PostCloseContributions),2)) else 0 end),2) as decimal(38,2)) as NVARCHAR(MAX)) as [Recycled Multiple]

,CAST(
	CAST(case when 
		ROUND(
				((CostAsOfClosingDate + PostCloseContributions) - isnull(STND_Distribution,0) - isnull(STND_UnderlyingFundStockDistribution,0)),2) > 0 then 
			ROUND(
				(
				(EstimatedNAV + PostCloseDistributions) - isnull(STND_Distribution,0) - isnull(STND_UnderlyingFundStockDistribution,0)
				) / 
				(
				(CostAsOfClosingDate + PostCloseContributions) - isnull(STND_Distribution,0) - isnull(STND_UnderlyingFundStockDistribution,0)
				),2)
			else 0 end as decimal(38,2))
			as NVARCHAR(MAX)) as [Recycled Multiple]    

,CAST(RolledForwardNAV AS NVARCHAR(MAX)) AS [RolledForward NAV As Of Current]
,CAST(FMV AS NVARCHAR(MAX)) AS [FMV As Of Current]

,CAST(EstimatedNAV AS NVARCHAR(MAX)) AS [Estimated Nav As Of Current]
,CAST(CAST((CASE WHEN ((CostAsOfClosingDate-PostCloseDistributions)+PostCloseContributions) <> 0 THEN CAST(CASE WHEN EstimatedNAV / ((CostAsOfClosingDate-PostCloseDistributions)+PostCloseContributions) > 0 THEN
CAST(ROUND((EstimatedNAV / ((CostAsOfClosingDate-PostCloseDistributions)+PostCloseContributions)),4) AS NVARCHAR(MAX))
ELSE '0' END AS NVARCHAR(MAX)) ELSE '0' END) AS decimal(38,2)) AS NVARCHAR(MAX)) as [Recycled MOIC]

--,CAST(CASE WHEN ((CostAsOfClosingDate-PostCloseDistributions)+PostCloseContributions) <> 0 THEN CAST(CASE WHEN ((EstimatedNAV / ((CostAsOfClosingDate-PostCloseDistributions)+PostCloseContributions) > 0) and (isnull(EstimatedNAV,0) > 0)) THEN 
--CAST(CAST((1 - ((CostAsOfClosingDate-PostCloseDistributions)+PostCloseContributions) / isnull(EstimatedNAV,0) ) * 100 AS BIGINT) AS NVARCHAR(MAX))
--ELSE '0' END AS NVARCHAR(MAX)) ELSE '0' END AS NVARCHAR(MAX)) as [Recycled Discount]

,CAST(CAST(CASE WHEN IncludeDiscountRDNAV > 0 THEN CAST((1 - (IncludeDiscountRDPP / IncludeDiscountRDNAV)) * 100 AS BIGINT) ELSE 0 END AS NVARCHAR(MAX)) AS NVARCHAR(MAX)) as [Reference Date Discount]

,CAST(RecordDateNAV AS NVARCHAR(MAX)) AS [RecordDateNAV]
,CAST(DirectFMV AS NVARCHAR(MAX)) AS [DirectFMV]

,CAST(ReferenceDateNAV AS NVARCHAR(MAX)) AS [Reference Date Nav]

,CAST(ReferenceDatePurchasePrice AS NVARCHAR(MAX)) AS [Gross Purchase Price]
,CAST(CAST(CASE WHEN TotalDiscountNAV > 0 THEN CAST(Round((1 - (CostAsOfClosingDate / TotalDiscountNAV)) * 100,0) AS BIGINT) ELSE 0 END AS NVARCHAR(MAX)) AS NVARCHAR(MAX)) AS [Closing Date Discount]
,CAST(DeemedCapitalCall AS NVARCHAR(MAX)) AS [Deemed Capital Call]
,CAST(Deemed_Distribution AS NVARCHAR(MAX)) AS [Deemed Distribution]
,CAST(StockDistribution AS NVARCHAR(MAX)) AS [Stock Distribution]
,CAST(StockSales AS NVARCHAR(MAX)) AS [Stock Sales]
,CAST((EstimatedNAV + PostCloseDistributions - PostCloseContributions) as NVARCHAR(MAX)) as [Comparable NAV]
,CAST((case when isnull(((EstimatedNAV + PostCloseDistributions - PostCloseContributions) - DiscountNAV),0) = 0 then 0 else ((EstimatedNAV + PostCloseDistributions - PostCloseContributions) - DiscountNAV) end) as NVARCHAR(MAX)) as [Appreciation/Depreciation]
,CAST(CAST((case when DiscountNAV > 0 then ((((EstimatedNAV + PostCloseDistributions - PostCloseContributions) - DiscountNAV) / DiscountNAV) * 100) else 0 end) AS decimal(38,2)) as NVARCHAR(MAX)) as [Appreciation/Depreciation %]
,CAST(0 AS NVARCHAR(MAX)) as [MOIC]
,CAST(FundCount as NVARCHAR(MAX)) as [Underlying Fund Count]
,CAST(DirectCount as NVARCHAR(MAX)) as [Direct Count]
,case when DirectCount > 0 and CAST(SecondaryAsset as NVARCHAR(MAX)) = 'Yes' then 'Mixed' else CAST(SecondaryAsset as NVARCHAR(MAX)) end as [Included in deal Discount]
--,CAST(SecondaryAsset as NVARCHAR(MAX)) as [Included in deal Discount]
,CAST(ReferenceDate as NVARCHAR(MAX)) as [Reference Date]
,CAST(CloseDate as NVARCHAR(MAX)) as [Closing Date]
,CAST((case when isnull(DiscountNAV,0) > 0 then DiscountNAV else 0 end)  AS NVARCHAR(MAX)) as [NAV as of Closing Date]
,CAST((case when isnull([SellerType],'') ='' then '' else [SellerType] end) AS NVARCHAR(MAX)) AS [Seller Type]
,CAST((case when isnull([SellerGeography],'') ='' then '' else [SellerGeography] end) AS NVARCHAR(MAX)) AS [Seller Geography]
,CAST((case when isnull(CurrentExpectedUnfundedAmount,0) > 0 then CurrentExpectedUnfundedAmount else 0 end)  AS NVARCHAR(MAX)) as [Expected Unfunded at Closing]
,CAST((case when isnull(CurrentAdjustedExpectedUnfundedAmount,0) > 0 then CurrentAdjustedExpectedUnfundedAmount else 0 end)  AS NVARCHAR(MAX)) as [Expected Unfunded at Current]
--,CAST(((case when isnull(CurrentExpectedUnfundedAmount,0) > 0 then CurrentExpectedUnfundedAmount else 0 end) - isnull(PostCloseContributions,0))  AS NVARCHAR(MAX)) as [Expected Unfunded at Current]

,cast(case when (isnull(CostAsOfClosingDate,0) + (case when isnull(CurrentExpectedUnfundedAmount,0) > 0 then isnull(CurrentExpectedUnfundedAmount,0) else 0 end)) > 0 then (isnull(CostAsOfClosingDate,0) + (case when isnull(CurrentExpectedUnfundedAmount,0) > 0 then isnull(CurrentExpectedUnfundedAmount,0) else 0 end)) else 0 end as nvarchar(max)) as [Deal Size] --  CAST((case when isnull(DealSize,0) > 0 then DealSize else 0 end)  AS NVARCHAR(MAX)) as [Deal Size]

,CAST((case when isnull(DeferredPaymentAmount,0) > 0 then DeferredPaymentAmount else 0 end)  AS NVARCHAR(MAX)) as [Deferred Payment Amount]
,case when isnull(DeferredPaymentDate,'01/01/1900') > '01/01/1900' then CAST(CONVERT(NVARCHAR(10), DeferredPaymentDate, 101) as NVARCHAR(MAX)) else '' end as [Deferred Payment Date]
,CAST((case when isnull(AccruedInterestDistribution,0) > 0 then AccruedInterestDistribution else 0 end)  AS NVARCHAR(MAX)) as [Accrued Interest]
--,CAST((case when isnull([AsOfStrategy],'') ='' then '' else [AsOfStrategy] end) AS NVARCHAR(MAX)) AS [As-Of Date Strategy]
--,CAST((case when isnull([AsOfGeography],'') ='' then '' else [AsOfGeography] end) AS NVARCHAR(MAX)) AS [As-Of Date Geography]
,CAST((case when isnull(IRR,0) != 0 then CAST((IRR * 100) AS decimal(38,2)) else 0 end)  AS NVARCHAR(MAX)) as [IRR]
from (

select deal.DealID, fund.FundName as Fund, deal.DealName AS DealName, deal.DealNumber as DealNumber

,ROUND(max(isnull(dealDetail.FMV,0)),2) as FMV
,ROUND(max(isnull(dealDetail.RolledForwardNAV,0)),2) as RolledForwardNAV
,ROUND(
	max(isnull(dealDetail.RolledForwardNAV,0)) + (
		max(isnull(dealDetail.FMV,0)) - max(isnull(dealDetail.DividendDistribution_Base,0))
		),2) as EstimatedNAV
--ROUND((select sum(TotalCapitalCall) 
--from DealUnderlyingFundReport dealUFReports 
--where dealUFReports.DealID = Deal.DealID and dealUFReports.DealUnderlyingFundID > 0),2) as PostCloseContributions

,ROUND( max(isnull(dealDetail.TotalCapitalCall,0)) 
+ (case when @isaccounting = 1 then max(isnull(dealDetail.DeemedCapitalCall,0)) else 0 end) 
+ (case when @isaccounting = 1 then max(isnull(dealDetail.StockDistribution,0)) else 0 end)  ,2) as PostCloseContributions


,max(isnull(dealDetail.RegularDistribution,0)) as RegularDistribution
,max(isnull(dealDetail.STND_Distribution,0)) as STND_Distribution
,max(isnull(dealDetail.STND_UnderlyingFundStockDistribution,0)) as STND_UnderlyingFundStockDistribution
,max(isnull(dealDetail.Regular_UnderlyingFundStockDistribution,0)) as Regular_UnderlyingFundStockDistribution
,max(isnull(dealDetail.UnderlyingFund_Sale,0)) as UnderlyingFund_Sale
,max(isnull(dealDetail.DealUnderlyingDirect_Sale,0)) as DealUnderlyingDirect_Sale
,max(isnull(dealDetail.DealUnderlyingDirect_STND_Sale,0)) as DealUnderlyingDirect_STND_Sale
,max(isnull(dealDetail.DividendDistribution,0)) as DividendDistribution
,max(isnull(dealDetail.DirectDistribution,0)) as DirectDistribution
,max(isnull(dealDetail.DealFundExpense,0)) as DealFundExpense
,(
		max(isnull(dealDetail.RegularDistribution,0)) + 
		max(isnull(dealDetail.STND_Distribution,0)) +
		max(isnull(dealDetail.STND_UnderlyingFundStockDistribution,0)) +
		max(isnull(dealDetail.Regular_UnderlyingFundStockDistribution,0)) +
		max(isnull(dealDetail.UnderlyingFund_Sale,0)) +
		max(isnull(dealDetail.DealUnderlyingDirect_Sale,0)) +
		max(isnull(dealDetail.DealUnderlyingDirect_STND_Sale,0)) +
		max(isnull(dealDetail.DividendDistribution,0)) +
		max(isnull(dealDetail.DirectDistribution,0)) +
		max(isnull(dealDetail.DealFundExpense,0)) 
	) as TotalDistribution

,ROUND(max(isnull(dealDetail.DeemedCapitalCall,0)),2) as DeemedCapitalCall
,ROUND(max(isnull(dealDetail.Deemed_Distribution,0)),2) as Deemed_Distribution
,ROUND(max(isnull(dealDetail.FMV,0)),2) as StockDistribution
,ROUND(max(isnull(dealDetail.StockSales,0)),2) as StockSales
,max(isnull(dealDetail.DealUnderlyingFundCount,0)) as FundCount
,max(isnull(dealDetail.DealUnderlyingDirectCount,0)) as DirectCount
,max(dealDetail.SecondaryAsset) as SecondaryAsset

,ROUND( 
	(
		max(isnull(dealDetail.RegularDistribution,0)) + 
		max(isnull(dealDetail.STND_Distribution,0)) +
		max(isnull(dealDetail.Deemed_Distribution,0)) +
		--max(isnull(dealDetail.STND_UnderlyingFundStockDistribution,0)) +
		--max(isnull(dealDetail.Regular_UnderlyingFundStockDistribution,0)) +
		(case when isnull(@isaccounting,0) = 0 then max(isnull(dealDetail.Realized_UnderlyingFundStockDistribution_FMV,0)) else 0 end) +
		max(isnull(dealDetail.UnderlyingFund_Sale,0)) +
		max(isnull(dealDetail.DealUnderlyingDirect_Sale,0)) +
		max(isnull(dealDetail.DealUnderlyingDirect_STND_Sale,0)) +
		max(isnull(dealDetail.DividendDistribution,0)) +
		max(isnull(dealDetail.DirectDistribution,0)) +
		max(isnull(dealDetail.DealFundExpense,0)) 
	)
	--+ (case when @isaccounting = 1 then max(isnull(dealDetail.DeemedDistribution,0)) else 0 end) 
	+ (case when @isaccounting = 1 then max(isnull(dealDetail.StockDistribution,0)) else 0 end) ,2) as PostCloseDistributions


,isnull(max(isnull(dealDetail.RecordDateNAV,0)),0) as RecordDateNAV
,isnull(max(isnull(dealDetail.DirectFMV,0)),0) as DirectFMV

,isnull(max(isnull(dealDetail.IncludeDiscountRFNAV,0)),0) + isnull(max(isnull(dealDetail.DirectDiscountNAV,0)),0) as IncludeDiscountRDNAV

,isnull(max(isnull(dealDetail.RecordDateNAV,0)),0) + isnull(max(isnull(dealDetail.DirectDiscountNAV,0)),0) as ReferenceDateNAV

,ROUND(isnull(max(isnull(dealDetail.IncludeDiscountGPP,0)),0),2) + isnull(max(isnull(dealDetail.DirectDiscountNAV,0)),0) as IncludeDiscountRDPP

,ROUND(isnull(max(isnull(dealDetail.GrossPurchasePrice,0)),0),2) + isnull(max(isnull(dealDetail.DirectDiscountNAV,0)),0) as ReferenceDatePurchasePrice

,isnull(max(isnull(dealDetail.DiscountNAV,0)),0) + isnull(max(isnull(dealDetail.DirectDiscountNAV,0)),0) as TotalDiscountNAV

,max(isnull(dealDetail.NetPurchasePrice,0)) as TotalNetPurchasePrice

,ROUND((max(isnull(dealDetail.NetPurchasePrice,0)) + max(isnull(dealDetail.ClosingCosts,0))),2) as CostAsOfClosingDate

,case when (max(dealDetail.DealUnderlyingFundCount) > 0 or max(dealDetail.DealUnderlyingDirectCount) > 0) and max(ReferenceDateCount) = 1 then (select CAST(CONVERT(NVARCHAR(10), min(isnull(RecordDate,'01/01/1900')), 101) as NVARCHAR(MAX)) as RecordDate from (select duf.RecordDate as RecordDate from dealunderlyingfund duf 
--left outer join InKindUnderlyingFundDistributionInDeal ink on ink.DealUnderlyingFundID = duf.DealUnderlyingFundID 
where duf.dealid = deal.dealid and duf.recorddate <= @asofdate 
--and isnull(ink.InKindUnderlyingFundDistributionInDealID,0) <= 0
union all
select dud.RecordDate as RecordDate from dealunderlyingdirect dud 
where dud.dealid = deal.dealid and dud.recorddate <= @asofdate
union all
select dud.DistributionDate as RecordDate from UnderlyingFundStockDistribution dud 
join UnderlyingFundStockDistributionLineItem item on item.UnderlyingFundStockDistributionID = dud.UnderlyingFundStockDistributionID 
where item.dealid = deal.dealid and dud.DistributionDate <= @asofdate
union all
select dud.DistributionDate as RecordDate from DirectDistribution dud 
join DirectDistributionLineItem item on item.DirectDistributionID = dud.DirectDistributionID 
where item.dealid = deal.dealid and dud.DistributionDate <= @asofdate
) as tbl) else case when (max(dealDetail.DealUnderlyingFundCount) > 0 or max(dealDetail.DealUnderlyingDirectCount) > 0) and max(ReferenceDateCount) > 1 then 'Various' else '' end end as ReferenceDate
--,case when max(dealDetail.DealUnderlyingFundCount) > 0 then (select max(duf.RecordDate) from dealunderlyingfund duf left outer join InKindUnderlyingFundDistributionInDeal ink on ink.DealUnderlyingFundID = duf.DealUnderlyingFundID where duf.dealid = deal.dealid and duf.recorddate <= @asofdate and isnull(ink.InKindUnderlyingFundDistributionInDealID,0) <= 0 order by duf.RecordDate asc) else (select isnull(max(dud.RecordDate),'01/01/1900') from dealunderlyingdirect dud where dud.dealid = deal.dealid and dud.recorddate <= @asofdate order by dud.RecordDate) end as ReferenceDate

,(case when (select isnull(count(*),0) as cnt from DealClosing dc where dc.DealID = deal.DealID) <= 0 then '' else (case when (select count(*) as cnt from DealClosing dc where dc.DealID = deal.DealID) > 1 then 'Various' 
else (select top 1 CONVERT(VARCHAR(10),dc.CloseDate,101) as CloseDate from DealClosing dc where dc.DealID = deal.DealID order by dc.TotalPaid desc) end) end) as CloseDate
,isnull(max(isnull(dealDetail.DiscountNAV,0)),0) + isnull(max(isnull(dealDetail.DirectDiscountNAV,0)),0) as DiscountNAV
,STUFF((SELECT ',' + stype.SellerType 
	FROM DealSeller ds
	join SellerType stype on stype.SellerTypeID = ds.SellerTypeID
	WHERE ds.DealID = deal.DealID
	FOR XML PATH('')), 1, 1, '') as [SellerType]
,(select top 1 geo.DisplayName from DealSeller ds
	left outer join [Geography] geo on geo.GeographyID = ds.SellerGeographyID
	where ds.DealID = deal.DealID
	)  as [SellerGeography]
--,STUFF((SELECT ',' + st.StrategyName  
--	FROM AttributeAllocation aa
--	join Strategy st on st.StrategyID = aa.AttributeID and aa.AttributeTypeID = 3 
--	WHERE aa.AttributeImplementationTypeID = 13 and aa.AttributeImplementationID = max(deal.DealID)
--	and ((@asofdate between aa.FromDate and aa.ToDate) or @asofdate is null)
--	FOR XML PATH('')), 1, 1, '') + 
	--,(select top 1
	--min(FromDate) as MinDate,max(ToDate) as MaxDate,
--	FORMAT (min(FromDate), 'dd/MM/yyyy') + ' To ' + FORMAT (max(ToDate), 'dd/MM/yyyy') from (
--select d.DealID,st.StrategyName
--	,case when aa.FromDate > '01/01/1900' then aa.FromDate else dc.CloseDate end as FromDate
--	,case when aa.ToDate = '01/01/2100' then @asofdate else aa.FromDate end as ToDate
--	FROM AttributeAllocation aa
--	join Strategy st on st.StrategyID = aa.AttributeID and aa.AttributeTypeID = 3 
--	join @SearchDeal d on d.DealID = aa.AttributeImplementationID
--	left outer join DealClosing dc on dc.DealID = d.DealID
--	WHERE aa.AttributeImplementationTypeID = 13 
--	 and aa.AttributeImplementationID = max(deal.DealID)
--	and ((@asofdate between aa.FromDate and aa.ToDate) or @asofdate is null)
--	) as tbl ) as AsOfStrategy 
--,STUFF((SELECT ',' + geo.DisplayName
--	FROM AttributeAllocation aa
--	join [Geography] geo on geo.GeographyID = aa.AttributeID and aa.AttributeTypeID = 1 
--	WHERE aa.AttributeImplementationTypeID = 13 and aa.AttributeImplementationID = max(deal.DealID)
--	and ((@asofdate between aa.FromDate and aa.ToDate) or @asofdate is null)
--	FOR XML PATH('')), 1, 1, '') + 
--	,(select top 1
--	--min(FromDate) as MinDate,max(ToDate) as MaxDate,
--	FORMAT (min(FromDate), 'dd/MM/yyyy') + ' To ' + FORMAT (max(ToDate), 'dd/MM/yyyy') from (
--select d.DealID,geo.DisplayName
--	,case when aa.FromDate > '01/01/1900' then aa.FromDate else dc.CloseDate end as FromDate
--	,case when aa.ToDate = '01/01/2100' then @asofdate else aa.FromDate end as ToDate
--	FROM AttributeAllocation aa
--	join [Geography] geo on geo.GeographyID = aa.AttributeID and aa.AttributeTypeID = 1 
--	join @SearchDeal d on d.DealID = aa.AttributeImplementationID
--	left outer join DealClosing dc on dc.DealID = d.DealID
--	WHERE aa.AttributeImplementationTypeID = 13 
--	 and aa.AttributeImplementationID = max(deal.DealID)
--	and ((@asofdate between aa.FromDate and aa.ToDate) or @asofdate is null)
--	) as tbl ) as AsOfGeography  
,isnull(max(isnull(dealDetail.CurrentExpectedUnfundedAmount,0)),0) as CurrentExpectedUnfundedAmount
,isnull(max(isnull(dealDetail.CurrentAdjustedExpectedUnfundedAmount,0)),0) as CurrentAdjustedExpectedUnfundedAmount
--,isnull(max(isnull(dealDetail.CurrentExpectedUnfundedAmount,0)),0) + ROUND((max(isnull(dealDetail.ClosingCosts,0))),2) as DealSize
,isnull(max(isnull(dealDetail.DeferredPaymentAmount,0)),0) as DeferredPaymentAmount
,isnull(max(isnull(dealDetail.DeferredPaymentDate,0)),0) as DeferredPaymentDate
,isnull(max(isnull(dealDetail.AccruedInterestDistribution,0)),0) as AccruedInterestDistribution
,(select top 1 xrr.XIRR from dm_deal_xirr xrr
	where xrr.DealID = deal.DealID
	and ((xrr.XIRRDate <= @asofdate) or @asofdate is null)
	order by xrr.XIRRDate desc,xrr.LastUpdatedDate desc ) as IRR
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
) as tbl
------Pivot Table Start----

) p UNPIVOT (value FOR name IN 
([Deal Name], [Deal Number]
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
) AS unpvt where ([name] not in('Deemed Capital Call','Deemed Distribution','Stock Distribution','Stock Sales') and isnull(@isaccounting,0) = 0) or isnull(@isaccounting,0) = 1
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

----Pivot Table End----