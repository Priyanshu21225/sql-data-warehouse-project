/*******************************************************************************************
 Script Name   : load_bronze
 Description   : Stored Procedure to load raw CRM and ERP source data into the Bronze Layer.
                 This script truncates existing Bronze tables and bulk inserts data from CSVs.
                 It also prints the time taken for each table and handles any loading errors.
 
 ⚠ WARNING     : Ensure all files exist at specified locations. File paths must be accessible 
                 to SQL Server with proper read permissions.
 Usage Example - EXEC bronze.load_bronze
 
 Author        : Priyanshu Chaudhary
 Date Created  : 4 July 2025
 Version       : 1.0
********************************************************************************************/

-- Stored Procedure to execute the query
CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME;
    DECLARE @start_time_1 DATETIME, @end_time_1 DATETIME;

    SET @start_time_1 = GETDATE();

    BEGIN TRY
        PRINT '===================================================================================';
        PRINT 'LOADING BRONZE LAYER';
        PRINT '===================================================================================';

        -- ===================================================================================
        -- CRM Source: Bulk insert into Bronze Layer tables
        -- ===================================================================================
        PRINT '------------------------------------------------------------------------------------';
        PRINT 'LOADING THE CRM TABLES ';
        PRINT '------------------------------------------------------------------------------------';

        -- Truncate and load data into CRM customer info table
        SET @start_time = GETDATE();
        PRINT 'Truncating the bronze.crm_cust_info Table ';
        TRUNCATE TABLE bronze.crm_cust_info;

        PRINT 'INSERTING In the Table: bronze.crm_cust_info ';
        BULK INSERT bronze.crm_cust_info
        FROM 'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH (
            FIRSTROW = 2,             -- Skip header row
            FIELDTERMINATOR = ',',    -- Columns separated by commas
            TABLOCK                   -- Use table-level locking for performance
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' Seconds';

        -- Truncate and load data into CRM product info table
        SET @start_time = GETDATE();
        PRINT 'Truncating the bronze.crm_prd_info Table ';
        TRUNCATE TABLE bronze.crm_prd_info;

        PRINT 'INSERTING In the Table: bronze.crm_prd_info ';
        BULK INSERT bronze.crm_prd_info
        FROM 'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' Seconds';

        -- Truncate and load data into CRM sales details table
        SET @start_time = GETDATE();
        PRINT 'Truncating the bronze.crm_sales_details Table ';
        TRUNCATE TABLE bronze.crm_sales_details;

        PRINT 'INSERTING In the Table: bronze.crm_sales_details ';
        BULK INSERT bronze.crm_sales_details
        FROM 'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' Seconds';

        -- ===================================================================================
        -- ERP Source: Bulk insert into Bronze Layer tables
        -- ===================================================================================
        PRINT '------------------------------------------------------------------------------------';
        PRINT 'LOADING THE ERP TABLES ';
        PRINT '------------------------------------------------------------------------------------';

        -- Truncate and load data into ERP customer demographics table
        SET @start_time = GETDATE();
        PRINT 'Truncating the bronze.erp_CUST_AZ12 Table ';
        TRUNCATE TABLE bronze.erp_CUST_AZ12;

        PRINT 'INSERTING In the Table: bronze.erp_CUST_AZ12 ';
        BULK INSERT bronze.erp_CUST_AZ12
        FROM 'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' Seconds';

        -- Truncate and load data into ERP customer location table
        SET @start_time = GETDATE();
        PRINT 'Truncating the Table bronze.erp_LOC_A101 ';
        TRUNCATE TABLE bronze.erp_LOC_A101;

        PRINT 'INSERTING In the Table: bronze.erp_LOC_A101 ';
        BULK INSERT bronze.erp_LOC_A101
        FROM 'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' Seconds';

        -- Truncate and load data into ERP product category table
        SET @start_time = GETDATE();
        PRINT 'Truncating the Table bronze.erp_PX_CAT_G1V1';
        TRUNCATE TABLE bronze.erp_PX_CAT_G1V1;

        PRINT 'INSERTING In the Table: bronze.erp_PX_CAT_G1V1 ';
        BULK INSERT bronze.erp_PX_CAT_G1V1
        FROM 'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' Seconds';

    END TRY
    BEGIN CATCH
        -- Error handling block
        PRINT '==================================================================';
        PRINT 'There is an error in loading the Bronze layer';
        PRINT 'Error Meaasage:' + ERROR_MESSAGE();
        PRINT 'Error no. :' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT '==================================================================';
    END CATCH

    -- Final load summary
    SET @end_time_1 = GETDATE();
    PRINT ' ';
    PRINT '----------------------------------------';
    PRINT 'Loading Bronze layer is Completed';
    PRINT '>> Complete Load Duration:' + CAST(DATEDIFF(second, @start_time_1, @end_time_1) AS NVARCHAR) + ' Seconds';
    PRINT '----------------------------------------';
END
