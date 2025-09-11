/*
ASSIGNMENT 2
Queries on EMP table:
1. Select all columns.
2. Select only Empname and Job.
3. Select unique Jobs.
4. Select only salesmen.
5. Display employee name, job, salary in order of salary.
6. Show % increment if salary increased by 200.
7. Show work experience using SYSDATE and HIREDATE.
8. Compare DROP and ALTER with examples.
*/


/* Step 1: Select all columns 
   - The * symbol selects all the columns from the EMP table. */
SELECT * FROM EMP;


/* Step 2: Select only ENAME and JOB 
   - This displays only the employee name and job from the EMP table. */
SELECT ENAME, JOB FROM EMP;


/* Step 3: Unique Jobs 
   - DISTINCT ensures duplicate job roles are not repeated. */
SELECT DISTINCT JOB FROM EMP;


/* Step 4: Select only Salesmen 
   - WHERE condition is used to filter rows.
   - Only employees whose JOB is 'SALESMAN' will be shown. */
SELECT ENAME, JOB FROM EMP 
WHERE JOB = 'SALESMAN';


/* Step 5: Display employee name, job, salary in order of salary 
   - ORDER BY arranges results in ascending order (lowest to highest).
   - To show highest salary first, use ORDER BY SAL DESC. */
SELECT ENAME, JOB, SAL 
FROM EMP 
ORDER BY SAL;


/* Step 6: Show percentage increment if salary increased by 200 
   - Formula: (Increment ÷ Original Salary) × 100 
   - Here increment = 200, so percentage = (200/SAL)*100 */
SELECT ENAME, SAL, (200/SAL)*100 AS PCT_INCR
FROM EMP;


/* Step 7: Show work experience of employees 
   - HIREDATE column must exist in EMP table (Date of Joining).
   - MONTHS_BETWEEN(SYSDATE, HIREDATE) gives total months worked.
   - Divide by 12 and take FLOOR() to get complete years. */

/* Add HIREDATE column (if not already present) */
ALTER TABLE EMP ADD HIREDATE DATE;

/* Update HIREDATE values (example data for demo) */
UPDATE EMP SET HIREDATE = TO_DATE('2020-01-01', 'YYYY-MM-DD') WHERE EMPNO = 101;
UPDATE EMP SET HIREDATE = TO_DATE('2021-06-15', 'YYYY-MM-DD') WHERE EMPNO = 102;
UPDATE EMP SET HIREDATE = TO_DATE('2019-03-10', 'YYYY-MM-DD') WHERE EMPNO = 103;

/* Calculate work experience in years */
SELECT ENAME, 
       FLOOR(MONTHS_BETWEEN(SYSDATE, HIREDATE)/12) AS YEARS_EXPERIENCE
FROM EMP;


/* Step 8: Compare DROP and ALTER with examples */

/* DROP Example:
   - DROP deletes a table permanently along with its data.
   - Once dropped, the table cannot be retrieved unless restored from backup. */
CREATE TABLE TEST (ID INT);
DROP TABLE TEST;

/* ALTER Example:
   - ALTER modifies the structure of an existing table (without removing data).
   - Here, we add a new column BONUS to the EMP table. */
ALTER TABLE EMP ADD BONUS INT;
