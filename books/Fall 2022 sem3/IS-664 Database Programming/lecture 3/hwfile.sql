DROP DATABASE IF EXISTS my_imperial_defense;
CREATE DATABASE my_imperial_defense;
USE my_imperial_defense;

CREATE TABLE AntiVirus(
SName VARCHAR(25),
Manufacturer VARCHAR(25),
CurrentVersion VARCHAR(25),
PreviousVersion VARCHAR(25),
ReviseDate DATE,
CONSTRAINT PK_AVIRUS PRIMARY KEY(SName)
);

DESCRIBE AntiVirus;
INSERT INTO AntiVirus VALUES
    ("Samm","csadf","fawr","fagwaa","1998-09-22"),
    ("Samr","csadf","fawr","fagwaa","1997-09-22"),
    ("Samu","cszssq","fawir","fagwaa","1999-09-22"),
    ("Samz","csccxd","fawzr","fqqwaa","1994-09-22"),
    ("Ssm","csawqtu","fawjjr","fqgwaa","1995-09-22"),
    ("zxm","cszadr","fawo","fauwaa","1996-09-22"),
    ("Sagdw","csadcvb","qqwr","fvgwaa","1997-09-22"),
    ("Sewq","csatrwf","fanbr","ffgwaa","1998-09-22"),
    ("Snbbg","csadfqr","fazzx","fagsaa","1998-09-22"),
    ("qqqw","csaddew","fawrii","fagwea","1999-09-22");

SELECT * FROM AntiVirus;

CREATE TABLE Firewall(
IDNumber VARCHAR(25),
SystemName VARCHAR(25),
Filter VARCHAR(25) NOT NULL DEFAULT 'Packet',
CONSTRAINT PK_FIRE PRIMARY KEY(IDNumber)
);

INSERT INTO Firewall VALUES
    ('1','ab','ttu'),
    ('2','abc','ztu'),
    ('3','abe',DEFAULT),
    ('4','afde','ttu'),
    ('5','abcd','wqq'),
    ('6','ffrs','wqq'),
    ('7','ccde','eew'),
    ('8','abe','ttu'),
    ('9','abe','ttu'),
    ('10','ab','ttu'),
    ('11','abc','ttu'),
    ('12','abe',DEFAULT),
    ('13','zab',DEFAULT);

SELECT * FROM Firewall;
DESCRIBE Firewall;

CREATE TABLE Subnet(
IDNumber VARCHAR(25),
BitMask CHAR(14),
Protocol ENUM('IPv4','IPv6') NOT NULL,
DHCProtocol ENUM('Alpha','Beta','Gamma') NOT NULL,
CONSTRAINT PK_SUB PRIMARY KEY(IDNumber)
);

SELECT * FROM Subnet;

CREATE TABLE IntrusionSystem(
SystemID VARCHAR(25),
SystemType ENUM("Network",'Host-Based') NOT NULL,
Detection ENUM('Signature','Anomaly') NOT NULL,
CONSTRAINT PK_INTRUSION PRIMARY KEY(SystemID)
);

CREATE TABLE Site(
SiteName VARCHAR(25),
SiteID VARCHAR(25),
SiteStatus ENUM('ONLINE','OFFLINE') NOT NULL,
XCoord INT,
YCoord INT,
CONSTRAINT PK_SITE PRIMARY KEY(SiteID),
CONSTRAINT UK_SITE UNIQUE KEY(SiteName)
);

INSERT INTO Site VALUES
    ("aav","1","ONLINE",1,10),
    ("aEv","2","OFFLINE",2,11),
    ("aFv","3","OFFLINE",3,12),
    ("aZv","4","ONLINE",4,13),
    ("aBv","5","ONLINE",5,14),
    ("aNv","6","OFFLINE",6,15),
    ("aMv","7","ONLINE",7,16),
    ("aCv","8","ONLINE",8,17),
    ("aOv","9","OFFLINE",9,18),
    ("aTv","10","ONLINE",10,19);

DESCRIBE Site;
SELECT * FROM Site;

CREATE TABLE Network(
NetName VARCHAR(25),
NetType ENUM('DATA','COMM','VIDEO') NOT NULL,
Bandwidth DECIMAL(10,2) NOT NULL,
OptimumBW DECIMAL(10,2) GENERATED ALWAYS AS(Bandwidth * 0.85) STORED,
MaxBW DECIMAL(10,2) GENERATED ALWAYS AS(Bandwidth * 1.25) STORED,
MinBW DECIMAL(10,2) GENERATED ALWAYS AS(Bandwidth * 0.45) STORED,
CSwitched BOOLEAN NOT NULL,
NetStatus ENUM('ONLINE','OFFLINE') NOT NULL,
CONSTRAINT PK_NET PRIMARY KEY(NetName)
);

INSERT INTO Network (NetName, NetType, Bandwidth, CSwitched, NetStatus) VALUES
    ('Asrt','DATA',5.02,true,'ONLINE'),
    ('bsrt','DATA',7.02,false,'ONLINE'),
    ('vszt','VIDEO',3.02,false,'ONLINE'),
    ('estt','COMM',5.32,true,'OFFLINE'),
    ('Afgt','DATA',6.12,false,'OFFLINE'),
    ('Azzz','DATA',1.22,false,'ONLINE'),
    ('Acyt','COMM',9.92,true,'OFFLINE'),
    ('Aydyt','VIDEO',4.02,false,'ONLINE'),
    ('Acdt','DATA',5.32,true,'OFFLINE'),
    ('oewt','VIDEO',5.21,true,'OFFLINE'),
    ('Abnt','VIDEO',7.72,false,'OFFLINE'),
    ('Aiit','COMM',5.33,true,'ONLINE');

DESCRIBE Network;
SELECT * FROM Network;


CREATE TABLE Router(
RID VARCHAR(10),
RType ENUM('Interior','Exterior','Border') NOT NULL,
RouteFinding ENUM('Static','Dynamic') NOT NULL,
Connectivity ENUM('Edge','Backbone','Port Forwarding') NOT NULL,
AssignedTo VARCHAR(25),
CONSTRAINT PK_RTR PRIMARY KEY(RID)
);

INSERT INTO Router VALUES
    ("RTR1","Interior", "Dynamic", "Edge", "afas"),
    ("RTR2","Interior", "Static", "Edge", "daas"),
    ("RTR3","Exterior", "Static", "Port Forwarding", "aaas"),
    ("RTR4","Exterior", "Static", "Edge", "paas"),
    ("RTR22","Interior", "Static", "Edge", "daas"),
    ("RTR12","Exterior", "Static", "Edge", "daas"),
    ("RTR32","Border", "Static", "Edge", "daas"),
    ("RTR5","Interior", "Dynamic", "Backbone", "aaas"),
    ("RTR6","Interior", "Static", "Edge", "aaas"),
    ("RTR7","Interior", "Static", "Edge", "aaas"),
    ("RTR42","Interior", "Static", "Edge", "daas"),
    ("RTR52","Border", "Static", "Edge", "daas"),
    ("RTR8","Border", "Static", "Backbone", "waas"),
    ("RTR9","Interior", "Static", "Edge", "aaas"),
    ("RTR62","Exterior", "Static", "Edge", "dwas"),
    ("RTR10","Interior", "Static", "Edge", "Acdt"),
    ("RTR13","Exterior", "Static", "Edge", "Acdt"),
    ("RTR14","Border", "Static", "Edge", "Acdt");
    

DESCRIBE Router;
SELECT * FROM Router;


CREATE TABLE Switch(
SID VARCHAR(10),
EntryPort INT NOT NULL,
ExitPort INT NOT NULL,
Stackable BOOLEAN NOT NULL,
PoE BOOLEAN NOT NULL,
AssignedTo VARCHAR(25),
CONSTRAINT PK_SWITCH PRIMARY KEY(SID),
CONSTRAINT UK_SWITCH1 UNIQUE KEY(EntryPort),
CONSTRAINT UK_SWITCH2 UNIQUE KEY(ExitPort)
);

INSERT INTO Switch VALUES
    ("1",221,311,true,false,"asw"),
    ("2",312,312,true,false,"asse"),
    ("3",411,313,true,false,"aswf"),
    ("4",211,212,true,true,"aswu"),
    ("5",213,111,false,false,"aswi"),
    ("6",214,511,true,false,"aswo"),
    ("7",314,315,true,true,"aswq"),
    ("8",112,113,false,false,"aswr"),
    ("9",315,114,false,false,"asww"),
    ("10",115,316,true,true,"aswb");

SELECT * FROM Switch;
DESCRIBE Switch;

CREATE TABLE Hub(
HID VARCHAR(10),
Ports INT,
EntryPort INT NOT NULL,
ExitPort INT NOT NULL,
AssignedTo VARCHAR(25),
CONSTRAINT PK_Hub PRIMARY KEY(HID),
CONSTRAINT UK_HUB1 UNIQUE KEY(EntryPort),
CONSTRAINT UK_HUB2 UNIQUE KEY(ExitPort)
);

CREATE TABLE Repeater(
RPID VARCHAR(10),
Ports INT,
EntryPort INT NOT NULL,
ExitPort INT NOT NULL,
AssignedTo VARCHAR(25),
CONSTRAINT PK_RP PRIMARY KEY(RPID),
CONSTRAINT UK_RP1 UNIQUE KEY(EntryPort),
CONSTRAINT UK_RP2 UNIQUE KEY(ExitPort)
);

CREATE TABLE Widget(
WID VARCHAR(25),
WType ENUM('Terminal','Pad','Device') NOT NULL,
AssignedTo VARCHAR(25),
Location VARCHAR(25) NOT NULL DEFAULT 'Unknown',
AccessCode VARCHAR(25) NOT NULL DEFAULT 'Pace',
Secure BOOLEAN NOT NULL DEFAULT false,
User JSON,
CONSTRAINT PK_WIDGET PRIMARY KEY(WID)
);

SELECT 'DATABASE BUILD COMPLETE' AS MSG;

INSERT INTO HUB VALUES 
    ('HB-1',17,495,495,'AAAA'),
    ('HB-12',18,1495,1111,'BBBB'),
    ('HB-21',19,220,584,'CCCC'),
    ('HB-31',15,122,732,'DDDD'),
    ('HB-41',13,534,089,'EEEE'),
    ('HB-51',12,415,666,'FFFF');


SELECT * FROM Hub LIMIT 5;
SELECT COUNT(*) FROM Switch;

SELECT Router.RID FROM Router LIMIT 5;

SELECT * FROM Router WHERE RID = 'RTR2';

SELECT RID, RType
FROM Router
WHERE CONNECTIVITY = 'Edge' AND RouteFinding = 'Static';

SELECT CONCAT(RID,'--',RType) AS ID FROM Router LIMIT 3;

SELECT * FROM Router WHERE RType LIKE 'E%' LIMIT 2;

SELECT * FROM Router ORDER BY RouteFinding LIMIT 5;

SELECT * FROM Router ORDER BY RouteFinding DESC LIMIT 5;

SELECT (XCoord - YCoord) AS 'XY Diff'
FROM Site
LIMIT 3;

SELECT MAX(XCoord) FROM SITE;

SELECT XCoord
FROM Site
WHERE XCoord BETWEEN 20 AND 30 LIMIT 3;

SELECT XCoord
FROM Site
WHERE XCoord IN(20,30) LIMIT 3;

SELECT COUNT(*) AS RtrCount, AssignedTo
FROM Router
GROUP BY AssignedTo
LIMIT 3;

SELECT COUNT(*) AS RtrCount, RType, AssignedTo
FROM Router
GROUP BY AssignedTo
HAVING RType = 'Border'
LIMIT 3;

SELECT RID, RType,
    (SELECT NetStatus AS Status
        FROM Network
        WHERE NetName = 'Acdt') AS NetInfo
FROM Router
WHERE AssignedTo = 'Acdt';

SELECT RID, RType, Network.NetStatus
FROM Router
JOIN Network ON Network.NetName = Router.AssignedTo
WHERE AssignedTo = 'Acdt';

DROP VIEW IF EXISTS SiteLocations;
-- DROP VIEW SiteLocations;

CREATE VIEW SiteLocations AS SELECT XCoord, YCoord FROM Site;

SELECT * FROM SiteLocations LIMIT 3;

CREATE OR REPLACE VIEW SiteLocations AS
SELECT XCoord, YCoord
FROM Site
WHERE XCoord != 8;

SELECT * FROM SiteLocations LIMIT 3;

-- Updateable Views --
DROP VIEW IF EXISTS SiteLocations2;

CREATE VIEW SiteLocations2 AS SELECT SiteName, XCoord, YCoord FROM Site;

SELECT * FROM SiteLocations2 LIMIT 3;

UPDATE SiteLocations2 SET XCoord = 138 WHERE SiteName = "aZv";

SELECT SiteName, XCoord, YCoord
FROM Site
WHERE SiteName = "aZv";

-- Updateable Views (update Base Table)

-- Updateable Views (check Option)

DROP VIEW IF EXISTS SiteLocations3;

Create VIEW SiteLocations3 AS
SELECT SiteName, XCoord, YCoord
From Site
Where XCoord > 10 WIth check Option;

UPDATE SiteLocations3 SET XCoord = 0 WHERE SiteName = "aTv";

SELECT SiteName, XCoord, YCoord
FROM Site
Where SiteName = "aTv";

-- Indexes

CREATE INDEX site_Stat ON Site(SiteStatus);
DESCRIBE Site;

DROP INDEX site_Stat ON Site;
DESCRIBE Site;

-- MUL is the first column of the non-unique index


-- test
DELIMITER //
CREATE FUNCTION routerDetails(whom VARCHAR(100))


SELECT CONCAT('ID: ',RID,'->Type: ',RType,'->RouteFinding: ',RouteFinding,'->Connectivity: ',Connectivity) 
FROM Router 
WHERE AssignedTo LIKE 'daas';