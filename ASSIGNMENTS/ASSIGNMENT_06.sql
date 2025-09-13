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
-- ============================
DELIMITER $$
CREATE PROCEDURE print_5_time()
BEGIN
  DECLARE i INT DEFAULT 1;
  WHILE i <= 5 DO
    SELECT CONCAT(i, '. ', 'Soumyendu Panda') AS Output;
    SET i = i + 1;
  END WHILE;
END$$
DELIMITER ;

CALL print_5_time();


-- ============================
-- STEP 2: Reverse a number
-- ============================
DELIMITER $$
CREATE PROCEDURE reverse_numb(IN input_num INT)
BEGIN
  DECLARE rev INT DEFAULT 0;
  DECLARE digit INT;
  DECLARE num INT;
  DECLARE sign INT DEFAULT 1;

  IF input_num < 0 THEN
    SET sign = -1;
    SET num = ABS(input_num);
  ELSE
    SET num = input_num;
  END IF;

  WHILE num > 0 DO
    SET digit = num % 10;
    SET rev = rev * 10 + digit;
    SET num = FLOOR(num / 10);
  END WHILE;

  SET rev = rev * sign;
  SELECT rev AS ReversedNumber;
END$$
DELIMITER ;

CALL reverse_numb(12345);


-- ============================
-- STEP 3: Factorial function
-- ============================
DELIMITER $$
CREATE FUNCTION factorial(n INT) RETURNS BIGINT
DETERMINISTIC
BEGIN
  DECLARE res BIGINT DEFAULT 1;
  DECLARE i INT DEFAULT 1;

  IF n < 0 THEN
    RETURN NULL;
  END IF;

  WHILE i <= n DO
    SET res = res * i;
    SET i = i + 1;
  END WHILE;

  RETURN res;
END$$
DELIMITER ;

SELECT factorial(5) AS FactorialResult;


-- ============================
-- STEP 4: Maximum of two numbers
-- ============================
DELIMITER $$
CREATE FUNCTION maxnum(a INT, b INT) RETURNS INT
DETERMINISTIC
BEGIN
  IF a IS NULL AND b IS NULL THEN
    RETURN NULL;
  ELSEIF a IS NULL THEN
    RETURN b;
  ELSEIF b IS NULL THEN
    RETURN a;
  END IF;

  IF a > b THEN
    RETURN a;
  ELSE
    RETURN b;
  END IF;
END$$
DELIMITER ;

SELECT maxnum(10, 20) AS MaxResult;
SELECT maxnum(NULL, 5) AS Max_With_Null;
SELECT maxnum(NULL, NULL) AS Both_Null;
