-- Create the database IEM
CREATE DATABASE IEM;

-- Create the Stud table with student ID, name, and mobile number
CREATE TABLE IEM.Stud (
    S_id INT,
    Sname VARCHAR(50),
    Mobile_no INT
);

-- Create the DEPART table with department ID, name, and associated student ID
CREATE TABLE IEM.DEPART (
    D_id VARCHAR(50),
    Dname VARCHAR(50),
    S_id INT
);

-- Insert sample data into Stud table
INSERT INTO IEM.Stud (S_id, Sname, Mobile_no) VALUES
    (1, 'A', 123),
    (2, 'B', 345),
    (3, 'C', 697),
    (4, 'D', 565);

-- Insert sample data into DEPART table
INSERT INTO IEM.DEPART (D_id, Dname, S_id) VALUES
    ('D1', 'ECE', 1),
    ('D2', 'IT', 2),
    ('D3', 'CSE', 3),
    ('D4', 'AI', 1);

-- Add new column 'Address' to Stud table to store student addresses
ALTER TABLE IEM.Stud ADD Address VARCHAR(100);

-- Update Address column with sample addresses for each student
UPDATE IEM.Stud
SET Address = CASE S_id
    WHEN 1 THEN 'KOL'
    WHEN 2 THEN 'VIZ'
    WHEN 3 THEN 'DEL'
    WHEN 4 THEN 'BANG'
END;

-- Add new column 'Location' to DEPART table to store department locations
ALTER TABLE IEM.DEPART ADD Location VARCHAR(100);

-- Update Location column with sample locations for each department's student ID
UPDATE IEM.DEPART
SET Location = CASE S_id
    WHEN 1 THEN 'KOL'
    WHEN 2 THEN 'USA'
    WHEN 3 THEN 'UK'
    WHEN 4 THEN 'DUBAI'
END;

-- If you get an error about safe mode during UPDATE or DELETE,
-- run this command before your updates to disable safe update mode temporarily:
-- SET SQL_SAFE_UPDATES = 0;

-- Query to display S_ids of students who belong to more than one department using self join
SELECT DISTINCT DEPART1.S_id  
FROM IEM.DEPART AS DEPART1, IEM.DEPART AS DEPART2  
WHERE DEPART1.S_id = DEPART2.S_id        -- Match student IDs (same student)  
  AND DEPART1.D_id <> DEPART2.D_id;      -- Ensure different departments for that student