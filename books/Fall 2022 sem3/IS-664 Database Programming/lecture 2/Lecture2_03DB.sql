DROP DATABASE IF EXISTS LocklearDB;
CREATE DATABASE LocklearDB;
USE LocklearDB;

CREATE TABLE R1(
A VARCHAR(20),
B DECIMAL(10,2),
C INT,
CONSTRAINT PK_R1 PRIMARY KEY(A)
);

LOAD DATA LOCAL INFILE "C:\\Users\\prath\\Desktop\\pranjal's studies\\Pace stuff\\books\\Fall 2022 sem 3\\IS-664 Database Programming\\lecture 2\\DATA_DB2.sql"
INTO TABLE R1 FIELDS TERMINATED BY ',';

SELECT * FROM R1;

/*
 We can also specify some other separation when using the LOAD DATA LOCAL INFILE command 
by using LOCAL DATA LOCAL INFILE [filepath] INTO TABLE [relation] FIELD TERMINATED BY [symbol]
*/