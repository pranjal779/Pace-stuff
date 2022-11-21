DROP DATABASE IF EXISTS StrikePlanning;
CREATE DATABASE StrikePlanning;
USE StrikePlanning;

-- Task 1
-- Creating a Targeting Database inside a Procedure

DROP PROCEDURE IF EXISTS buildTargeting;
DELIMITER //
CREATE PROCEDURE buildTargeting()
BEGIN

    DROP DATABASE IF EXISTS Targeting;
    CREATE DATABASE Targeting;

    CREATE TABLE targets(
    targetID VARCHAR(50),
    reportingSource ENUM('Satellite', 'Ground Observer','Airborne Observer'),
    reportingDate DATE,
    CONSTRAINT PK_target PRIMARY KEY (targetID)
    );

    CREATE TABLE targetDimensions(
    targetID VARCHAR(50),
    length DECIMAL(10,2),
    width DECIMAL(10,2),
    sqFootage DECIMAL(10,2) GENERATED ALWAYS AS (length * width) STORED,
    CONSTRAINT PK_targetDimensions PRIMARY KEY (targetID),
    CONSTRAINT FK_targetDimensions FOREIGN KEY (targetID) REFERENCES targets(targetID)
    );

    CREATE TABLE targetLocation(
    targetID VARCHAR(50),
    coords JSON,
    CONSTRAINT PK_targetLocation PRIMARY KEY (targetID),
    CONSTRAINT FK_targetLocation FOREIGN KEY (targetID) REFERENCES targets(targetID)
    );

    CREATE TABLE targetValue(
    targetID VARCHAR(50),
    sector ENUM('North', 'East', 'West', 'South'),
    tgtvalue DECIMAL(10,2),
    CONSTRAINT PK_targetValue PRIMARY KEY (targetID),
    CONSTRAINT FK_targetValue FOREIGN KEY (targetID) REFERENCES targets(targetID)
    );

    CREATE TABLE targetList(
    tgtDesignation VARCHAR(50),
    targetID VARCHAR(50),
    approved TINYINT(1),
    priority ENUM('Immediate', 'High', 'Routine'),
    CONSTRAINT PK_targetList PRIMARY KEY (tgtDesignation),
    CONSTRAINT UK_targetList UNIQUE KEY(targetID)
    );

    CREATE TABLE resourcesRequired(
    tgtDesignation VARCHAR(50),
    assetType VARCHAR(50),
    assets INT,
    CONSTRAINT PK_resourcesRequired PRIMARY KEY (tgtDesignation),
    CONSTRAINT FK_resourcesRequired FOREIGN KEY (tgtDesignation) REFERENCES targetList(tgtDesignation)
    );

    CREATE TABLE strikeAssets(
    assetID VARCHAR(50) NOT NULL,
    assetType VARCHAR(50) NULL,
    costPerMission DECIMAL(10,2) NULL,
    CONSTRAINT PK_strikeAssets PRIMARY KEY (assetID)
    );

END //
DELIMITER ;

CALL buildTargeting();

-- Task 2

-- [10]
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
    targetID VARCHAR(100),
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

-- CALL buildTargeting();


-- Task 2

DROP PROCEDURE IF EXISTS populate_Targeting;
DELIMITER //
CREATE PROCEDURE populate_Targeting(js JSON)
BEGIN
    CALL buildTargeting();
    -- SELECT JSON_EXTRACT(js, '$.targets[1]');
    -- INSERT INTO Targeting.targets  VALUES(JSON_EXTRACT(js, '$.targets[0]'), JSON_EXTRACT(js, '$.targets[1]'), JSON_EXTRACT(js, '$.targets[2]'));
    INSERT INTO Targeting.targets VALUES(JSON_EXTRACT(js, '$.targets[0]',JSON_EXTRACT(js, '$.targets[1]'), JSON_EXTRACT(js, '$.targets[2]')));


    INSERT INTO Targeting.targetLocation VALUES(JSON_EXTRACT(js, '$.targetLocation[0]'), JSON_OBJECT(JSON_EXTRACT(js, '$.targetLocation[1][0]'), JSON_EXTRACT(js, '$.targetLocation[1][1]')));


    INSERT INTO Targeting.targetValue VALUES(JSON_EXTRACT(js, '$.targetValue[0]'), JSON_OBJECT(JSON_EXTRACT(js, '$.targetValue[1][1]'), JSON_EXTRACT(js, '$.targetValue[2]')));

    -- INSERT INTO Targeting.targetDimension

    select * from Targeting.targets;
    select * from Targeting.targetLocation;
    select * from Targeting.targetValue;
    -- JSON_OBJECT('targets',JSON_ARRAY('T-001','Satellite','2022-01-01')));

END //
DELIMITER ;

-- CALL populate_Targeting();

-- CALL populate_Targeting(SELECT JSON_EXTRACT('targets','$.[0]','$.[1]','$.[2]'));
CALL populate_Targeting(JSON_OBJECT('targets',JSON_ARRAY('T-001', 'Satellite' ,'2022-01-01')
    ,'targetLocation',JSON_ARRAY('T-001',JSON_ARRAY(10,12)),'targetValue',JSON_ARRAY('T-001','North',120000),
    'targetDimensions',JSON_ARRAY('T-001',50,50),'targetList',JSON_ARRAY('APT-001','T-001',1,'Immediate'),'strikeAssets',JSON_ARRAY('A1','Aircraft',1000),
    'resourcesRequired',JSON_ARRAY('APT-001','Aircraft',4)));
-- CALL populate_Targeting(JSON_OBJECT('targets',JSON_ARRAY('T-001','Satellite','2022-01-01')));



