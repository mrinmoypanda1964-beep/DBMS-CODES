/*
ASSIGNMENT 4
1. Show employee name, dept name & job.
2. Dept name, no. of employees, avg salary.
3. No. of jobs per department.
4. Group by first character of name, show in descending order.
*/


/* Assume DEPT table exists */
CREATE TABLE DEPT (
    DEPTNO INT(3),        -- Department number (primary key)
    DNAME  VARCHAR(20)      -- Department name
);

-- Insert sample department records
INSERT INTO DEPT VALUES (10, 'HR');
INSERT INTO DEPT VALUES (20, 'Finance');
INSERT INTO DEPT VALUES (30, 'Sales');


/* Step 1: Show employee name, department name, and job
   - Join EMP and DEPT on DEPTNO (common column).
   - E.ENAME → employee name, D.DNAME → department name, E.JOB → job title. */
SELECT E.ENAME, D.DNAME, E.JOB
FROM EMP E 
JOIN DEPT D ON E.DEPTNO = D.DEPTNO;


/* Step 2: Show department name, number of employees, and average salary
   - COUNT(E.EMPNO) → total employees per department.
   - AVG(E.SAL) → average salary per department.
   - GROUP BY D.DNAME → ensures results are grouped by department. */
SELECT D.DNAME, 
       COUNT(E.EMPNO) AS NUM_EMPLOYEES, 
       AVG(E.SAL)     AS AVG_SALARY
FROM EMP E 
JOIN DEPT D ON E.DEPTNO = D.DEPTNO
GROUP BY D.DNAME;


/* Step 3: Show number of jobs per department
   - DISTINCT JOB ensures we count unique job types.
   - GROUP BY DEPTNO groups results per department. */
SELECT DEPTNO, 
       COUNT(DISTINCT JOB) AS NUM_JOBS
FROM EMP
GROUP BY DEPTNO;


/* Step 4: Group employees by first character of ENAME
   - SUBSTR(ENAME,1,1) extracts the first character of employee name.
   - GROUP BY groups employees having the same first character.
   - COUNT(*) counts how many employees fall under each group.
   - ORDER BY FirstChar DESC shows results in reverse alphabetical order. */
SELECT SUBSTR(ENAME,1,1) AS FIRST_CHAR, 
       COUNT(*) AS EMP_COUNT
FROM EMP
GROUP BY SUBSTR(ENAME,1,1)
ORDER BY FIRST_CHAR DESC;
