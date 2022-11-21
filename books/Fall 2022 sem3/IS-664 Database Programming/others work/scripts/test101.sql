
use imperial_defense;

drop procedure if exists test;

delimeter //

create procedure test(A varchar(40))
RETURNS VARCHAR(40)

declare rout varchar(40);
declare count int;
declare B varchar(80);
select  RPID from router where assignedto = A into rout;
select count(*) from router where assignedto = A into count;

set B = rout;

RETURN B;

END //

delimeter ;

select test('Brore06vNET_SURV') as test45;
