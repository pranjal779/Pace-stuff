DROP DATABASE IF EXISTS functionDEMO;
CREATE DATABASE functionDEMO;
USE functionDEMO;

SELECT 1 AS MSG;

DELIMITER //
CREATE FUNCTION addMe(A INT, B INT)
RETURNS INT
DETERMINISTIC

BEGIN
    DECLARE C INT;
    SET C = A + B;
    RETURN C;

END //
DELIMITER ;

SELECT addMe(10,20) AS VALUE;

-- User-defined functions

SELECT 2 AS MSG;

DELIMITER //
CREATE FUNCTION sumDiffernce(A INT, B INT, C INT, D INT)
RETURNS INT
DETERMINISTIC

BEGIN
    DECLARE V INT;
    SET V = (A + B) - (C + D);
    RETURN V;

END //
DELIMITER ;

SELECT sumDiffernce(10,20,30,40) AS VALUE;

-- functions and Flow Control

-- IF ... THEN

SELECT 3 AS MSG;

DELIMITER //
CREATE FUNCTION bigSmallValue(A INT, B INT, C INT)
RETURNS VARCHAR(20)
DETERMINISTIC

BEGIN
    DECLARE S INT;
    DECLARE V VARCHAR(20);
    SET S = (A + B + C);
    IF S > 99 THEN
        SET V = 'Big Value';
    END IF;
    IF S < 99 THEN
        SET V = 'Small Value';
    END IF;
    RETURN V;

END //
DELIMITER ;

SELECT bigSmallValue(10,20,30) AS MSG;

/*
The IF...THEN statement is used to 
execute one or more statements 
depending on a Boolean expressions.
IF...THEN statements can be nested 
within another IF...THEN statement.
*/

-- IF...THEN ELSEIF...ELSE...END IF
-- CASE...WHEN...ELSE...END CASE

SELECT 4 AS MSG;

DELIMITER //
CREATE FUNCTION bigSmallValueIF(A INT, B INT, C INT)
RETURNS VARCHAR(20)
DETERMINISTIC

BEGIN
    DECLARE S INT;
    DECLARE V VARCHAR(20);
    SET S = (A + B + C);
    IF S > 99 THEN
        SET V = 'Big Value';
    ELSE
        SET V = 'Small Value';
    END IF;
    RETURN V;

END //
DELIMITER ;

SELECT bigSmallValueIF(80,20,30) AS MSGIF;

/*
The IF...THEN ELSE statement is used 
to execute one or more statements 
depending on one or more Boolean 
expressions.
*/

-- NESTED IF

SELECT 5 AS MSG;

DELIMITER //
CREATE FUNCTION bigSmallValues(A INT, B INT, C INT)
RETURNS VARCHAR(20)
DETERMINISTIC

BEGIN
    DECLARE S INT;
    DECLARE V VARCHAR(20);
    SET S = (A + B + C);
    IF S > 99 THEN
        SET V = 'Big Vlaue';
        IF S = 100 THEN
            SET V = 'Value is 100';
        END IF;
    ELSE
        SET V = 'Small Value';
    END IF;
    RETURN V;

END //
DELIMITER ;

SELECT bigSmallValues(80,20,0) AS MSG2;

/*
Nested IF statements allow the 
testing of multiple conditions.
Is considered poor style but 
sometimes may be expedient
*/

-- if ... THEN ... ELSEIF ELSE

SELECT 6 AS MSG;

DELIMITER //
CREATE FUNCTION bigSmallValueIFTHEN(A INT, B INT, C INT)
RETURNS VARCHAR(20)
DETERMINISTIC

BEGIN
    DECLARE S INT;
    DECLARE V VARCHAR(20);
    SET S = (A + B + C);
    IF S > 99 THEN
        SET V = 'Big Value';
    ELSEIF S = 100 THEN
        SET V = 'Value is 100';
    ELSEIF S = 150 THEN
        SET V = 'Value is 150';
    ELSE
        SET V = 'Small Value';
    END IF;
    RETURN V;

END //
DELIMITER ;

SELECT bigSmallVlaue(80,60,10) AS MSG3;

SELECT 7 AS MSG;

/*
IF... THEN...ELSEIF tests multiple 
conditions and executes the first true 
condition.
This condition is the MOST true but it is 
not the first true statement
*/

-- case...end case

DELIMITER //
CREATE FUNCTION bigSmallValueCASE(A INT, B INT, C INT)
RETURNS VARCHAR(20)
DETERMINISTIC

BEGIN
    DECLARE testMe INT;
    DECLARE V VARCHAR(20);
    SET testMe = (A + B + C);
    CASE testMe
        WHEN 100 THEN
            SET V = '100';
        WHEN 150 THEN
            SET V = '150';
        ELSE
            SET V = '???';
    END CASE;
    RETURN V;

END //
DELIMITER ;

SELECT bigSmallValueCASE(80,60,10) AS msgCASE;

/*
 CASE statement structure allow the 
testing of multiple conditions using 
pattern matching.
The first true ‘CASE’ is executed.
*/

-- FUNCTIONS AND LOOPS

/*
WHILE...DO..END WHILE
LOOP..LEAVE..END LOOP
REPEAT...UNTIL...END REPEAT
*/

-- WHILE..DO..END WHILE loop

DELIMITER //
CREATE FUNCTION incrementBy10(A INT)
RETURNS VARCHAR(20)
DETERMINISTIC

BEGIN
    DECLARE I INT;
    DECLARE V VARCHAR(20);
    SET I = 0;
    SET V = 0;
    WHILE I < A DO
        SET V = V + 10;
        SET I = I + 1;
    END WHILE;
    RETURN V;

END //
DELIMITER ;

SELECT incrementBy10(4) AS MsgIncBy10;

/*
The WHILE DO loop executes as long 
as the loop continuation condition is 
true.
*/

-- LOOP...LEAVE...END LOOP loop

DELIMITER //
CREATE FUNCTION incrementBy10Second(A INT)
RETURNS VARCHAR(20)
DETERMINISTIC

BEGIN
    DECLARE I INT;
    DECLARE V VARCHAR(20);
    SET I = 0;
    SET V = 0;
    myLoop: LOOP
        SET V = V + 10;
        SET I = I + 1;
    IF I = A THEN
        LEAVE myLoop;
    END IF;
    END LOOP myLoop;
    RETURN V;

END //
DELIMITER ;

SELECT incrementBy10Second(4) msgINCby10;

/*
 The LOOP END LOOP loop executes 
if the loop continuation condition is 
true.
The loop continuation condition is 
specified by use of a conditional 
statement as uses the LEAVE
keyword.
*/

-- REPEAT...UNITL...END REPEAT Loop

DELIMITER //
CREATE FUNCTION incrementBy10Third(A INT)
RETURNS VARCHAR(20)
DETERMINISTIC

BEGIN
    DECLARE I INT;
    DECLARE V VARCHAR(20);
    SET I = 0;
    SET V = 0;
    REPEAT
        SET V = V + 10;
        SET I = I + 1;
    UNTIL I = A
    END REPEAT;
    RETURN V;

END //
DELIMITER ;

SELECT incrementBy10Third(5) AS MSG3RD;

/*
 The REPEAT…UNTIL LOOP loop 
executes if the loop continuation 
condition is true.
The loop continuation condition is 
specified by use of the UNTIL 
keyword.
*/

-- UDF inside UDF
-- page 17

-- SUBSTRACTION FUNCTION FOR plusDifference FN

DELIMITER //
CREATE FUNCTION subtractMe(A INT, B INT)
RETURNS INT
DETERMINISTIC

BEGIN
    DECLARE C INT;
    SET C = A - B;
    RETURN C;

END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION plusDifference(A DECIMAL(10,2), B INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC

BEGIN
    DECLARE S DECIMAL(10,2);
    DECLARE T DECIMAL(10,2);
    DECLARE U DECIMAL(10,2);

    SET S = addMe(A,B);
    SET T = subtractMe(A,B);
    SET U = S + T;
    RETURN U;

END //
DELIMITER ;

SELECT plusDifference(10,20) AS MSGplusDiff;

-- UDF and Native Function

DELIMITER //
CREATE FUNCTION circleArea(R INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC

BEGIN
    DECLARE Area DECIMAL(10,2);
    SET Area = 3.14 * POW(R,2);
    RETURN Area;

END //
DELIMITER ;

SELECT circleArea(10) AS MSGcricle;

-- SQL and User-Defined FUNCTIONS

USE imperial_defense;

DELIMITER //
CREATE FUNCTION countRouterss2()
RETURNS INT
NOT DETERMINISTIC
READS SQL DATA

BEGIN
    DECLARE A INT;
    SELECT COUNT(*) FROM Network INTO A;
    RETURN A;

END //
DELIMITER ;

SELECT countRouterss2() AS MSGcount;

-- SQL and User-Defined Functions

DELIMITER //
CREATE FUNCTION countNetworkRouters2nd(N VARCHAR(50))
RETURNS INT
NOT DETERMINISTIC
READS SQL DATA

BEGIN
    DECLARE A INT;
    SELECT COUNT(*) FROM Router WHERE AssignedTo = N INTO A;
    RETURN A;

END //
DELIMITER ;

SELECT countNetworkRouters2nd('daas') AS MSG_countAssignedTo;


