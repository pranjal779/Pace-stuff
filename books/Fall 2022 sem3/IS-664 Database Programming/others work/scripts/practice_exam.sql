/* Mid-Term Practice exam 
script 
created by Pranav on
28th October*/


/* Creating the function
to calulate distance */

use imperial_defense;

DROP FUNCTION IF EXISTS calc_distance;
DELIMITER //
CREATE FUNCTION calc_distance(Loct VARCHAR(30))
RETURNS DECIMAL(10,2)
DETERMINISTIC
	
BEGIN

DECLARE DISTANCE DECIMAL(10,2);
DECLARE A,B INT;

select XCoord from site where SiteName = Loct into A;
select YCoord from site where SiteName = Loct into B;

set DISTANCE = abs(A-B);

Return DISTANCE;

END //

DELIMITER ;


/*
CREATING THE REQUIRED
PROCEDURE */

DROP PROCEDURE widget_connect;
DELIMITER //
CREATE PROCEDURE widget_connect(A VARCHAR(40))

BEGIN
	-- CREATE UTILITY VARIABLES
	DECLARE count_rows, I INT;	

	-- CREATE CURSOR VARIABLES
	DECLARE WI_ID, NETW_IN, NETW_STAT, LOCT, WI_TYP VARCHAR(30);
	DECLARE NETW_BW INT;
	DECLARE CODE DECIMAL(10,2);
	DECLARE USE_R JSON;

	-- DECLARE CURSOR
	DECLARE WID_CURSOR CURSOR FOR SELECT W.WID, W.WTYPE, N.NETNAME, N.NETSTATUS, N.BANDWIDTH,S.SITENAME 
	FROM NETWORK N INNER JOIN WIDGET W ON W.ASSIGNEDTO = N.NETNAME INNER JOIN SITE S ON S.SITENAME = W.LOCATION AND N.NETNAME = A limit 10; 

	DROP TABLE IF EXISTS master_widget;
	CREATE TABLE master_widget(
		WID VARCHAR(30),
		WTYPE ENUM('Pad','Terminal','Device'),
		NetworkIn VARCHAR(30),
		NetworkStatus VARCHAR(30),
		NetworkBW int,
		Location VARCHAR(30),
		DistanceTo DECIMAL(10,2),
		User JSON,
		CONSTRAINT PK_MW PRIMARY KEY(WID),
		CONSTRAINT FK_MW FOREIGN KEY(WID) REFERENCES widget(WID));

	-- OPEN CURSOR
	OPEN WID_CURSOR;
	SET count_rows = Found_Rows();
	SET I = 0;
	-- Fetch Cursor
	WHILE I < count_rows DO
		FETCH WID_CURSOR INTO WI_ID, WI_TYP, NETW_IN, NETW_STAT, NETW_BW,LOCT;
		SET CODE = calc_distance(LOCT);

		INSERT INTO master_widget(WID,WTYPE,NetworkIn,NetworkStatus,NetworkBW,Location,DistanceTo,User) 
		VALUES (WI_ID,WI_TYP,NETW_IN,NETW_STAT,NETW_BW,LOCT,CODE,JSON_OBJECT("Tech:",(WI_TYP),"Status:",(NETW_STAT),"Location:",(LOCT)));
		SET I = I + 1;
	END WHILE;

	-- Close Cursor
	CLOSE WID_CURSOR;
	
	-- Display

	SELECT * FROM master_widget;


END //
DELIMITER ;

CALL widget_connect('Brore03yNET_SAT') ;
