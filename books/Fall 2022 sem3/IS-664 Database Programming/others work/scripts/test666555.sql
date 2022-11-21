

use imperial_defense;

drop function if exists sona;

DELIMITER //


create function sona(A JSON)
Returns Varchar(100)

DETERMINISTIC

BEGIN

DECLARE L,J int;
DECLARE B VARCHAR(100);

set L = JSON_LENGTH(A);
set J = 0;
WHILE J < L DO
	set B = JSON_EXTRACT(A, CONCAT('$[',J,']')) ;
	set J = J + 1;
END WHILE;

RETURN B;

END //

DELIMITER ;

select sona(JSON_ARRAY('aBa-12~da','WDG#100~Device','WDG#100~Pad'));

