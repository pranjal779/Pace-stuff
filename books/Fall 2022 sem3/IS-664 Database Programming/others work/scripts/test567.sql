use paceML;



drop function if exists abc;
DELIMITER //
create function abc(A JSON)
RETURNS Decimal(10,2)
DETERMINISTIC

BEGIN
DECLARE I, L, K int;
DECLARE B,MEAN decimal(10,4);	
	

	set I = 0;
	set L = JSON_LENGTH(A);
	SET K = 0;
	while K < L DO
		set A = select OBV_DATA from yuanClassjson where observation = K;
	END WHILE;
	SET MEAN = 0;
	WHILE I < L DO
		SET B = json_extract(A, CONCAT('$[',I,']')) ;
		SET MEAN = MEAN + B;
		SET I = I + 1;
	END WHILE;
	RETURN MEAN;

END //

DELIMITER ;

select abc(OBV_DATA) from yuanclassjson;