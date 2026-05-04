
-----create tables for the silver layer-----------------------

/*use NokiaDB

go

create table silver.Revenue
([Date] date,
[Region] varchar(100),
[Product_Line] varchar(100),
[Revenue_Millions] decimal(18,10)
);


go

create table silver.Stock_Data
([Date] date,
[Open] decimal(18,10),
[High] decimal(18,10),
[Low] decimal(18,10),
[Close] decimal(18,10),
[Volume] int,
[Dividends] decimal(18,10),
[Stock Splits] decimal(18,10),
[Event] varchar(50)
);*/


 --------------------------insert data from bronze to silver layer
 --EXEC SILVER.LOAD_SILVER
 CREATE OR ALTER PROCEDURE SILVER.LOAD_SILVER
 AS 
 BEGIN
 BEGIN TRY
 DECLARE @START_LOAD DATETIME, @END_LOAD DATETIME ,@BATCH_START_TIME DATETIME,@BATCH_END_TIME DATETIME;
 PRINT '=============================';
 PRINT '>>>LOADING SILVER LAYER>>>>'
 PRINT '=============================';
 SET @BATCH_START_TIME = GETDATE();
 SET @START_LOAD = GETDATE();
 
 PRINT'============================';
 PRINT'TRANCATE table:revenue';
  PRINT'============================';

 TRUNCATE TABLE silver.Revenue
  PRINT'============================';
  PRINT'ISERT DATA INTO SILVER.REVENUE';
    PRINT'============================';

 insert into silver.Revenue (
 [Date] ,
[Region] ,
[Product_Line] ,
[Revenue_Millions] 
 )
 select 
 CAST ([Date] AS DATE) ,
TRIM ([Region]) ,
 UPPER   (TRIM([Product_Line])) ,
 ISNULL([Revenue_Millions],0) 

from bronze.Revenue
WHERE [Date] IS NOT NULL;
SET @END_LOAD = GETDATE();
PRINT'<<<<LOAD DURATION:'+ CAST (DATEDIFF(SECOND, @START_LOAD,@END_LOAD) AS NVARCHAR) + 'SECOND';
PRINT '=============================';
PRINT'=====TRUNCATE TABLE SILVER STOCK_DATA==';
TRUNCATE TABLE SILVER.Stock_Data;
PRINT'>>>>LOADING SILVER.STOCK_DATA>>>>';
PRINT '=============================';
SET @START_LOAD = GETDATE();
INSERT INTO SILVER.Stock_Data (
[Date] ,
[Open] ,
[High] ,
[Low] ,
[Close] ,
[Volume] ,
[Dividends] ,
[Stock Splits] ,
[Event] )
SELECT 
CAST ([Date] AS DATE) ,
CAST ([Open] AS DECIMAL(18,9)) ,
[High] ,
[Low] ,
[Close] ,
[Volume] ,
[Dividends] ,
[Stock Splits] ,
TRIM([Event]) 
FROM BRONZE.Stock_Data
WHERE [DATE] IS NOT NULL;
SET @END_LOAD = GETDATE();
PRINT '=============================';
PRINT' LOAD DURETION : ' + CAST(DATEDIFF(SECOND,@START_LOAD,@END_LOAD) AS NVARCHAR) + 'SECOND'

SET @BATCH_END_TIME = GETDATE();
print'>>>>>>>>>>loading silver layer is completed'
print ' batch duretion : ' + CAST( datediff(second, @BATCH_START_TIME, @BATCH_END_TIME) AS NVARCHAR) + 'SECOND'
END TRY
BEGIN CATCH
END CATCH
PRINT '=========================================='
		PRINT 'ERROR OCCURED DURING LOADING SILVER LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================='
END