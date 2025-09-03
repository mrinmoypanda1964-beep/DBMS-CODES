/* 
Assignment Question:

1. Create a table called EMP (EMPLOYEE) with fields:
   - EMPNO   NUMBER(6)
   - ENAME   VARCHAR2(20)
   - JOB     VARCHAR2(10)
   - DEPTNO  NUMBER(3)
   - SAL     NUMBER(7,2)
   - HIREDATE DATE (added to calculate experience)

2. Insert sample values.

3. Queries:
   a) Select all columns of EMP table.
   b) Select only EMPNO, ENAME, JOB.
   c) Select unique JOBs.
   d) Select employees who are SALESMAN.
   e) Select ENAME, SAL, and sort by SAL (ascending).
   f) Display ENAME, SAL, and percentage increment if everyone gets +200 salary.
   g) Display ENAME and work experience (in years) using SYSDATE - HIREDATE.
*/

------------------------------------------------------
-- 1. Create EMP table
------------------------------------------------------
CREATE TABLE EMP (
    EMPNO    NUMBER(6),
    ENAME    VARCHAR2(20) NOT NULL,
    JOB      VARCHAR2(10) NOT NULL,
    DEPTNO   NUMBER(3),
    SAL      NUMBER(7,2),
    HIREDATE DATE
);

------------------------------------------------------
-- 2. Insert sample data
------------------------------------------------------
INSERT INTO EMP VALUES (101, 'Alice',   'Manager', 10, 60000, DATE '2015-03-01');
INSERT INTO EMP VALUES (102, 'Bob',     'Clerk',   20, 25000, DATE '2018-07-15');
INSERT INTO EMP VALUES (103, 'Charlie', 'Analyst', 10, 40000, DATE '2016-01-10');
INSERT INTO EMP VALUES (104, 'David',   'Salesman',30, 30000, DATE '2020-11-20');
INSERT INTO EMP VALUES (105, 'Emma',    'Salesman',30, 28000, DATE '2019-05-25');

------------------------------------------------------
-- 3a) Query: Select all columns
------------------------------------------------------
SELECT * FROM EMP;

------------------------------------------------------
-- 3b) Query: Select only EMPNO, ENAME, JOB
------------------------------------------------------
SELECT EMPNO, ENAME, JOB FROM EMP;

------------------------------------------------------
-- 3c) Query: Select unique JOBs
------------------------------------------------------
SELECT DISTINCT JOB FROM EMP;

------------------------------------------------------
-- 3d) Query: Select employees who are SALESMAN
------------------------------------------------------
SELECT * FROM EMP
WHERE JOB = 'Salesman';

------------------------------------------------------
-- 3e) Query: Employee name, salary, ordered by salary
------------------------------------------------------
SELECT ENAME, SAL
FROM EMP
ORDER BY SAL;

------------------------------------------------------
-- 3f) Query: Salary increment analysis
-- Display ENAME, current SAL, and percentage increment
-- Formula: (200 / SAL) * 100
------------------------------------------------------
SELECT ENAME,
       SAL,
       ROUND((200 / SAL) * 100, 2) AS PCTINCR
FROM EMP;

------------------------------------------------------
-- 3g) Query: Work experience in years
-- Formula: FLOOR(MONTHS_BETWEEN(SYSDATE, HIREDATE) / 12)
------------------------------------------------------
SELECT ENAME,
       HIREDATE,
       FLOOR(MONTHS_BETWEEN(SYSDATE, HIREDATE) / 12) AS EXPERIENCE_YEARS
FROM EMP;
