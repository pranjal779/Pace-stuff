DROP DATABASE IF EXISTS LocklearDB;
CREATE DATABASE LocklearDB;
USE LocklearDB;

CREATE TABLE IF NOT EXISTS R1(
-- CREATE TABLE R1(
A VARCHAR(20) PRIMARY KEY,
B DECIMAL(10,2),
C INT
);

DESCRIBE R1;

CREATE TEMPORARY TABLE IF NOT EXISTS R2(
-- CREATE TABLE R2(
A VARCAHR(20) PRIMARY KEY,
B DECIMAL(10,2),
C INT
);

DESCRIBE R2;

CREATE TABLE IF NOT EXISTS R3 LIKE R1;

INSERT INTO R1 VALUES('Pran',100.00,54);
SELECT * FROM R1;

UPDATE R1 SET C = 30;
UPDATE R1 SET C = 30 WHERE A = 'Pran';
UPDATE R1 SET B = 130, C = 30 WHERE A = 'Pran';

-- SELECT * FROM R1;

CREATE TABLE R5(
A VARCHAR(20),
B VARCHAR(20),
C VARCHAR(20) NOT NULL DEFAULT 'PACE',
D VARCHAR(20) CHECK (C IN ('IS','CS','NOT SPECIFIED')),
CONSTRAINT pk_r5 PRIMARY KEY(A),
CONSTRAINT uk_r5 UNIQUE KEY(B),
CONSTRAINT fk_r5 FOREIGN KEY(A) REFERENCE R1(A)
);

DESCRIBE R5;