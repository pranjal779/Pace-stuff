USE asteroids;

DROP FUNCTION IF EXISTS convertCountryCode;
DELIMITER //
CREATE FUNCTION convertCountryCode(C VARCHAR(50))
RETURNS VARCHAR(50)
DETERMINISTIC

BEGIN
    DECLARE V VARCHAR(50);
    IF C = 'US' THEN
        SET V = 'United States';
    END IF;
    IF C = 'UK' THEN
        SET V = 'United Kingdom';
    END IF;
    IF C = 'RUSSIA' THEN
        SET V = 'Russian Federation';
    END IF;
    IF C = 'CHINA' THEN
        SET V = "People's Republic of China";
    END IF;
    RETURN V;

END //
DELIMITER ;

-- C for CountryCode
-- V for returned Value
-- SELECT convertCountryCode('US') AS 'MSG1';
-- SELECT convertCountryCode('UK') AS 'MSG2';
-- SELECT convertCountryCode('RUSSIA') AS 'MSG3';
-- SELECT convertCountryCode('CHINA') AS 'MSG4';

-- Converting AType
-- AT for the converting AType values
-- V for convertedValues
DROP FUNCTION IF EXISTS convertAType;
DELIMITER //
CREATE FUNCTION convertAType(AT VARCHAR(100))
RETURNS VARCHAR(100)
DETERMINISTIC

BEGIN
    DECLARE V VARCHAR(100);
    IF AT = 'Carboneous' THEN
        SET V = 'CARBON_BASED';
    END IF;
    IF AT = 'Metallic' THEN
        SET V = 'METAL_BASED';
    END IF;
    IF AT = 'Silicaceous' THEN
        SET V = 'SILICON_BASED';
    END IF;
    RETURN V;

END //
DELIMITER ;
-- SELECT convertAType('Carboneous') AS 'MSG5';


-- converting DDate
DROP FUNCTION IF EXISTS convertDate;
DELIMITER //
CREATE FUNCTION convertDate(D VARCHAR(20))
RETURNS VARCHAR(50)
DETERMINISTIC

BEGIN
    DECLARE M VARCHAR(50);
    CASE
        WHEN D = 'JANUARY' THEN
            SET M = 'Winter';
        WHEN D = 'FEBRUARY' THEN
            SET M = 'Winter';
        WHEN D = 'MARCH' THEN
            SET M = 'Winter';
        WHEN D = 'APRIL' THEN
            SET M = 'Spring';
        WHEN D = 'MAY' THEN
            SET M = 'Spring';
        WHEN D = 'JUNE' THEN
            SET M = 'Summer';
        WHEN D = 'JULY' THEN
            SET M = 'Summer';
        WHEN D = 'AUGUST' THEN
            SET M = 'Summer';
        WHEN D = 'SEPTEMBER' THEN
            SET M = 'Fall';
        WHEN D = 'OCTOBER' THEN
            SET M = 'Fall';
        WHEN D = 'NOVEMBER' THEN
            SET M = 'Winter';
        WHEN D = 'DECEMBER' THEN
            SET M = 'Winter';
        END CASE;
        RETURN M;

END //
DELIMITER ;

-- 2nd
DROP PROCEDURE IF EXISTS showType2;
DELIMITER //

CREATE PROCEDURE showType2()
BEGIN
    -- DECLARING Variable arguments
    DECLARE row_count INT; DECALRE counter INT;

    -- Declare variable for cusor
    DECLARE DG VARCHAR(40); DECLARE DH VARCHAR(40); DECLARE DK VARCHAR(40); DECLARE DL DATE;

    --DECLARE CONVERSION
    DECLARE DC VARCHAR(40); DECLARE DV VARCHAR(40); DECLARE DB VARCHAR(40);
    -- DECLARE DM VARCHAR(40);

    -- DECLARE CURSOR
    DECLARE cursor_showType2 CURSOR FOR SELECT * FROM registry;

    -- Create a table
    DROP TABLE IF EXISTS ADetails;
    CREATE TABLE ADetails(
    DesigID VARCHAR(20),
    AstType Varchar(20),
    CountryName VARCHAR(20),
    Dates DATE,
    CONSTRAINT PK_AD PRIMARY KEY(Designation)
    CONSTRAINT FK_AD FOREIGN KEY(DesgnID) REFERENCES registry(Designation)
    );

    -- OPEN CURSOR
    OPEN cursor_showType2;
    SET row_count = FOUND_ROWS();
    SET counter = 0;

    WHILE counter < row_count DO
        -- Fetch
        FETCH cursor_showType2 INTO DG,DH,DK,DL,DJ;
        --Convert VLAUES
        SET DC = convertCountryCode(DH);
        SET DV = convertAType(DK);
        SET DB = convertDate(DL);
        --INSERT VALUES INTO TABLE
        INSERT INTO ADetails (DesgnID,AstType,CountryName,Dates)
        VALUES(DG,DC,DV,DB);
        SET counter = counter + 1;
    END WHILE;

    -- CLOSE
    CLOSE cursor_showType2;

    -- Display table output
    SELECT CONCAT(DesgnID, ' Type: ',AstType,' Asteroid Country: ',CountryName,' Season: ',Dates,' ',YEAR(Dates.registry)) FROM ADetails;

END //
DELIMITER ;
CALL cursor_showType2();






-- PART 2
DROP FUNCTION IF EXISTS price;
DELIMITER //
CREATE FUNCTION price(A DECIMAL(10,5), B DECIMAL(10,5), C DECIMAL(10,5), D DECIMAL(10,5))
RETURNS DECIMAL(10,5)
DETERMINISTIC

BEGIN
    DECLARE V DECIMAL(10,5);
    SET V = A + B + C + D
    SET A = Chromium.composition_strategic
    SET B = Cobalt.composition_strategic
    SET C = Tungsten.composition_strategic
    SET D = Uranium.composition_strategic
    RETURN V WHERE Designation = 'C-f4314-j' FROM composition_strategic;

    SELECT CONCAT(Designation, 'has a value of $',V) AS "MSG";

END //
DELIMITER ;


-- Part 3
DROP PROCEDURE IF EXISTS showAllValues;
DELIMITER //

CREATE PROCEDURE showAllValues()
BEGIN






-- SELECT convertDate('JULY') AS 'MSG6';

/*
-- 2nd time
DROP FUNCTION IF EXISTS convertMonth;
DELIMITER //
CREATE FUNCTION convertMonth(D DATE)
RETURNS VARCHAR(50)
DETERMINISTIC

BEGIN
    DECLARE M VARCHAR(50);
    IF MONTH(DDate.registry) = 1 THEN
        SET M = 'Winter';
    END IF;
    IF MONTH(DDate.registry) = 2 THEN
        SET M = 'Winter';
    END IF;
    IF MONTH(DDate.registry) = 3 THEN
        SET M = 'Winter';
    END IF;
    IF MONTH(DDate.registry) = 4 THEN
        SET M = 'Spring';
    END IF;
    IF MONTH(DDate.registry) = 5 THEN
        SET M = 'Spring';
    END IF;
    IF MONTH(DDate.registry) = 6 THEN
        SET M = 'Summer';
    END IF;
    IF MONTH(DDate.registry) = 7 THEN
        SET M = 'Summer';
    END IF;
    IF MONTH(DDate.registry) = 8 THEN
        SET M = 'Summer';
    END IF;
    IF MONTH(DDate.registry) = 9 THEN
        SET M = 'Fall';
    END IF;
    IF MONTH(DDate.registry) = 10 THEN
        SET M = 'Fall';
    END IF;
    IF MONTH(DDate.registry) = 11 THEN
        SET M = 'Winter';
    END IF;
    IF MONTH(DDate.registry) = 12 THEN
        SET M = 'Winter';
    END IF;
    RETURN M;

END //
DELIMITER ;

SELECT convertMonth() AS 'MSG6';
*/


/*
DROP PROCEDURE IF EXISTS showType;
DELIMETER //

CREATE PROCEDURE showType(S INT)
BEGIN
    -- Decalaring variables arguments
    DECLARE I INT; DECLARE FROWS INT;
    -- Declaring cursor variables
    DECALRE DesgnID VARCHAR(50); DECALRE CCode VARCHAR(50); DECLARE WhichType VARCHAR(50); DECLARE WhichDate DATE;
    -- SET DesgnID = Designation.registry;
    -- SET CCode = convertCountryCode();
    -- SET WhichType = convertAType();
    -- SET WhichDate = convertDate();

    DECLARE cursor_showType CURSOR FOR SELECT Designation, AType, Country, DDate FROM registry LIMIT S;

    OPEN cursor_showType;
    SELECT FOUND_ROWS() INTO FROWS;
    SET I = 0;
    WHILE I < FROWS DO
        FETCH cursor_showType INTO DesgnID, CCode, WhichType, WhichDate;
        SELECT CONCAT(DesgnID, ' Type: ', CCode , ' Asteroid Country: ', WhichType, ' Season: ', YEAR(DDate.registry));
        SELECT I = I + 1;
    END WHILE;
    CLOSE cursor_showType;

    SELECT CONCAT(DesgnID, ' Type: ', CCode , ' Asteroid Country: ', WhichType, ' Season: ', YEAR(DDate.registry));
END //
DELIMITER ;

CALL showType();
*/
