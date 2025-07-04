/*****************************************************************************************
* Script Name   : BronzeLayer_Tables.sql
* Description   : T-SQL script to create bronze layer tables for CRM and ERP sources.
*                 Applies standard best practices:
*                 - Drop tables if they exist
*                 - Proper data typing and column comments
*                 - No changes to strict naming conventions
*
* Author        : Priyanshu Chaudhary
* Date Created  : 4 July 2025
* Version       : 1.0
******************************************************************************************/

-- =======================================================================================
-- Bronze Layer Tables
-- Source: CRM System
-- =======================================================================================

-- Drop and create CRM customer info table
IF OBJECT_ID('bronze.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_cust_info;
GO

CREATE TABLE bronze.crm_cust_info (
    cst_id             INT,           -- Customer ID (Primary Identifier)
    cst_key            VARCHAR(50),   -- Customer business key
    cst_firstname      VARCHAR(50),   -- First name
    cst_lastname       VARCHAR(50),   -- Last name
    cst_marital_status VARCHAR(10),   -- Marital status (e.g., Single, Married)
    cst_gndr           VARCHAR(10),   -- Gender
    cst_create_date    DATE           -- Account creation date
);
GO

-- Drop and create CRM product info table
IF OBJECT_ID('bronze.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_prd_info;
GO

CREATE TABLE bronze.crm_prd_info (
    prd_id        INT,           -- Product ID
    prd_key       VARCHAR(50),   -- Product business key
    prd_nm        VARCHAR(100),  -- Product name
    prd_cost      INT,           -- Product cost
    prd_line      VARCHAR(10),   -- Product line/category
    prd_start_date DATE,         -- Start date of product availability
    prd_end_date   DATE          -- End date of product availability
);
GO

-- Drop and create CRM sales details table
IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE bronze.crm_sales_details;
GO

CREATE TABLE bronze.crm_sales_details (
    sls_ord_num   VARCHAR(50),  -- Sales order number
    sls_prd_key   VARCHAR(50),  -- Product key
    sls_cust_id   INT,          -- Customer ID
    sls_order_dt  DATE,         -- Order date
    sls_ship_dt   DATE,         -- Shipping date
    sls_due_dt    DATE,         -- Due date
    sls_sales     INT,          -- Total sales amount
    sls_quantity  INT,          -- Quantity sold (Note: consider fixing typo if needed)
    sls_price     INT           -- Price per unit
);
GO

-- =======================================================================================
-- Bronze Layer Tables
-- Source: ERP System
-- =======================================================================================

-- Drop and create ERP customer demographic table
IF OBJECT_ID('bronze.erp_CUST_AZ12', 'U') IS NOT NULL
    DROP TABLE bronze.erp_CUST_AZ12;
GO

CREATE TABLE bronze.erp_CUST_AZ12 (
    CID    VARCHAR(50),   -- Customer ID
    BDATE  DATE,          -- Birthdate
    GEN    VARCHAR(10)    -- Gender
);
GO

-- Drop and create ERP customer location table
IF OBJECT_ID('bronze.erp_LOC_A101', 'U') IS NOT NULL
    DROP TABLE bronze.erp_LOC_A101;
GO

CREATE TABLE bronze.erp_LOC_A101 (
    CID    VARCHAR(50),   -- Customer ID
    CNTRY  VARCHAR(50)    -- Country
);
GO

-- Drop and create ERP product category table
IF OBJECT_ID('bronze.erp_PX_CAT_G1V1', 'U') IS NOT NULL
    DROP TABLE bronze.erp_PX_CAT_G1V1;
GO

CREATE TABLE bronze.erp_PX_CAT_G1V1 (
    ID           VARCHAR(50),   -- Product ID
    CAT          VARCHAR(50),   -- Product category
    SUBCAT       VARCHAR(50),   -- Product subcategory
    MAINTENANCE  VARCHAR(10)    -- Maintenance flag or type
);
GO
