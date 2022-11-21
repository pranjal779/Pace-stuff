USE imperial_defense;


DROP function if exists hubrange ;
DELIMITER //
CREATE function hubrange(N VARCHAR(20))
Returns varchar(60)
Not Deterministic
Reads SQL Data

Begin
	Declare R int ;
	Declare A varchar(60);
	select abs(EntryPort-ExitPort) from hub where AssignedTo = N Limit 1 into R ;
	Set A = concat('Hub has range of ',R);
	Return A ;

End //

DELIMITER ;

-- select hubrange('Brore06vNET_SURV') ;



DROP function if exists sw_range ;
DELIMITER //
CREATE function sw_range(S VARCHAR(20))
Returns varchar(60)
Not Deterministic
Reads SQL Data

Begin
	Declare B int ;
	Declare A varchar(60);
	select abs(EntryPort-ExitPort) from switch where AssignedTo = S Limit 1 into B ;
	Set A = concat('Switch has range of ',B);
	Return A ;

End //

DELIMITER ;

-- select sw_range('Brore06vNET_SURV') as msg;




DROP function if exists rp_range ;
DELIMITER //
CREATE function rp_range(R VARCHAR(20))
Returns varchar(60)
Not Deterministic
Reads SQL Data

Begin
	Declare B int ;
	Declare A varchar(60);
	select abs(EntryPort-ExitPort) from repeater where AssignedTo = R Limit 1 into B ;
	Set A = concat('Repeater has range of ',B);
	Return A ;

End //

DELIMITER ;

-- select rp_range('Brore06vNET_SURV') as msg;



select rp_range('Brore06vNET_SURV') as repeater ,sw_range('Brore06vNET_SURV')as switch ,hubrange('Brore06vNET_SURV') as Hub;