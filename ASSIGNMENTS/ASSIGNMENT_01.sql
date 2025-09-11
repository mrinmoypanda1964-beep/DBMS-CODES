/* 
ASSIGNMENT 1
1. Create a table called EMP with the following structure:
   EMPNO NUMBER(6), ENAME VARCHAR2(20), JOB VARCHAR2(10), 
   DEPTNO NUMBER(3), SAL NUMBER(7,2)
   - Allow NULL for all columns except ENAME and JOB.

2. Add a column "experience" to the emp table. (numeric, NULL allowed)

3. Modify the column width of JOB field.

4. Create emp1 table with ENAME and EMPNO, 
   add constraint empno > 100.
*/

/* Step 1: Create EMP table */
CREATE TABLE EMP (
    EMPNO INT(6),
    ENAME VARCHAR(20) NOT NULL,
    JOB   VARCHAR(10) NOT NULL,
    DEPTNO INT(3),
    SAL INT(7)
);

/* Insert sample values */
INSERT INTO EMP VALUES (101, 'Amit', 'Manager', 10, 50000);
INSERT INTO EMP VALUES (102, 'Rita', 'Clerk', 20, 20000);
INSERT INTO EMP VALUES (103, 'Sam', 'Salesman', 30, 25000);

/* Show output */
SELECT * FROM EMP;

/* Step 2: Add column experience */
ALTER TABLE EMP ADD (experience INT);

/* Step 3: Modify JOB field to VARCHAR(20) */
ALTER TABLE EMP MODIFY JOB VARCHAR(20);


/* Step 4: Create emp1 with constraint empno > 100 */
CREATE TABLE EMP1 (
    EMPNO INT(6) CHECK (EMPNO > 100),
    ENAME VARCHAR(20)
);

/* Insert valid values */
INSERT INTO EMP1 VALUES (101, 'Amit');  -- Works
-- INSERT INTO EMP1 VALUES (99, 'Invalid'); -- Error due to constraint

/* Show output */
SELECT * FROM EMP1;
