declare @TempDate as Table
(
	ID INT IDENTITY(1, 1),
	[RecordDate] [datetime] NOT NULL,
	[TotalAvg] [decimal](19,8) NULL,
	[Avg] [decimal](19,8) NULL,
	[Count] [INT] NULL
); 

insert into @TempDate(RecordDate)
select RecordDate from dm_asset_core_lot
where 
symbol = 'NIFTY' 
and LotType = 'P' 
and RecordDate >= '2024-04-01 00:00:00.000'
and RecordDate <= getdate() --'2024-06-30 00:00:00.000'
group by RecordDate

--select * from @TempDate 

DECLARE @index INT = 1
DECLARE @maxindex INT = 0;
DECLARE @recorddate DATETIME = NULL;
DECLARE @avg decimal(19,8) = 0;
DECLARE @count INT = 0;
DECLARE @totalavg decimal(19,8) = 0;

-- Get the maximum index from the @TempDate table
SELECT @maxindex = MAX(ID) FROM @TempDate;

-- Loop through each record in @TempDate
WHILE @index <= @maxindex
BEGIN
	set @recorddate = NULL;
    -- Get the RecordDate for the current index
    SELECT @recorddate = RecordDate FROM @TempDate WHERE ID = @index;

	set @avg = 0;
	set @count = 0;
       
	select @avg = AVG(ChangePercentage),@count = count(*) from (
		select (((tbl.SharePrice - tbl.PrevPrice) / tbl.PrevPrice) * 100) as ChangePercentage
		,tbl.* from (
		select
		l.SharePrice
		,(select top 1 pl.SharePrice from dm_asset_core_lot pl where pl.Symbol = l.Symbol and pl.RecordDate < l.RecordDate and pl.LotType = 'P' order by pl.RecordDate desc,pl.dm_asset_core_lot_id desc) as PrevPrice
		--,ls.NumberOfShares,ls.Amount 
		from dm_asset_core_lot_share ls	
		join dm_asset_core_lot l on l.Symbol = ls.Symbol and l.RecordDate = @recorddate and l.LotType = 'P'
		) as tbl where tbl.PrevPrice > 0
	) as tbl2

	select @totalavg = AVG(ChangePercentage) from (
		select (((tbl.SharePrice - tbl.PrevPrice) / tbl.PrevPrice) * 100) as ChangePercentage
		,tbl.* from (
		select
		l.SharePrice
		,(select top 1 pl.SharePrice from dm_asset_core_lot pl where pl.Symbol = l.Symbol and pl.RecordDate < l.RecordDate and pl.LotType = 'P' order by pl.RecordDate desc,pl.dm_asset_core_lot_id desc) as PrevPrice
		from dm_asset_core_lot l 
		where l.Symbol = 'NIFTY' 
		and l.RecordDate = @recorddate and l.LotType = 'P'
		) as tbl where tbl.PrevPrice > 0
	) as tbl2

	--select @avg as '@avg',@totalavg as '@totalavg';

	update @TempDate set [Avg] = @avg,[TotalAvg] = @totalavg,[Count] = @count where ID = @index;
    
    -- Example: Print the current date
    PRINT CONVERT(VARCHAR(10), @recorddate, 120)
    
    -- Replace the print statement with your actual logic inside the loop
    -- Increment the index
    SET @index = @index + 1
END

select sum([TotalAVG]) as [TotalAVG],sum([AVG]) as [AVG] from @TempDate where [Avg] is not null

--select * from @TempDate where [Avg] is not null

 -- Declare the start date
DECLARE @StartDate DATE = '2021-01-01';
DECLARE @EndDate DATE = GETDATE();

-- Create a table variable to hold the month wise start and end dates
DECLARE @MonthWiseDates TABLE (
    MonthStartDate DATE,
    MonthEndDate DATE
);

-- Initialize variables for loop
DECLARE @CurrentStartDate DATE = DATEADD(DAY, 1 - DAY(@StartDate), @StartDate); -- First day of the month containing @StartDate
DECLARE @CurrentEndDate DATE;

-- Loop through each month from @StartDate to @EndDate
WHILE @CurrentStartDate <= @EndDate
BEGIN
    -- Calculate the end date of the current month
    SET @CurrentEndDate = EOMONTH(@CurrentStartDate);
    
    -- Adjust the end date if it exceeds @EndDate
    IF @CurrentEndDate > @EndDate
        SET @CurrentEndDate = @EndDate;
    
    -- Insert the current month's start and end date into the table variable
    INSERT INTO @MonthWiseDates (MonthStartDate, MonthEndDate)
    VALUES (@CurrentStartDate, @CurrentEndDate);
    
    -- Move to the next month
    SET @CurrentStartDate = DATEADD(MONTH, 1, @CurrentStartDate);
    SET @CurrentStartDate = DATEADD(DAY, 1 - DAY(@CurrentStartDate), @CurrentStartDate); -- First day of the next month
END

-- Join @TempDate with @MonthWiseDates and calculate the sum of TotalAvg and Avg
SELECT
    m.MonthStartDate,
    m.MonthEndDate,
    SUM(t.TotalAvg) AS TotalAvg,
    SUM(t.[Avg]) AS [Avg],
	case when SUM(t.[Avg]) > SUM(t.TotalAvg) then 'Win' else '' end as [Result],
	SUM(t.[Avg]) - SUM(t.TotalAvg) as [Difference]
FROM
    @MonthWiseDates m
LEFT JOIN
    @TempDate t ON t.RecordDate >= m.MonthStartDate AND t.RecordDate <= m.MonthEndDate
where t.[Avg] is not null
GROUP BY
    m.MonthStartDate,
    m.MonthEndDate
ORDER BY
    m.MonthStartDate 

--select sum(TotalAvg) as t1,sum([Avg]) as t2 from (
--SELECT
--    m.MonthStartDate,
--    m.MonthEndDate,
--    SUM(t.TotalAvg) AS TotalAvg,
--    SUM(t.[Avg]) AS [Avg],
--	case when SUM(t.[Avg]) > SUM(t.TotalAvg) then 'Win' else '' end as [Result],
--	SUM(t.[Avg]) - SUM(t.TotalAvg) as [Difference]
--FROM
--    @MonthWiseDates m
--LEFT JOIN
--    @TempDate t ON t.RecordDate >= m.MonthStartDate AND t.RecordDate <= m.MonthEndDate
--where t.[Avg] is not null
--GROUP BY
--    m.MonthStartDate,
--    m.MonthEndDate
--) as tbl