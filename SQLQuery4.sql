declare @key as varchar(max) = 'Net Income';
declare @Temp as Table
(
ID INT IDENTITY(1, 1),
Symbol varchar(max),
Growth decimal(19,8),
NegativeCount int
)
insert into @Temp(Symbol)
select q.Symbol from FinancialReporting q
--where q.Symbol = 'SPORTKING'
group by q.Symbol 
order by q.Symbol

declare @TempDate as Table
(
ID INT IDENTITY(1, 1),
PeriodDate date
)
insert into @TempDate(PeriodDate)
select q.PeriodDate from FinancialReporting q
join FinancialReportingSchemaKey k on k.FinancialReportingSchemaKeyID = q.FinancialReportingSourceKeyID 
where k.[Key] = @key
and q.PeriodDate >= '2021-03-31'
group by q.PeriodDate 
order by q.PeriodDate
 

DECLARE @i int; DECLARE @maxTempGroupID int; DECLARE @numrowsGroup int;
SET @maxTempGroupID = (SELECT MAX(ID) FROM @Temp);
SET @numrowsGroup = (SELECT COUNT(*) FROM @Temp);
--select 'TotalRows:' + cast(@numrowsGroup as varchar(max));
--select TransactionDate,OriginalGrossPurchasePrice,* from @Temp where TransactionTypeID = -1
--select EffectiveDate,CloseDate,TransactionTypeID,* from @Temp 
--select * from @Temp 
SET @i = 1;
IF @numrowsGroup > 0
    WHILE (@i <= @maxTempGroupID)
    BEGIN

		declare @symbol varchar(max) = '';
		select @symbol = Symbol from @Temp where ID = @i;

		DECLARE @dateindex int = 0; DECLARE @maxDateTempGroupID int = 0; DECLARE @datenumrowsGroup int = 0;
		SET @maxDateTempGroupID = (SELECT MAX(ID) FROM @TempDate);
		SET @datenumrowsGroup = (SELECT COUNT(*) FROM @TempDate);
		--select 'TotalRows:' + cast(@numrowsGroup as varchar(max));
		--select TransactionDate,OriginalGrossPurchasePrice,* from @Temp where TransactionTypeID = -1
		--select EffectiveDate,CloseDate,TransactionTypeID,* from @Temp 
		--select * from @Temp 

		declare @total decimal(19,8) = 0;
		declare @totalcount int = 1;
		declare @negtivecount int = 0;

		SET @dateindex = 2;
		IF @datenumrowsGroup > 0
			WHILE (@dateindex <= @maxDateTempGroupID)
			BEGIN
				declare @date datetime = null;
				declare @prevdate datetime = null;

				declare @prev decimal(19,8) = 0;
				declare @current decimal(19,8) = 0;

				select @prevdate = q.PeriodDate from @TempDate q where q.ID = @dateindex - 1;
				select @date = q.PeriodDate from @TempDate q where q.ID = @dateindex;

				select @prev = isnull(q.[Value],0) from FinancialReporting q 
				join FinancialReportingSchemaKey k on k.FinancialReportingSchemaKeyID = q.FinancialReportingSourceKeyID 
				where q.Symbol = @symbol and q.PeriodDate = @prevdate and k.[Key] = @key

				select @current = isnull(q.[Value],0) from FinancialReporting q join FinancialReportingSchemaKey k on k.FinancialReportingSchemaKeyID = q.FinancialReportingSourceKeyID where q.Symbol = @symbol and q.PeriodDate = @date and k.[Key] = @key

				declare @percentage decimal(19,8) = 0;
				if isnull(@prev,0) > 0
					begin
						set @percentage = ((isnull(@current,0) - isnull(@prev,0)) / isnull(@prev,0)) * 100;

						if isnull(@percentage,0) < 0
							begin
								set @negtivecount = isnull(@negtivecount,0) + 1
							end
					end

				--select @dateindex as '@dateindex',@prevdate as '@prevdate',@date as '@date',@prev as '@prev',@current as '@current',@percentage as '@percentage';

				set @total = isnull(@total,0) + isnull(@percentage,0);
				set @totalcount = isnull(@totalcount,0) + 1;
		
				SET @dateindex = @dateindex + 1
			END

		declare @avg decimal(19,8) = 0;
		if isnull(@totalcount,0) > 0
			begin
				set @avg = isnull(@total,0) / isnull(@totalcount,0);
			end

		update @Temp set Growth = @avg,NegativeCount = @negtivecount where ID = @i

		--select @total as '@total',@totalcount as '@totalcount';
		
		SET @i = @i + 1
	END



select Symbol,Growth,NegativeCount from @Temp 
where NegativeCount <= 2
order by Growth desc