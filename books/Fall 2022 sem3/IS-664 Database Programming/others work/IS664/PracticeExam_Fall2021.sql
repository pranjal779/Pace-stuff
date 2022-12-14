/*
Practice Exam
IS 664 Database Programming
Fall 2021
*/

USE imperial_defense;

DROP FUNCTION IF EXISTS euclidean;
DELIMITER //
CREATE FUNCTION euclidean(X1 INT,Y1 INT,X2 iNT,Y2 INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC

BEGIN
	DECLARE D DECIMAL(10,2);
	DECLARE XDIFF INT;
	DECLARE YDIFF INT;
	SET XDIFF = POW(X2-X1,2);
	SET YDIFF = POW(Y2-Y1,2);
	SET D = SQRT(XDIFF + YDIFF);
	RETURN D;

END //
DELIMITER ;

DROP FUNCTION IF EXISTS  buildUser;
DELIMITER //
CREATE FUNCTION buildUser(D VARCHAR(20), L VARCHAR(20), S VARCHAR(20))
RETURNS JSON
DETERMINISTIC

BEGIN
	DECLARE U JSON;
	SET U = JSON_OBJECT("Tech",D,"Location",L,"Status",S);
	RETURN U;

END //
DELIMITER ;

DROP PROCEDURE IF EXISTS  widget_connect;
DELIMITER //
CREATE PROCEDURE widget_connect(NET VARCHAR(30))

BEGIN
		-- UTILITY VARIABLES
		DECLARE I INT; DECLARE FROWS INT;
		DECLARE DISTANCE DECIMAL(10,2);
		DECLARE X INT; DECLARE Y INT;
		DECLARE U JSON;

		-- CURSOR VARIABLES
		DECLARE ID VARCHAR(20); DECLARE WT VARCHAR(20); DECLARE WN VARCHAR(30);
		DECLARE NS VARCHAR(20); DECLARE NB INT; DECLARE WL VARCHAR(30);

		-- DECLARE CURSOR
		DECLARE MW_CURSOR CURSOR FOR 
		SELECT W.WID, W.WType, W.AssignedTo, N.NetStatus, N.Bandwidth, W.Location
		FROM widget W
		JOIN Network N ON W.AssignedTo = N.NetName
		WHERE W.AssignedTo = NET AND N.NetStatus = 'ONLINE' LIMIT 10;		


DROP TABLE IF EXISTS master_widget;
CREATE TABLE master_widget(
WID VARCHAR(30),
WType ENUM('Pad','Terminal','Device'),
NetworkIn VARCHAR(30),
NetworkStatus VARCHAR(30),
NetworkBW INT,
Location VARCHAR(30),
DistanceTo DECIMAL(10,2),
User JSON,
CONSTRAINT PK_MW PRIMARY KEY(WID),
CONSTRAINT FK_MW FOREIGN KEY(WID) REFERENCES widget(WID)
);

	-- OPEN CURSOR
	OPEN MW_CURSOR;
	SET FROWS = FOUND_ROWS();
	SET I = 0;
	-- FETCH CURSOR
	WHILE I < FROWS DO
		FETCH MW_CURSOR INTO ID, WT, WN, NS, NB, WL;

		SELECT XCoord FROM site WHERE SiteName = WL INTO X;
		SELECT YCoord FROM site WHERE SiteName = WL INTO Y;
		SET DISTANCE = euclidean(X,100,Y,100);
		SET U = buildUser(WT,WL,NS);
		
		INSERT INTO master_widget VALUES(ID,WT,WN,NS,NB,WL,DISTANCE,U);
		SET I = I + 1;
	END WHILE;

		-- CLOSE CURSOR
		CLOSE MW_CURSOR;

		-- DISPLAY TABLE
		SELECT * FROM master_widget;

END //

DELIMITER ;

CALL widget_connect('Brore03yNET_SAT');
