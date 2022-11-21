 USE imperial_defense;

 DROP PROCEDURE IF EXISTS variableUSE;
 DELIMITER //

 CREATE PROCEDURE variableUSE()
 BEGIN
    DECLARE A varchar(50);
    SET A = 'The Imperial Defense Networks Are Active';
    SELECT A AS 'Networks';
END //
DELIMITER ;

CALL variableUSE();

DROP PROCEDURE IF EXISTS sessionVariableUSE;
DELIMITER //

CREATE PROCEDURE sessionVariableUSE()
BEGIN
    SET @A = 'Imperial Defense Network';
END //
DELIMITER ;

CALL sessionVariableUSE();
SELECT @A AS 'Networks';

-- Simple Stored Procedure

DROP PROCEDURE IF EXISTS countNetworks;
DELIMITER //

CREATE PROCEDURE countNetworks()
BEGIN
    SELECT COUNT(*) AS 'Networks' FROM Network;
END //
DELIMITER ;

CALL countNetworks();

-- Simple Stored Procedure
DROP PROCEDURE IF EXISTS storeNetworkCount;
DELIMITER //

CREATE PROCEDURE storeNetworkCount(INOUT B INT)
BEGIN
    SELECT COUNT(*) INTO B FROM Network;
END //
DELIMITER ;

CALL storeNetworkCount(@B);
SELECT @B AS 'Number of Networks';

-- Simple Stored Procedure
DROP PROCEDURE IF EXISTS displaNetwork;
DELIMITER //

CREATE PROCEDURE displaNetwork(BW DECIMAL(10,2))
BEGIN
    DECLARE C VARCHAR(20);
    SELECT NetName INTO C FROM Network WHERE Bandwidth = BW;
    SELECT CONCAT(c,'bandwidth is ',BW) AS MSG;
END //
DELIMITER ;

CALL displaNetwork(809.00);

-- Block Structure
DROP PROCEDURE IF EXISTS blocks;
DELIMITER //

CREATE PROCEDURE blocks()
outer_block: BEGIN
    DECLARE A VARCHAR(50);
    SET A = 'My name is Gene';
    inner_block: BEGIN
        IF(A = 'My name is Pranjal') THEN
            LEAVE inner_block;
        END IF;
        SET A = 'My name is not Pranjal'
    END inner_block;
    SELECT A;
END outer_block //
DELIMTER ;

CALL blocks();


-- Nested Block Structure
DROP PROCEDURE IF EXISTS blockTest1;
DELIMITER //

CREATE PROCEDURE blockTest1()
BEGIN
    DECLARE A INT;
    BEGIN
        DECLARE B INT;
        SET B = 10;
    END ;
    SELECT B;
END //
DELIMITER ;

CALL blockTest1();

-- Nested Block Structure
DROP PROCEDURE IF EXISTS blockTest2;
DELIMITER //

CREATE PROCEDURE blockTest2()
BEGIN
    DECLARE A INT;
    SET A = 10;
    BEGIN
        SET A = 20;
    END ;
    SELECT A;
END //
DELIMITER ;

CALL blockTest2();

-- Use of Cursors

/*
 To handle a SELECT statement that returns more than one row, we must create and manipulate a
cursor.
 A cursor is an object that provide programmatic access to the result set returned by a SELECT
statement.
 A cursor is used to iterate through the rows in a result set and take action for each row individually.
 MySQL supports cursors inside Stored Procedures.
 https://dev.mysql.com/doc/refman/8.0/en/cursors.html
 Cursors have these properties:
 Asensitive: The server may or may not make a copy of its result set.
 Read Only: Not updateable.
 Nonscrollable: Can be traversed in only one direction and cannot skip rows.
 Cursor declaration must appear before handler declarations and after variable and condition
declarations.

 The MySQL stored program language supports three statements for performing cursor operations:
 OPEN
 Initialize the result set for the cursor.
 OPEN [cursor name]
 FETCH
 Retrieves the next row from the cursor and moves the cursor to the following row in the result set.
 FETCH [cursor name] INTO [variable list]
 The variable list must contain one variable for each column returned by the SELECT statement
contained in the cursor declaration.
 CLOSE
 Deactivates the cursor and releases memory associated with that cursor.
 CLOSE [cursor name]
*/

-- USE of Cursors

DROP PROCEDURE IF EXISTS displayNetworkBandwidth;
DELIMITER //

CREATE PROCEDURE displayNetworkBandwidth(N INT)
BEGIN
    DECLARE row_count INT; DECLARE counter INT;

    DECLARE N_name VARCHAR(20); DECLARE N_type VARCHAR(20); DECLARE N_BW DECIMAL(10,2);

    DECLARE cursor_NBW CURSOR FOR SELECT NetName, NetType, Bandwidth FROM Network LIMIT N;

    OPEN cursor_NBW;
    SELECT FOUND() INTO row_count;
    SET counter = 0;
    WHILE counter < row_count DO
        FETCH cursor_NBW INTO N_name, N_type, N_BW;
        SELECT CONCAT(N_name, 'is a ', N_type,' network and has a bandwidth of ', N_BW, ' mbps');
        SET counter = counter + 1;
    END WHILE;
    CLOSE cursor_NBW;
END //
DELIMITER ;

CALL displayNetworkBandwidth(3);

-- Use of Handlers

CREATE PROCEDURE displayNetworkBandwidth2(N INT);
BEGIN
    DECLARE row_count INT; DECLARE counter INT;

    DECLARE N_name VARCHAR(20); DECLARE N_type VARCHAR(20); DECLARE N_BW DECIMAL(10,2);

    DECLARE cursor_NBW CURSOR FOR SELECT NetName,NetType,Bandwidth FROM Network LIMIT N;
    DECLARE CONTINUE HANDLER FOR 1146
        BEGIN
            SET row_count = 0;
            SELECT 'TABLE DOES NOT EXIST' AS MSGSS;
            END;
        OPEN cursor_NBW;
        SELECT FOUND_ROWS() INTO row_count;
        SET counter = 0;
        WHILE counter < row_count DO
            FETCH cursor_NBW INTO N_name, N_type, N_BW;
            SELECT CONCAT(N_name, ' is a ', N_type, ' network and has a bandwidth of ', N_BW, ' mbps');
            SET counter = counter + 1;
        END WHILE;
        CLOSE cursor_NBW;
END //
DELIMITER ;

CALL displayNetworkBandwidth2(4);
