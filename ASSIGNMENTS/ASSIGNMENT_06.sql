/*
ASSIGNMENT 6 — MySQL Workbench version
1. Display your name 5 times using a loop (stored procedure).
2. Reverse number 12345 -> 54321 (stored procedure).
3. Function for factorial.
4. Function for maximum of 2 numbers.

Important MySQL notes (why this looks different from Oracle PL/SQL):
- MySQL uses DELIMITER to allow multi-statement routine definitions.
- Procedures are invoked with CALL; functions are used in SELECT expressions.
- There is no DBMS_OUTPUT.PUT_LINE; use SELECT to show output.
- Use INT / BIGINT for numeric types.
- Many statements produce result sets that Workbench displays.
*/

-- ============================
-- STEP 1: Print name 5 times
-- - We use a stored procedure because MySQL doesn't support anonymous PL/SQL blocks.
-- - Each SELECT inside the loop produces a small result set row visible in Workbench.
-- ============================
DELIMITER $$
CREATE PROCEDURE print_name_5_times()
BEGIN
  -- i is the loop counter; default 1
  DECLARE i INT DEFAULT 1;

  /* Loop from 1 to 5 and SELECT the name each iteration.
     Note: Each SELECT produces a result set row in MySQL Workbench.
     If you prefer a single result set with 5 rows, this is still fine —
     Workbench will show 5 separate result sets (one per SELECT).
     Alternatively you can accumulate into a temporary table or use UNION, but
     the simple SELECT approach is the clearest for learning. */
  WHILE i <= 5 DO
    SELECT CONCAT(i, '. ', 'Soumyendu Panda') AS Output;
    SET i = i + 1;
  END WHILE;
END $$
DELIMITER ;

-- Call the procedure to see the output rows
CALL print_name_5_times();


-- ============================
-- STEP 2: Reverse a number
-- - Stored procedure that accepts an integer and prints the reversed integer.
-- - Handles negative input by preserving the sign.
-- - Uses modulo (%) and integer division (FLOOR).
-- ============================
DELIMITER $$
CREATE PROCEDURE reverse_number(IN input_num INT)
BEGIN
  DECLARE rev INT DEFAULT 0;     -- reversed number being built
  DECLARE digit INT;            -- last digit extracted each step
  DECLARE num INT;              -- working copy of input number (positive)
  DECLARE sign INT DEFAULT 1;   -- record sign for negative numbers

  -- If the input is negative, remember sign and work with absolute value
  IF input_num < 0 THEN
    SET sign = -1;
    SET num = ABS(input_num);
  ELSE
    SET num = input_num;
  END IF;

  /* Main loop:
     - Extract last digit with num % 10
     - Append to rev (rev = rev*10 + digit)
     - Remove last digit from num via FLOOR(num/10)
  */
  WHILE num > 0 DO
    SET digit = num % 10;
    SET rev = rev * 10 + digit;
    SET num = FLOOR(num / 10);
  END WHILE;

  -- Reapply sign if original number was negative
  SET rev = rev * sign;

  -- Output the reversed number as a single-column result set
  SELECT rev AS ReversedNumber;
END $$
DELIMITER ;

-- Example run: should print 54321
CALL reverse_number(12345);


-- ============================
-- STEP 3: Factorial function
-- - Returns n! as BIGINT (supports up to 20! safely in signed 64-bit).
-- - Returns NULL for negative input (you can change to SIGNAL to raise an error).
-- - Use as SELECT factorial(5);
-- ============================
DELIMITER $$
CREATE FUNCTION factorial(n INT) RETURNS BIGINT
DETERMINISTIC
BEGIN
  DECLARE res BIGINT DEFAULT 1;
  DECLARE i INT DEFAULT 1;

  -- Guard: factorial is undefined for negative integers here
  IF n < 0 THEN
    RETURN NULL; -- option: SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Negative input';
  END IF;

  -- Compute factorial iteratively to avoid recursion limits
  WHILE i <= n DO
    SET res = res * i;
    SET i = i + 1;
  END WHILE;

  RETURN res;
END $$
DELIMITER ;

-- Test: returns 120
SELECT factorial(5) AS FactorialResult;

-- Important note:
--  - 20! = 2,432,902,008,176,640,000 fits in signed 64-bit (BIGINT).
--  - factorial(21) will overflow a signed BIGINT. For larger factorials, use DECIMAL or arbitrary-precision logic.


-- ============================
-- STEP 4: Maximum of two numbers (function)
-- - Handles NULL arguments: if both NULL -> NULL; if one NULL -> return the other.
-- - Use in SELECT: SELECT maxnum(10,20);
-- ============================
DELIMITER $$
CREATE FUNCTION maxnum(a INT, b INT) RETURNS INT
DETERMINISTIC
BEGIN
  -- Handle NULL inputs explicitly
  IF a IS NULL AND b IS NULL THEN
    RETURN NULL;
  ELSEIF a IS NULL THEN
    RETURN b;
  ELSEIF b IS NULL THEN
    RETURN a;
  END IF;

  -- Normal comparison
  IF a > b THEN
    RETURN a;
  ELSE
    RETURN b;
  END IF;
END $$
DELIMITER ;

-- Test:
SELECT maxnum(10, 20) AS MaxResult;
SELECT maxnum(NULL, 5) AS Max_With_Null;   -- returns 5
SELECT maxnum(NULL, NULL) AS Both_Null;    -- returns NULL


/* ============================
   CLEANUP / NOTES
   - If you want to drop these routines later, use:
       DROP PROCEDURE IF EXISTS print_name_5_times;
       DROP PROCEDURE IF EXISTS reverse_number;
       DROP FUNCTION IF EXISTS factorial;
       DROP FUNCTION IF EXISTS maxnum;
   - You need CREATE ROUTINE privilege to create procedures/functions.
   - Because we used SELECT to show outputs, each SELECT produces a result set
     which MySQL Workbench displays. For compact output you can store results in
     a table or temporary table and SELECT that table once at the end.
   - If you prefer all outputs in one result set for Step 1, we can change the
     procedure to INSERT into a temp table and then SELECT from it once.
   ============================ */
