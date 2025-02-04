--- B. Transform Function ---

CREATE OR REPLACE FUNCTION FULLNAME(first_name VARCHAR, last_name VARCHAR)
RETURNS VARCHAR
LANGUAGE plpgsql
AS
$$

DECLARE 
  full_name VARCHAR;
BEGIN
      RETURN CONCAT(full_name, ‘ ‘, last_name) AS full_name;
END;
$$;

--- C. Create Detailed and Summary Tables ---

DROP TABLE IF EXISTS detailed_table;
CREATE TABLE detailed_table (
  customer_id INT,
  first_name VARCHAR(45),
  last_name VARHCAR(45),
  email VARCHAR(100),
  rental_id INT
);

DROP TABLE IF EXISTS summary_table;	
CREATE TABLE summary_table (
  customer_id INT,
  full_name VARCHAR(100),
  email VARCHAR(100),
  total_rentals INT
);

--- Verify that fields are correctly defined ---
SELECT *
FROM detailed_table;

SELECT *
FROM summary_table;

--- D. Extracting the raw data from the Customer and Rental tables into the detailed_table

DELETE FROM detailed_table;
INSERT INTO detailed_table
  SELECT 
          c.customer_id,
          c.first_name,
          c.last_name,
          c.email,
          r.rental_id
  FROM 
          customer c
  INNER JOIN 
          rental r ON c.customer_id = r.customer_id;

--- Verify data was successfully extracted and inserted into the detailed_table
SELECT *
FROM detailed_table;

--- E. Create a trigger to update the summary_table after every insert into the detailed_table ---

--- Creates trigger to update summary data ---
CREATE OR REPLACE FUNCTION summary_data() 
RETURNS TRIGGER 
LANGUAGE plpgsql 
AS 
$$ 
BEGIN
  --- Calls the function FULLNAME and counts the amount of rentals under total_rentals of each customer listed ---
      DELETE FROM summary_table;
      INSERT INTO summary_table(customer_id, full_name, email, total_rentals) 
          SELECT 
                d.customer_id,
                FULLNAME(d.first_name, d.last_name),
                d.email,
                COUNT(customer_id) AS total_rentals 
          FROM 
                detailed_table d
          GROUP BY d.customer_id, d.first_name, d.last_name, d.email 
          ORDER BY total_rentals DESC;
          RETURN NEW;
END; 
$$;

--- Creates trigger on detailed_table ---
DROP TRIGGER IF EXISTS update_summary ON detailed_table;
CREATE TRIGGER update_summary 
AFTER INSERT ON detailed_table 
FOR EACH STATEMENT
EXECUTE PROCEDURE summary_data();

--- Verify if records were updated ---
SELECT *
FROM summary_table;

--- F. Stored Procedure ---

CREATE OR REPLACE PROCEDURE tables_data_refresh()
LANGUAGE plpgsql
AS
$$
BEGIN
      DELETE FROM summary_table;
      DELETE FROM detailed_table;

      INSERT INTO detailed_table
        SELECT 
              c.customer_id,
              c.first_name,
              c.last_name,
              c.email,
              r.rental_id
        FROM 
              customer c
        INNER JOIN 
              rental r ON c.customer_id = r.customer_id;
END;
$$;

--- Call Procedure ---
CALL tables_data_refresh();

--- Verify tables ---
SELECT *
FROM summary_table;

SELECT *
FROM detailed_table;

--- TEST PROCEDURE ---

DELETE FROM summary_table
WHERE total_rentals <= 20;

SELECT *
FROM summary_table
ORDER BY total_rentals;

CALL tables_data_refresh();

SELECT *
FROM summary_table
ORDER BY total_rentals;
