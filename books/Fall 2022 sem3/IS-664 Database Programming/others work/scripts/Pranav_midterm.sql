/* 
MIDSEM EXAM SCRIPT
CREATED BY PRANAV
FALL 2021 */

use imperial_defense;


DROP PROCEDURE if exists network_summary;
DELIMITER //
CREATE PROCEDURE network_summary(N VARCHAR(60))

BEGIN
	-- CREATE UTILITY VARIABLES
	DECLARE FROWS, I INT;	

	-- CREATE CURSOR VARIABLES
	DECLARE Nt_NAME,RoutID, SwitID, HuID, ReptPID VARCHAR(30);
	DECLARE RouteID, SwitchID, HubID, RepID INT;
	

	-- DECLARE CURSOR
	DECLARE COMP_CURSOR CURSOR FOR SELECT NetName, group_concatoncat(DISTINCT RID order by RID), group_concat(DISTINCT SID order by SID), 
			group_concat(DISTINCT HID order by HID), group_concat(DISTINCT RID order by RPID), 
			COUNT(DISTINCT RID), Count(DISTINCT RPID), Count(DISTINCT HID), Count(DISTINCT SID) 
			from router r join repeater rep on r.assignedto = rep.assignedto
			join hub h on h.assignedto = rep.assignedto
			join switch s on s.assignedto = h.assignedto
			join network n on n.netname = s.assignedto where netname = N;  

	DROP TABLE IF EXISTS N_COMPONENTS;
	CREATE TABLE N_COMPONENTS(
		NID INT AUTO_INCREMENT,
		NET_NAME VARCHAR(30),
		ALL_ROUTERS VARCHAR(30),
		ALL_SWITCHES VARCHAR(30),
		ALL_HUBS VARCHAR(30),
		ALL_REPEATERS VARCHAR(30),
		RouterCount int,
		SwitchCount int,
		HubCount int,
		RepeaterCount int,
		CONSTRAINT PK_COM PRIMARY KEY(NID),
		CONSTRAINT FK_COM FOREIGN KEY(NET_NAME) REFERENCES NETWORK(NetName));
		ALTER TABLE N_COMPONENTS modify column NET_NAME varchar(30) ,
     	add key(NET_NAME); 

	-- OPEN CURSOR
	OPEN COMP_CURSOR;
		SET FROWS = Found_Rows();
		SET I = 0;
	-- Fetch Cursor
	WHILE I < FROWS DO
		FETCH COMP_CURSOR INTO Nt_NAME,RoutID, SwitID, HuID, ReptPID, RouteID, SwitchID, HubID, RepID ;
		INSERT INTO N_COMPONENTS(NET_NAME, ALL_ROUTERS, ALL_SWITCHES, ALL_HUBS, ALL_REPEATERS, RouterCount, SwitchCount, HubCount, RepeaterCount) 
		VALUES (Nt_NAME,RoutID, SwitID, HuID, ReptPID, RouteID, SwitchID, HubID, RepID);
		SET I = I + 1;
	END WHILE;

	-- Close Cursor
	CLOSE COMP_CURSOR;
	
	-- Display

	SELECT * FROM N_COMPONENTS;


END //
DELIMITER ;

CALL network_summary('Brore03yNET_SAT') ;
