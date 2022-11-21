/* Class Exercise 3 - Full Text Search 
Leena Bhirud */

USE docText;

-- procedure widget refactor 
DROP PROCEDURE IF EXISTS wordCounter ;
DELIMITER //
                             
CREATE PROCEDURE wordCounter(A VARCHAR(50), B VARCHAR(50), C VARCHAR(50))

BEGIN

 -- DECLARATION OF CURSOR VARIABLES
 DECLARE COUNT INT;
 DECLARE COUNTER INT;
 DECLARE N_ID VARCHAR(15);
 DECLARE N_DOCID INT ;
 DECLARE N_DOCSCORE1 DECIMAL(10,8);
 DECLARE N_DOCSCORE2 DECIMAL(10,8);
 DECLARE N_DOCSCORE3 DECIMAL(10,8);

-- DECLARE CURSOR 
DECLARE TAB_CURSOR CURSOR FOR  SELECT DOCID, MATCH(DOC) AGAINST ( A IN NATURAL LANGUAGE MODE) AS score1,
                                MATCH(DOC) AGAINST ( B IN NATURAL LANGUAGE MODE) AS score2,
                                MATCH(DOC) AGAINST ( C IN NATURAL LANGUAGE MODE) AS score3                              
   					            FROM DOCUMENTS LIMIT 4;

-- TABLE CREATION 
DROP TABLE IF EXISTS docScoring;
	
CREATE TABLE docScoring(
DOC VARCHAR(40) PRIMARY KEY,
DOCSCORE_A VARCHAR(20) ,
DOCSCORE_B VARCHAR(20) ,
DOCSCORE_C VARCHAR(20) );

-- OPEN CURSOR 
OPEN TAB_CURSOR ;

-- GET THE NO. OF ROWS IN THE TABLE 
         SET COUNT = FOUND_ROWS(); 
         SET COUNTER = 0;
         WHILE COUNTER < COUNT DO

-- FETCH CURSOR 
         FETCH TAB_CURSOR INTO N_DOCID, N_DOCSCORE1,N_DOCSCORE2, N_DOCSCORE3 ;
         
         SET N_ID = CONCAT('DOCUMENT',N_DOCID);
     
     IF COUNTER = 0 THEN 
         INSERT INTO DOCSCORING( DOC, DOCSCORE_A, DOCSCORE_B, DOCSCORE_C) 
                         VALUES( 'D SEARCH' , A , B , C ),             
                               ( 'D->','----','----','----');
     END IF ;
         INSERT INTO DOCSCORING( DOC, DOCSCORE_A, DOCSCORE_B, DOCSCORE_C) 
                         VALUES (N_ID, N_DOCSCORE1,N_DOCSCORE2, N_DOCSCORE3 );
         
         SET COUNTER = COUNTER + 1;
         END WHILE; 

-- CLOSE CURSOR
CLOSE TAB_CURSOR;	
-- Display Records
SELECT * FROM docScoring;	
END //
DELIMITER ;
	

-- Call procedure     
CALL  wordCounter( 'submarine', 'Trident', 'Ohio' );
CALL  wordCounter( 'submarines', 'sonar', 'Seawolf' );
CALL  wordCounter( 'submarine', 'SSN', 'Virginia');