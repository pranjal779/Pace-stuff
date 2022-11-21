DROP DATABASE IF EXISTS LocklearDB;
CREATE DATABASE LocklearDB;
USE LocklearDB;

CREATE TABLE R1(
IDNumber INT AUTO_INCREMENT,
A VARCHAR(20),
B DECIMAL(10,2),
C INT,
CONSTRAINT PK_R1 PRIMARY KEY(IDNumber)
);

DESCRIBE R1;

/*
ALTER TABLE R1 DROP PRIMARY KEY;
ALTER TABLE R1 ADD CONSTRAINT NPK_R1 PRIMARY KEY(B);

DESCRIBE R1;
*/