DROP DATABASE IF EXISTS StrikePlanning;
CREATE DATABASE StrikePlanning;
USE StrikePlanning;

-- Task 1
-- Creating a Targeting Database inside a Procedure
DROP DATABASE IF EXISTS Targeting;
CREATE DATABASE Targeting;
USE Targeting;


DROP PROCEDURE IF EXISTS buildTargeting;
DELIMITER //
CREATE PROCEDURE buildTargeting()
BEGIN

    -- DROP DATABASE IF EXISTS Targeting;
    -- CREATE DATABASE Targeting;

    DROP TABLE IF EXISTS Targeting.targets;
    CREATE TABLE Targeting.targets(
    targetID VARCHAR(50),
    reportingSource ENUM('Satellite', 'Ground Observer', 'Airborne Observer'),
    reportingDate DATE,
    CONSTRAINT PK_target PRIMARY KEY (targetID)
    );

    DROP TABLE IF EXISTS Targeting.targetDimensions;
    CREATE TABLE Targeting.targetDimensions(
    targetID VARCHAR(50),
    length DECIMAL(10,2),
    width DECIMAL(10,2),
    sqFootage DECIMAL(10,2) GENERATED ALWAYS AS (length * width) STORED,
    CONSTRAINT PK_targetDimensions PRIMARY KEY (targetID),
    CONSTRAINT FK_targetDimensions FOREIGN KEY (targetID) REFERENCES targets(targetID)
    );

    DROP TABLE IF EXISTS Targeting.targetLocation;
    CREATE TABLE Targeting.targetLocation(
    targetID VARCHAR(50),
    coords JSON,
    CONSTRAINT PK_targetLocation PRIMARY KEY (targetID),
    CONSTRAINT FK_targetLocation FOREIGN KEY (targetID) REFERENCES targets(targetID)
    );

    DROP TABLE IF EXISTS Targeting.targetValue;
    CREATE TABLE Targeting.targetValue(
    targetID VARCHAR(50),
    sector ENUM('North', 'East', 'West', 'South'),
    tgtvalue DECIMAL(10,2),
    CONSTRAINT PK_targetValue PRIMARY KEY (targetID),
    CONSTRAINT FK_targetValue FOREIGN KEY (targetID) REFERENCES targets(targetID)
    );

    DROP TABLE IF EXISTS Targeting.targetList;
    CREATE TABLE Targeting.targetList(
    tgtDesignation VARCHAR(50),
    targetID VARCHAR(50),
    approved TINYINT(1),
    priority ENUM('Immediate', 'High', 'Routine'),
    CONSTRAINT PK_targetList PRIMARY KEY (tgtDesignation),
    CONSTRAINT UK_targetList UNIQUE KEY(targetID)
    );

    DROP TABLE IF EXISTS Targeting.resourcesRequired;
    CREATE TABLE Targeting.resourcesRequired(
    tgtDesignation VARCHAR(50),
    assetType VARCHAR(50),
    assets INT,
    CONSTRAINT PK_resourcesRequired PRIMARY KEY (tgtDesignation),
    CONSTRAINT FK_resourcesRequired FOREIGN KEY (tgtDesignation) REFERENCES targetList(tgtDesignation)
    );

    DROP TABLE IF EXISTS Targeting.strikeAssets;
    CREATE TABLE Targeting.strikeAssets(
    assetID VARCHAR(50) NOT NULL,
    assetType VARCHAR(50) NULL,
    costPerMission DECIMAL(10,2) NULL,
    CONSTRAINT PK_strikeAssets PRIMARY KEY (assetID)
    );

    SHOW TABLES FROM Targeting;

END //
DELIMITER ;

CALL buildTargeting();


-- Task 2

DROP PROCEDURE IF EXISTS populate_Targeting;
DELIMITER //
CREATE PROCEDURE populate_Targeting(js JSON)
BEGIN

    -- SELECT JSON_EXTRACT(js, '$.targets[1]');
    -- INSERT INTO Targeting.targets  VALUES(JSON_EXTRACT(js, '$.targets[0]'), JSON_EXTRACT(js, '$.targets[1]'), JSON_EXTRACT(js, '$.targets[2]'));
    INSERT INTO Targeting.targets VALUES(JSON_EXTRACT(js, '$.targets[0]'),JSON_EXTRACT(js, '$.targets[1]'), JSON_EXTRACT(js, '$.targets[2]'));


    INSERT INTO Targeting.targetLocation VALUES(JSON_EXTRACT(js, '$.targetLocation[0]'), JSON_OBJECT(JSON_EXTRACT(js, '$.targetLocation[1][0]')), JSON_EXTRACT(js, '$.targetLocation[1][1]')));
    -- INSERT INTO Targeting.targetLocation VALUES(JSON_EXTRACT(js, '$.targetLocation[0]'), JSON_EXTRACT(js, 'Satellite'), JSON_EXTRACT(js, '$.targetLocation[1][1]'));

    INSERT INTO Targeting.targetValue VALUES(JSON_EXTRACT(js, '$.targetValue[0]'), JSON_OBJECT(JSON_EXTRACT(js, '$.targetValue[1][1]')), JSON_EXTRACT(js, '$.targetValue[2]'));
    -- INSERT INTO Targeting.targetValue VALUES(JSON_EXTRACT(js, '$.targetValue[0]'), JSON_EXTRACT(js, 'North'), JSON_EXTRACT(js, '$.targetValue[2]'));

    -- INSERT INTO Targeting.targetDimension

    INSERT INTO Targeting.targetDimensions VALUES(JSON_EXTRACT(js, '$.targetDimensions[0]'), JSON_EXTRACT(js, '$.targetDimensions[1]'));

    INSERT INTO Targeting.targetList VALUES(JSON_EXTRACT(js, '$.targetlist[0]'), JSON_EXTRACT(js, '$.targetList[1]'), JSON_EXTRACT(js, '$.targetList[2]'), JSON_EXTRACT(js, 'Immediate'));

    INSERT INTO Targeting.strikeAssets VALUES(JSON_EXTRACT(js, '$.strikeAssets[0]'), JSON_EXTRACT(js, '$.strikeAssets[1]'), JSON_EXTRACT(js, '$.strikeAssets[2]'));

    INSERT INTO Targeting.resourcesRequired VALUES(JSON_EXTRACT(js, '$.resourcesRequired[0]'),JSON_EXTRACT(js, '$.resourcesRequired[1]'), JSON_EXTRACT(js, '$.resourcesRequired[2]'));

    select * from Targeting.targets;
    select * from Targeting.targetLocation;
    select * from Targeting.targetValue;
    SELECT * FROM Targeting.targetDimensions;
    select * from Targeting.targetList;
    select * from Targeting.strikeAssets;
    select * from Targeting.resourcesRequired;
    -- JSON_OBJECT('targets',JSON_ARRAY('T-001','Satellite','2022-01-01')));

END //
DELIMITER ;

-- CALL populate_Targeting();

-- CALL populate_Targeting(SELECT JSON_EXTRACT('targets','$.[0]','$.[1]','$.[2]'));
-- CALL populate_Targeting(JSON_OBJECT('targets',JSON_ARRAY('T-001','Satellite','2022-01-01')
--     ,'targetLocation',JSON_ARRAY('T-001',JSON_ARRAY(10,12)),'targetValue',JSON_ARRAY('T-001','North',120000),
--     'targetDimensions',JSON_ARRAY('T-001',50,50),'targetList',JSON_ARRAY('APT-001','T-001',1,'Immediate'),'strikeAssets',JSON_ARRAY('A1','Aircraft',1000),
--     'resourcesRequired',JSON_ARRAY('APT-001','Aircraft',4)));
-- CALL populate_Targeting(JSON_OBJECT('targets',JSON_ARRAY('T-001','Satellite','2022-01-01')));





CALL populate_Targeting(JSON_OBJECT('targets',JSON_ARRAY('T-001','Satellite','2022-01-01')
    ,'targetLocation',JSON_ARRAY('T-001',JSON_ARRAY(10,12)),'targetValue',JSON_ARRAY('T-001','North',120000),
    'targetDimensions',JSON_ARRAY('T-001',50,50),'targetList',JSON_ARRAY('APT-001','T-001',1,'Immediate'),'strikeAssets',JSON_ARRAY('A1','Aircraft',1000),
    'resourcesRequired',JSON_ARRAY('APT-001','Aircraft',4)));

CALL populate_Targeting(JSON_OBJECT('targets',JSON_ARRAY('T-002','Ground Observer','2022-01-03')
    ,'targetLocation',JSON_ARRAY('T-002',JSON_ARRAY(18,18)),'targetValue',JSON_ARRAY('T-002','South',125000),
    'targetDimensions',JSON_ARRAY('T-002',20,50),'targetList',JSON_ARRAY('APT-002','T-002',1,'Routine'),'strikeAssets',JSON_ARRAY('A2','Aircraft',1000),
    'resourcesRequired',JSON_ARRAY('APT-002','Aircraft',2)));

CALL populate_Targeting(JSON_OBJECT('targets',JSON_ARRAY('T-003','Satellite','2022-01-05')
    ,'targetLocation',JSON_ARRAY('T-003',JSON_ARRAY(130,12)),'targetValue',JSON_ARRAY('T-003','East',125000),
    'targetDimensions',JSON_ARRAY('T-003',50,90),'targetList',JSON_ARRAY('APT-003','T-003',1,'Immediate'),'strikeAssets',JSON_ARRAY('S1','System',8000),
    'resourcesRequired',JSON_ARRAY('APT-003','System',4)));

CALL populate_Targeting(JSON_OBJECT('targets',JSON_ARRAY('T-004','Airborne Observer','2022-01-02')
    ,'targetLocation',JSON_ARRAY('T-004',JSON_ARRAY(10,120)),'targetValue',JSON_ARRAY('T-004','North',180000),
    'targetDimensions',JSON_ARRAY('T-004',10,50),'targetList',JSON_ARRAY('APT-004','T-004',1,'High'),'strikeAssets',JSON_ARRAY('A3','Aircraft',1000),
    'resourcesRequired',JSON_ARRAY('APT-004','Aircraft',6)));

CALL populate_Targeting(JSON_OBJECT('targets',JSON_ARRAY('T-005','Satellite','2022-01-07')
    ,'targetLocation',JSON_ARRAY('T-005',JSON_ARRAY(110,125)),'targetValue',JSON_ARRAY('T-005','West',160000),
    'targetDimensions',JSON_ARRAY('T-005',50,150),'targetList',JSON_ARRAY('APT-005','T-005',1,'Immediate'),'strikeAssets',JSON_ARRAY('S2','System',8000),
    'resourcesRequired',JSON_ARRAY('APT-005','System',2)));


-- Task 3
DROP PROCEDURE IF EXISTS displayTargeting;
DELIMITER //
CREATE PROCEDURE displayTargeting(V VARCHAR(50))
BEGIN

    IF V = "targets" THEN
        DESCRIBE Targeting.targets;
        SELECT * FROM Targeting.targets;
    END IF;
    IF V = "targetLocation" THEN
        SELECT * FROM Targeting.targetLocation;
    END IF;
    IF V = "targetDimensions" THEN
        SELECT * FROM Targeting.targetDimensions;
    END IF;
    IF V = "targetList" THEN
        SELECT * FROM Targeting.targetList;
    END IF;
    IF V = "targetValue" THEN
        SELECT * FROM Targeting.targetValue;
    END IF;
    IF V = "resourcesRequired" THEN
        SELECT * FROM Targeting.resourcesRequired;
    END IF;
    IF V = "strikeAssets" THEN
        SELECT * FROM Targeting.strikeAssets;
    END IF;


END //
DELIMITER ;


CALL displayTargeting("targets");
