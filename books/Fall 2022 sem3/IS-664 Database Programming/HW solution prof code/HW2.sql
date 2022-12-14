USE imperial_defense;

DROP FUNCTION IF EXISTS convertBoolean;
DELIMITER //
CREATE FUNCTION convertBoolean(A INT)
RETURNS VARCHAR(40)
DETERMINISTIC

BEGIN
	DECLARE E VARCHAR(20);
	IF A = 1 THEN
		SET E = 'Encrypted';
	END IF;
	IF A = 0 THEN
		SET E = 'Plain Text';
	END IF;
	RETURN E;
END //
DELIMITER ;

DROP FUNCTION IF EXISTS convertDevice;
DELIMITER //
CREATE FUNCTION convertDevice(A VARCHAR(20))
RETURNS VARCHAR(20)
DETERMINISTIC

BEGIN
	DECLARE E VARCHAR(20);
	IF A = 'Device' THEN
		SET E = 'IDEV';
	END IF;
	IF A = 'Pad' THEN
		SET E = 'IPAD';
	END IF;
	IF A = 'Terminal' THEN
		SET E = 'ITERM';
	END IF;
	RETURN E;
END //
DELIMITER ;

DROP FUNCTION IF EXISTS convertNet;
DELIMITER //
CREATE FUNCTION convertNet(A VARCHAR(20))
RETURNS VARCHAR(20)
DETERMINISTIC

BEGIN
	DECLARE E VARCHAR(20);
	IF A LIKE '%TRACK' THEN
		SET E = 'TRACK';
	END IF;
	IF A LIKE '%SAT' THEN
		SET E = 'SAT';
	END IF;
	IF A LIKE '%CIV' THEN
		SET E = 'CIV';
	END IF;
	IF A LIKE '%SURV' THEN
		SET E = 'SURV';
	END IF;
	IF A LIKE '%DEF' THEN
		SET E = 'DEF';
	END IF;
	
	RETURN E;
END //
DELIMITER ;

DROP FUNCTION IF EXISTS convertAccess;
DELIMITER //
CREATE FUNCTION convertAccess(A VARCHAR(20))
RETURNS VARCHAR(20)
DETERMINISTIC

BEGIN
	DECLARE E VARCHAR(20);
	IF A LIKE 'A%' THEN
		SET E = 'A1';
	END IF;
	IF A LIKE 'B%' THEN
		SET E = 'B2';
	END IF;
	IF A LIKE 'C%' THEN
		SET E = 'C3';
	END IF;
	IF A LIKE 'D%' THEN
		SET E = 'D4';
	END IF;
		
	RETURN E;
END //
DELIMITER ;

DROP FUNCTION IF EXISTS getCoords;
DELIMITER //
CREATE FUNCTION getCoords(L VARCHAR(40))
RETURNS VARCHAR(100)
READS SQL DATA
NOT DETERMINISTIC

BEGIN
	DECLARE SLOC VARCHAR(40); DECLARE X INT; DECLARE Y INT;
	SELECT XCoord FROM Site WHERE SiteName = L INTO X;
	SELECT YCoord FROM Site WHERE SiteName = L INTO Y;
	SET SLOC = CONCAT(L,'-- X:',X,' Y:',Y);
	RETURN SLOC;
END //
DELIMITER ;

DROP FUNCTION IF EXISTS createUser;
DELIMITER //
CREATE FUNCTION createUser(A VARCHAR(10),B VARCHAR(10),C VARCHAR(10),D INT)
RETURNS JSON
DETERMINISTIC

BEGIN
	DECLARE U JSON; DECLARE CD VARCHAR(40);
	IF D = 1 THEN
		SET CD = 'User Encrypted';
	END IF;
	IF D = 0 THEN
		SET CD = 'User Not Encrypted';
	END IF;	
	SET U = JSON_OBJECT("ID",A,"DEVICE",B,"ACCESS CODE",C,"Encypted_YN",CD);
	RETURN U;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS widgetRefactor;
DELIMITER //
CREATE PROCEDURE widgetRefactor()

BEGIN
	-- DECLARE UTILITY VARIABLES
	DECLARE I INT; DECLARE FROWS INT;
	-- DECLARE CURSOR VARIABLES
	DECLARE WA VARCHAR(40); DECLARE WB VARCHAR(40); DECLARE WC VARCHAR(40);
	DECLARE WD VARCHAR(40); DECLARE WE VARCHAR(40); DECLARE WF INT;
	DECLARE WG JSON;

	-- DECLARE CONVERSION VARIABLES
	DECLARE WT VARCHAR(40); DECLARE WNT VARCHAR(40); DECLARE RLOC VARCHAR(100);
	DECLARE WAC VARCHAR(10); DECLARE WSEC VARCHAR(40);
	DECLARE WUSER JSON;

	-- DECLARE CURSOR
	DECLARE RW_CURSOR CURSOR FOR SELECT * FROM Widget;

	-- CREATE TABLE
	DROP TABLE IF EXISTS R_Widget;
	CREATE TABLE R_Widget(
	RWID INT AUTO_INCREMENT,
	WidgetID VARCHAR(20),
	RType ENUM('IDEV','IPAD','ITERM'),
	NetAssigned VARCHAR(40),
	RNetType ENUM('SAT','TRACK','SURV','DEF','CIV'),
	RLocation VARCHAR(100),
	RAccess ENUM('A1','B2','C3','D4'),
	RSecure ENUM('Encrypted','Plain Text'),
	RUser JSON,
	CONSTRAINT PK_RW PRIMARY KEY(RWID),
	CONSTRAINT UK_RW UNIQUE KEY(WidgetID),
	CONSTRAINT FK_RW FOREIGN KEY(WidgetID) REFERENCES Widget(WID)
	);

	-- OPEN CURSOR
	OPEN RW_CURSOR;
	SET FROWS = FOUND_ROWS();
	SET I = 0;

	WHILE I < FROWS DO
		-- FETCH CURSOR 
		FETCH RW_CURSOR INTO WA,WB,WC,WD,WE,WF,WG;
		-- CONVERT VALUES
		SET WT = convertDevice(WB);
		SET WNT = convertNet(WC);
		SET RLOC = getCoords(WD);
		SET WAC = convertAccess(WE);
		SET WSEC = convertBoolean(WF);
		SET WUSER = createUser(WA,WB,WE,WF);
		-- INSERT VALUES INTO TABLE
		INSERT INTO R_Widget (WidgetID,RType,NetAssigned,RNetType,RLocation,RAccess,RSecure,RUser) 
		VALUES(WA,WT,WC,WNT,RLOC,WAC,WSEC,WUSER);
		SET I = I + 1;
	END WHILE ;	

	-- CLOSE CURSOR
	CLOSE RW_CURSOR;

	-- DISPLAY TABLE
	SELECT * FROM R_Widget LIMIT 10;

END //
DELIMITER ;
CALL widgetRefactor();
