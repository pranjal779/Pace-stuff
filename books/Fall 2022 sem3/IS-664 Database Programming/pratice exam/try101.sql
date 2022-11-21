DROP DATABASE IF EXISTS Strike_Planning;
CREATE DATABASE Strike_Planning;
USE Strike_Planning;

-- Task 1
-- Creating a Targeting Database inside a Procedure

DROP PROCEDURE IF EXISTS build_Targeting;
DELIMITER $$
CREATE PROCEDURE build_Targeting()


CREATE DATABASE IF NOT EXISTS Targeting;
USE Targeting;

    BEGIN

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

    CALL testingschema();


END $$
DELIMITER ;

CALL build_Targeting();
-- Task 2



-- [3]

-- (targetID, reportingSource, reportingDate)
-- 'Ground Observer',
-- UPDATE INTO Targeting.targets VALUES(JSON_EXTRACT(js, '$.targets[0]'), JSON_EXTRACT(js, '$.targets[1]'), JSON_EXTRACT(js, '$.targets[2]'));
