# snowflake_proj3_error_handling

TASK 1:- Loading Data with Errors from S3 into Snowflake
Use the demo Warehouse: Ensure you are using the demo warehouse for this assignment.
Create a Database: Create a database called sales_db_with_errors.

Create a Table: Create a table named sales_with_errors with the following schema:
order_id INTEGER
customer_id INTEGER
customer_name STRING
order_date DATE
product STRING
quantity INTEGER
price FLOAT
complete_address STRING

Create a Stage: Create a named stage s3_stage_errors that points to the S3 bucket containing the CSV file with errors.
Load the Data: Attempt to load data from the S3 file into the sales_with_errors table using the COPY INTO command.
S3 Path: s3://snowflake-hands-on-data/sample_data_with_errors/basic/sales_sample_data_with_errors.csv
AWS Access Key: 88888888888888
AWS Secret Key: 88888888888888

Observe the Error: Observe and document any errors encountered during the data load.
Clean Up: Once you have observed and documented the errors, clean up by dropping the stage, table, and database.


TASK 2:- Loading Data with Validation Mode for Detailed Error Handling
Use the demo Warehouse: Ensure you are using the demo warehouse for this assignment.
Create a Database: Create a database called sales_db_with_validation.

Create a Table: Create a table named sales_with_validation with the following schema:
order_id INTEGER
customer_id INTEGER
customer_name STRING
order_date DATE
product STRING
quantity INTEGER
price FLOAT
complete_address STRING

Create a Stage: Create a named stage s3_stage_validation that points to the S3 bucket containing the CSV file with errors.
Load the Data Using Validation Mode: Attempt to load data from the S3 file into the sales_with_validation table using the COPY INTO command with the VALIDATION_MODE = RETURN_ERRORS option. This option allows you to see detailed information about the errors encountered during the load.
S3 Path: s3://snowflake-hands-on-data/sample_data_with_errors/basic/sales_sample_data_with_errors.csv
AWS Access Key: 8888888888888
AWS Secret Key: 8888888888888

Observe and Document Errors: Use the VALIDATION_MODE = RETURN_ERRORS to observe and document the specific errors that occurred during the data load.
Clean Up: Once done, drop the stage, table, and database.


TASK 3:- Handling Data Errors with ON_ERROR = 'CONTINUE'
Use the demo Warehouse: Ensure you are using the demo warehouse for this assignment.
Create a Database: Create a database called sales_db_with_continue.

Create a Table: Create a table named sales_with_continue with the following schema:
order_id INTEGER
customer_id INTEGER
customer_name STRING
order_date DATE
product STRING
quantity INTEGER
price FLOAT
complete_address STRING

Create a Stage: Create a named stage s3_stage_continue that points to the S3 bucket containing the CSV file with errors.
Load Data Using ON_ERROR = 'CONTINUE': Attempt to load data from the S3 file into the sales_with_continue table using the ON_ERROR = 'CONTINUE' option. This option allows Snowflake to skip rows that contain errors and continue loading the rest of the valid data.
S3 Path: s3://snowflake-hands-on-data/sample_data_with_errors/basic/sales_sample_data_with_errors.csv
AWS Access Key: 88888888888888
AWS Secret Key: 88888888888888

Observe the Outcome: Verify the data loaded into the table and observe the number of rows skipped due to errors.
Clean Up: Once done, drop the stage, table, and database.


TASK 4:- Handling Multiple Files with ON_ERROR = 'SKIP_FILE'
Use the demo Warehouse: Ensure you are using the demo warehouse for this assignment.
Create a Database: Create a database called sales_db_skip_file.

Create a Table: Create a table named sales_skip_file with the following schema:
order_id INTEGER
customer_id INTEGER
customer_name STRING
order_date DATE
product STRING
quantity INTEGER
price FLOAT
complete_address STRING

Create a Stage: Create a named stage s3_stage_skip_file that points to the S3 bucket containing the two CSV files.
S3 Path: s3://snowflake-hands-on-data/sample_data_with_errors/mixed_multiple/
File Names: sales_sample_data_with_errors_1.csv, sales_sample_data_with_errors_2.csv
One file has errors, while the other is error-free.
AWS Access Key: 8888888888888
AWS Secret Key: 8888888888888

Load Data Using ON_ERROR = 'SKIP_FILE': Load data from both files into the sales_skip_file table, using the ON_ERROR = 'SKIP_FILE' option. This option tells Snowflake to skip any file that contains errors and load only the valid file.
Observe the Outcome: Verify the data loaded into the table and observe that only the valid file was loaded, while the erroneous file was skipped.
Clean Up: Once done, drop the stage, table, and database.


TASK 5:- Handling Multiple Files with ON_ERROR = 'SKIP_FILE_30%'
Use the Demo Warehouse: Ensure you are using the demo warehouse for this assignment.
Create a Database: Create a database called sales_db_skip_file_30.

Create a Table: Create a table named sales_skip_file_30 with the following schema:
order_id (INTEGER)
customer_id (INTEGER)
customer_name (VARCHAR)
order_date (DATE)
product (VARCHAR)
quantity (INTEGER)
price (FLOAT)
complete_address (VARCHAR)

Create a Named Stage: Create a named stage s3_stage_skip_file_30 that points to the S3 bucket containing the two CSV files.
S3 Path: s3://snowflake-hands-on-data/sample_data_with_errors/mixed_multiple/
File Names: sales_sample_data_with_errors_1.csv, sales_sample_data_with_errors_2.csv
One file contains errors, and the other does not.
AWS Access Key: 8888888888888888
AWS Secret Key: 8888888888888888

Load Data Using ON_ERROR = 'SKIP_FILE_30%': Load data from both files into the sales_skip_file_30 table using the ON_ERROR = 'SKIP_FILE_30%' option. This tells Snowflake to skip any file that has more than 30% of its rows containing errors and load the valid file(s).
Observe the Outcome: Verify the data loaded into the table and observe that any file with errors exceeding 30% is skipped, while the valid file is loaded.
Clean Up: Once done, drop the stage, table, and database.

