/*
ASSIGNMENT 3
1. Show number of employees, min & max salary per department.
2. Update Email based on dept id.
3. Compare DELETE vs TRUNCATE.
4. Dept-wise employee count (salary > 5000), filter avg salary > 6500.
5. Insert new employee (Scott, Tiger).
6. Show day, month, year of hiredate.
*/


/* Step 1: Show number of employees, minimum & maximum salary per department
   - COUNT(*) → total employees in each department
   - MIN(SAL), MAX(SAL) → salary range in each department
   - GROUP BY DEPTNO ensures results are grouped department-wise */
SELECT DEPTNO, 
       COUNT(*) AS EMP_COUNT, 
       MIN(SAL) AS MIN_SALARY, 
       MAX(SAL) AS MAX_SALARY
FROM EMP 
GROUP BY DEPTNO;


/* Step 2: Add and update EMAIL column based on department number
   - ALTER TABLE is used to add a new column EMAIL of VARCHAR2(30).
   - UPDATE sets email dynamically using ENAME and department condition.
*/
ALTER TABLE EMP ADD EMAIL VARCHAR(30);

-- For deptno < 1000
UPDATE EMP
SET EMAIL = CONCAT(ENAME, '@oracle.com')
WHERE DEPTNO < 1000;

-- For deptno < 5000
UPDATE EMP
SET EMAIL = CONCAT(ENAME, '@oracle.co.uk')
WHERE DEPTNO < 5000;

-- For deptno >= 5000
UPDATE EMP
SET EMAIL = CONCAT(ENAME, '@oracle.co.in')
WHERE DEPTNO >= 5000;



/* Step 3: DELETE vs TRUNCATE
   - DELETE removes specific rows based on condition; it can be rolled back (UNDO possible).
   - TRUNCATE removes all rows quickly and cannot be rolled back (no WHERE allowed).
   - Both remove data, but DELETE = selective & recoverable, TRUNCATE = fast & permanent. */

-- Example: DELETE (only clerks removed, can rollback with ROLLBACK)
DELETE FROM EMP WHERE JOB = 'CLERK';

-- Example: TRUNCATE (all rows removed permanently, cannot rollback)
TRUNCATE TABLE EMP;


/* Step 4: Department-wise employee count (only salaries > 5000)
   - WHERE SAL > 5000 filters eligible employees.
   - COUNT(*) → number of such employees per department.
   - AVG(SAL) → average salary per department.
   - HAVING AVG(SAL) > 6500 filters only departments with avg salary > 6500. */
SELECT DEPTNO, 
       COUNT(*) AS EMP_COUNT, 
       AVG(SAL) AS AVG_SALARY
FROM EMP
WHERE SAL > 5000
GROUP BY DEPTNO
HAVING AVG(SAL) > 6500;


/* Step 5: Insert a new employee 'Scott Tiger'
   - INSERT INTO adds a new row into EMP table.
   - Make sure EMPNO is unique.
   - HIREDATE must be properly converted to DATE using TO_DATE(). */
INSERT INTO EMP (EMPNO, ENAME, JOB, DEPTNO, SAL, HIREDATE, EMAIL)
VALUES (10000, 'Scott Tiger', 'Company President', 280, 50000, '2014-02-01', 'stiger@oracle.com');

/* Step 6: Show day, month, and year from HIREDATE
   - TO_CHAR(date, format) extracts specific parts of a DATE column.
   - 'DD' → Day, 'MM' → Month, 'YYYY' → Year. */
SELECT ENAME,
       DATE_FORMAT(HIREDATE, '%d') AS DAY,
       DATE_FORMAT(HIREDATE, '%m') AS MONTH,
       DATE_FORMAT(HIREDATE, '%Y') AS YEAR
FROM EMP;

