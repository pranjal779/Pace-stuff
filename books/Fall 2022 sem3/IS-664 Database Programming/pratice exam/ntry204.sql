CREATE DATABASE IF NOT EXISTS TargetingSchema;
USE TargetingSchema;

DROP PROCEDURE IF EXISTS testingschema;
DELIMITER //

CREATE PROCEDURE testingschema()

BEGIN

    CREATE TABLE targets(
    targetID VARCHAR(50),
    reportingSource ENUM('Satellite', 'Ground Observer','Airborne Observer') NULL,
    reportingDate DATE NULL,
    CONSTRAINT PK_target PRIMARY KEY (targetID)
    );

    CREATE TABLE targetDimensions(
    targetID VARCHAR(50) NOT NULL,
    length DECIMAL(10,2) NULL,
    width DECIMAL(10,2) NULL,
    sqFootage DECIMAL(10,2) GENERATED ALWAYS AS (length * width) NULL,
    CONSTRAINT FK_targetDimensions FOREIGN KEY (targetID) REFERENCES targets(targetID)
    );

    CREATE TABLE targetLocation(
    targetID VARCHAR(50),
    coords JSON NULL,
    CONSTRAINT PK_targetLocation PRIMARY KEY (targetID),
    CONSTRAINT FK_targetLocation FOREIGN KEY (targetID) REFERENCES targets(targetID)
    );

    CREATE TABLE targetValue(
    targetID VARCHAR(50) NOT NULL,
    sector ENUM('North', 'East', 'West', 'South') NULL,
    tgtvalue DECIMAL(10,2) NULL,
    CONSTRAINT PK_targetValue PRIMARY KEY (targetID),
    CONSTRAINT FK_targetValue FOREIGN KEY (targetID) REFERENCES targets(targetID)
    );

    CREATE TABLE targetList(
    tgtDesignation VARCHAR(50) NOT NULL,
    targetID VARCHAR(50) NULL,
    approved TINYINT(1) NULL,
    priority ENUM('Immediate', 'High', 'Routine') NULL,
    CONSTRAINT PK_targetList PRIMARY KEY (tgtDesignation),
    CONSTRAINT UK_targetList UNIQUE KEY(targetID)
    );

    CREATE TABLE resourcesRequired(
    tgtDesignation VARCHAR(50) NOT NULL,
    assetType VARCHAR(50) NULL,
    assets INT NULL,
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

CALL testingschema();
