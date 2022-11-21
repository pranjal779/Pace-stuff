USE imperial_defense ;

drop function IF exists buildcode;

DELIMITER //

create function buildcode(IDnum varchar(20), sysnam varchar(20), fil varchar(40))
Returns varchar(40)
DETERMINISTIC

BEGIN

 Declare code varchar (40);

 set code = SUBSTRING(IDnum,1,3);
IF code like 'FW_' THEN
 	set code = 'FW_101_';
end IF;
IF code like 'FWx' THEN
 	set code = 'FWx001_101_';
end IF;
IF code like 'FW-' THEN
 	set code = 'FW-111_101';
end IF;
set code = CONCAT(code,'88');
set code = CONCAT(code,'SYS');
set code = CONCAT(code,'_');
IF fil = 'Packet' THEN
 set code = CONCAT(code, 'PKT');
end IF;
IF fil = 'Frame' THEN
 set code = CONCAT(code,'FMR');
end IF;

 
Return code;

End //

DELIMITER ;

select buildcode('FW_y-0','Zara','Packet') as abc;