/*
SCRIPT - STORED PROCEDURE USING CURSORS BUIT ON IMPERIAL DEFENSE  
 - BY LEENA BHIRUD
28 OCTOBER 2021
*/


USE imperial_defense;





-- FUNCTION TO INSERT THE VALUES IN MASTER_WIDGET TABEL 
DROP FUNCTION IF EXISTS GET_DATA;

DELIMITER //
CREATE FUNCTION GET_DATA(n_wtype varchar(30),n_netstat varchar(30),n_loc varchar(30))
RETURNS JSOn
DETERMINISTIC

BEGIN
DECLARE W_CODE json ;

set w_code = json_object('Tech:',n_wtype,'Status:',n_netstat,'Location:',n_loc);
RETURN W_CODE;
END //
DELIMITER ; 

/*
 -- TABLE CREATION 
DROP TABLE IF EXISTS MASTER_WIDGET ;   
CREATE TABLE MASTER_WIDGET(
    WID VARCHAR(25) PRIMARY KEY ,
    WTYPE ENUM('TERMINAL','PAD','DEVICE') NOT NULL,
    NETWORKIN VARCHAR(30),
    NETWORKSTATUS VARCHAR(30),
    NETWORKBW INT,
    LOCATION VARCHAR(30),
    DISTANCETO DECIMAL(10,2),
    USER JSON
    );  

*/

-- PROCEDURE TO CREATE MASTER WIDGET TABLE AND UPDATE THE VALUES IN THE TABLE  
DROP PROCEDURE IF EXISTS WIDGET_CONNECT ;
DELIMITER //
CREATE PROCEDURE WIDGET_CONNECT(P_NETNAME VARCHAR(20)) 


BEGIN
 -- DECLARATION OF  VARIABLES 
 DECLARE COUNT INT;
 DECLARE COUNTER INT;
 DECLARE N_NAME VARCHAR(30) ; 
 declare n_bandwidth varchar(20) ;
 DECLARE N_WID VARCHAR(30); 
 DEClaRE N_WTYPE VARCHAR(30); 
 DECLARE N_NETSTAT VARCHAR(30);
 DEClaRE N_NETBW VARCHAR(30); 
 DECLARE N_LOC VARCHAR(30);
 DECLARE N_DISTANCe VARCHAR(30); 
 DECLARE N_USER VARCHAR(100); 


-- DECLARE CURSOR 
DECLARE TAB_CURSOR CURSOR FOR  SELECT N.NETNAME,N.NETSTATUS,n.bandwidth,w.wid,w.wtype,w.location,
                                      abs(s.xcoord-s.ycoord) as dist
                                    FROM NETWORK N INNER JOIN widget w
                                    ON N.NETNAME = w.ASSIGNEDto
                                    inner join site s
                                    on w.location = s.sitename
                                    WHERE N.NETNAME = 'Zebetis05uNET_CIV'
                                        and n.NETSTATUS = 'Online' limit 10;


 -- TABLE CREATION 
DROP TABLE IF EXISTS MASTER_WIDGET ;   
CREATE TABLE MASTER_WIDGET(
    WID VARCHAR(25) PRIMARY KEY ,
    WTYPE ENUM('TERMINAL','PAD','DEVICE') NOT NULL,
    NETWORKIN VARCHAR(30),
    NETWORKSTATUS VARCHAR(30),
    NETWORKBW INT,
    LOCATION VARCHAR(30),
    DISTANCETO DECIMAL(10,2),
    USER JSON
    );   

-- OPEN CURSOR 
OPEN TAB_CURSOR ;

-- GET THE NO. OF ROWS IN THE TABLE 
         SET COUNT = FOUND_ROWS(); 
         SET COUNTER = 0;
         WHILE COUNTER < COUNT DO
-- FETCH CURSOR 
    fetch TAB_CURSOR into n_name, n_netstat, n_bandwidth, n_wid, n_wtype, n_loc, N_DISTANCe;
     set n_user = get_data(n_wtype,n_netstat,n_loc);
      INSERT INTO MASTER_WIDGET (WID,Wtype, NETWORKIN, nETWORKSTATUS, NETWORKBW,LOCATION,distanceto,user) 
                          VALUES(n_wid,n_wtype,n_name,n_netstat,n_bandwidth,n_loc,n_distance,n_user);
        set counter = counter + 1;
        end while;
-- CLOSE CURSOR
CLOSE TAB_CURSOR;
-- DISPLAY TABLE    
SELECT * from master_widget;
END //
DELIMITER ;



 -- CALL PROCEDURE 
CALL WIDGET_CONNECT ('Zebetis05uNET_CIV');
-- CALL WIDGET_CONNECT ('Brore03yNET_SAT');
