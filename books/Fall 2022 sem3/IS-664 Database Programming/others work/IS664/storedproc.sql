
DROP DATABASE IF EXISTS PACEML;
CREATE DATABASE PACEML;
USE PACEML;


-- CREATE A FUNCTION TO CALCULATE MINIMUM VALUE 
DROP FUNCTION IF EXISTS MINVALUE1 ;
DELIMITER //

CREATE FUNCTION MINVALUE1( JA JSON )
RETURNS INT
DETERMINISTIC

BEGIN
  DECLARE MIN_VAL INT ;
  /* DECLARE I INT; DECLARE TEMP INT ; DECLARE A INT;
   
   SET I = 0;
   SET TEMP = 0;
 
    WHILE I < JSON_LENGTH(JA) DO 
     
    SET A = JSON_EXTRACT( JA,CONCAT('$[',I,']') ) ;
 
     IF  I = 0 THEN 
      IF TEMP < A THEN 
         SET TEMP = A ;
          SET MIN_VAL = TEMP;
      END IF ;
     ELSE     
        IF TEMP < A THEN 
           SET MIN_VAL = TEMP;
        END IF ;
        IF TEMP > A THEN 
          SET TEMP = A;
          SET MIN_VAL = TEMP;
        END IF ;
     END IF ; 
    SET I = I + 1;
   END WHILE;
   */
   RETURN MIN_VAL;

END //
DELIMITER ;

 SELECT MINVALUE1(JSON_ARRAY(1,2,3,4,5)) AS msg ;

/*
--  CREATE A FUNCTION TO CALCULATE MAXIMUM VALUE 

DROP FUNCTION IF EXISTS MAXVALUE;
DELIMITER //
CREATE FUNCTION MAXVALUE(JA JSON)
RETURNS INT
DETERMINISTIC

BEGIN
   DECLARE MAX_VAL INT;
   DECLARE I INT; DECLARE TEMP INT ; DECLARE A INT;
   
   SET I = 0;
   SET TEMP = 0;
 
    WHILE I < JSON_LENGTH(JA) DO 
     
    SET A = JSON_EXTRACT( JA,CONCAT('$[',I,']') ) ;
    IF  I = 0 THEN 
      IF A > TEMP THEN 
         SET TEMP = A ;
         SET MAX_VAL = A ;
      END IF ;
     ELSE     
        IF A > TEMP THEN 
           SET MAX_VAL = A;
           SET TEMP = A ;
        END IF ;
        IF  A < TEMP  THEN 
           SET MAX_VAL = TEMP;
        END IF ;
     END IF ; 
    
    SET I = I + 1;
   END WHILE;
  
   RETURN MAX_VAL;
END //
DELIMITER ;


 
 SELECT MAXVALUE(JSON_ARRAY(1,2,3,4,5)) AS MAX_VALUE; 	
*/


