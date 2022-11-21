DROP DATABASE IF EXISTS asteroids;
CREATE DATABASE asteroids;
USE asteroids;

CREATE TABLE registry(
Designation VARCHAR(20),
AType ENUM('Carboneous','Metallic','Silicaceous'),
Country ENUM('US','UK','CHINA','RUSSIA'),
DDate DATE,
CONSTRAINT PK_REG PRIMARY KEY(Designation)
);


CREATE TABLE spatialCoord(
Designation VARCHAR(20),
X DECIMAL(10,2),
Y DECIMAL(10,2),
Z DECIMAL(10,2),
CONSTRAINT PK_SP PRIMARY KEY(Designation),
CONSTRAINT FK_SP FOREIGN KEY(Designation) REFERENCES registry(Designation)
);

CREATE TABLE specifications(
Designation VARCHAR(20),
Diameter Decimal(10,3),
Mass Decimal(10,3),
Density Decimal(10,3),
Inclination Decimal(10,3),
Rotation Decimal(10,2),
CONSTRAINT PK_SPEC PRIMARY KEY(Designation),
CONSTRAINT FK_SPEC FOREIGN KEY(Designation) REFERENCES registry(Designation)
);

CREATE TABLE orbit(
Designation VARCHAR(20),
Aphelion Decimal(10,3),
Perihelion Decimal(10,3),
Eccentricity Decimal(10,3),
Period_Orbit Decimal(10,3),
Radius_Orbit Decimal(10,2),
CONSTRAINT PK_OB PRIMARY KEY(Designation),
CONSTRAINT FK_OB FOREIGN KEY(Designation) REFERENCES registry(Designation)
);

CREATE TABLE composition_simple(
Designation VARCHAR(20),
Content_Rock Decimal(10,3),
Content_Metal Decimal(10,3),
CONSTRAINT PK_CS PRIMARY KEY(Designation),
CONSTRAINT FK_CS FOREIGN KEY(Designation) REFERENCES registry(Designation)
);

CREATE TABLE composition_precious(
Designation VARCHAR(20),
Gold Decimal(10,5),
Silver Decimal(10,5),
Platinum Decimal(10,5),
Palladium Decimal(10,5),
Rhodium Decimal(10,5),
Ruthenium Decimal(10,5),
Iridium Decimal(10,5),
Osmium Decimal(10,5),
CONSTRAINT PK_CP PRIMARY KEY(Designation),
CONSTRAINT FK_CP FOREIGN KEY(Designation) REFERENCES registry(Designation)
);

CREATE TABLE composition_common(
Designation VARCHAR(20),
Nickel Decimal(10,5),
Molybdenum Decimal(10,5),
Iron Decimal(10,5),
Zinc Decimal(10,5),
CONSTRAINT PK_CC PRIMARY KEY(Designation),
CONSTRAINT FK_CC FOREIGN KEY(Designation) REFERENCES registry(Designation)
);

CREATE TABLE composition_strategic(
Designation VARCHAR(20),
Chromium Decimal(10,5),
Cobalt Decimal(10,5),
Tungsten Decimal(10,5),
Uranium Decimal(10,5),
CONSTRAINT PK_CST PRIMARY KEY(Designation),
CONSTRAINT FK_CST FOREIGN KEY(Designation) REFERENCES registry(Designation)
);

CREATE TABLE surface_feature(
Designation VARCHAR(20),
Surface ENUM('Hard','Hard-Medium','Medium','Medium-Soft','Soft'),
Water ENUM('High-Content','Medium-Content','Low-Content','No-Content'),
CONSTRAINT PK_SF PRIMARY KEY(Designation),
CONSTRAINT FK_SF FOREIGN KEY(Designation) REFERENCES registry(Designation)
);

