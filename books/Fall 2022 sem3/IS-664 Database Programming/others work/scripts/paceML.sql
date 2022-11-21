

use paceML;


DROP PROCEDURE if exists json_transform;
DELIMITER //
CREATE PROCEDURE json_transform()

BEGIN
	-- CREATE UTILITY VARIABLES
	declare count_rows, I int;
	declare row_cont, J int;
	-- CREATE CURSOR VARIABLES
	declare obs int;
	declare elen, ebea, edraf, press, vort, mag, lig decimal(10,4);
	declare x_obs int;
	declare x_elen, x_ebea, x_edraf, x_press, x_vort, x_mag, x_lig, mean, stdev, mean1, stdev1 decimal(10,4);


	-- Declare Cursor
	Declare trans_cursor CURSOR FOR select Observation, ELength, EBeam, EDraft, Pressure, Vortex, Magnetic, Light from yuanClass; 
	Declare xia_cursor CURSOR FOR select ELength, EBeam, EDraft, Pressure, Vortex, Magnetic, Light from xiaClass;

	Drop Table if exists yuanClassJSON;
	Create table yuanClassJSON(
		observation int AUTO_INCREMENT,
		OBV_DATA JSON,
		CONSTRAINT PK_yuanC PRIMARY KEY(observation)
		);

	Drop Table if exists xiaClassJSON;
	Create table xiaClassJSON(
		observation int AUTO_INCREMENT,
		OBV_DATA JSON,
		CONSTRAINT PK_xiaC PRIMARY KEY(observation)
		);


	-- OPEN CURSOR
	OPEN trans_cursor ;
	set count_rows = FOUND_ROWS() ;
	set I = 0 ;
	-- FETCH CURSOR
		while I < count_rows do
			FETCH trans_cursor into obs, elen, ebea, edraf, press, vort, mag, lig ;
		
		INSERT INTO yuanClassJSON(OBV_DATA) VALUES (JSON_ARRAY(elen, ebea, edraf, press, vort, mag, lig));
		set I = I + 1;
	end while;
	close trans_cursor;

	select * from yuanClassJSON;
-- OPEN CURSOR 2
	OPEN xia_cursor ;
	set row_cont = FOUND_ROWS() ;
	set J = 0 ;
-- FETCH CURSOR
		while J < row_cont do
			FETCH xia_cursor into x_elen, x_ebea, x_edraf, x_press, x_vort, x_mag, x_lig;
			
		
		INSERT INTO xiaClassJSON(OBV_DATA) VALUES (JSON_ARRAY(x_elen, x_ebea, x_edraf, x_press, x_vort, x_mag, x_lig));
		set J = J + 1;
	end while;
	close xia_cursor;

	 select * from xiaClassJSON;


	END //

	DELIMITER ;

	call json_transform();
