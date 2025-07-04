/*****************************************************************************************
* Script Name   : BronzeLayer_BulkInsert.sql
* Description   : T-SQL script to truncate and bulk load CSV files into Bronze Layer tables
*                 from CRM and ERP source systems using BULK INSERT.
*
* ⚠ WARNING:
*   Ensure that file paths are accessible from the SQL Server machine.
*   Files must have headers (row 1), and the server must have read permission.
*
* Author        : Priyanshu Chaudhary
* Date Created  : 4 July 2025
* Version       : 1.0
******************************************************************************************/

-- =======================================================================================
-- CRM Source: Bulk insert into Bronze Layer tables
-- =======================================================================================

-- Truncate and load data into CRM customer info table
TRUNCATE TABLE bronze.crm_cust_info;
BULK INSERT bronze.crm_cust_info
FROM 'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
WITH (
	FIRSTROW = 2,             -- Skip header row
	FIELDTERMINATOR = ',',    -- Columns separated by commas
	TABLOCK                   -- Use table-level locking for performance
);

-- Truncate and load data into CRM product info table
TRUNCATE TABLE bronze.crm_prd_info;
BULK INSERT bronze.crm_prd_info
FROM 'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);

-- Truncate and load data into CRM sales details table
TRUNCATE TABLE bronze.crm_sales_details;
BULK INSERT bronze.crm_sales_details
FROM 'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);

-- =======================================================================================
-- ERP Source: Bulk insert into Bronze Layer tables
-- =======================================================================================

-- Truncate and load data into ERP customer demographics table
TRUNCATE TABLE bronze.erp_CUST_AZ12;
BULK INSERT bronze.erp_CUST_AZ12
FROM 'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);

-- Truncate and load data into ERP customer location table
TRUNCATE TABLE bronze.erp_LOC_A101;
BULK INSERT bronze.erp_LOC_A101
FROM 'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);

-- Truncate and load data into ERP product category table
TRUNCATE TABLE bronze.erp_PX_CAT_G1V1;
BULK INSERT bronze.erp_PX_CAT_G1V1
FROM 'D:\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
