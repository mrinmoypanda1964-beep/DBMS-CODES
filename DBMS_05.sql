-- Create the Orders table with consistent column names
CREATE TABLE Orders (
    Order_id INT PRIMARY KEY,         -- no auto_increment, so must specify Order_id in inserts
    item VARCHAR(100) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,  -- changed amount to DECIMAL to allow decimals
    customer_id INT                   -- renamed to customer_id to match inserts
);

-- Insert initial rows with Order_id explicitly specified
INSERT INTO Orders (Order_id, item, amount, customer_id)
VALUES 
    (1, 'Keyboard', 400.00, 4),
    (2, 'Mouse', 300.00, 4),
    (3, 'Monitor', 12000.00, 3),
    (4, 'Keyboard', 400.00, 1),
    (5, 'Mousepad', 250.00, 2);

-- Start a transaction (use START TRANSACTION for compatibility)
START TRANSACTION;

-- Insert a new order with explicit Order_id
INSERT INTO Orders (Order_id, item, amount, customer_id)
VALUES (6, 'Tablet', 450.00, 4);

-- Set a savepoint after first insert
SAVEPOINT after_first_insert;

-- Insert another order which may need correction
INSERT INTO Orders (Order_id, item, amount, customer_id)
VALUES (7, 'Smartwatch', 250.00, 5);

-- Rollback to savepoint to undo last insert but keep first insert
ROLLBACK TO after_first_insert;

-- Insert corrected data for the second order
INSERT INTO Orders (Order_id, item, amount, customer_id)
VALUES (7, 'Smartwatch', 270.00, 5);

-- Commit the transaction to save all changes
COMMIT;