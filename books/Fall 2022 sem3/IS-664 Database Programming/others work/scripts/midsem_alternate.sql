/* Mid-term exam script
created by Pranav
on 11/11/2021 */
use imperial_defense;

DROP FUNCTION IF EXISTS sec;
DELIMITER //
CREATE FUNCTION sec(C INT)
RETURNS VARCHAR(30)
DETERMINISTIC
	
BEGIN

DECLARE F int;
DECLARE E VARCHAR(30);

set F = C;


IF F = 0 THEN
	SET E = 'Plain Text';
END IF;
IF F = 1 THEN
	SET E = 'Encrypted';
END IF;

Return E;

END //

DELIMITER ;


DROP FUNCTION IF EXISTS acc;
DELIMITER //
CREATE FUNCTION acc(C VARCHAR(30))
RETURNS VARCHAR(30)
DETERMINISTIC
	
BEGIN

DECLARE E VARCHAR(30);

set E = substring(C,1,3);

IF E LIKE 'AX-' THEN
	SET E = 'A1';
END IF;
IF E LIKE 'BY-' THEN
	SET E = 'B2';
END IF;
IF E LIKE 'CW-' THEN
	SET E = 'C3';
END IF;
IF E LIKE 'DV-' THEN
	SET E = 'D4';
END IF;
	
RETURN E;

END //

DELIMITER ;

DROP FUNCTION IF EXISTS R_loc;

DELIMITER //

create function R_loc(A varchar (40))
Returns VARCHAR (100)
DETERMINISTIC

Begin

Declare Loc varchar(100);
Declare X,Y int;

select XCoord from site where SiteName = A into X;
select YCoord from site where SiteName = A into Y;

set Loc = concat(A, 'X:', X ,'Y:',Y);

Return Loc;

End //

DELIMITER ;




/*
CREATING THE REQUIRED
PROCEDURE */

DROP PROCEDURE if exists widget_refactor;

DELIMITER //

CREATE PROCEDURE widget_refactor()

BEGIN
	-- CREATE UTILITY VARIABLES
	DECLARE count_rows, I INT;	

	-- CREATE CURSOR VARIABLES
	DECLARE WI_ID, type, NETW_ass,w_loc, w_access, wtype VARCHAR(30);
	DECLARE w_sec INT;
	DECLARE Loca varchar(100);
	Declare code,sec_cod, s_code,ne_type VARCHAR(40);

	-- DECLARE CURSOR
	DECLARE WID_CURSOR CURSOR FOR SELECT wid, type, assignedto, location, AccessCode, secure from widget;

	DROP TABLE IF EXISTS R_widget;
	CREATE TABLE R_widget(
		RWID int AUTO_INCREMENT,
		WidgetID VARCHAR(20),
		RTYPE ENUM('IDEV','IPAD','ITERM'),
		NetAssigned VARCHAR(40),
		RNetType ENUM('SAT', 'TRACK','SURV','DEF','CIV'),
		RLocation VARCHAR(100),
		RAcess ENUM('A1','B2','C3','D4'),
		Rsecure ENUM('Encrypted', 'Plain Text'),
		RUser JSON,
		CONSTRAINT PK_RW PRIMARY KEY(RWID),
		CONSTRAINT UK_RW UNIQUE KEY(WidgetID),
		CONSTRAINT FK_RW FOREIGN KEY(WidgetID) REFERENCES widget(WID));


	-- OPEN CURSOR
	OPEN WID_CURSOR;
		SET count_rows = FOUND_ROWS();
		SET I = 0;

		WHILE I < count_rows DO
			FETCH WID_CURSOR INTO WI_ID, type, NETW_ass, w_loc, w_access, w_sec ;
			set CODE = acc(w_access) ;
			set sec_cod = sec(w_sec) ;
			set wtype = concat('I', type) ;
			set loca = R_loc(w_loc) ;
			set ne_type = substring_index(type,'_',-1);

			IF sec_cod = 'Encrypted' THEN
				set s_code = 'User Encrypted' ;
			END IF;
			IF sec_cod = 'Plain Text' THEN
				set s_code = 'User Not Encrypted';
			END IF; 

			INSERT INTO R_widget(WidgetID, RTYPE, NetAssigned, RNetType, RLocation, RAcess, Rsecure, RUser) VALUES
			(WI_ID, wtype, NETW_ass, ne_type, loca, code, sec_cod, JSON_OBJECT("ID:",(WI_ID),"Device:",(TYPE),"Access Code:", (w_access), "EncryptedYN", (s_code)));
		END WHILE;

	CLOSE WID_CURSOR;

select * from R_widget limit 10 ;

END //
DELIMITER ;

CALL widget_refactor();

 
