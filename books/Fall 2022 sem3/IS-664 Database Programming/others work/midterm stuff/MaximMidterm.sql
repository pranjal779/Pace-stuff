/*
Create the stored procedure asteroid_prospectus which accepts a country name and an
asteroid designation and calculates the closest and most distant asteroid, belonging to
the specified country, to the specified asteroid. Additionally, the procedure provides an
analysis of the asteroid’s composition based on the following rules. */



USE asteroids;

DROP PROCEDURE IF EXISTS asteroid_prospectus;
DELIMITER //

CREATE PROCEDURE asteroid_prospectus(CountryName VARCHAR(20), Design VARCHAR(20))
BEGIN

	DECLARE row_count INT;    
	DECLARE counter INT;
	DECLARE RowLoop INT;    
	DECLARE CounterLoop INT;
	DECLARE NameAsteroid VARCHAR(30);
	DECLARE CloseDistance DECIMAL(10,2);
	DECLARE MostDistance DECIMAL(10,2);
	DECLARE Dist DECIMAL(10,2);
	DECLARE SurfaceCond VARCHAR(20);
	DECLARE WaterCond VARCHAR(20);
	DECLARE RockCond VARCHAR(20);
	DECLARE MetalCond VARCHAR(20);
	DECLARE X DECIMAL(10,2);
	DECLARE Y DECIMAL(10,2);
	DECLARE Z DECIMAL(10,2);
	DECLARE X1 DECIMAL(10,2);
	DECLARE Y1 DECIMAL(10,2);
	DECLARE Z1 DECIMAL(10,2);
	DECLARE A VARCHAR(20);
	DECLARE Close VARCHAR(20);
	DECLARE Far VARCHAR(20);

	DECLARE cursor_Inv CURSOR FOR SELECT reg.Designation, sp.X, sp.Y, sp.Z, sf.Surface, sf.Water, cs.Content_Rock, cs.Content_Metal
	FROM registry reg
	JOIN spatialCoord sp ON reg.Designation = sp.Designation
	JOIN surface_feature sf ON reg.Designation = sf.Designation
	JOIN composition_simple cs ON reg.Designation = cs.Designation
	WHERE reg.Designation = Design and reg.Country = CountryName;


	DECLARE cursor_Coordinats CURSOR FOR SELECT * FROM spatialCoord WHERE Designation != Design;

    # X AS X1, Y AS Y1, Z AS Z1, Designation
	OPEN cursor_Inv;
	#SELECT FOUND_ROWS() INTO row_count;
	SET counter = 0;
	SET row_count = FOUND_ROWS();
	WHILE counter < row_count DO
		FETCH cursor_Inv INTO NameAsteroid, X,Y,Z, SurfaceCond, WaterCond, RockCond, MetalCond;
		SET CloseDistance = 100;
		SET MostDistance = 0;

		OPEN cursor_Coordinats;
		SET CounterLoop = 0;
		SET RowLoop = FOUND_ROWS();
		WHILE CounterLoop < RowLoop DO
			FETCH cursor_Coordinats INTO A, X1,Y1,Z1;

			SET Dist = CONCAT(ROUND(SQRT(POW(ABS(X - X1), 2) + POW(ABS(Y - Y1), 2) + POW(ABS(Z - Z1), 2)), 1/2));
			

			IF CloseDistance > Dist THEN
			SET CloseDistance = Dist;
			SET Close = A;
			END IF;
			IF MostDistance < Dist THEN
			SET MostDistance = Dist;
			SET Far = A;
			END IF;
			#SET MostDistance = CONCAT(ROUND(SQRT(POW(ABS(X - X1), 2) + POW(ABS(Y - Y1), 2) + POW(ABS(Z - Z1), 2)), 2))
			
			#SELECT CONCAT(ROUND(SQRT(POW(ABS(X - X1), 2) + POW(ABS(Y - Y1), 2) + POW(ABS(Z - Z1), 2)), 2)) AS INV;
			#SELECT CONCAT(Dist, ' ', CloseDistance) as dfdf;
			SET CounterLoop = CounterLoop + 1;
			
		END WHILE;
		CLOSE cursor_Coordinats;



		SELECT CONCAT(NameAsteroid,' is Closest To: ', Close,'(',CloseDistance,')',' and most Distant from: ', Far,'(',MostDistance,')', '--> SURFACE: ', 
		CASE
			WHEN SurfaceCond = 'Medium' THEN 'IDEAL'
			WHEN SurfaceCond = 'Medium-Soft' THEN  'IDEAL'
			WHEN SurfaceCond = 'Soft' THEN 'ACCEPTABLE'
			WHEN SurfaceCond = 'Hard' THEN  'ACCEPTABLE'
			WHEN SurfaceCond = 'Hard-Medium' THEN  'ACCEPTABLE'
		END, ' WATER : ',
		CASE
			WHEN WaterCond = 'No-Content' THEN 'ACCEPTABLE'
			WHEN WaterCond = 'Low-Content' THEN  'IDEAL'
		 	WHEN WaterCond = 'Medium-Content' THEN 'UNACCEPTABLE'       
			WHEN WaterCond = 'High-Content' THEN  'UNACCEPTABLE'
		END, ' ROCK : ',
		CASE
			WHEN RockCond <= 50 THEN 'ACCEPTABLE'
			WHEN RockCond > 50 THEN 'UNACCEPTABLE'
		END, ' METAL : ',
		CASE	
			WHEN MetalCond > 55 THEN 'ACCEPTABLE'
			WHEN MetalCond <= 55 THEN 'UNACCEPTABLE'
		END) AS INV;
		SET counter = counter + 1;	
	END WHILE;
	CLOSE cursor_Inv;

	
	
END //
DELIMITER ;

CALL asteroid_prospectus('CHINA','C-e3137-m');