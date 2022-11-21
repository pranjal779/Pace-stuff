Drop database if exists RanjanHW2;
create database RanjanHW2;
use RanjanHW2;





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

select sumString('123') as sum;