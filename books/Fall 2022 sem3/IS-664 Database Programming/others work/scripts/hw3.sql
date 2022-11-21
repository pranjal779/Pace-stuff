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

														
DROP PROCEDURE componentSummary;
DELIMITER //						
CREATE PROCEDURE componentSummary(N VARCHAR(60))

BEGIN
	-- CREATE UTILITY VARIABLES
	Declare row_count int ; Declare i int ;

	-- CREATE CURSOR VARIABLES
	Declare N_name  varchar(40) ; 
	Declare H_range varchar(80) ; 
	Declare S_range varchar(80) ; 
	Declare R_range varchar(80) ; 
	Declare HubID varchar(80) ; 
	Declare SwID varchar(80) ; 
	Declare RpID varchar(80) ;

	-- DECLARE CURSOR
	Declare Net_cursor CURSOR for select HID, SID, RPID from hub,switch,repeater where AssignedTo = N ;

	-- OPEN CURSOR
	open Net_cursor;
		set row_count = FOUND_ROWS();
		set i = 0;
		while i < row_count do
			fetch Net_cursor into HubID, SwID, RpID;
			-- set H_range = hubrange(N);
			-- set S_range = sw_range(N);
			-- set R_range = rp_range(N);
			select HubID, SwID, RpID /* ,N_name, H_range, S_range, R_range */ ;
			set i = i + 1; 		
		end while;
	close Net_cursor;

END //
DELIMITER ;

CALL componentSummary ('Brore06vNET_SURV');
