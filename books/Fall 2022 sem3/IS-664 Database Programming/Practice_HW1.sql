# ------- TASK 1 ------- #
USE imperial_defense;
/* DROP FUNCTION IF EXISTS routerDisplay;

DELIMITER //
CREATE FUNCTION routerDisplay(RI VARCHAR(10))
RETURNS VARCHAR(150)
NOT DETERMINISTIC
READS SQL DATA

BEGIN

	DECLARE RTy VARCHAR(150);
	SELECT CONCAT('ID: ', RID, '->TYPE: ', RType,'->PATH: ', RouteFinding, '->CONNECT: ', Connectivity) FROM Router WHERE RID = RI INTO RTy;
	RETURN RTy;

END //
DELIMITER ;

SELECT routerDisplay('RTR1') AS TASK 1;


# ------- TASK 2 ------- #

DROP FUNCTION IF EXISTS timeTillRevise;
DELIMITER //
CREATE FUNCTION timeTillRevise(Name VARCHAR(25))
RETURNS VARCHAR(100)
NOT DETERMINISTIC
READS SQL DATA
BEGIN
	DECLARE MSG VARCHAR(100);
	DECLARE year DECIMAL(10,2);
	SELECT DATEDIFF(ReviseDate,'2022-02-10') FROM AntiVirus WHERE SName = Name INTO year;
	SET year = year / 365;

	SELECT CONCAT(SName,' Antivirus Software Revision in ',year, ' years') FROM AntiVirus WHERE SName = Name INTO MSG;

	RETURN MSG;

END //
DELIMITER ;

SELECT timeTillRevise('APHALEA') AS TASK 2;


# ------- TASK 3 ------- #

DROP FUNCTION IF EXISTS getFirewallCode;

DELIMITER //
CREATE FUNCTION getFirewallCode(ID VARCHAR(25))
RETURNS VARCHAR(100)
NOT DETERMINISTIC
READS SQL DATA

BEGIN

	DECLARE MSG1 VARCHAR(100);
	DECLARE Sname VARCHAR(25);
	DECLARE Sfilter VARCHAR(25);
	DECLARE code VARCHAR(5);
	SELECT SystemName, Filter FROM Firewall WHERE IDNumber = ID INTO Sname, Sfilter;

	IF Sname = 'Zara' 	AND Sfilter = 'Packet' THEN
		SET code = 25;
	ELSEIF Sname = 'Zara' AND Sfilter = 'Frame' THEN
		SET code = 30;
	ELSEIF Sname = 'Etis' AND Sfilter = 'Frame' THEN
		SET code = 35;
	ELSEIF Sname = 'Etis' AND Sfilter = 'Packet' THEN
		SET code = 40;
	ELSEIF Sname = 'Ecoria' AND Sfilter = 'Packet' THEN
		SET code = 45;
	ELSEIF Sname = 'Cheirus' AND Sfilter = 'Frame' THEN
		SET code = 50;
	END IF;		

	#SELECT CONCAT(IDNumber,'->',Sname,'->',SFilter,'->CODE: ',code) FROM Firewall WHERE IDNumber = ID INTO MSG1;
SET MSG1 =	CONCAT(ID,'->',Sname,'->',SFilter,'->CODE: ',code);
	RETURN MSG1;

END //
DELIMITER ;

SELECT getFirewallCode('FW_y-0') AS TASK 3;


# ------- TASK 4 ------- #

DROP FUNCTION IF EXISTS hubPortDifference;

DELIMITER //
CREATE FUNCTION hubPortDifference(HID1 VARCHAR(10),HID2 VARCHAR(10))
RETURNS VARCHAR(100)
NOT DETERMINISTIC
READS SQL DATA

BEGIN
	DECLARE DIFF1 INT(20);
	DECLARE DIFF2 INT(20);
	DECLARE MSG2 VARCHAR(100);
	SELECT (EntryPort - ExitPort) FROM Hub WHERE HID = HID1 INTO Diff1;
	SELECT (EntryPort - ExitPort) FROM Hub WHERE HID = HID2 INTO Diff2;
	SELECT CONCAT('HUB: ',HID1,' Range: ',Diff1,' HUB: ',HID2,' Range: ',ABS(Diff2)) INTO MSG2;
	RETURN MSG2;

END //
DELIMITER ;

SELECT hubPortDifference('HB-1','HB-10') AS TASK 4;



# ------- TASK 5 ------- #

DROP FUNCTION IF EXISTS distanceToSite;

DELIMITER //
CREATE FUNCTION distanceToSite(SiteN VARCHAR(25),X2 INT, Y2 INT)
RETURNS VARCHAR(100)
NOT DETERMINISTIC
READS SQL DATA

BEGIN
	DECLARE X1 INT;
	DECLARE Y1 INT;
	DECLARE status VARCHAR(10);
	DECLARE MSG3 VARCHAR(100);
	DECLARE E DECIMAL(5,2);

	SELECT SiteStatus, XCoord, YCoord FROM Site WHERE SiteName = SiteN INTO status,X1,Y1;

	IF status = 'OFFLINE' THEN
		SET MSG3 = 'Site Offline...Distance Unknown';
	ELSEIF status = 'ONLINE' THEN
		SELECT Eudis(X1,Y1,X2,Y2) INTO E;
		SELECT CONCAT('Distance to location ','[',X2,':',Y2,']',' from ',SiteN,' is ', E, ' Km') INTO MSG3;
	END IF;

	RETURN MSG3;

END //
DELIMITER ;
SELECT distanceToSite('Eaw99q12',10,20) AS TASK5;

DROP FUNCTION IF EXISTS Eudis;
DELIMITER //
CREATE FUNCTION Eudis(x1 INT,y1 INT,x2 INT,y2 INT)
RETURNS DECIMAL(5,2)
DETERMINISTIC

BEGIN
DECLARE ED DECIMAL(5,2);

SET ED = SQRT(POW((x2 - x1),2) + POW((y2 - y1),2));
RETURN ED; 

END //
DELIMITER ;



# ------- TASK 6 ------- #

DROP FUNCTION IF EXISTS distanceBetweenWidgets;
DELIMITER //
CREATE FUNCTION distanceBetweenWidgets(ID1 VARCHAR(25),ID2 VARCHAR(25))
RETURNS VARCHAR(150)
NOT DETERMINISTIC
READS SQL DATA
BEGIN
	DECLARE MSG4 VARCHAR(100);
	DECLARE site1 VARCHAR(25);
	DECLARE site2 VARCHAR(25);
	DECLARE EU DECIMAL(5,2);
	DECLARE X1 INT;
	DECLARE Y1 INT;
	DECLARE X2 INT;
	DECLARE Y2 INT;
	
	SELECT Location FROM Widget WHERE WID = ID1 INTO site1;
	SELECT Location FROM Widget WHERE WID = ID2 INTO site2;

	SELECT XCoord, YCoord FROM Site WHERE SiteName = site1 INTO X1,Y1;
	SELECT XCoord, YCoord FROM Site WHERE SiteName = site2 INTO X2,Y2;

	SELECT Eudis(X1,Y1,X2,Y2) INTO EU;

	SELECT CONCAT('Distance from ',ID1,' Located at Site ',site1,' to ',ID2,' Located at Site ',site2,' is ',EU,' Kms') INTO MSG4;

	RETURN MSG4;

END //
DELIMITER ;

SELECT distanceBetweenWidgets('WDG#1','WDG#10') AS TASK6;


*/

# ------- TASK 7 ------- #
DROP FUNCTION IF EXISTS networkBWRange;

DELIMITER //
CREATE FUNCTION networkBWRange(Name VARCHAR(25))
RETURNS VARCHAR(150)
NOT DETERMINISTIC
READS SQL DATA

BEGIN
	DECLARE MSG5 VARCHAR(150);
	DECLARE NetN VARCHAR(25);
	DECLARE Descr VARCHAR(25);
	DECLARE Status VARCHAR(10);
	DECLARE BW DECIMAL(10,2);
#	SELECT RIGHT(NetName,4) AS NetN, (MaxBW -  MinBW) AS BW, NetStatus FROM Network WHERE NetName = Name INTO NetN, BW,Status;

	SELECT NetName, (MaxBW -  MinBW) AS BW, NetStatus FROM Network WHERE NetName = Name INTO NetN, BW,Status;
	
	IF Status = 'ONLINE' THEN
		IF NetN LIKE '%_SAT' THEN
			SET Descr = 'Satellite Network';
		ELSEIF NetN LIKE '%_DEF' THEN
			SET Descr = 'Defense Network';
		ELSEIF NetN LIKE '%_CIV' THEN
			SET Descr = 'Civilian Network';
		ELSEIF NetN LIKE '%_SURV' THEN
			SET Descr = 'Surveillance Network';	
		ELSEIF NetN LIKE '%_TRACK' THEN
			SET Descr = 'Tracking Network';
		END IF;
		
	SELECT CONCAT(Descr,' ', Name,' Bandwidth Range is ', BW,' gbs') INTO MSG5;
	
	ELSEIF Status = 'OFFLINE' THEN
		SET MSG5 = 'Network is Offline Bandwidth is 0';
	END IF;

RETURN MSG5;

END //
DELIMITER ;

SELECT networkBWRange('Povebos04zNET_CIV') AS TASK 7_1;
SELECT networkBWRange('Brore03yNET_SAT') AS 'TASK 7_2';

/*
# ------- TASK 8 ------- #
DROP FUNCTION IF EXISTS switchConfiguration;

DELIMITER //
CREATE FUNCTION switchConfiguration(SWID VARCHAR(10))
RETURNS VARCHAR(150)
NOT DETERMINISTIC
READS SQL DATA

BEGIN

	DECLARE MSG6 VARCHAR(150);
	DECLARE Rating VARCHAR(25);
	DECLARE Source VARCHAR(10);
	DECLARE AsTo VARCHAR(25);
	DECLARE ID VARCHAR(10);
	DECLARE NS VARCHAR(10);
	DECLARE Stack BOOLEAN;
	DECLARE PE BOOLEAN;
	DECLARE EntryP INT;
	DECLARE ExitP INT;
	DECLARE PPORT INT;


	SELECT RIGHT(SID,1) AS ID,EntryPort, ExitPort, Stackable, PoE, AssignedTo FROM Switch WHERE SID = SWID
	INTO ID, EntryP, ExitP, Stack, PE, AsTo;
	SELECT NetStatus FROM Network WHERE NetName = AsTo INTO NS;


	IF NS = 'ONLINE' THEN
		IF ID % 2 = '0' AND Stack = '0' THEN
			SET PPORT = EntryP;
		ELSE
			SET	PPORT = ExitP;
		END IF;

		IF PPORT = EntryP THEN
	    	SET Rating = 'Secure Switch';
	    ELSE
	      	SET Rating = 'Unsecure Switch';
	    END IF;

	    IF PE = '1' THEN
	    	SET Source = 'AC';
	    ELSE
	    	SET Source = 'DC';
	    END IF;

	SELECT CONCAT('Switch ',SWID,' PRIMARY PORT: ',PPORT,' POWER: ',Source,' SECURITY: ',Rating,' is a part of Network ',AsTo) INTO MSG6;
	RETURN MSG6;
    
  ELSE
    SELECT CONCAT('The Switch is Currently Unavailable') INTO MSG6;
    RETURN MSG6;
  END IF;


END //
DELIMITER ;

SELECT switchConfiguration('SW-1') AS 'TASK 8_2';
SELECT switchConfiguration('SW-20') AS 'TASK 8_3';





