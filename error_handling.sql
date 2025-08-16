--TASK 1:- Loading Data with Errors from S3 into Snowflake
-- Use the 'demo' warehouse for running the queries.
USE WAREHOUSE demo;

-- Create a new database named 'sales_db_with_errors'.
CREATE OR REPLACE DATABASE sales_db_with_errors;

-- Create a 'sales_with_errors' table with specified schema.
CREATE OR REPLACE TABLE sales_db_with_errors.public.sales_with_errors (
    order_id INTEGER,              -- Order ID field as Integer
    customer_id INTEGER,           -- Customer ID field as Integer
    customer_name STRING,          -- Customer Name as String
    order_date DATE,               -- Order Date as Date
    product STRING,                -- Product as String
    quantity INTEGER,              -- Quantity as Integer
    price FLOAT,                   -- Price as Float
    complete_address STRING        -- Complete Address as String
);

-- Create a named stage 's3_stage_errors' that points to the S3 bucket with the error-prone CSV file.
CREATE OR REPLACE STAGE s3_stage_errors
  URL = 's3://snowflake-hands-on-data/sample_data_with_errors/basic/sales_sample_data_with_errors.csv'  -- S3 path to the CSV file
  CREDENTIALS = (
     AWS_KEY_ID = 88888888888 
     AWS_SECRET_KEY = 8888888888
  )
  FILE_FORMAT = (TYPE = 'CSV' FIELD_DELIMITER = ',' SKIP_HEADER = 1); -- Define file format (CSV), delimiter, and skip header

-- Load data from the S3 stage into the 'sales_with_errors' table, 
--Error output will come: "Field delimiter ',' found while expecting record delimiter '\n'"
COPY INTO sales_db_with_errors.public.sales_with_errors
FROM @s3_stage_errors;  -- Ensure CSV format with header skipping
--Error output: Field delimiter ',' found while expecting record delimiter '\n'

--validate
select * from sales_db_with_errors.public.sales_with_errors;

-- Drop the 's3_stage_errors' stage.
DROP STAGE IF EXISTS s3_stage_errors;

-- Drop the 'sales_with_errors' table.
DROP TABLE IF EXISTS sales_db_with_errors.public.sales_with_errors;

-- Drop the entire 'sales_db_with_errors' database.
DROP DATABASE IF EXISTS sales_db_with_errors;



-- TASK 2:- Loading Data with Validation Mode for Detailed Error Handling
-- Use the 'demo' warehouse for running the queries.
USE WAREHOUSE demo;

-- Create a new database named 'sales_db_with_validation'.
CREATE OR REPLACE DATABASE sales_db_with_validation;

-- Create a 'sales_with_validation' table with specified schema.
CREATE OR REPLACE TABLE sales_db_with_validation.public.sales_with_validation (
    order_id INTEGER,              -- Order ID field as Integer
    customer_id INTEGER,           -- Customer ID field as Integer
    customer_name STRING,          -- Customer Name as String
    order_date DATE,               -- Order Date as Date
    product STRING,                -- Product as String
    quantity INTEGER,              -- Quantity as Integer
    price FLOAT,                   -- Price as Float
    complete_address STRING        -- Complete Address as String
);

-- Create a named stage 's3_stage_validation' that points to the S3 bucket with the error-prone CSV file.
CREATE OR REPLACE STAGE s3_stage_validation
  URL = 's3://snowflake-hands-on-data/sample_data_with_errors/basic/sales_sample_data_with_errors.csv'  -- S3 path to the CSV file
  CREDENTIALS = (
      AWS_KEY_ID = 88888888888888 
      AWS_SECRET_KEY = 88888888888888
  )
  FILE_FORMAT = (TYPE = 'CSV' FIELD_DELIMITER = ',' SKIP_HEADER = 1); -- Define file format (CSV), delimiter, and skip header

  -- Load data from the S3 stage into the 'sales_with_validation' table using validation mode.
COPY INTO sales_db_with_validation.public.sales_with_validation
FROM @s3_stage_validation
FILE_FORMAT = (TYPE = 'CSV' FIELD_DELIMITER = ',' SKIP_HEADER = 1)
VALIDATION_MODE = RETURN_ERRORS;  -- Use validation mode to return detailed errors without loading the data

-- Drop the 's3_stage_validation' stage.
DROP STAGE IF EXISTS s3_stage_validation;

-- Drop the 'sales_with_validation' table.
DROP TABLE IF EXISTS sales_db_with_validation.public.sales_with_validation;

-- Drop the entire 'sales_db_with_validation' database.
DROP DATABASE IF EXISTS sales_db_with_validation;



-- TASK 3:- Handling Data Errors with ON_ERROR = 'CONTINUE'
-- Use the 'demo' warehouse for running the queries.
USE WAREHOUSE demo;

-- Create a new database named 'sales_db_with_continue'.
CREATE OR REPLACE DATABASE sales_db_with_continue;

-- Create a 'sales_with_continue' table with the specified schema.
CREATE OR REPLACE TABLE sales_db_with_continue.public.sales_with_continue (
    order_id INTEGER,              -- Order ID field as Integer
    customer_id INTEGER,           -- Customer ID field as Integer
    customer_name STRING,          -- Customer Name as String
    order_date DATE,               -- Order Date as Date
    product STRING,                -- Product as String
    quantity INTEGER,              -- Quantity as Integer
    price FLOAT,                   -- Price as Float
    complete_address STRING        -- Complete Address as String
);

-- Create a named stage 's3_stage_continue' that points to the S3 bucket with the error-prone CSV file.
CREATE OR REPLACE STAGE s3_stage_continue
  URL = 's3://snowflake-hands-on-data/sample_data_with_errors/basic/sales_sample_data_with_errors.csv'  -- S3 path to the CSV file
  CREDENTIALS = (
    AWS_KEY_ID = 888888888888       -- AWS access key for authentication
    AWS_SECRET_KEY = 8888888888888888  -- AWS secret key for authentication
  )
  FILE_FORMAT = (TYPE = 'CSV' FIELD_DELIMITER = ',' SKIP_HEADER = 1); -- Define file format (CSV), delimiter, and skip header

  -- Load data from the S3 stage into the 'sales_with_continue' table while skipping rows with errors.
COPY INTO sales_db_with_continue.public.sales_with_continue
FROM @s3_stage_continue
ON_ERROR = 'CONTINUE';  -- Skip erroneous rows and continue loading the rest of the valid data

-- Query to check the loaded rows.
SELECT * FROM sales_db_with_continue.public.sales_with_continue;

-- Drop the 's3_stage_continue' stage.
DROP STAGE IF EXISTS s3_stage_continue;

-- Drop the 'sales_with_continue' table.
DROP TABLE IF EXISTS sales_db_with_continue.public.sales_with_continue;

-- Drop the entire 'sales_db_with_continue' database.
DROP DATABASE IF EXISTS sales_db_with_continue;



-- TASK 4:- Handling Multiple Files with ON_ERROR = 'SKIP_FILE'
-- Use the 'demo' warehouse for running the queries.
USE WAREHOUSE demo;

-- Create a new database named 'sales_db_skip_file'.
CREATE OR REPLACE DATABASE sales_db_skip_file;

-- Create a 'sales_skip_file' table with the specified schema.
CREATE OR REPLACE TABLE sales_db_skip_file.public.sales_skip_file (
    order_id INTEGER,              -- Order ID field as Integer
    customer_id INTEGER,           -- Customer ID field as Integer
    customer_name STRING,          -- Customer Name as String
    order_date DATE,               -- Order Date as Date
    product STRING,                -- Product as String
    quantity INTEGER,              -- Quantity as Integer
    price FLOAT,                   -- Price as Float
    complete_address STRING        -- Complete Address as String
);

-- Create a named stage 's3_stage_skip_file' that points to the S3 bucket with two CSV files.
CREATE OR REPLACE STAGE s3_stage_skip_file
  URL = 's3://snowflake-hands-on-data/sample_data_with_errors/mixed_multiple/'  -- S3 path to the CSV files
  CREDENTIALS = (
      AWS_KEY_ID = 88888888888888 
      AWS_SECRET_KEY = 88888888888888
  )
  FILE_FORMAT = (TYPE = 'CSV' FIELD_DELIMITER = ',' SKIP_HEADER = 1); -- Define file format (CSV), delimiter, and skip header

-- Load data from both CSV files into the 'sales_skip_file' table, skipping the file with errors.
COPY INTO sales_db_skip_file.public.sales_skip_file
FROM @s3_stage_skip_file
FILES = ('sales_sample_data_with_errors_1.csv', 'sales_sample_data_with_errors_2.csv')  -- Two files, one with errors
ON_ERROR = 'SKIP_FILE';  -- Skip the file with errors and load the valid one

-- Query to check the loaded rows.
SELECT * FROM sales_db_skip_file.public.sales_skip_file;

-- Drop the 's3_stage_skip_file' stage.
DROP STAGE IF EXISTS s3_stage_skip_file;

-- Drop the 'sales_skip_file' table.
DROP TABLE IF EXISTS sales_db_skip_file.public.sales_skip_file;

-- Drop the entire 'sales_db_skip_file' database.
DROP DATABASE IF EXISTS sales_db_skip_file;



-- TASK 5:- Handling Multiple Files with ON_ERROR = 'SKIP_FILE_30%'
-- Switch to the demo warehouse
USE WAREHOUSE demo;

-- Create the database for this assignment
CREATE OR REPLACE DATABASE sales_db_skip_file_30;

CREATE OR REPLACE TABLE sales_skip_file_30 (
    order_id INTEGER,
    customer_id INTEGER,
    customer_name VARCHAR,
    order_date DATE,
    product VARCHAR,
    quantity INTEGER,
    price FLOAT,
    complete_address VARCHAR
);

-- Create a named stage that points to the S3 bucket containing the files
CREATE OR REPLACE STAGE s3_stage_skip_file_30
URL = 's3://snowflake-hands-on-data/sample_data_with_errors/mixed_multiple/'
CREDENTIALS = (
  AWS_KEY_ID = 888888888888
  AWS_SECRET_KEY = 888888888888
)
FILE_FORMAT = (TYPE = 'CSV' FIELD_DELIMITER = ',' SKIP_HEADER = 1);

-- Load data from both files into the sales_skip_file_30 table
-- Use the ON_ERROR = 'SKIP_FILE_30%' option to skip files with more than 30% errors
COPY INTO sales_skip_file_30
FROM @s3_stage_skip_file_30
ON_ERROR = 'SKIP_FILE_30%';

-- Query the table to verify which files were loaded successfully
SELECT * FROM sales_skip_file_30;

-- Drop the stage after completing the assignment to clean up the resources
DROP STAGE IF EXISTS s3_stage_skip_file_30;

-- Drop the table after completing the assignment
DROP TABLE IF EXISTS sales_skip_file_30;

-- Drop the database to ensure no resources are left behind
DROP DATABASE IF EXISTS sales_db_skip_file_30;
