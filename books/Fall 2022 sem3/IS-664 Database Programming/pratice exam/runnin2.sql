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

    DROP TABLE IF EXISTS Targeting.targets;
    CREATE TABLE Targeting.targets(
    targetID VARCHAR(50),
    reportingSource ENUM('Satellite', 'Ground Observer', 'Airborne Observer') NOT NULL,
    reportingDate DATE,
    CONSTRAINT PK_target PRIMARY KEY (targetID)
    );



    DROP TABLE IF EXISTS Targeting.targetLocation;
    CREATE TABLE Targeting.targetLocation(
    targetID VARCHAR(50),
    coords JSON,
    CONSTRAINT PK_targetLocation PRIMARY KEY (targetID),
    CONSTRAINT FK_targetLocation FOREIGN KEY (targetID) REFERENCES targets(targetID)
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
    assetID VARCHAR(50),
    assetType VARCHAR(50),
    costPerMission DECIMAL(10,2),
    CONSTRAINT PK_strikeAssets PRIMARY KEY (assetID)
    );

    SHOW TABLES FROM Targeting;

END //
DELIMITER ;

-- CALL buildTargeting();


-- Task 2

DROP PROCEDURE IF EXISTS populate_Targeting;
DELIMITER //
CREATE PROCEDURE populate_Targeting(js JSON)
BEGIN
    CALL buildTargeting();
    SELECT JSON_EXTRACT(js, '$.targets[1]');
    INSERT INTO Targeting.targets VALUES(JSON_EXTRACT(js, '$.targets[0]'), 'Ground Observer', JSON_EXTRACT(js, '$.targets[2]'));
    select * from Targeting.targets;
    INSERT INTO Targeting.targetLocation VALUES(JSON_EXTRACT(js, '$.targetLocation[0]'), JSON_EXTRACT(js, '$.targetLocation[1]'));
    select * from Targeting.targetLocation;
    INSERT INTO Targeting.targetDimensions (targetID,length,width)
    VALUES
        (
            JSON_EXTRACT(js, '$.targetDimensions[0]'),
        JSON_EXTRACT(js, '$.targetDimensions[1]'),
        JSON_EXTRACT(js, '$.targetDimensions[2]')
        );

    select sqFootage from Targeting.targetDimensions;
    INSERT INTO Targeting.targetValue VALUES(JSON_EXTRACT(js, '$.targetValue[0]'), 'North', JSON_EXTRACT(js, '$.targetValue[2]'));
    SELECT * FROM Targeting.targetValue;
    INSERT INTO Targeting.targetList VALUES(JSON_EXTRACT(js, '$.targetList[0]'), JSON_EXTRACT(js, '$.targetList[1]'), JSON_EXTRACT(js, '$.targetList[2]'), 'Immediate');
    SELECT * FROM Targeting.targetList;
    INSERT INTO Targeting.resourcesRequired VALUES(JSON_EXTRACT(js, '$.resourcesRequired[0]'), JSON_EXTRACT(js, '$.resourcesRequired[1]'), JSON_EXTRACT(js, '$.resourcesRequired[2]'));
    SELECT * FROM Targeting.resourcesRequired;
    INSERT INTO Targeting.strikeAssets VALUES(JSON_EXTRACT(js, '$.strikeAssets[0]'), JSON_EXTRACT(js, '$.strikeAssets[1]'), JSON_EXTRACT(js, '$.strikeAssets[2]'));
    SELECT * FROM Targeting.strikeAssets;


END //
DELIMITER ;


CALL populate_Targeting(JSON_OBJECT('targets',JSON_ARRAY('T-001', 'Ground Observer' ,'2022-01-01')
    ,'targetLocation',JSON_ARRAY('T-001',JSON_ARRAY(10,12)),'targetValue',JSON_ARRAY('T-001','North',120000),
    'targetDimensions',JSON_ARRAY('T-001',50.00,50.00),'targetList',JSON_ARRAY('APT-001','T-001',1,'Immediate'),'strikeAssets',JSON_ARRAY('A1','Aircraft',1000),
    'resourcesRequired',JSON_ARRAY('APT-001','Aircraft',4)));


-- TASK 3

DELIMITER //
CREATE PROCEDURE displayTargeting(V VARCHAR(50))
BEGIN

    IF V = "targets" THEN
        DESCRIBE Targeting.targets;
        SELECT * FROM Targeting.targets;
    END IF;
    IF V = "targetLocation" THEN
        DESCRIBE Targeting.targetLocation;
        SELECT * FROM Targeting.targetLocation;
    END IF;
    IF V = "targetDimensions" THEN
        DESCRIBE Targeting.targetDimensions;
        SELECT * FROM Targeting.targetDimensions;
    END IF;
    IF V = "targetList" THEN
        DESCRIBE Targeting.targetList;
        SELECT * FROM Targeting.targetList;
    END IF;
    IF V = "targetValue" THEN
        DESCRIBE Targeting.targetValue;
        SELECT * FROM Targeting.targetValue;
    END IF;
    IF V = "resourcesRequired" THEN
        DESCRIBE Targeting.resourcesRequired;
        SELECT * FROM Targeting.resourcesRequired;
    END IF;
    IF V = "strikeAssets" THEN
        DESCRIBE Targeting.strikeAssets;
        SELECT * FROM Targeting.strikeAssets;
    END IF;


END //
DELIMITER ;


CALL displayTargeting("targets");
CALL displayTargeting("targetLocation");
CALL displayTargeting("targetDimensions");
CALL displayTargeting("targetList");
CALL displayTargeting("targetValue");
CALL displayTargeting("resourcesRequired");
CALL displayTargeting("strikeAssets");
