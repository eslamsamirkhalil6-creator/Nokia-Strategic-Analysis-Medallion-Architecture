--exec bronze.load_bronze

/*use master 
go 
create database NokiaDB;
go
create schema bronze;
go 
create schema silver;
go 
create schema gold;*/
---------create the table revenue and stockdata-------------------------------------

/*use NokiaDB
go
drop table bronze.Revenue;
go
create table bronze.Revenue (
[Date] date,
[Region] varchar(100),
[Product_Line] varchar(100),
[Revenue_Millions] decimal(18,10)
);
go
drop table bronze.Stock_Data;
go
create table bronze.Stock_Data
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

---------------------insert data ----------------------------------

-----------create procedure------------------
create or alter procedure bronze.load_bronze as 
begin
    declare @start_time datetime , @end_time datetime , @start_batch_load datetime , @end_batch_time datetime ;
       begin try
          SET @start_batch_load = GETDATE();
		     PRINT '================================================';
		     PRINT 'Loading Bronze Layer';
		     PRINT '================================================';

          set @start_time = getdate();
             print '===truncate bronze.revenue==';
             truncate table bronze.Revenue;
     
             print'==========================';
             print '>>inserting bronze.revenue';
             print '==========================';

   bulk insert bronze.Revenue from 'D:\project\Nokia_Full_Historical_Revenue.csv'
      with(
           firstrow = 2,
           fieldterminator = ',',
           tablock
          );
      set @end_time = getdate();
  ------------------know time of loading revenue

     
         print '>> load duration: ' + cast (datediff(second, @start_time,@end_time) as varchar) + 'second';

      set @start_time = getdate()
         print '===truncate bronze.stock_data==';
truncate table bronze.Stock_Data;
          print'==============================';
          print '>>inserting bronze.stock_data';
          print '=============================';
   bulk insert bronze.Stock_Data from 'D:\project\Nokia_Stock_Data_1994_2026.csv'
       with (
           firstrow = 2 ,
           fieldterminator = ',' ,
           tablock
            );
set @end_time = getdate();
------know time for loading stock_data
       print '>> load duration: ' + cast (datediff(second, @start_time,@end_time) as varchar) + 'second';
SET @end_batch_time = GETDATE();
		PRINT '=========================================='
		PRINT 'Loading Bronze Layer is Completed';
        PRINT '   - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @start_batch_load, @end_batch_time) AS NVARCHAR) + ' seconds';
		PRINT '==========================================';
end try
begin catch
---------the erorr message to know where the issue in loading
PRINT '=========================================='
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================='
end catch    
end         