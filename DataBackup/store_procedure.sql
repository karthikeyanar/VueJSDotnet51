--USE [onpepper-willowridge-12102022]
--GO
--/****** Object:  StoredProcedure [dbo].[PROC_dm_asset_core_lot_share]    Script Date: 1/2/2023 5:39:50 PM ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
----USE [onpepperprod]
----GO
----/****** Object:  StoredProcedure [dbo].[PROC_UpdateSecurityLotSharesHistory]    Script Date: 12/31/2022 6:05:19 PM ******/
----SET ANSI_NULLS ON
ALTER PROCEDURE [dbo].[PROC_dm_asset_core_lot_share]
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
--and  Symbol in ('LIQUIDBEES')
group by Symbol


--select * from @TempSymbol order by symbol 

declare @Temp as Table
(
	ID INT IDENTITY(1, 1),
	dm_asset_core_lot_id int NOT NULL,
	Symbol varchar(max) NOT NULL,
	RecordDate datetime NOT NULL,
	NumberOfShares decimal(19,8) NOT NULL,
	SharePrice decimal(19,8) NOT NULL,
	LotType varchar(1) NOT NULL,
	Balance decimal(19,8) NULL,
	Amount decimal(19,8) NULL 
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

		delete from @Temp;

		insert into @Temp(
		dm_asset_core_lot_id,
		Symbol,
		RecordDate,
		NumberOfShares,
		SharePrice,
		LotType
		)
		select 
		dm_asset_core_lot_id,
		Symbol,
		RecordDate,
		NumberOfShares,
		SharePrice,
		LotType
		from dm_asset_core_lot
		where Symbol = @symbol and LotType in ('B','S')
		order by RecordDate asc,LotType asc

		 

		DECLARE @x int = 0; DECLARE @ztempgroupid int = 0; DECLARE @znrgroup int = 0;
		SET @ztempgroupid = (SELECT MAX(ID) FROM @Temp);
		SET @znrgroup = (SELECT COUNT(*) FROM @Temp);
		--select 'Total:' + cast(@znrgroup as varchar(max));
		SET @x = 1;
		
		IF @znrgroup > 0
			WHILE (@x <= @ztempgroupid)
			BEGIN
				declare @prevshares int = 0;
				declare @balance int = 0;
				declare @prevamount decimal(19,8) = 0;
				declare @sellprice  decimal(19,8) = 0;

				select top 1 @prevshares = isnull(NumberOfShares,0)
				,@balance = isnull(Balance,0) 
				,@prevamount = isnull(Amount,0)
				from @Temp WHERE ID < @x order by ID desc;

				select top 1 @sellprice = isnull(SharePrice,0)
				from @Temp WHERE ID = @x and LotType = 'S' order by ID desc;

				declare @currentshares int = 0;
				declare @lottype varchar(1) = '';
				declare @currentamount decimal(19,8) = 0; 
				select @currentshares = isnull(NumberOfShares,0)
				, @lottype = isnull(LotType,'') 
				, @currentamount = case when LotType = 'B' then isnull(NumberOfShares,0) * isnull(SharePrice,0) else 0 end
				from @Temp WHERE ID = @x;

				declare @sellamount decimal(19,8) = 0;
				declare @totalshares int = isnull(@balance,0) + isnull(@currentshares,0); 
				if @lottype = 'S'
					begin
						set @totalshares = isnull(@balance,0) - isnull(@currentshares,0);
						set @sellamount = @currentshares * isnull(@sellprice,0);
					end

				if isnull(@totalshares,0) < 0 
					begin
						set @totalshares = 0;
					end

				set @currentamount = (isnull(@currentamount,0) + isnull(@prevamount,0)) - isnull(@sellamount,0);

				if isnull(@totalshares,0) <= 0 
					begin
						set @currentamount = 0;
					end

				update @Temp set  Balance = @totalshares, Amount = @currentamount  where ID = @x;
				 


				SET @x = @x + 1
			END
		/******************** END LOOP *****************/

		delete  from dm_asset_core_lot_share where Symbol = @symbol;
		declare @current_balance int = 0;
		declare @current_price decimal(19,8) = 0;
		select top 1  @current_balance = isnull(Balance,0),@current_price = case when isnull(Balance,0) > 0 then isnull(Amount,0) / isnull(Balance,0) else 0 end  from @Temp order by ID desc
		--select * from @Temp 
		--select @current_balance as '@current_balance',@current_price as '@current_price';
		if isnull(@current_balance,0) > 0
			begin
				insert into dm_asset_core_lot_share(Symbol,[NumberOfShares],[SharePrice],[Amount]) values (@symbol,@current_balance,@current_price,@current_balance * @current_price)
			end

        SET @i = @i + 1
    END
/******************** END LOOP *****************/

