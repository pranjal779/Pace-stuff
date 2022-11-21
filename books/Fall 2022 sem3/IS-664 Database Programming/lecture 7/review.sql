DROP DATABASE IF EXISTS spreview;
CREATE DATABASE spreview;
USE spreview;

DROP FUNCTION addme;
DELIMITER //
CREATE FUNCTION(A INT, B INT)



DROP PROCEDURE showMe;
DELIMITER //


CREATE PROCEDURE showMe()



BEGIN
    SELECT 'hello database';
END //
DELIMITER ;

CALL showMe();

call showme(addme( , ));

-- min
-- max
-- mean
-- variance
-- standard deviation

--
DELIMITER //
CREATE FUNCTION mean(C INT)
RETRUNS INT

BEGIN
    DECLARE A INT; DECLARE B INT;
    SET A
    SET C = ((A + B)/2)
