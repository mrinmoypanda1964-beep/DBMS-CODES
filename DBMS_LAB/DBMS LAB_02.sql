CREATE DATABASE CLASSROOM;
CREATE TABLE CLASSROOM.STUDENTS (
    ROLL INT,
    Name VARCHAR(30),
    Address VARCHAR(30),
    MARKS INT
);

INSERT INTO CLASSROOM.STUDENTS (ROLL, Name, Address, MARKS) VALUES
(1, 'A', 'KOLKATA', 80),
(2, 'B', 'DELHI', 90),
(3, 'C', 'MUMBAI', 95),
(4, 'D', 'CHENNAI', 100),
(5, 'E', 'DELHI', 90);
-- Select the minimum marks from all students
SELECT MIN(MARKS) AS MinimumMarks FROM CLASSROOM.STUDENTS;

-- Select the maximum marks from the first 3 students ordered by ROLL
SELECT MAX(MARKS) AS MaximumMarks
FROM (
    SELECT MARKS FROM CLASSROOM.STUDENTS
    ORDER BY ROLL
    LIMIT 3
) AS FirstThree;

-- Calculate the sum of all marks from all students
SELECT SUM(MARKS) AS TotalMarks FROM CLASSROOM.STUDENTS;

-- Calculate the avreage of all marks from all students
SELECT AVG(MARKS) AS AverageMarks FROM CLASSROOM.STUDENTS;

-- Count the total number of students (rows) in the STUDENTS table
SELECT COUNT(*) AS TotalStudents FROM CLASSROOM.STUDENTS;
-- COUNT(*) counts all rows in the table, including those with NULL values in any column.

-- Count the total number of distinct (unique) MARKS values in the STUDENTS table
SELECT COUNT(DISTINCT MARKS) AS DistinctMarksCount FROM CLASSROOM.STUDENTS;
-- COUNT(DISTINCT MARKS) counts how many unique MARKS values exist, ignoring duplicates.
-- AS DistinctMarksCount gives a readable name to the result column.

-- Select all students ordered by MARKS in ascending order (lowest to highest)
SELECT * FROM CLASSROOM.STUDENTS
ORDER BY MARKS ASC;

-- Select all students ordered by MARKS in descending order (highest to lowest)
SELECT * FROM CLASSROOM.STUDENTS
ORDER BY MARKS DESC;

SELECT * FROM CLASSROOM.STUDENTS
ORDER BY 
    MARKS DESC,  -- Sorts the rows by MARKS in descending order (highest marks first)
    ROLL DESC;   -- If MARKS are the same, sorts those rows by ROLL in descending order (highest roll first)

-- Select students who are from 'DELHI' AND have marks greater than 90
SELECT * FROM CLASSROOM.STUDENTS
WHERE Address = 'DELHI' AND MARKS > 90;

-- Select students who are either from 'KOLKATA' OR have marks equal to 90
SELECT * FROM CLASSROOM.STUDENTS
WHERE Address = 'KOLKATA' OR MARKS = 90;

-- Select students whose Address starts with the letter 'K'
SELECT * FROM CLASSROOM.STUDENTS
WHERE Address LIKE 'K%';
-- 'K%' means the value should start with 'K' followed by any number of characters

-- Select students whose Address ends with the letter 'I'
SELECT * FROM CLASSROOM.STUDENTS
WHERE Address LIKE '%I';
-- '%I' means the value can start with any characters but must end with 'I'