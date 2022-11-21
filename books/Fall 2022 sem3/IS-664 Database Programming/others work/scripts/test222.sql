/* 
MIDSEM EXAM SCRIPT
CREATED BY PRANAV */




DROP PROCEDURE if exists network_summary;
DELIMITER //
CREATE PROCEDURE network_summary(A VARCHAR(40))

BEGIN
	-- CREATE UTILITY VARIABLES
	DECLARE count_rows, I INT;
	DECLARE c_rows, J INT;	

	-- CREATE CURSOR VARIABLES
	DECLARE Ne_NAME,RouID, SwiID, HubID, RepPID VARCHAR(30);
	DECLARE RoID, SwID, HuID, ReID INT;
	

	-- DECLARE CURSOR
	DECLARE COMP_CURSOR CURSOR FOR SELECT NetName, COUNT(DISTINCT RID), Count(DISTINCT RPID), Count(DISTINCT HID), Count(DISTINCT SID) 
	from router r join repeater b on r.assignedto = b.assignedto
	join hub h on h.assignedto = b.assignedto
	join switch s on s.assignedto = h.assignedto
	join network n on n.netname = s.assignedto  where netname = A;

	DECLARE NAME_CURSOR CURSOR FOR SELECT RID, SID, HID, RPID 
	from router r join repeater b on r.assignedto = b.assignedto
	join hub h on h.assignedto = b.assignedto
	join switch s on s.assignedto = h.assignedto
	join network n on n.netname = s.assignedto  where netname = A;  

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
	SET count_rows = Found_Rows();
	SET I = 0;
	-- Fetch Cursor
	WHILE I < count_rows DO
		FETCH COMP_CURSOR INTO Ne_NAME, RoID, SwID, HuID, ReID ;
		

		INSERT INTO N_COMPONENTS(NET_NAME, RouterCount, SwitchCount, HubCount, RepeaterCount) 
		VALUES (Ne_NAME, RoID, SwID, HuID, ReID);
		SET I = I + 1;
	END WHILE;

	-- Close Cursor
	CLOSE COMP_CURSOR;

	OPEN NAME_CURSOR;
	SET c_rows = Found_Rows();
	SET J = 0;
	-- Fetch Cursor
	WHILE J < c_rows DO
		FETCH NAME_CURSOR INTO RouID, SwiID, HubID, RepPID;		

		INSERT INTO N_COMPONENTS (ALL_ROUTERS, ALL_SWITCHES, ALL_HUBS, ALL_REPEATERS) 
		VALUES (RouID,SwID,HubID,RepPID);
		SET J = J + 1;
	END WHILE;
	CLOSE NAME_CURSOR;
	-- Display

	SELECT * FROM N_COMPONENTS;


END //
DELIMITER ;

CALL network_summary('Brore03yNET_SAT') ;
