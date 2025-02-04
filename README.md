# D326_Advanced_Data_Management

### Project Overview

Data analysts frequently transform data within a database so that it can be used for analysis and so that the data will be easier for nontechnical users to use and understand. This project will emulate such a process in this task by choosing my own business question to analyze, creating tables and queries to use as a business report, and streamlining my analysis by writing my own SQL functions, triggers, and stored procedures.

This task defines a report as a collection of data that answers a real-world business question. This report will have two distinct sections (SQL tables that will be created) that differ in the granularity of the data they present and how directly they support the answering of the business question I chose. The detailed table will contain all data that informs the answer to the question at a very granular level, and the summary table will contain aggregated data that provide a direct answer to the business question. 

This project and the SQL code created for it utlizies the [PostgreSQL Sample DB ](https://neon.tech/postgresql/postgresql-getting-started/postgresql-sample-database)

### A. Summarize one real-world written business report that can be created from the DVD Dataset from the “Labs on Demand Assessment Environment and DVD Database” attachment

The purpose of this business report is that it aims to identify how frequently a customer rents a film from the DVD Rental Store. This is to provide the business insight with departments such as marketing to promote new programs such as a points or rewards system. They can use this to reward customers with discounted rental fees, BOGOs, or free movies if they reach a certain number of points to redeem. This would also target the sales department and help increase revenue for the business.

### A1. Identify the specific fields that will be included in the detailed table and the summary table of the report
<span>Detailed Table: **detailed_table**<span>

| Column      |  Data Type      |  Referenced Table  |
| :---------: | :----------:    | :----------------: |
| Customer_id |	    INT         |       Customer     |
| First_name	|   VARCHAR(45)   |	      Customer     |
| Last_name	  |   VARCHAR(45)   |       Customer     |
| Email       |   VARCHAR(100)  |       Customer     |
| Rental_id   |     INT	        |        Rental      |

</br>

<span>Summary Table: **summary_table**<span>

| Column        |  Data Type      |  Referenced Table  |
| :-----------: | :-------------: | :----------------: |
| Customer_id   |	    INT         |       Customer     |
| Full_name     |   VARCHAR(100)  |       Customer     |
| Email         |   VARCHAR(100)  |       Customer     |
| Total_rentals |     INT	        |        Rental      |

</br>

Full_name	column is transformed by the first_name & last_name columns from the detailed table.
</br>
Total_rentals	is aggregated count of rentals made by each customer within the detailed table.
</br>

### A2. Describe the types of data fields used for the report

Detailed Table:
1.	Customer_id: INTEGER, this represents numerical data stored as a unique identifier, identifying each customer registered in the business’s database
2.	First_name: VARCHAR(45), this represents data stored as a string type, listing the first name of each customer
3.	Last_name: VARCHAR(45), this represents data stored as a string type, listing the last name of each customer
4.	Email: VARCHAR(100), this represents data stored as a string type, listing the email for each customer
5.	Rental_id: INTEGER, this represents numerical data stored as a unique identifier, identifying each movie rental
6.	Rental_date: TIMESTAMP WITHOUT TIME ZONE, represents the date and time data is stored as a timestamp data type, indicating the date and time the film was rented

</br>

Summary Table:
1.	Customer_id: INTEGER, represents numerical data stored as a unique identifier for each customer
2.	Email: VARCHAR(100), represents data stored as a string type, listing the email address of each customer
3.	Full_name: VARCHAR(100), represents data stored as a string type transformed by combining the first_name and last_name columns
4.	Total_rentals: INTEGER, represents numerical data stored as the total number of rentals each customer has made

</br>

### A3. Identify at least two specific tables from the given dataset that will provide the data necessary for the detailed table section and the summary table section of the report.

- **Rental Table**: This table contains the transaction details including the rental IDs which will be used in both the detailed and summary tables.
- **Customer Table**: This contains the details of each customer that is registered in the database. We will use this to sum up the total rentals each customer has made.

</br>

### A4. Identify at least one field in the detailed table section that will require a custom transformation with a user-defined function and explain why it should be transformed (e.g., you might translate a field with a value of N to No and Y to Yes).

There are two fields that will require a custom transformation and that is the first_name and last_name columns. These two fields will be combined into one field under the new attribute ‘full_name’ which will be included in the summary table. This would be essential to the business for when staff wants to look up each customer total rentals that they have made for the month, and they can do so by having the option to search by the customers full name instead of individually by their first or last name. This would also help eliminate repetitive names and narrow down searches by using the full name option in the summary table.

</br>

### A5. Explain the different business uses of the detailed table section and the summary table section of the report.

The detailed table section will provide a view of the individual customers, and rental ids and their occurred rental dates. This is valuable for business uses to promote marketing strategies and having the rental data will help the business track how frequently each customer rents a movie from the business.

</br>

The summary table section provides an overview of total rental records that each customer has made at that time. This will be useful for marketing and sales purposes such as rewards, BOGOs, earning points based on the type of movie or how many movies you rent, or every $1 gets you a certain number of points. etc.

</br>

### A6. Explain how frequently your report should be refreshed to remain relevant to stakeholders.

This report is designed to be refreshed monthly because the summarized data is aggregated to count the number of rentals that have occurred in that month. By having this refresh rate occur monthly, it can be used by the business in monthly meetings that go over any overall update to the business, and n   be reviewed in marketing strategies to promote more sales and customer satisfaction rates.

</br>

### B. Provide original code for function(s) in text format that perform the transformation(s) you identified in part A4.

Example code located in DVD_DB_Proj.sql

</br>

### C. Provide original SQL code in a text format that creates the detailed and summary tables to hold your report table sections.

Example code located in DVD_DB_Proj.sql

</br>

### D. Provide an original SQL query in a text format that will extract the raw data needed for the detailed section of your report from the source database.

Example code located in DVD_DB_Proj.sql

</br>

### E. Provide original SQL code in a text format that creates a trigger on the detailed table of the report that will continually update the summary table as data is added to the detailed table.

Example code located in DVD_DB_Proj.sql

</br>

### F. Provide an original stored procedure in a text format that can be used to refresh the data in both the detailed table and summary table. The procedure should clear the contents of the detailed table and summary table and perform the raw data extraction from part D.

Example code located in DVD_DB_Proj.sql

</br>

### F1. Identify a relevant job scheduling tool that can be used to automate the stored procedure.

A relevant job scheduling tool that can be used is pgAgent. This is a handy tool that can be used to automate the stored procedure above. pgAgent is a job scheduling tool for PostgreSQL that allows the execution of stored procedures, SQL statements, and shell scripts (Dias, 2022). pgAgent can be easily managed by PgAdmin 4 after installing both tools.

</br>

### Section G is a video for this course that has been submitted to WGU. The video will not be accessible to outside users.

</br>

### H. Acknowledge all utilized sources, including any sources of third-party code, using in-text citations and references. If no sources are used, clearly declare that no sources were used to support your submission.

References

</br>
	
Dias, H. (2022, May 4). An Overview of Job Scheduling Tools for PostgreSQL [Review of An Overview of Job Scheduling Tools for PostgreSQL]. An Overview of Job Scheduling Tools for PostgreSQL. https://severalnines.com/blog/overview-job-scheduling-tools-postgresql/

