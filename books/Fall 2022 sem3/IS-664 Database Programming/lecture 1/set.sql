CREATE DATABASE Persons;

SET @A = 10;
SET @B = 5;

-- SELECT @A AS 'Value of A';
SELECT @A FROM Persons;

SELECT NAME FROM Persons LIMIT @B;
