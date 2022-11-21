/*
CLASS EXERCISE 
STORED PROCEDURE DEVELOPMENT
*/

USE imperial_defense;

DROP FUNCTION IF EXISTS buildCode;
DELIMITER //
CREATE FUNCTION buildCode(ID VARCHAR(20), SYS VARCHAR(20), FILTR VARCHAR(20))
RETURNS VARCHAR(40)
DETERMINISTIC

BEGIN
	DECLARE CODE VARCHAR(40);
	SET CODE = SUBSTRING(ID,1,3);
	IF CODE LIKE '%x%' THEN
		SET CODE = CONCAT(CODE,'001_');
	END IF;

	IF CODE LIKE '%-%' THEN
		SET CODE = CONCAT(CODE,'111_');
	END IF;

	IF CODE LIKE '%_%' THEN
		SET CODE = CONCAT(CODE,'101_');
	END IF;

	SET CODE = CONCAT(CODE,'88',SYS,'_');

	IF FILTR = 'Packet' THEN
		SET CODE = CONCAT(CODE,'PKT');
	ELSE
		SET CODE = CONCAT(CODE,'FRM');
	END IF;

	RETURN CODE;

END //
DELIMITER ;

DROP PROCEDURE IF EXISTS firewallAccessCodes;
DELIMITER //
CREATE PROCEDURE firewallAccessCodes()

BEGIN

-- UTILITY VARIABLES
	DECLARE I INT; DECLARE FROWS INT;
	DECLARE CODE VARCHAR(40);

-- CURSOR VARIABLES
	DECLARE ID VARCHAR(20); DECLARE SYS VARCHAR(20); DECLARE FIL VARCHAR(20);

-- DECLARE CURSOR
    DECLARE FW_CURSOR CURSOR FOR SELECT * FROM firewall;

-- TABLE
	DROP TABLE IF EXISTS firewallCodes;
	CREATE TABLE firewallCodes(
	FID INT AUTO_INCREMENT,
	IDNumber VARCHAR(20),
	SystemName VARCHAR(20),
	Filter ENUM('Packet','Frame'),
	FWCode VARCHAR(40),
	CONSTRAINT PK_FWC PRIMARY KEY(FID),
	CONSTRAINT UK_FWC UNIQUE KEY(IDNumber),
	CONSTRAINT FK_FWC FOREIGN KEY(IDNumber) REFERENCES firewall(IDNumber)
	);

	ALTER TABLE firewallCodes AUTO_INCREMENT = 76;

-- OPEN CURSOR
	OPEN FW_CURSOR;
	SET FROWS = FOUND_ROWS();
	SET I = 0;
-- FETCH CURSOR
	WHILE I < FROWS DO
		FETCH FW_CURSOR INTO ID,SYS,FIL;
		SET CODE = buildCode(ID,SYS,FIL);
		INSERT INTO firewallCodes (IDNumber,SystemName,Filter,FWCode) VALUES(ID,SYS,FIL,CODE);
		SET I = I + 1;
	END WHILE;

-- CLOSE CURSOR
	CLOSE FW_CURSOR;

-- DISPLAY TABLE
	SELECT * FROM firewallCodes;

END //

DELIMITER ;

CALL fireWallAccessCodes();

DROP FUNCTION IF EXISTS entryExitData;
DELIMITER //
CREATE FUNCTION entryExitData(T VARCHAR(10), EN INT, EX INT)
RETURNS VARCHAR(30)
DETERMINISTIC

BEGIN
	DECLARE DS VARCHAR(30);
	DECLARE RNG INT; 
	SET RNG = ABS(EX - EN);
	SET DS = CONCAT(T, ' Has Range of ',RNG);
	RETURN DS;

END //
DELIMITER ;

DROP PROCEDURE IF EXISTS componentSummary;
DELIMITER //
CREATE PROCEDURE componentSummary(N VARCHAR(20))

BEGIN
	-- UTILITY VARIABLES
	DECLARE I INT; DECLARE FROWS INT; 
	-- CURSOR VARIABLES
	DECLARE HBID VARCHAR(20);  DECLARE HBENTRY INT; 
	DECLARE HBEXIT INT; DECLARE HBNET VARCHAR(20);
	DECLARE SWID VARCHAR(20); DECLARE SWENTRY INT; DECLARE SWEXIT INT;
	DECLARE RID VARCHAR(20); DECLARE RENTRY INT; DECLARE REXIT INT;
	-- DECLARE CURSOR
	 DECLARE HSR_CURSOR CURSOR FOR 
	 SELECT H.HID, H.EntryPort, H.ExitPort, H.AssignedTo, S.SID, S.EntryPort, S.ExitPort,
	 R.RPID, R.EntryPort, R.ExitPort 
	 FROM hub H
	 JOIN switch S ON H.AssignedTo = S.AssignedTo
	 JOIN repeater R ON S.AssignedTo = R.AssignedTo
	 WHERE H.AssignedTo = N AND S.AssignedTo = N AND R.AssignedTo = N
	 LIMIT 3;
	-- OPEN CURSOR
	OPEN HSR_CURSOR;
	SET FROWS = FOUND_ROWS();
	SET I = 0;
	-- FETCH CURSOR
	WHILE I < FROWS DO
		FETCH HSR_CURSOR INTO HBID,HBENTRY,HBEXIT,HBNET,SWID,SWENTRY,SWEXIT,RID,RENTRY,REXIT;
		
		SELECT CONCAT('HUB: ',HBID,' SWITCH: ',SWID,' REPEATER: ', RID,
		 '\n  Hub Port Range: ',entryExitData('HUB',HBENTRY,HBEXIT),
		 '\n  Switch Port Range: ',entryExitData('SWITCH',SWENTRY,SWEXIT),
		 '\n  Repeater Port Range: ',entryExitData('REPEATER',RENTRY,REXIT),
		 '\n  All Components Assigned To: ',HBNET) AS MSG;		
		SET I = I + 1;
	END WHILE;
	
	-- CLOSE CURSOR
	CLOSE HSR_CURSOR;

END //
DELIMITER ;

CALL componentSummary('Brore06vNET_SURV');