USE imperial_defense;
		
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
*/
												
DROP PROCEDURE if exists componentSummary;
DELIMITER $$						

CREATE PROCEDURE componentSummary(N VARCHAR(60))

BEGIN

	DECLARE COUNT_ROWS INT; 
	DECLARE I INT;

	DECLARE N_NAME VARCHAR(60);
	DECLARE HID VARCHAR(60); 
	DECLARE SW_ID VARCHAR(60);
	 DECLARE RP_ID VARCHAR(60);
	/* DECLARE H_RANGE VARCHAR(60); DECLARE S_RANGE VARCHAR(60); DECLARE R_RANGE VARCHAR(60); */

	DECLARE NET_CURSOR CURSOR FOR SELECT N.NetName, H.HID,S.SID,R.RPID, abs(H.EntryPort-H.ExitPort), abs(S.EntryPort-S.ExitPort), abs(R.EntryPort-R.ExitPort)
	FROM NETWORK as N 
   	Join HUB H ON N.NetName = H.ASSIGNEDTO
  	JOIN SWITCH S ON N.NetName = S.ASSIGNEDTO
  	JOIN REPEATER R ON N.NetNAME = R.ASSIGNEDTO 
 	AND N.NetName = N 
 	group by H.HID;

	OPEN NET_CURSOR;
		SET COUNT_ROWS = FOUND_ROWS();
		SET I = 0;
		WHILE I < COUNT_ROWS DO
			FETCH NET_CURSOR INTO N_NAME, HID, SW_ID, RP_ID ;

			SELECT N_NAME, HID, SW_ID, RP_ID;
			SET I = I + 1;
		END WHILE;
	CLOSE NET_CURSOR;

END $$
DELIMITER ;

call componentSummary('Brore06vNET_SURV');


