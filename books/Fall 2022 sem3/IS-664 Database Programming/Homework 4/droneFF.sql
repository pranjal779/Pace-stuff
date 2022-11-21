DROP DATABASE IF EXISTS droneFF;
CREATE DATABASE droneFF;
USE droneFF;

SELECT 'Database droneFF Created' AS MSG;

CREATE TABLE droneTypes(
TypeID VARCHAR(20),
DModel VARCHAR(20),
DRange INT,
DSpeed INT,
DCapacity INT,
MissionCost DECIMAL(10,2),
CONSTRAINT pk_dt PRIMARY KEY(TypeID),
CONSTRAINT fk_dt UNIQUE KEY(DModel)
);

SELECT 'Table droneTypes Created' AS MSG;

CREATE TABLE airfields(
AFID VARCHAR(20),
AF_Location VARCHAR(10),
CONSTRAINT pk_afld PRIMARY KEY(AFID)
);

SELECT 'Table airfields Created' AS MSG;

CREATE TABLE droneUnits(
UnitID VARCHAR(20),
DroneModel VARCHAR(20),
DronesAssigned INT,
DronesOperational INT,
DronesReady INT,
AirfieldAssigned VARCHAR(20),
CONSTRAINT pk_du PRIMARY KEY(UnitID),
CONSTRAINT fk1_du FOREIGN KEY(AirfieldAssigned) REFERENCES airfields(AFID),
CONSTRAINT fk2_du FOREIGN KEY(DroneModel) REFERENCES droneTypes(DModel)
);

SELECT 'Table droneUnits Created' AS MSG;

CREATE TABLE activeFires(
FireID VARCHAR(20),
Fire_Category ENUM('A','B','C','D'),
Fire_Location VARCHAR(20),
CONSTRAINT pk_af PRIMARY KEY(FireID)
);

SELECT 'Table activeFires Created' AS MSG;
SELECT 'Database Script Complete' AS MSG;

