DROP DATABASE IF EXISTS fucntion_master;
CREATE DATABASE function_master;
USE function_master;

DELIMETER //
CREATE FUNCTION personName(FN VARCHAR(10), LR VARCHAR(20));
RETURNS VARCHAR(100)
DETERMINISTIC

BEGIN
    DECLARE N VARCHAR(20);
    SET N = CONCAT(FN, ' ', LN);
    RETURN personName

END //
DELIMETER ;

SELECT personName('PRAN', 'SHUK') AS MSG;