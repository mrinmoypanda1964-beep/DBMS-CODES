/* 
Assignment Question:

1. Create a table called EMP with the following structure:
   - EMPNO NUMBER(6)
   - ENAME VARCHAR2(20)
   - JOB   VARCHAR2(10)
   - DEPTNO NUMBER(3)
   - SAL NUMBER(7,2)
   - Allow NULL for all columns except ENAME and JOB.

2. Add a column “experience” to the EMP table (numeric, NULL allowed).

3. Modify the column width of the JOB field of EMP table.

4. Create the EMP1 table with ENAME and EMPNO.
   - Add constraints to check that EMPNO value > 100.
*/

------------------------------------------------------
-- 1. Create EMP table
------------------------------------------------------
CREATE TABLE EMP (
    EMPNO   NUMBER(6),              -- Employee number (numeric, max 6 digits)
    ENAME   VARCHAR2(20) NOT NULL,  -- Employee name (cannot be NULL)
    JOB     VARCHAR2(10) NOT NULL,  -- Job title (cannot be NULL)
    DEPTNO  NUMBER(3),              -- Department number
    SAL     NUMBER(7,2)             -- Salary with 2 decimal places
);

-- Check structure of EMP table
DESC EMP;


------------------------------------------------------
-- 2. Add a new column "experience"
------------------------------------------------------
ALTER TABLE EMP
ADD experience NUMBER;

-- Check structure after adding experience
DESC EMP;


------------------------------------------------------
-- 3. Modify JOB column width (10 → 15)
------------------------------------------------------
ALTER TABLE EMP
MODIFY JOB VARCHAR2(15) NOT NULL;

-- Check structure after modifying JOB
DESC EMP;


------------------------------------------------------
-- 4. Insert sample data into EMP
------------------------------------------------------
INSERT INTO EMP (EMPNO, ENAME, JOB, DEPTNO, SAL, experience)
VALUES (101, 'Alice', 'Manager', 10, 60000.50, 5);

INSERT INTO EMP (EMPNO, ENAME, JOB, DEPTNO, SAL, experience)
VALUES (102, 'Bob', 'Clerk', 20, 25000.00, 2);

INSERT INTO EMP (EMPNO, ENAME, JOB, DEPTNO, SAL, experience)
VALUES (103, 'Charlie', 'Analyst', 10, 40000.75, NULL);

-- View EMP data
SELECT * FROM EMP;


------------------------------------------------------
-- 5. Create EMP1 table with CHECK constraint
------------------------------------------------------
CREATE TABLE EMP1 (
    EMPNO NUMBER(6) CHECK (EMPNO > 100),  -- EMPNO must be > 100
    ENAME VARCHAR2(20) NOT NULL
);

-- Check structure of EMP1
DESC EMP1;


------------------------------------------------------
-- 6. Insert sample data into EMP1
------------------------------------------------------
INSERT INTO EMP1 VALUES (150, 'David');   -- Valid
INSERT INTO EMP1 VALUES (200, 'Emma');    -- Valid

-- This will fail (constraint violation):
-- INSERT INTO EMP1 VALUES (50, 'FailTest');

-- View EMP1 data
SELECT * FROM EMP1;
