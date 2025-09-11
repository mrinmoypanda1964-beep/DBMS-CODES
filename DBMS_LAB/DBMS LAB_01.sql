-- Create a new database named 'iemcollege'
CREATE DATABASE iemcollege;


-- Create a table 'students' with columns:
-- Student_ID (primary key), NAME (not null), ADDRESS (default value), and YEAR
CREATE TABLE iemcollege.students (
    Student_ID INT PRIMARY KEY,
    NAME VARCHAR(100) NOT NULL,   
    ADDRESS VARCHAR(100) DEFAULT 'KOLKATA',
    YEAR INT
);

-- Add two new columns to the existing 'students' table:
-- PhoneNumber (string up to 15 chars) and AGE (integer)
ALTER TABLE iemcollege.students
ADD (
    PhoneNumber VARCHAR(15),
    AGE INT
);

-- Insert multiple rows into the 'students' table
-- Using correct column name 'ADDRESS' and DEFAULT keyword where needed
INSERT INTO iemcollege.students (Student_ID, NAME, ADDRESS, YEAR)
VALUES 
  (123, 'A', NULL, 3),          -- NULL overrides default 'KOLKATA'
  (456, 'B', 'MUMBAI', 3),      -- Explicit ADDRESS
  (789, 'C', 'CHENNAI', 3),     -- Explicit ADDRESS
  (380, 'D', DEFAULT, 3);        -- Use DEFAULT to insert 'KOLKATA'

-- Update AGE to 18 for the student whose Student_ID is 456
UPDATE students
SET AGE = 18
WHERE Student_ID = 456;

-- Delete the row where Student_ID is 456
-- Important notes:
-- Always use a WHERE clause to avoid deleting all rows.
-- If you omit WHERE, all rows in the table will be deleted.
DELETE FROM students WHERE Student_ID = 456;

-- Describe the structure of the 'students' table (shows columns, types, keys, etc.)
DESC students;