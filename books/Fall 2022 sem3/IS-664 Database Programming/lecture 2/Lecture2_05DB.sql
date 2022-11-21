DROP DATABASE IF EXISTS LocklearDB;
CREATE DATABASE LocklearDB;
USE LocklearDB;

CREATE TABLE R2(
IDNumber INT(20),
FirstName VARCHAR(20),
LastName VARCHAR(20),
FullName VARCHAR(40) GENERATED ALWAYS AS (CONCAT(FirstName,' ',LastName)),
CONSTRAINT PK_R1 PRIMARY KEY(IDNumber)
);

INSERT INTO R2 (IDNumber,FirstName,LastName) VALUES(123,'Pranjal','Shukla');

SELECT * FROM R2;