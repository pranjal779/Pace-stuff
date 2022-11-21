/*
SCRIPT -  To create/display N_componenets table using stored procedure 
 - BY LEENA BHIRUD
11/3/2021
*/

USE imperial_defense;

/*

DROP FUNCTION IF EXISTS GET_DATA;

DELIMITER //
CREATE FUNCTION GET_DATA( n_netname varchar(40),n_rid VARCHAR(10),n_sid VARCHAR(10),n_hid VARCHAR(10),n_rpid VARCHAR(10))
RETURNS VARCHAR(60)
DETERMINISTIC

BEGIN
DECLARE FW_CODE VARCHAR(60) ;
 
 if n_rid 
   

    RETURN FW_CODE;
END //
DELIMITER ;
   
*/

DROP PROCEDURE IF EXISTS network_summary;
DELIMITER //
                             
CREATE PROCEDURE  network_summary(n_name varchar(40)) 

BEGIN
 -- DECLARATION OF  VARIABLES 
 DECLARE COUNT INT;
 DECLARE COUNTER INT;
 DECLARE N_RID VARCHAR(10); 
 DEClaRE N_sid VARCHAR(10); 
 DECLARE N_hid VARCHAR(10);
 DEClaRE N_rpid VARCHAR(10); 
 declare n_netname varchar(40);
 declare n_count int;
 declare n_cnt int;
 declare dummy varchar(30);

-- DECLARE CURSOR 
DECLARE TAB_CURSOR CURSOR FOR  select n.netname, group_concat(distinct r.rid) as all_R, count(distinct r.rid) as rcount,
                               group_concat(distinct s.sid) as all_s , count(distinct s.sid) as scount,
                               group_concat(distinct h.hid) as all_h , count(distinct h.hid) as hcount,
                               group_concat(distinct rp.rpid) as cnt , count(distinct rp.rpid) as rpcount
                               from NETWORK N inner JOIN router r
                               ON N.NETNAME = r.ASSIGNEDto
                               inner join switch s
                                ON N.NETNAME = s.ASSIGNEDto 
                                 inner join hub h
                                ON N.NETNAME = h.ASSIGNEDto 
                                 inner join repeater rp
                                ON N.NETNAME = rp.ASSIGNEDto 
                                where N.NETNAME = 'Zebetis05uNET_CIV';


-- TABLE CREATION 
DROP TABLE IF EXISTS N_Components;  
CREATE table N_Components(  
    nID int NOT NULL AUTO_INCREMENT ,
    NET_name VARCHAR(30),
    all_routers VARCHAR(30),
    all_switches VARCHAR(30),
    all_hubs VARCHAR(30),
    all_repeaters VARCHAR(30),
    routercount INT,
    switchcount int,
    hubcount int,
    repeatercount int,
    constraint pk_nid primary key(nid)
    constraint fk_nm  FOREIGN KEY(net_name) REFERENCES network(netname));

-- OPEN CURSOR 
OPEN TAB_CURSOR;
-- GET THE NO. OF ROWS IN THE TABLE 
         SET COUNT = FOUND_ROWS(); 
         SET COUNTER = 0;
         set n_cnt = 0;
         WHILE COUNTER < COUNT DO
-- FETCH CURSOR 
         FETCH TAB_CURSOR INTO n_netname,n_rid,n_count;

          
         SET COUNTER = COUNTER + 1;
         END WHILE; 

-- CLOSE CURSOR
CLOSE TAB_CURSOR;

END //
DELIMITER ;

 -- CALL PROCEDURE 
CALL network_summary('Zebetis05uNET_CIV');

/* if counter = 0 then
          -- set p_rid = get_data(n_netname,n_rid,n_sid,n_hid,n_rpid);
          -- insert the table 
       --   INSERT INTO N_Components (net_name,all_routers,all_switches,all_hubs,all_repeaters,routercount,switchcount,hubcount,repeatercount)
                      VALUES(n_netname,n_rid,n_sid,n_hid,n_rpid,'1','1','1','1');

         else 
          
          if dummy <> n_rid then 
           set rrid = concat(dummy,',',n_rid);
           update  N_Components set all_routers = rrid ; 
          else 
           set dummy = ' ';  
          end if ;