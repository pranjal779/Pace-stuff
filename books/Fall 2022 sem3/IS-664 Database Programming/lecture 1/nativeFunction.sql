-- Mathematical Functions
SELECT PI() AS PI;
SELECT RAND() AS 'Random Number';
SELECT MOD(10,2) AS 'Modulus Division';
SELECT POW(10,2) AS 'Exponential Value';

-- String Functions
SELECT CONCAT('pranj', 'shukla') AS Name;
SELECT CONCAT_WS("**",'GENE','Locklear') AS NAME;
SELECT LCASE('PRANJAL') AS Lowercase;
SELECT REVERSE('PRANJAL') AS Reversed;


-- Date and Time Functions
SELECT CURRENT_DATE() AS 'Date Now';
SELECT CURRENT_TIME() AS 'Time Now';
SELECT DAYOFWEEK('2021-09-09') AS 'Time Now';
SELECT DATEDIFF('2021-09-09','2020-09-09') AS 'Day Count';