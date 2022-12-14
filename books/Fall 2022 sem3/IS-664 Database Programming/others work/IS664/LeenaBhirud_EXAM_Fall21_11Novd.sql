/*
SCRIPT - TO CREATE,DISPLAY TABE R_WIDGET 
- BY LEENA BHIRUD
  11/11/2021
*/

USE IMPERIAL_DEFENSE;

-- to get User data in json 
DROP FUNCTION IF EXISTS GET_JSON;
DELIMITER //
CREATE FUNCTION GET_JSON( N_WID VARCHAR(25),N_WTYPE VARCHAR(25),N_ACCESS VARCHAR(25),N_SECURE VARCHAR(25))
RETURNS JSON
DETERMINISTIC

BEGIN
   DECLARE N_USER JSON;
   DECLARE N_TEXT VARCHAR(20);

   IF N_SECURE = 1 THEN
    SET N_TEXT = 'User Encrypted';
   END IF;
   IF N_SECURE = 0 THEN
   SET N_TEXT = 'User not Encrypted';
   END IF ;

   SET N_USER = JSON_OBJECT("ID",N_WID,"DEVICE",N_WTYPE ,"ACCESS CODE",N_ACCESS,"ENCRYPTED_YN",N_TEXT);
   RETURN N_USER;
END //
DELIMITER ;


-- to get location data
DROP FUNCTION IF EXISTS GET_LOC;
DELIMITER //
CREATE FUNCTION GET_LOC( N_WID VARCHAR(25))
RETURNS VARCHAR(100)
DETERMINISTIC

BEGIN
   DECLARE N_CODE VARCHAR(100);
   DECLARE X INT; DECLARE Y INT;

   SELECT XCOORD FROM SITE WHERE SITENAME = N_WID INTO X ;   
   SELECT YCOORD FROM SITE  WHERE SITENAME = N_WID INTO Y;
   SET N_CODE = CONCAT( N_WID,'--','X:',X,' ','Y:',Y);
   RETURN N_CODE;
END //
DELIMITER ;


-- procedure widget refactor 
DROP PROCEDURE IF EXISTS WIDGET_REFACTOR ;
DELIMITER //
                             
CREATE PROCEDURE WIDGET_REFACTOR() 

BEGIN
 -- DECLARATION OF CURSOR VARIABLES
 DECLARE COUNT INT;
 DECLARE COUNTER INT;
 DECLARE N_WID VARCHAR(25); 
 DECLARE N_WTYPE VARCHAR(25); 
 DECLARE N_ASSIGNEDTO VARCHAR(25);
 DECLARE N_LOCATION VARCHAR(25); 
 DECLARE N_ACCESS VARCHAR(25);
 DECLARE N_SECURE VARCHAR(25);
 DECLARE N_USER JSON;
 -- DECLARATION OF GENERAL VARIABLES
 DECLARE P_TEXT JSON;
 DECLARE P_WTYPE VARCHAR(25);
 DECLARE P_ACCESS VARCHAR(25);
 DECLARE P_SECURE VARCHAR(25);
 DECLARE P_ASSIGNED VARCHAR(10);
 DECLARE P_LOC VARCHAR(100);

-- DECLARE CURSOR 
DECLARE TAB_CURSOR CURSOR FOR  SELECT * FROM WIDGET LIMIT 10;

-- TABLE CREATION 
DROP TABLE IF EXISTS R_WIDGET ;

CREATE TABLE R_WIDGET(
RWID INT AUTO_INCREMENT PRIMARY KEY,
WIDGETID VARCHAR(20) NOT NULL,
RTYPE ENUM('IDEV','IPAD','ITERM'),
NETASSIGNED VARCHAR(40),
RNETTYPE ENUM('SAT','TRACK','SURV','DEF','CIV') ,
RLOCATION VARCHAR(100),
RACCESS ENUM('A1','B2','C3','D4'),
RSECURE ENUM('Encrypted','Plain Text'),
RUSER JSON,
CONSTRAINT FK_MW FOREIGN KEY(WIDGETID) REFERENCES WIDGET(WID) );
   

-- OPEN CURSOR 
OPEN TAB_CURSOR ;

-- GET THE NO. OF ROWS IN THE TABLE 
         SET COUNT = FOUND_ROWS(); 
         SET COUNTER = 0;
         WHILE COUNTER < COUNT DO

-- FETCH CURSOR 
         FETCH TAB_CURSOR INTO N_WID,N_WTYPE,N_ASSIGNEDTO,N_LOCATION,N_ACCESS,N_SECURE,N_USER ;

         IF N_WTYPE = 'DEVICE' THEN
         SET P_WTYPE = 'IDEV';
         END IF;
         IF N_WTYPE = 'PAD' THEN
         SET P_WTYPE = 'IPAD';
         END IF;
         IF N_WTYPE = 'TERMINAL' THEN
         SET P_WTYPE = 'ITERM';
         END IF;
               

         IF N_ASSIGNEDTO LIKE '%_SAT%' THEN 
           SET P_ASSIGNED = 'SAT';
         END IF;
         IF N_ASSIGNEDTO LIKE '%_TRACK%' THEN 
           SET P_ASSIGNED = 'TRACK';
         END IF;
         IF N_ASSIGNEDTO LIKE '%_SURV%' THEN 
           SET P_ASSIGNED = 'SURV';
         END IF;
         IF N_ASSIGNEDTO LIKE '%_CIV%' THEN 
           SET P_ASSIGNED = 'CIV';
         END IF;
         IF N_ASSIGNEDTO LIKE '%_DEF%' THEN 
           SET P_ASSIGNED = 'DEF';
         END IF; 

          
        IF N_ACCESS LIKE 'A%' THEN
         SET P_ACCESS = 'A1';
        END IF; 

        IF N_ACCESS LIKE 'B%' THEN
         SET P_ACCESS = 'B2';
        END IF;

        IF N_ACCESS LIKE 'C%' THEN
         SET P_ACCESS = 'C3';
        END IF;

        IF N_ACCESS LIKE 'D%' THEN
         SET P_ACCESS = 'D4';
        END IF;

         IF N_SECURE = 1 THEN
          SET P_SECURE = 'ENCRYPTED';
         END IF;
          IF N_SECURE = 0 THEN 
         SET P_SECURE = 'PLAIN TEXT';
         END IF ;
        
         SET P_LOC = GET_LOC(N_LOCATION);
         SET P_TEXT = GET_JSON( N_WID,N_WTYPE,N_ACCESS,N_SECURE);

         INSERT INTO R_WIDGET(WIDGETID,RTYPE,NETASSIGNED,RNETTYPE,RLOCATION,RACCESS,RSECURE,RUSER) 
                       VALUES(N_WID,P_WTYPE,N_ASSIGNEDTO,P_ASSIGNED, P_LOC,P_ACCESS,P_SECURE,P_TEXT);
         SET COUNTER = COUNTER + 1;
         END WHILE; 

-- CLOSE CURSOR
CLOSE TAB_CURSOR;
-- DISPLAY DATA
SELECT * FROM R_WIDGET;

END //
DELIMITER ;

 -- CALL PROCEDURE 
CALL WIDGET_REFACTOR();

