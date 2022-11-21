DROP DATABASE IF EXISTS LocklearDB;
CREATE DATABASE LocklearDB;
USE LocklearDB;

CREATE TABLE R1(
A VARCHAR(20),
B DECIMAL(10,2),
C INT,
D DECIMAL GENERATED ALWAYS AS (B * C),
E DECIMAL GENERATED ALWAYS AS (D * 0.10),
CONSTRAINT PK_R1 PRIMARY KEY(A)
);

INSERT INTO R1 (A,B,C) VALUES('PRANJAL',100.00,54);
INSERT INTO R1 (A,B,C) VALUES('GEORGE',200.00,45);

SELECT * FROM R1;

/*
Generated Columns can be used in other Generated Columns.
The use of the Generated Always keyword is optional but preferred for clarity.
*/