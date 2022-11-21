USE asteroids;

# TASK 1

DROP PROCEDURE IF EXISTS showType;
DELIMITER //

CREATE PROCEDURE showType(T VARCHAR(30) , C INT)
BEGIN
	

	DECLARE row_count INT;    
	DECLARE counter INT;

	DECLARE I INT;
	DECLARE AstDesign VARCHAR(30);
	DECLARE AstType VARCHAR(30);
	DECLARE AstCountry VARCHAR(30);
	DECLARE AstDate VARCHAR(10);

	DECLARE cursor_Inv CURSOR FOR SELECT Designation, 
	CASE 
		WHEN AType = 'Carboneous' THEN  'CARBON_BASED'
		WHEN AType = 'Metallic' THEN 'METAL_BASED'
		WHEN AType = 'Silicaceous' THEN 'SILICON_BASED'
	END

	, CASE
		WHEN Country = 'US' THEN 'United States'
		WHEN Country = 'UK' THEN 'United Kingdom'
		WHEN Country = 'RUSSIA' THEN 'Russian Federation'
		WHEN Country = 'CHINA' THEN "People's Republic of China"

	END

	, CASE
		WHEN MONTHNAME(DDate) = 'November' THEN 'Winter'
		WHEN MONTHNAME(DDate) = 'December' THEN 'Winter'
		WHEN MONTHNAME(DDate) = 'January' THEN 'Winter'
		WHEN MONTHNAME(DDate) = 'February' THEN 'Winter'
		WHEN MONTHNAME(DDate) = 'March' THEN 'Winter'
		WHEN MONTHNAME(DDate) = 'April' THEN 'Spring'
		WHEN MONTHNAME(DDate) = 'May' THEN 'Spring'
		WHEN MONTHNAME(DDate) = 'June' THEN 'Summer'
		WHEN MONTHNAME(DDate) = 'July' THEN 'Summer'
		WHEN MONTHNAME(DDate) = 'August' THEN 'Summer'
		WHEN MONTHNAME(DDate) = 'September' THEN 'Fall'
		WHEN MONTHNAME(DDate) = 'October' THEN 'Fall'
	END
	FROM registry
	WHERE AType = T LIMIT C;


	
	OPEN cursor_Inv;
	#SELECT FOUND_ROWS() INTO row_count;
	SET counter = 0;
	SET row_count = FOUND_ROWS();

	WHILE counter < row_count DO
		FETCH cursor_Inv INTO AstDesign, AstType, AstCountry, AstDate;
		SELECT CONCAT(AstDesign,' Type: ', AstType,' Asteroid Country: ', AstCountry, ' Season: ', AstDate) AS 'F_Data';
		SET counter = counter + 1;
	
	END WHILE;
	
	
	CLOSE cursor_Inv;
	
END //
DELIMITER ;

CALL showType('Carboneous', 3);


# TASK 2

DROP FUNCTION IF EXISTS AsteroidValue;
DELIMITER //

CREATE FUNCTION AsteroidValue(AstWeight DECIMAL(10,3), Chromium DECIMAL(10,3)
, Cobalt DECIMAL(10,3), Tungsten DECIMAL(10,3), Uranium DECIMAL(10,3))

RETURNS VARCHAR(255)
NOT DETERMINISTIC
READS SQL DATA

BEGIN
	DECLARE Total VARCHAR(255);
	DECLARE Percentage DECIMAL(10,3);
	
	SET Percentage = AstWeight/100;
	SET Total = ROUND(((Percentage * Chromium) * 12.50) + ((Percentage * Cobalt) * 9.25) +
	((Percentage * Tungsten) * 7.75) + ((Percentage * Uranium) * 10), 2);
	RETURN Total;


END //
DELIMITER ;



DROP PROCEDURE IF EXISTS showValue;
DELIMITER //

CREATE PROCEDURE showValue(A VARCHAR(20))
BEGIN
    
    DECLARE AstData VARCHAR(150);
	DECLARE AstWeight DECIMAL(10,3);
	DECLARE Ast1 DECIMAL(10,3);
	DECLARE Ast2 DECIMAL(10,3);
	DECLARE Ast3 DECIMAL(10,3);
	DECLARE Ast4 DECIMAL(10,3);
	#DECLARE TotalValue VARCHAR(255);

	SELECT sp.Designation, sp.Mass, cs.Chromium, cs.Cobalt, 
	cs.Tungsten, cs.Uranium  INTO AstData, AstWeight, Ast1, Ast2, Ast3, Ast4
	FROM specifications sp
	JOIN composition_strategic cs ON sp.Designation = cs.Designation
	WHERE cs.Designation = A;
	
	SELECT CONCAT(AstData,' has a value of $', AsteroidValue(AstWeight, Ast1, Ast2, Ast3, Ast4)) AS MSG;

END //
DELIMITER ;

CALL showValue('C-a3740-n');


# TASK 3

DROP FUNCTION IF EXISTS AsteroidValues;
DELIMITER //

CREATE FUNCTION AsteroidValues(AstWeight DECIMAL(10,3), Chromium DECIMAL(10,3)
, Cobalt DECIMAL(10,3), Tungsten DECIMAL(10,3), Uranium DECIMAL(10,3))

RETURNS VARCHAR(255)
NOT DETERMINISTIC
READS SQL DATA

BEGIN
	DECLARE Total VARCHAR(255);
	DECLARE Percentage DECIMAL(10,3);
	
	SET Percentage = AstWeight/100;
	SET Total = ROUND(((Percentage * Chromium) * 12.50) + ((Percentage * Cobalt) * 9.25) +
	((Percentage * Tungsten) * 7.75) + ((Percentage * Uranium) * 10), 2);
	RETURN Total;


END //
DELIMITER ;

DROP PROCEDURE IF EXISTS showAllValues;
DELIMITER //

CREATE PROCEDURE showAllValues(A JSON)
BEGIN
      
	DECLARE counter INT;
    DECLARE AstData VARCHAR(50);
	DECLARE AstWeight DECIMAL(10,3);
	DECLARE Ast1 DECIMAL(10,3);
	DECLARE Ast2 DECIMAL(10,3);
	DECLARE Ast3 DECIMAL(10,3);
	DECLARE Ast4 DECIMAL(10,3);
	
	SET counter = 0;
	
	WHILE  counter < JSON_LENGTH(A) DO
		
		SELECT sp.Designation, sp.Mass, cs.Chromium, cs.Cobalt, 
		cs.Tungsten, cs.Uranium  INTO AstData, AstWeight, Ast1, Ast2, Ast3, Ast4
		FROM specifications sp
		JOIN composition_strategic cs ON sp.Designation = cs.Designation
		WHERE cs.Designation = JSON_EXTRACT(A, CONCAT('$[',counter,']'));


		#SELECT * FROM specifications WHERE Designation = JSON_EXTRACT(A, CONCAT('$[',counter,']'));

		SELECT CONCAT(AstData,' has a value of $', AsteroidValue(AstWeight, Ast1, Ast2, Ast3, Ast4)) AS 'Total Stragic Value';
		SET counter = counter + 1;
		
	
	END WHILE;
	

END //
DELIMITER ;


CALL showAllValues(JSON_ARRAY('C-a3740-n', 'S-f4675-m', 'C-h3613-k'));