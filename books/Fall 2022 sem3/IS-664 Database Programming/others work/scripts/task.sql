

use paceML;



drop function if exists abc;

delimiter //

create function abc(len decimal(10,4), ebe decimal(10,4), edra decimal(10,4), pres decimal(10,4), vort decimal(10,4), mag decimal(10,4), lig decimal(10,4))
RETURNS DECIMAL(10,4)
DETERMINISTIC

BEGIN

declare mean decimal(10,4);
set mean = (len + ebe + edra + pres + vort + mag + lig) / 7;
RETURN mean ;

END //

DELIMITER ;

drop function if exists sdev;

DELIMITER //
create function sdev(len decimal(10,4), ebe decimal(10,4), edra decimal(10,4), pres decimal(10,4), vort decimal(10,4), mag decimal(10,4), lig decimal(10,4))
RETURNS DECIMAL(10,4)
DETERMINISTIC

BEGIN

declare mean decimal(10,4);
declare var, stddev decimal(65,4);

set mean = abc(len, ebe, edra, pres, vort, mag, lig);

set var = (Pow((len - mean),2) + Pow((ebe - mean),2) + Pow((edra - mean),2) + Pow((pres - mean),2) + Pow((vort - mean),2) + Pow((mag - mean),2) + Pow((lig - mean),2)) / 7 ;

set stddev = SQRT(var);

RETURN stddev ;

END //

DELIMITER ;


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

	Drop Table if exists yuanClassJSONnorm;
	Create table yuanClassJSONnorm(
		observation int AUTO_INCREMENT,
		OBV_DATA JSON,
		CONSTRAINT PK_yuanC PRIMARY KEY(observation)
		);

	Drop Table if exists xiaClassJSONnorm;
	Create table xiaClassJSONnorm(
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
			set mean = abc(elen, ebea, edraf, press, vort, mag, lig);
			set stdev = sdev(elen, ebea, edraf, press, vort, mag, lig);		
			INSERT INTO yuanClassJSONnorm(OBV_DATA) VALUES (JSON_ARRAY(Round((elen-mean)/stdev,3), Round((ebea-mean)/stdev,3), Round((edraf-mean)/stdev,3), 
		Round((press-mean)/stdev,3), Round((vort-mean)/stdev,3), Round((mag-mean)/stdev,3), Round((lig-mean)/stdev,3)));
			set I = I + 1;
	end while;
	close trans_cursor;

	select * from yuanClassJSONnorm;
-- OPEN CURSOR 2
	OPEN xia_cursor ;
	set row_cont = FOUND_ROWS() ;
	set J = 0 ;
-- FETCH CURSOR
		while J < row_cont do
			FETCH xia_cursor into x_elen, x_ebea, x_edraf, x_press, x_vort, x_mag, x_lig;
			set mean1 = abc(x_elen, x_ebea, x_edraf, x_press, x_vort, x_mag, x_lig);
			set stdev1 = sdev(x_elen, x_ebea, x_edraf, x_press, x_vort, x_mag, x_lig);
				
		INSERT INTO xiaClassJSONnorm(OBV_DATA) VALUES (JSON_ARRAY(Round((x_elen-mean1)/stdev1,3), Round((x_ebea-mean1)/stdev1,3), Round((x_edraf-mean1)/stdev1,3), 
		Round((x_press-mean1)/stdev1,3), Round((x_vort-mean1)/stdev1,3), Round((x_mag-mean1)/stdev1,3), Round((x_lig-mean1)/stdev1,3)));
		
		set J = J + 1;
	end while;
	close xia_cursor;

	 select * from xiaClassJSONnorm;


	END //

	DELIMITER ;

	call json_transform();


