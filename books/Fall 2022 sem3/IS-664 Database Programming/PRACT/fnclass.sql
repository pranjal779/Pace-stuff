CREATE DATABASE Function_main;
USE Function_main;

DELIMITER //
CREATE FUCNTION avgOfNums(A INT, B INT, C INT, D INT, E INT,)
RETURNS DECIMAL(10,2)
DETERMINISTIC

BEGIN
    DECLARE N DECIMAL(10,2);
    SET N = (A + B + C + D + E) / 5;
    RETURNS avgOfNums

END //
DELIMITER ;

SELECT avgOfNums(1,2,3,4,5) AS MSG;









-----------------------------
 