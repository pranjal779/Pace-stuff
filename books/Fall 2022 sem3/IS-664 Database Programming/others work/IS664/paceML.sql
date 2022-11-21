DROP DATABASE IF EXISTS paceML;
CREATE DATABASE paceML;
USE paceML;

CREATE TABLE yuanClass(
Observation INT AUTO_INCREMENT,
ELength DECIMAL(10,4),
EBeam DECIMAL(10,4),
EDraft DECIMAL(10,4),
Pressure DECIMAL(10,4),
Vortex DECIMAL(10,4),
Magnetic DECIMAL(10,4),
Light DECIMAL(10,4),
CONSTRAINT PK_yuan PRIMARY KEY(Observation)
);

CREATE TABLE xiaClass(
Observation INT AUTO_INCREMENT,
ELength DECIMAL(10,4),
EBeam DECIMAL(10,4),
EDraft DECIMAL(10,4),
Pressure DECIMAL(10,4),
Vortex DECIMAL(10,4),
Magnetic DECIMAL(10,4),
Light DECIMAL(10,4),
CONSTRAINT PK_xia PRIMARY KEY(Observation)
);

INSERT INTO yuanClass (ELength,EBeam,EDraft,Pressure,Vortex,Magnetic,Light) 
VALUES(62.08,7.98,5.03,534.56,965.18,17.21,0.94);
INSERT INTO yuanClass (ELength,EBeam,EDraft,Pressure,Vortex,Magnetic,Light) 
VALUES(73.72,8.40,6.37,835.25,463.29,15.49,1.06);
INSERT INTO yuanClass (ELength,EBeam,EDraft,Pressure,Vortex,Magnetic,Light) 
VALUES(77.60,6.30,6.70,890.93,463.29,17.21,0.56);
INSERT INTO yuanClass (ELength,EBeam,EDraft,Pressure,Vortex,Magnetic,Light) 
VALUES(77.60,6.72,5.03,534.56,463.29,13.77,0.56);
INSERT INTO yuanClass (ELength,EBeam,EDraft,Pressure,Vortex,Magnetic,Light) 
VALUES(69.84,6.72,5.36,1113.67,965.18,8.26,1.06);

INSERT INTO xiaClass (ELength,EBeam,EDraft,Pressure,Vortex,Magnetic,Light) 
VALUES(96.00,4.80,6.40,3157.92,1697.28,57.60,14.40);
INSERT INTO xiaClass (ELength,EBeam,EDraft,Pressure,Vortex,Magnetic,Light) 
VALUES(96.00,8.00,6.00,3508.80,1909.44,51.84,14.40);
INSERT INTO xiaClass (ELength,EBeam,EDraft,Pressure,Vortex,Magnetic,Light) 
VALUES(57.60,4.80,7.20,3157.92,1909.44,43.20,14.40);
INSERT INTO xiaClass (ELength,EBeam,EDraft,Pressure,Vortex,Magnetic,Light) 
VALUES(114.00,4.80,7.60,3333.36,1697.28,54.72,17.10);
INSERT INTO xiaClass (ELength,EBeam,EDraft,Pressure,Vortex,Magnetic,Light) 
VALUES(90.00,9.00,7.60,2631.60,1018.37,43.20,16.20);

DESCRIBE yuanClass;
SELECT * FROM yuanClass LIMIT 2;
DESCRIBE xiaClass;
SELECT * FROM xiaClass LIMIT 2;
SELECT 'SCRIPT COMPLETE' AS 'PROFESSOR MSG';

