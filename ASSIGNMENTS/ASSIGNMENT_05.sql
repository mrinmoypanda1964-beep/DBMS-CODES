/*
ASSIGNMENT 5
1) Show NAME, LOCATION, PHONE_NUMBER from EMPLOYEE table by dept.
2) Orders & Customers join.
3) Create view for customers from a location.
4) Create aliases.
5) GRANT & REVOKE example.

Notes:
- Per your requirement, all numeric columns use INT and text columns use VARCHAR.
- The date literal uses ANSI form: DATE 'YYYY-MM-DD' (works in Oracle; in MySQL use 'YYYY-MM-DD' without DATE).
*/


/* ============================================================
   STEP 1: EMPLOYEE table + query “by department”
   Purpose:
   - Create a simple EMPLOYEE table.
   - Insert one sample row.
   - Select NAME, LOCATION, PHONE_NUMBER for a given department (here: 10).
   Design choices:
   - EMPNO and DEPTNO are INT (identifiers).
   - PHONE_NUMBER stored as VARCHAR because phone numbers may include
     leading zeros or non-numeric characters in real datasets.
   ============================================================ */
CREATE TABLE EMPLOYEE (
    EMPNO        INT,            -- Employee unique ID (integer identifier)
    NAME         VARCHAR(20),    -- Employee name (text up to 20 chars)
    LOCATION     VARCHAR(20),    -- City/location (text up to 20 chars)
    PHONE_NUMBER VARCHAR(15),    -- Phone as text to preserve formatting
    DEPTNO       INT             -- Department number (integer identifier)
);

-- Sample row (dept 10). Add more INSERTs as needed for testing.
INSERT INTO EMPLOYEE VALUES (1, 'Amit', 'Kolkata', '9876543210', 10);

-- Query: “by dept” = filter with WHERE DEPTNO = 10.
-- Returns only the three requested columns.
SELECT NAME, LOCATION, PHONE_NUMBER
FROM EMPLOYEE
WHERE DEPTNO = 10;


/* ============================================================
   STEP 2: Orders & Customers join
   Purpose:
   - Demonstrate a basic INNER JOIN between ORDERS and CUSTOMERS.
   Design choices:
   - CUSTOMERID is INT in both tables to join on the same data type.
   - ORDERDATE is a DATE column; we use ANSI date literal for clarity.
   - The SELECT shows ORDERID beside CUSTOMERNAME to verify the join.
   Tip:
   - In a production schema, define PRIMARY KEY / FOREIGN KEY constraints.
   ============================================================ */
CREATE TABLE CUSTOMERS (
    CUSTOMERID   INT,            -- Customer unique ID
    CUSTOMERNAME VARCHAR(30),    -- Display name of the customer
    CONTACTNAME  VARCHAR(30),    -- Contact person name
    COUNTRY      VARCHAR(20)     -- Country/region
);

CREATE TABLE ORDERS (
    ORDERID    INT,              -- Order unique ID
    CUSTOMERID INT,              -- References CUSTOMERS.CUSTOMERID
    ORDERDATE  DATE              -- Order date
);

-- Sample data: One customer and one order placed by that customer.
INSERT INTO CUSTOMERS VALUES (1, 'Ravi', 'Ravi Kumar', 'India');
-- ANSI date literal (Oracle-friendly). For MySQL, just use '2023-01-10'.
INSERT INTO ORDERS VALUES (101, 1, DATE '2023-01-10');

-- INNER JOIN: returns rows where the CUSTOMERID matches in both tables.
SELECT O.ORDERID, C.CUSTOMERNAME
FROM ORDERS O
JOIN CUSTOMERS C ON O.CUSTOMERID = C.CUSTOMERID;


/* ============================================================
   STEP 3: Create a view for customers from a location
   Purpose:
   - Create a simple VIEW that filters CUSTOMERS by COUNTRY = 'India'.
   Notes:
   - A VIEW stores the query; it does not duplicate data.
   - Selecting from the view always reflects current data in CUSTOMERS.
   ============================================================ */
CREATE VIEW INDIAN_CUSTOMERS AS
SELECT *
FROM CUSTOMERS
WHERE COUNTRY = 'India';

-- Example usage:
-- SELECT * FROM INDIAN_CUSTOMERS;


/* ============================================================
   STEP 4: Column aliases (renaming in result set)
   Purpose:
   - Show how to rename columns in SELECT output for readability.
   Notes:
   - The AS keyword is optional; both "AS NAME" and just "NAME" work.
   - Aliases do not change table structure—only the output column headers.
   ============================================================ */
SELECT CUSTOMERID AS ID,
       CUSTOMERNAME AS NAME
FROM CUSTOMERS;


/* ============================================================
   STEP 5: GRANT & REVOKE example
   Purpose:
   - Demonstrate granting and revoking SELECT privileges on a table.
   Notes:
   - PUBLIC means “all users”. In real systems, prefer roles or specific users.
   - You need sufficient privileges to issue GRANT/REVOKE.
   - Syntax varies by RDBMS; this example follows Oracle-style semantics.
   ============================================================ */
GRANT SELECT ON CUSTOMERS TO PUBLIC;      -- Allow everyone to SELECT from CUSTOMERS
REVOKE SELECT ON CUSTOMERS FROM PUBLIC;   -- Remove that permission again
