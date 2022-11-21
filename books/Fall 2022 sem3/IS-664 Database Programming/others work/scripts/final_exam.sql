/* This is the Final
Exam Script created by
Pranav on 17th December,2021 */

USE imperial_defense;

DELIMITER //

DROP PROCEDURE IF EXISTS enhancedWidgetBuilder;

CREATE PROCEDURE enhancedWidgetBuilder()

BEGIN

-- Declare Utility Variables
Declare count_rows, I int;

-- Declare Cursor Variables
Declare w_id, w_typ, w_assign, w_loc, w_sec, w_acc, w_secr VARCHAR(25);

-- Declare Cursor

Declare wdg_cursor CURSOR FOR SELECT wid, wtype, assignedto, location, accesscode, secure from widget;

-- Create the table

DROP TABLE IF EXISTS enhancedWidget;
CREATE TABLE enhancedWidget(
	W_Count int AUTO_INCREMENT,	
	W_IDTYPE VARCHAR(25),
	W_NETWORK VARCHAR(25),
	W_SITE VARCHAR(25),
	W_ACCESS VARCHAR(25),
	CONSTRAINT PK_EW PRIMARY KEY(W_Count) ); 

-- Open Cursor
Open wdg_cursor;
	Set I = 0;
	Set count_rows = Found_Rows();

-- Fetch Cursor
	WHILE I < count_rows DO
		Fetch wdg_cursor into w_id, w_typ, w_assign, w_loc, w_acc, w_sec;
		IF w_sec = 0 THEN
			set w_secr = 'Not Secure';
		END IF;	
		IF w_sec = 1 THEN
			set w_secr = 'Secure';
		END IF;

		INSERT INTO enhancedWidget(W_IDTYPE, W_NETWORK, W_SITE, W_ACCESS) VALUES (concat(w_id,'~',w_typ), w_assign, w_loc, concat(w_acc,'~',w_secr));
		SET I = I + 1;
	END WHILE;

	select * from enhancedWidget limit 4;

END //

DELIMITER ;

call enhancedWidgetBuilder();

DELIMITER //

DROP PROCEDURE IF EXISTS enhancedSiteBuilder;

CREATE PROCEDURE enhancedSiteBuilder()

BEGIN

-- Declare Utility Variables
Declare F_rows, J int;

-- Declare Cursor Variables
Declare s_nme, s_id, s_stat VARCHAR(25);
Declare xcd, ycd int;

-- Declare Cursor

Declare ste_cursor CURSOR FOR SELECT sitename, siteid, sitestatus, xcoord, ycoord from site;

-- Create the table

DROP TABLE IF EXISTS enhancedSite;
CREATE TABLE enhancedSite(
	S_Count int AUTO_INCREMENT,	
	S_NAMEID VARCHAR(25),
	S_STATUS VARCHAR(25),
	S_X int,
	S_Y int,
	CONSTRAINT PK_EW PRIMARY KEY(S_Count) ); 

-- Open Cursor
Open ste_cursor;
	Set J = 0;
	Set F_rows = Found_Rows();

-- Fetch Cursor
	WHILE J < F_rows DO
		Fetch ste_cursor into s_nme, s_id, s_stat, xcd, ycd;
		
		INSERT INTO enhancedSite (S_NAMEID, S_STATUS, S_X, S_Y) VALUES (concat(s_nme,'~',s_id), concat('Site is ', s_stat), xcd, ycd);
		SET J = J + 1;
	END WHILE;

	select * from enhancedSite limit 4;

END //

DELIMITER ;

call enhancedSiteBuilder();


DELIMITER //

DROP PROCEDURE IF EXISTS enhancedNetworkBuilder;

CREATE PROCEDURE enhancedNetworkBuilder()

BEGIN

-- Declare Utility Variables
Declare F_rows, J int;

-- Declare Cursor Variables
Declare n_nme, n_typ, n_stat VARCHAR(25);
Declare n_bw int;

-- Declare Cursor

Declare net_cursor CURSOR FOR SELECT netname, nettype, bandwidth, netstatus from network;

-- Create the table

DROP TABLE IF EXISTS enhancedNetwork;
CREATE TABLE enhancedNetwork(
	N_Count int AUTO_INCREMENT,	
	N_NAMETYPE VARCHAR(25),
	N_BANDWIDTH INT,
	N_STATUS VARCHAR(25),
	CONSTRAINT PK_EW PRIMARY KEY(N_Count) ); 

-- Open Cursor
Open net_cursor;
	Set J = 0;
	Set F_rows = Found_Rows();

-- Fetch Cursor
	WHILE J < F_rows DO
		Fetch net_cursor into n_nme, n_typ, n_bw, n_stat;
		
		INSERT INTO enhancedNetwork (N_NAMETYPE, N_BANDWIDTH, N_STATUS) VALUES (concat(n_nme,'~',n_typ), n_bw, concat('Network is ', n_stat));
		SET J = J + 1;
	END WHILE;

	select * from enhancedNetwork limit 4;

END //

DELIMITER ;

call enhancedNetworkBuilder();



DELIMITER //

DROP PROCEDURE IF EXISTS widgetListAnalysis;

CREATE PROCEDURE widgetListAnalysis(A JSON)

BEGIN

-- Create Utility Variables
Declare count_rows, I INT;

-- Create Cursor Variables
DECLARE w_ide, w_net, w_acc, n_stat, s_nam, w_ids, w_accs, n_stats, b VARCHAR(50);
DECLARE w_cnt,n_bw, s_xcord, s_ycord INT;




-- Declare The Cursor

Declare wid_cursor CURSOR FOR  select w.w_count, w.w_idtype, w.w_network, w.w_access, n.n_bandwidth, n.N_STATUS, s.s_nameid, s.s_x, s.s_y from enhancedwidget w 
								inner join enhancednetwork n on  substring_index(n.N_NAMETYPE,'~',1) = w.W_NETWORK 
								inner join enhancedsite s on substring_index(s.s_nameid,'~',1) = w.w_site 
								where w.w_idtype = JSON_EXTRACT(A,'$[0]') or w.w_idtype = JSON_EXTRACT(A,'$[1]')
								or w.w_idtype = JSON_EXTRACT(A,'$[2]'); 




-- Create the tables

DROP TABLE IF EXISTS widgetAnalysis_1;

CREATE TABLE widgetAnalysis_1(
	W_COUNT INT,
	W_ID VARCHAR(50),
	W_TYPE ENUM('PORTABLE','FIXED'),
	W_SECURITY ENUM('PLAIN TEXT WIDGET','ENCRYPTED WIDGET'),
	W_PW VARCHAR(50),
	W_NETWORK VARCHAR(50),
	N_BANDWIDTH INT,
	N_BANDWIDTH_S DECIMAL(10,2) AS (0.92*N_BANDWIDTH)STORED,	
	N_BANDWIDTH_T DECIMAL(10,2) AS (0.62*N_BANDWIDTH_S)STORED,
	N_STATUS ENUM('NET ONLINE', 'NET OFFLINE'),
	CONSTRAINT PK_WAL PRIMARY KEY(W_ID)
);

DROP TABLE IF EXISTS widgetAnalysis_2;

CREATE TABLE widgetAnalysis_2(
	W_COUNT INT,
	W_ID VARCHAR(50),
	W_TYPE ENUM('PORTABLE','FIXED'),
	W_SECURITY ENUM('PLAIN TEXT WIDGET','ENCRYPTED WIDGET'),
	W_PW VARCHAR(50),
	W_SITE_ID VARCHAR(50),
	W_SITE_CODE VARCHAR(50),
	W_SITE_COORDS JSON,
	CONSTRAINT PK_WAL2 PRIMARY KEY(W_ID)
);

-- OPEN CURSOR

OPEN wid_cursor;
	SET count_rows = Found_Rows();
	SET I = 0;

-- FETCH CURSOR
WHILE I < count_rows DO
	FETCH wid_cursor into w_cnt, w_ide, w_net, w_acc, n_bw, n_stat, s_nam, s_xcord, s_ycord;


	IF substring_index(w_ide,'~',-1) = 'Pad' THEN
		set w_ids = 'PORTABLE';
	END IF;
	IF substring_index(w_ide,'~',-1) = 'Device' THEN
		set w_ids = 'PORTABLE';
	END IF;
	IF substring_index(w_ide,'~',-1) = 'Terminal'  THEN
		set w_ids = 'FIXED';
	END IF ;
	IF substring_index(w_acc,'~',-1) = 'Not Secure' THEN
		set w_accs = 'PLAIN TEXT WIDGET';
	END IF;
	IF substring_index(w_acc,'~',-1) = 'Secure' THEN
		set w_accs = 'ENCRYPTED WIDGET';
	END IF;
	IF n_stat = 'Network is ONLINE' THEN
		set n_stats = 'NET ONLINE';
	END IF;
	IF n_stat = 'Network is OFFLINE' THEN 
		set n_stats = 'NET OFFLINE';
	END IF;

	INSERT INTO widgetAnalysis_1(w_count,w_id, w_type, w_security, w_pw, w_network, n_bandwidth, N_STATUS) VALUES
					(w_cnt, substring_index(w_ide,'~',1), w_ids, w_accs, concat('Password: ',substring_index(w_acc,'~',1)), w_net, n_bw, n_stats);

	INSERT INTO widgetAnalysis_2(w_count, w_id, w_type, w_security, w_pw, w_site_id, w_site_code, W_SITE_COORDS ) VALUES
					(w_cnt, substring_index(w_ide,'~',1), w_ids, w_accs, concat('Password: ',substring_index(w_acc,'~',1)), substring_index(s_nam,'~',1),
						concat('Code: ', substring_index(s_nam,'~',-1)), JSON_OBJECT("X Coordinate:", s_xcord, "Y Coordinate:", s_ycord));

	SET I = I + 1;
	
END WHILE;

select * from widgetAnalysis_1 limit 5;

select * from widgetAnalysis_2 limit 5;


END //

DELIMITER ;

call widgetListAnalysis(JSON_ARRAY('WDG#1~Device','WDG#10~Pad','WDG#100~Pad')); 

call widgetListAnalysis(JSON_ARRAY('WDG#152~Pad','WDG#17~Terminal','WDG#158~Terminal'));


