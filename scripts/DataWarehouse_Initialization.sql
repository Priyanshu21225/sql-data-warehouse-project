/*****************************************************************************************
* Script Name   : DataWarehouse_Initialization.sql
* Description   : This script initializes the Data Warehouse environment by:
*                 - Switching to the master database
*                 - Creating a new database called 'Datawarehouse'
*                 - Creating the necessary schemas for data processing layers:
*                     • Bronze (Raw data)
*                     • Silver (Cleaned/transformed data)
*                     • Gold (Business-ready data)
*
* Author        : Priyanshu Chaudhary
* Date Created  : 4 July 2025
* Version       : 1.0
******************************************************************************************/

-- Switch to the master database (safe starting point for creating new DBs)
USE master;
GO

-- Create the Datawarehouse database
CREATE DATABASE Datawarehouse;
GO

-- Switch context to the new Datawarehouse database
USE Datawarehouse;
GO

-- Create the Bronze schema for raw, unprocessed data
CREATE SCHEMA bronze;
GO

-- Create the Silver schema for cleaned and standardized data
CREATE SCHEMA silver;
GO

-- Create the Gold schema for business-ready, analytical data
CREATE SCHEMA gold;
GO
