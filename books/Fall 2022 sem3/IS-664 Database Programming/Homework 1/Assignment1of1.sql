USE imperial_defense;

-- My Name

DELIMITER //
CREATE FUNCTION displayAuthorName()
RETURNS VARCHAR(30)
DETERMINISTIC

BEGIN
    DECLARE MyName VARCHAR(30);
    SET MyName = "Pranjal Shukla";
    RETURN MyName;

END //
DELIMITER ;

SELECT displayAuthorName() AS AuthorName;

-- Task 1

DELIMITER //
CREATE FUNCTION routerDisplay(whom VARCHAR(100))
RETURNS VARCHAR(100)
NOT DETERMINISTIC
READS SQL DATA

BEGIN
    DECLARE display VARCHAR(100);
    SELECT CONCAT('ID: ',RID,'->Type: ',RType,'->RouteFinding: ',RouteFinding,'->Connectivity: ',Connectivity) 
    FROM Router
    WHERE RID = whom INTO display;
    RETURN display;

END //
DELIMITER ;

SELECT routerDisplay('RTR52') AS 'TASK-1';


/*
RTR2
RTR12
RTR32
RTR42

,'RTR2','RTR12','RTR32','RTR42'


SELECT CONCAT('ID: ',RID,'->Type: ',RType,'->RouteFinding: ',RouteFinding,'->Connectivity: ',Connectivity) 
FROM Router 
WHERE AssignedTo LIKE 'daas';


DELIMITER //
CREATE FUNCTION routerDisplay2(whom VARCHAR(100))
RETURNS VARCHAR(100)
NOT DETERMINISTIC
READS SQL DATA

BEGIN
    DECLARE display VARCHAR(100);
    SELECT CONCAT('ID: ',RID,'->Type: ',RType,'->RouteFinding: ',RouteFinding,'->Connectivity: ',Connectivity) 
    FROM Router
    WHERE AssignedTo.Router LIKE 'daas' = whom INTO display;
    RETURN display;

END //
DELIMITER ;

SELECT routerDisplay2() AS test;
*/
-- TASK 2

DELIMITER //
CREATE FUNCTION timeTillRevise(AntiVirusName VARCHAR(50))
RETURNS VARCHAR(100)
NOT DETERMINISTIC
READS SQL DATA

BEGIN
    DECLARE NAME VARCHAR(100);
    SELECT CONCAT(SName,", Antivirus Software Revision in ",ROUND(DATEDIFF("1998-09-22", "2025-07-24")/365)," year's.")
    FROM AntiVirus WHERE Sname = AntiVirusName INTO NAME;
    RETURN NAME;

END //
DELIMITER ;

SELECT timeTillRevise('Norton') AS 'TASK-2';


-- Task 3
DESCRIBE Firewall;
SELECT * FROM Firewall;

DROP FUNCTION IF EXIST getFirewallCode;
DELIMITER //
CREATE FUNCTION getFirewallCode(firewallID VARCHAR(100))
RETURNS VARCHAR(100)
NOT DETERMINISTIC
READS SQL DATA

BEGIN
    DECLARE display2 VARCHAR(100);
    DECLARE SystemName VARCHAR(100);
    DECLARE SystemFilter VARCHAR(100);
    DECLARE TOTAL VARCHAR(100);
    
    SELECT SystemName, Filter
    FROM Firewall WHERE IDNumber = firewallID INTO SystemName, SystemFilter;
    
    IF SystemName = 'Zara' THEN
        IF SystemFilter = 'Packet' THEN
        SET display2 = 25;
    ELSEIF SystemName = 'Zara' THEN
        IF SystemFilter = 'Frame' THEN
        SET display2 = 30;
    ELSEIF SystemName = 'Etis' THEN 
        IF SystemFilter = 'Frame' THEN
        SET display2 = 35;
    ELSEIF SystemName = 'Etis' THEN
        IF SystemFilter = 'Packet' THEN
        SET display2 = 40;
    ELSEIF SystemName = 'Etis' THEN 
        IF SystemFilter = 'Packet' THEN
        SET display2 = 45;   
    ELSEIF SystemName = 'Etis' THEN 
        IF SystemFilter = 'Packet' THEN
        SET display2 = 50;
    END IF;
    
    SET TOTAL = CONCAT(firewallID,'->',SystemName,'->',SystemFilter,'->CODE: ',display2);

    RETURN TOTAL;
END //
DELIMITER ;

SELECT getFirewallCode('FWx-3') AS 'TASK-3';

-- Task 4
/*
DROP FUNCTION IF EXISTS differenceOfHUBports;

DELIMITER //
CREATE FUNCTION differenceOfHUBports(A VARCHAR (10))
RETURNS VARCHAR(100)
READS SQL DATA

BEGIN
    DECLARE N VARCHAR(100);
    SELECT CONCAT('HUB: ',HID,' RANGE: ',ABS(EntryPort-ExitPort))
    FROM Hub
    WHERE HID = A INTO N;
    RETURN N;

END //
DELIMITER ;

SELECT differenceOfHUBports('HB-1') AS 'TASK-4';
*/
/*
DELIMITER //
CREATE FUNCTION hubPortDifference(difrnc1 INT, difrnc2 INT)
RETURNS INT
DETERMINISTIC

BEGIN
    DECLARE A1 INT; DECLARE B1 INT; DECLARE A2 INT; DECLARE B2 INT; DECLARE C1 INT; DECLARE C2 INT;
    SET A1 = EntryPort.HUB; SET B1 = ExitPort.HUB;
    SET A2 = EntryPort.HUB; SET B2 = ExitPort.HUB;
    select abs(EntryPort-ExitPort) from hub where HID = difrnc1 Limit 1 into C1;
    SELECT CONCAT('HUB: ',HID.HUB,' Range: ',C1,' HUB: ',HID.HUB,' Range: 'C2)
    FROM HUB
    WHERE A1 = 495 && B1 = 495 && A2 = 1982 && B2 = 1997;

END //
DELIMITER ;

SELECT hubPortDifference('HB-1','HB-12') AS 'HubPortDifference';
*/
DROP FUNCTION IF EXISTS differenceOfHUBports;
DELIMITER //
CREATE FUNCTION differenceOfHUBports(difrnc1 VARCHAR(50), difrnc2 VARCHAR(50))
RETURNS VARCHAR(150)
-- RETURNS INT
NOT DETERMINISTIC
READS SQL DATA

BEGIN
    DECLARE diffAtHub1 INT; DECLARE diffAtHub2 INT; DECLARE C3MainDiff VARCHAR(150); DECLARE C1Hub_ID1Result VARCHAR(150); DECLARE C2Hub_ID2Result VARCHAR(50);
    SELECT abs(EntryPort-ExitPort) FROM Hub WHERE difrnc1 = HID INTO diffAtHub1;
    SELECT abs(EntryPort-ExitPort) from hub where difrnc2 = HID INTO diffAtHub2;
    SELECT CONCAT('HUB: ', HID,' Range: ',diffAtHub1) FROM Hub WHERE difrnc1 = HID INTO C1Hub_ID1Result;
    SELECT CONCAT('HUB: ', HID,' Range: ',diffAtHub2) FROM Hub WHERE difrnc2 = HID INTO C2Hub_ID2Result;
    SELECT CONCAT(C1Hub_ID1Result, C2Hub_ID2Result) INTO C3MainDiff;
    RETURN C3MainDiff;

END //
DELIMITER ;
SELECT differenceOfHUBports('HB-1','HB-12') AS 'TASK-4'; 

-- TASK 5
DROP FUNCTION IF EXISTS distanceToSite;
DELIMITER //
CREATE FUNCTION distanceToSite(NameSite Varchar(200), xcord INT, ycord INT)
RETURNS VARCHAR(200)
NOT DETERMINISTIC
READS SQL DATA

BEGIN
    DECLARE Dist VARCHAR(200);
    DECLARE Dist1 INT;
    DECLARE Dist2 INT;
    DECLARE Dist3 DECIMAL(10,2);
    DECLARE STATUS ENUM('ONLINE', 'OFFLINE');
    SELECT SiteStatus FROM Site WHERE NameSite = SiteName INTO STATUS;
    SELECT XCoord FROM Site WHERE NameSite = SiteName INTO Dist1;
    SELECT YCoord FROM Site WHERE NameSite = SiteName INTO Dist1;
    SET Dist3 = ROUND(SQRT(POWER((xcord - Dist1), 2) + POWER((ycord - Dist2), 2)), 2);
    IF STATUS = 'OFFLINE' THEN
        SET Dist = 'Site Offline.....Distance Unknown';
    ELSEIF
        SELECT CONCAT('Distance to location', '[', xcord,':', ycord,']',' from ',NameSite,' is',Dist3,' km')
    END IF;

    Return Dist;

END //
DELIMITER;

SELECT distanceToSite('Eay0016', 59, 212) AS 'TASK-5';

-- TASK 6

DROP FUNCTION IF EXISTS distanceBetweenWidgets;
DELIMITER //
CREATE FUNCTION distanceBetweenWidgets(ID1 VARCHAR(50),ID2 VARCHAR(50))
RETURNS VARCHAR(150)
NOT DETERMINISTIC
READS SQL DATA
BEGIN
	DECLARE MsgTask6 VARCHAR(100);
	DECLARE site1 VARCHAR(100);
	DECLARE site2 VARCHAR(100);
	DECLARE EUc DECIMAL(5,2);
	DECLARE xcord INT;
	DECLARE ycord INT;
	DECLARE xcord2 INT;
	DECLARE ycord2 INT;
	
	SELECT Location FROM Widget WHERE WID = ID1 INTO site1;
	SELECT Location FROM Widget WHERE WID = ID2 INTO site2;

	SELECT XCoord, YCoord FROM Site WHERE SiteName = site1 INTO xcord,ycord;
	SELECT XCoord, YCoord FROM Site WHERE SiteName = site2 INTO xcord2,ycord2;

	SELECT Allcord(xcord,ycord,xcord2,ycord2) INTO EUc;

	SELECT CONCAT('Distance from ',ID1,' Located at Site ',site1,' to ',ID2,' Located at Site ',site2,' is ',EUc,' Kms') INTO MsgTask6;

	RETURN MsgTask6;

END //
DELIMITER ;

SELECT distanceBetweenWidgets('WDG#1','WDG#10') AS 'TASK-6';

-- TASK 7

DROP FUNCTION IF EXISTS networkBWRange;

DELIMITER //
CREATE FUNCTION networkBWRange(Name VARCHAR(25))
RETURNS VARCHAR(150)
NOT DETERMINISTIC
READS SQL DATA

BEGIN
	DECLARE MsgTask7 VARCHAR(150);
	DECLARE NetNwk VARCHAR(25);
	DECLARE msgs VARCHAR(25);
	DECLARE Status VARCHAR(10);
	DECLARE BnW DECIMAL(10,2);
	
    SELECT RIGHT(NetName,4) AS NetNwk, (MaxBW -  MinBW) AS BnW, NetStatus 
    FROM Network 
    WHERE NetName = Name INTO NetNwk, BnW,Status;

	SELECT NetName, (MaxBW -  MinBW) AS BnW, NetStatus 
    FROM Network 
    WHERE NetName = Name INTO NetNwk, BnW,Status;
	
	IF Status = 'ONLINE' THEN
		IF NetNwk LIKE '%_SAT' THEN
			SET msgs = 'Satellite Network';
		ELSEIF NetNwk LIKE '%_DEF' THEN
			SET msgs = 'Defense Network';
		ELSEIF NetNwk LIKE '%_CIV' THEN
			SET msgs = 'Civilian Network';
		ELSEIF NetNwk LIKE '%_SURV' THEN
			SET msgs = 'Surveillance Network';	
		ELSEIF NetNwk LIKE '%_TRACK' THEN
			SET msgs = 'Tracking Network';
		END IF;
		
	SELECT CONCAT(msgs,' ', Name,' Bandwidth Range is ', BnW,' gbs') INTO MsgTask7;
	
	ELSEIF Status = 'OFFLINE' THEN
		SET MsgTask7 = 'Network is Offline Bandwidth is 0';
	END IF;

RETURN MsgTask7;

END //
DELIMITER ;

SELECT networkBWRange('Povebos04zNET_CIV') AS 'TASK 7_1';
SELECT networkBWRange('Brore03yNET_SAT') AS 'TASK 7_2';


/*
DELIMITER //
CREATE FUNCTION networkBWRange(bwDIFF VARCHAR(100))
RETURNS VARCHAR(100)
NOT DETERMINISTIC
READS SQL DATA

BEGIN
    DECLARE Bandwit DECIMAL(10,2);
    DECLARE MSG VARCHAR(100);
    SET Bandwit = (MaxBW.Network - MinBW.Network);
    IF NetStatus.Network = 'OFFLINE' THEN
        SET MSG = ("Network is Offline Bandwidth is 0") AS "TASK-7_1";
    ELSE
        NetStatus.Network = 'ONLINE' THEN
        SET MSG = CONCAT("Satellite Network ",NetName.Network," Bandwidth Range is ",Bandwit," gbs.") AS "TASK-7_2";
        -- FROM Network
        -- WHERE NetName LIKE 'B%' LIMIT 1;
        END IF;
        RETURN MSG;

END //
DELIMITER ;

SELECT networkBWRange();
*/


/*
DROP FUNCTION IF EXISTS networkBWRange;
DELIMITER //
CREATE function networkBWRange(NName VARCHAR(100))
RETURNS VARCHAR(100)
NOT DETERMINISTIC
READS SQL DATABASE

BEGIN
    DECLARE Result_task7 VARCHAR(100);
    DECLARE NetNamez VARCHAR(100);
    DECLARE msg VARCHAR(100);
    DECLARE Bandwit DECIMAL(10,2);
    DECLARE maxBandwit VARCHAR(10,2);
    DECLARE minBandwit VARCHAR(10,2);
    -- DECLARE banwitStatus VARCHAR(100);

    SELECT NetName from Network WHERE NName = NetName INTO NetNamez;
    SELECT NetStatus from Network WHERE NName = NetName INTO banwitStatus;

    SELECT MaxBW FROM Network
    WHERE NName = NetName INTO maxBandwit;
    
    SELECT MinBW FROM Network
    WHERE NName = NetName INTO minBandwit;
    
    SET Bandwit = maxBandwit - minBandwit;
    
    IF NetNamez LIKE '%_SAT' THEN
        SET msg = 'Satelite Network';
    ELSEIF NetNamez LIKE '%_DEF' THEN
        SET msg = 'Defense Network';
    ELSEIF NetNamez LIKE '%_SURV' THEN
        SET msg = 'Surveillance Network';
    ELSEIF NetNamez LIKE '%_TRACK' THEN
        SET msg = 'Tracking Network';
    END IF;

    IF STATUS = 'OFFLINE' THEN
        SET Information = 'Network is Offline Bandwidth is 0';
    ELSE
        SELECT CONCAT(msg,' ',NetName,' Bandwidth Range is ',Bandwit,' gbs.')
        FROM Network
        WHERE NName = NetName INTO Result_task7;
    END IF;

    RETURN Result_task7;

END //
DELIMITER ;

SELECT networkBWRange('Povebos04zNET_CIV') AS 'TASK 7_1';
SELECT networkBWRange('Brore03yNET_SAT') AS 'TASK 7_2';
*/


-- TASK8
DROP FUNCTION IF EXISTS switchConfiguration;

DELIMITER //
CREATE FUNCTION switchConfiguration(SWID VARCHAR(10))
RETURNS VARCHAR(150)
NOT DETERMINISTIC
READS SQL DATA

BEGIN

	DECLARE MsgTask8 VARCHAR(150);
	DECLARE Rating VARCHAR(25);
	DECLARE Source VARCHAR(10);
	DECLARE AssgTo VARCHAR(25);
	DECLARE ID VARCHAR(10);
	DECLARE S VARCHAR(10);
	DECLARE Stack BOOLEAN;
	DECLARE PE BOOLEAN;
	DECLARE EntryP INT;
	DECLARE ExitP INT;
	DECLARE tPORT INT;


	SELECT RIGHT(SID,1) AS ID,EntryPort, ExitPort, Stackable, PE, AssignedTo FROM Switch WHERE SID = SWID
	INTO ID, EntryP, ExitP, Stack, PE, AssgTo;
	SELECT NetStatus FROM Network WHERE NetName = AssgTo INTO S;


	IF S = 'ONLINE' THEN
		IF ID % 2 = '0' AND Stack = '0' THEN
			SET tPORT = EntryP;
		ELSE
			SET	tPORT = ExitP;
		END IF;

		IF tPORT = EntryP THEN
	    	SET Rating = 'Secure Switch';
	    ELSE
	      	SET Rating = 'Unsecure Switch';
	    END IF;

	    IF PE = '1' THEN
	    	SET Source = 'AC';
	    ELSE
	    	SET Source = 'DC';
	    END IF;

	SELECT CONCAT('Switch ',SWID,' PRIMARY PORT: ',tPORT,' POWER: ',Source,' SECURITY: ',Rating,' is a part of Network ',AssgTo) INTO MsgTask8;
	RETURN MsgTask8;
    
  ELSE
    SELECT CONCAT('The Switch is Currently Unavailable') INTO MsgTask8;
    RETURN MsgTask8;
  END IF;


END //
DELIMITER ;

SELECT switchConfiguration('SW-1') AS 'TASK 8_2';
SELECT switchConfiguration('SW-20') AS 'TASK 8_3';