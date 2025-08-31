-- Step 1: Create the database
CREATE DATABASE CustomerDB;

-- Step 2: Use the database
USE CustomerDB;

-- Step 3: Create the first table
CREATE TABLE Customer1 (
    customer_id INT PRIMARY KEY ,
    first_name VARCHAR(50) NOT NULL,
    age INT,
    country VARCHAR(50)
);

-- Step 4: Create the second table
CREATE TABLE Customer2 (
    customer_id INT PRIMARY KEY ,
    first_name VARCHAR(50) NOT NULL,
    age INT,
    country VARCHAR(50)
);

INSERT INTO Customer1 (customer_id, first_name, age, country)
VALUES 
    (1, 'John', 31, 'USA'),
    (2, 'Robert', 22, 'USA'),
    (3, 'David', 22, 'UK');
    
SELECT* FROM Customer1;

INSERT INTO Customer2 (customer_id, first_name, age, country)
VALUES 
    (4, 'John', 25, 'UK'),
    (5, 'Betty', 28, 'UAE');

SELECT* FROM Customer2;

-- Select all customer records from Customer1
SELECT customer_id, first_name, age, country FROM Customer1
UNION  -- Combine results from Customer1 and Customer2, removing duplicate rows
-- Select all customer records from Customer2
SELECT customer_id, first_name, age, country FROM Customer2;

-- Create a new table named 'customer' using the combined data from Customer1 and Customer2
-- The UNION operation combines rows from both tables and removes duplicates by default
CREATE TABLE customer AS
SELECT customer_id, first_name, age, country FROM Customer1
UNION
SELECT customer_id, first_name, age, country FROM Customer2;


-- Select customer details from Customer1 where the country is 'UK'
SELECT customer_id, first_name, age, country
FROM Customer1
WHERE country = 'UK'
UNION  -- Combine results from the two tables, removing duplicates by default
-- Select customer details from Customer2 where the country is 'UK'
SELECT customer_id, first_name, age, country FROM Customer2
WHERE country = 'UK';

-- Select the count of customers per country from the 'customer' table
-- Group the results by country to aggregate counts for each country
-- Use HAVING clause to filter results where the country is 'UK'
SELECT COUNT(customer_id) AS customer_count, country
FROM customer
GROUP BY country
HAVING country = 'UK';

CREATE TABLE Orders (
    Order_id INT PRIMARY KEY,
    item VARCHAR(100) NOT NULL,
    amount INT NOT NULL,
    customer INT
);

INSERT INTO Orders (Order_id, item, amount, customer)
VALUES 
    (1, 'Keyboard', 400, 4),
    (2, 'Mouse', 300, 4),
    (3, 'Monitor', 12000, 3),
    (4, 'Keyboard', 400, 1),
    (5, 'Mousepad',250,2);

-- Select the order ID, item name, and amount from the Orders table
SELECT 
  Order_id,    -- Unique identifier for each order
  item,        -- Name of the product/item ordered
  amount,      -- Price or amount of the order

  -- Categorize the order amount into price tags using a CASE statement
  CASE
    WHEN amount > 500 THEN 'high price'       -- If amount is greater than 500, label as 'high price'
    WHEN amount < 300 THEN 'low price'        -- If amount is less than 300, label as 'low price'
    ELSE 'average price'                       -- Otherwise, label as 'average price'
  END AS price_tag                            -- Alias for the computed price category

FROM Orders;                                  -- From the Orders table