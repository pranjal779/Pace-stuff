/*
This is the HW2 script
created by Pranav
Oct 21 */


-- 1

Drop database if exists RanjanHW2;
create database RanjanHW2;
use RanjanHW2;


DELIMITER //
Drop function if exists calculateHours;
Create Function calculateHours(A Date, B Date)
Returns Int
DETERMINISTIC

Begin
	Declare F int;
	Declare D int;
	SET F = ABS(Datediff(A,B));
	Set D = 24*F;
	Return D;

End //

DELIMITER ;

select calculateHours('2020-01-03','2020-01-01') as T1;

-- 2


DELIMITER //
Drop function if exists largestTimegap;
Create Function largestTimegap(A Date, B Date, C Date, D Date)
Returns varchar(100)
DETERMINISTIC
    	
Begin
	Declare F int;
	Declare E int;
    Declare G varchar(100);
    
	SET F = calculateHours(A,B);
	Set E = calculateHours(C,D);
	set @t1 = concat('Gap - ',A,'  ',B);
	set @t2 = concat('Gap - ',C,'  ',D);
    
	if F > E Then
		Set G = @t1;
	End if;
	if E > F Then
		Set G = @t2;	
	End if; 
	
	Return G;
End //
DELIMITER ;

select largestTimegap('2020-01-03','2020-01-01','2020-04-01','2020-11-01') as T2;

-- sum of single digit integers in a string

DELIMITER //
Drop function if exists sumString;
Create Function sumString(A varchar(60))
Returns int
DETERMINISTIC

Begin
DECLARE N INT;  
DECLARE sum DECIMAL(10,2);
DECLARE Length INT; 
DECLARE I INT;

	SET Length = CHARACTER_LENGTH(A);
	SET sum = 0;
	SET I = 0;
	WHILE I < Length DO
		SET N = SUBSTRING(A,(I + 1),1);
		SET sum = sum + N;
		SET I = I + 1;		
	END WHILE;
	RETURN sum;

End //

DELIMITER ;

select sumString('12345') as sum;

-- 3

DELIMITER //
Drop function if exists calcvariance;
Create Function calcvariance(A varchar(60))
Returns decimal(10,2)
DETERMINISTIC

Begin
DECLARE N INT; 
DECLARE mean DECIMAL(10,2); 
DECLARE var DECIMAL(10,2);
DECLARE Length INT; 
DECLARE I INT;

	SET Length = CHARACTER_LENGTH(A);
	SET mean = sumString(A) / Length;
	SET var = 0;
	SET I = 0;
	WHILE I < Length DO
		SET N = SUBSTRING(A,(I + 1),1);
		SET var = var +  POW((N - mean),2);
		SET I = I + 1;		
	END WHILE;
	SET var = var / Length;
	RETURN var;

	End //

	DELIMITER ;

select calcvariance('12345') as T3;	

-- 4



DELIMITER //
DROP FUNCTION IF EXISTS calcStandardDeviation;
CREATE FUNCTION calcStandardDeviation(A VARCHAR(10))
RETURNS DECIMAL(10,2)
DETERMINISTIC

BEGIN
	DECLARE N DECIMAL(10,2);
	SET N = SQRT(calcVariance(A));
	RETURN N;

END //
DELIMITER ;

SELECT calcStandardDeviation('12345') AS T4;	