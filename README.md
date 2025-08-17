# Snowflake Project 3: Error Handling

This project demonstrates Snowflake’s error handling capabilities while loading data from Amazon S3. It covers:

- Loading data with errors  
- Observing and documenting errors  
- Using various error handling options such as VALIDATION_MODE, ON_ERROR = CONTINUE, ON_ERROR = SKIP_FILE, and ON_ERROR = SKIP_FILE_30%  
- Managing multiple files and ensuring that valid data is ingested while errors are handled efficiently  

The objective is to understand how Snowflake allows robust data ingestion even when source data may contain inconsistencies or errors.

---

## Prerequisites

- Active Snowflake account  
- Access to Snowflake Web UI or SnowSQL  
- AWS credentials with access to the specified S3 buckets  
- Demo warehouse created in Project 1  

---

## Tasks Performed

### TASK 1: Loading Data with Errors
- Created a database and table for sales data containing errors  
- Created a named stage pointing to the S3 bucket with erroneous CSV data  
- Attempted to load data and observed the errors generated  
- Cleaned up by dropping the database, table, and stage  

---

### TASK 2: Validation Mode for Detailed Error Handling
- Created a database and table for sales data  
- Created a named stage pointing to the S3 bucket with errors  
- Used `VALIDATION_MODE = RETURN_ERRORS` to observe detailed error information without loading data  
- Documented the errors and cleaned up all objects after verification  

---

### TASK 3: Handling Data Errors with ON_ERROR = CONTINUE
- Created a database and table for sales data  
- Loaded data using `ON_ERROR = CONTINUE` to skip erroneous rows while ingesting valid data  
- Verified how many rows were skipped and observed successful loading of valid rows  
- Cleaned up all objects  

---

### TASK 4: Handling Multiple Files with ON_ERROR = SKIP_FILE
- Created a database and table for sales data  
- Created a named stage pointing to multiple CSV files (some with errors, some valid)  
- Loaded data using `ON_ERROR = SKIP_FILE` to skip files containing errors while loading valid files  
- Verified outcome and cleaned up objects  

---

### TASK 5: Handling Multiple Files with ON_ERROR = SKIP_FILE_30%
- Created a database and table for sales data  
- Created a named stage pointing to multiple CSV files  
- Loaded data using `ON_ERROR = SKIP_FILE_30%` to skip files where more than 30% of rows contained errors  
- Verified outcome and cleaned up objects  

---

## Real-World Relevance

- Error Handling is critical for ensuring clean, reliable data ingestion in production environments  
- Validation Mode allows data engineers to identify problematic records before they affect reporting or analytics  
- ON_ERROR Options provide flexibility to skip rows or files, enabling robust data pipelines for real-time or batch ingestion
