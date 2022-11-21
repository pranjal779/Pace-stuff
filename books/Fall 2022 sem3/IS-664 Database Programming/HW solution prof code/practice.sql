DROP PROCEDURE IF EXISTS showRegistry;
DELIMITER //

CREATE PROCEDURE showRegistry()

BEGIN

    -- Utility variable
    DECLARE I INT; DECLARE R INT;

    -- Cursor variables
    DECLARE A_Desing VARCHAR(50); DECLARE B_Type VARCHAR(50);
    DECLARE C_Country VARCHAR(50); DECLARE D_Date DATE;
    DECLARE S VARCHAR(50);

    -- Outout variables

    -- Declare cursor
    DECLARE X CURSOR FOR
    SELECT Designation, AType, Country, DDate
    FROM registry; 
    -- Open
    OPEN X;

    SET R = FOUND_ROWS();
    SET I = 0;
    -- Fetch
    WHILE I < R DO
        FETCH X INTO A_Desing, B_Type, C_Country, D_Date;
        SET S = CONCAT(A_Desing,' ',B_Type,' ',C_Country,' ',D_Date);

        SET Y = euclidean(1,2,3,4); # It allows to call a function if we create it.

        SELECT S AS INV
        SET I = I + 1;

    END WHILE;
    -- Close
    CLOSE X;

END //
DELIMITER ;

CALL showRegistry();
