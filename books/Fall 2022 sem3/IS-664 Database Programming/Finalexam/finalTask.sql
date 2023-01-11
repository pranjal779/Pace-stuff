USE aggresorsystem;


# task 1
-- traducerAgent

DELIMITER //
CREATE FUNCTION traducerAgent()
RETURNS VARCHAR(255);
DETERMINISTIC

BEGIN
DECLARE ttype VARCHAR(10);
DECLARE tstatus VARCHAR(20);

SET ttype = IF(RAND() < 0.5, 'Medium', 'Heavy');
SET tstatus = IF(RAND() < 0.5, 'Available', 'Not Available');

RETURN CONCAT(
  'INSERT INTO traducer (TID, TType, TLoc_X, TLoc_Y, TValue, TLeathal, TStatus, TDurable) VALUES (',
  '''TA-', FLOOR(RAND() * 5) + 1, '-', FLOOR(RAND() * 100) + 1, ''', ',
  '''', ttype, ''', ',
  FLOOR(RAND() * 200), ', ',
  FLOOR(RAND() * 200), ', ',
  IF(ttype = 'Medium', 10, 25), ', ',
  IF(ttype = 'Medium', 100, 300), ', ',
  '''', tstatus, '', ', ',
  ROUND((RAND() * (10 - 5) + 5) / 100 * IF(ttype = 'Heavy', 300, 100)),
  ')')
END //
DELIMITER ;

SELECT traducerAgent() AS MSG;

-- discriminatorAgent

DELIMITER //
CREATE FUNCTION discriminatorAgent()
RETURNS VARCHAR(255);
DETERMINISTIC

BEGIN
DECLARE dtype VARCHAR(15);
DECLARE dstatus VARCHAR(20);

SET dtype = IF(RAND() < 0.5, 'Standard', 'Multi-Role');
SET dstatus = IF(RAND() < 0.5, 'Available', 'Not Available');

RETURN CONCAT(
  'INSERT INTO Discriminator (DID, DType, DLoc_X, DLoc_Y, DValue, DLeathal, DStatus, DDurable) VALUES (',
  '''TA-', FLOOR(RAND() * 5) + 1, '-', FLOOR(RAND() * 100) + 1, ''', ',
  '''', dtype, ''', ',
  FLOOR(RAND() * 500) + 400, ', ',
  FLOOR(RAND() * 896) + 4, ', ',
  IF(dtype = 'Standard', 4, 7), ', ',
  IF(dtype = 'Standard', 10, 12), ', ',
  '''', dstatus, '', ', ',
  ROUND((RAND() * (10 - 5) + 5) / 100 * IF(dtype = 'Standard', 10, 12)),
  ')')
END //
DELIMITER ;

SELECT discriminatorAgent() AS MSG;


-- resourceBuilder

DELIMITER //
CREATE FUNCTION resourceBuilder()
RETURNS VARCHAR(255);
DETERMINISTIC

BEGIN
DECLARE rtype VARCHAR(10);
DECLARE rloc_x INT;
DECLARE rloc_y INT;
DECLARE rvalue INT;
DECLARE rstatus VARCHAR(10);
DECLARE rprotect INT;

SET rtype = IF(RAND() < 0.34, 'TAC', IF(RAND() < 0.67, 'OP', 'STRAT'));
SET rloc_x = FLOOR(RAND() * (950 - 700 + 1)) + 700;
SET rloc_y = FLOOR(RAND() * (950 - 700 + 1)) + 700;
SET rvalue =
  IF(rtype = 'TAC', FLOOR(RAND() * (150 - 10 + 1)) + 10,
    IF(rtype = 'OP', FLOOR(RAND() * (300 - 75 + 1)) + 75,
      FLOOR(RAND() * (500 - 250 + 1)) + 250));
SET rstatus = IF(RAND() < 0.5, 'Active', 'Dormant');
SET rprotect =
  IF(rtype = 'TAC' AND rvalue BETWEEN 100 AND 300, 'Active',
    IF(rtype = 'TAC' AND rvalue BETWEEN 50 AND 150, 'Dormant',
      IF(rtype = 'OP' AND rvalue BETWEEN 750 AND 1000, 'Active',
        IF(rtype = 'OP' AND rvalue BETWEEN 50 AND 150, 'Dormant',
          IF(rtype = 'STRAT' AND rvalue BETWEEN 2500 AND 3000, 'Active',
            IF(rtype = 'STRAT' AND rvalue BETWEEN 50 AND 150, 'Dormant', NULL)
          )
        )
      )
    )
  );

RETURN CONCAT(
  'INSERT INTO Resource (RID, RType, RLoc_X, RLoc_Y, RValue, RStatus, RProtect) VALUES (',
  '''R-', FLOOR(RAND() * 5) + 1, '#', FLOOR(RAND() * 100) + 1, ''', ',
  '''', rtype, ''', ',
  rloc_x, ', ',
  rloc_y, ', ',
  rvalue, ', ',
  '''', rstatus, ''', ', ',
  rprotect,
  ')''
);
END //
DELIMITER ;

# task 2

DROP PROCEDURE IF EXISTS buildAggressor;
DELIMITER //

CREATE PROCEDURE buildAggressor()
BEGIN
CREATE TABLE traducer (
  TID VARCHAR(20) NOT NULL PRIMARY KEY,
  TType ENUM('Medium','Heavy') NULL,
  TLoc_X INT NULL,
  TLoc_Y INT NULL,
  TValue INT NULL,
  TLeathal INT NULL,
  TStatus ENUM('Available','Not Available') NULL,
  TDurable DECIMAL(10,2)
);

CREATE TABLE Discriminator (
  DID VARCHAR(20) NOT NULL PRIMARY KEY,
  DType ENUM('Standard','Multi-Role') NULL,
  DLoc_X INT NULL,
  DLoc_Y INT NULL,
  DValue INT NULL,
  DLeathal INT NULL,
  DStatus ENUM('Available', 'Not Available') NULL,
  DDurable DECIMAL(10,2) NULL
);

CREATE TABLE Resource (
  RID VARCHAR(20) NOT NULL PRIMARY KEY,
  RType ENUM('TAC','OP','STRAT') NULL,
  RLoc_X INT NULL,
  RLoc_Y INT NULL,
  RValue INT NULL,
  RStatus ENUM('Active', 'Dormant') NULL,
  RProtect DECIMAL(10,2) NULL
);


END //
DELIMITER ;

CALL buildAggressor();
*/

# Task 3

DROP FUNCTION IF EXISTS dividedString;
DELIMITER //
CREATE FUNCTION dividedString(A VARCHAR(100))
RETURNS JSON
DETERMINISTIC

BEGIN
DECLARE S VARCHAR(100); DECLARE J JSON;
DECALRE SU VARCHAR(100); DECALRE SI VARCHAR(100); DECALRE SO VARCHAR(100); DECALRE SP VARCHAR(100); DECALRE SQ VARCHAR(100);
DECALRE SW VARCHAR(100); DECALRE SE VARCHAR(100);
SET S = REPLACE(A,'INSERT INTO resource VALUES(','');
SET S = REPLACE(S,')','');
SET SU = SUBSTRING_INDEX(S,',',1);
SET SI = SUBSTRING_INDEX(SUBSTRING_INDEX(S,',',2),',',1);
SET SO = SUBSTRING_INDEX(SUBSTRING_INDEX(S,',',3),',',1);
SET SP = SUBSTRING_INDEX(SUBSTRING_INDEX(S,',',4),',',1);
SET SQ = SUBSTRING_INDEX(SUBSTRING_INDEX(S,',',5),',',1);
SET SW = SUBSTRING_INDEX(SUBSTRING_INDEX(S,',',6),',',1);
SET SE = SUBSTRING_INDEX(SUBSTRING_INDEX(S,',',7),',',1);
SET J = JSON_ARRAY(S_1,S_2,S_3,S_4,S_5,S_6,S_7);
RETURN J;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS

CREATE PROCEDURE IF EXISTS aggressorPopulator;
DELIMITER ;


DROP PROCEDURE IF EXISTS aggressorPopulator;
DELIMITER //
CREATE PROCEDURE aggressorPopulator(TAG INT, DAG INT, RS INT)

BEGIN
DECLARE T JSON; DECLARE D JSON; DECLARE R JSONl
DECLARE IT INT; DECALRE ID INT; DECLARE IR INT;

DECLARE T0 VARCHAR(20); DECALRE T1 VARCHAR(20); DECALRE T3 INT;
DECALRE T4 INT; DECALRE T5 INT; DECLARE T6 VARCHAR(20); DECALRE T7 DECIMAL(10,2);

DECALRE R0 VARCHAR(20); DECALRE R1 VARCHAR(20); DECLARE R2 INT; DECALRE R3 INT;
DECLARE R4 INT; DECLARE R5 VARCHAR(20); DECALRE R6 INT;

SET IT = 0;
WHILE IT < TAG DO
  SET T = splitString(traducerAgent());
  SET T0 = JASON_EXTRACT(T,'$[0]'); SET T1 JSON_EXTRACT(T,'$[1]'); SET T2 = JSON_EXTRACT(T,'$[2]');
  SET T3 = JASON_EXTRACT(T,'$[3]'); SET T4 JASON_EXTRACT(T,'$[4'); SET T5 = JSON_EXTRACT(T,'$[5]');
  SET T6 = JASON_EXTRACT(T,'$[6]'); SET T7 JASON_EXTRACT(T,'$[7]');

  INSERT INTO traducer VALUES(stq(T0),stq(T1),T2,T3,T4,T5,stq(T6),stq(T7));
  SET IT = IT * 1;
END WHILE

SET ID = 0;
WHILE ID < DAG DO
  SET D = splitString(discriminatorAgent());
  SET T0 = JASON_EXTRACT(T,'$[0]'); SET T1 JSON_EXTRACT(T,'$[1]'); SET T2 = JSON_EXTRACT(T,'$[2]');
  SET T3 = JASON_EXTRACT(T,'$[3]'); SET T4 JASON_EXTRACT(T,'$[4'); SET T5 = JSON_EXTRACT(T,'$[5]');
  SET T6 = JASON_EXTRACT(T,'$[6]'); SET T7 JASON_EXTRACT(T,'$[7]');

  INSERT INTO discriminatorAgent VALUES(stq(T0),stq(T1),T2,T3,T4,T5,stq(T6),stq(T7));
  SET ID = ID * 1;
END WHILE

SET IR = 0;
WHILE IR < RS DO
  SET R = splitString(resourceBuilder());
  SET T0 = JASON_EXTRACT(T,'$[0]'); SET T1 JSON_EXTRACT(T,'$[1]'); SET T2 = JSON_EXTRACT(T,'$[2]');
  SET T3 = JASON_EXTRACT(T,'$[3]'); SET T4 JASON_EXTRACT(T,'$[4'); SET T5 = JSON_EXTRACT(T,'$[5]');
  SET T6 = JASON_EXTRACT(T,'$[6]'); SET T7 JASON_EXTRACT(T,'$[7]');

  INSERT INTO resourceBuilder VALUES(stq(T0),stq(T1),T2,T3,T4,T5,stq(T6),stq(T7));
  SET IR = IR * 1;
END WHILE

END //
DELIMITER ;

-- Task 3

/*
DROP PROCEDURE IF EXISTS aggressorPopulator;
DELIMITER //
CREATE PROCEDURE aggressorPopulator(
IN numTraducer INT,
IN numDiscriminator INT,
IN numResource INT
)
BEGIN
DECLARE i INT DEFAULT 0;

START TRANSACTION;

WHILE i < numTraducer DO
  SET @sql = traducerAgent();
  PREPARE stmt FROM @sql;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;
  SET i = i + 1;
END WHILE;

SET i = 0;
WHILE i < numDiscriminator DO
  SET @sql = discriminatorAgent();
  PREPARE stmt FROM @sql;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;
  SET i = i + 1;
END WHILE;

SET i = 0;
WHILE i < numResource DO
  SET @sql = resourceBuilder();
  PREPARE stmt FROM @sql;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;
  SET i = i + 1;
END WHILE;

COMMIT;
END //
DELIMITER ;



CALL aggressorPopulator(10, 5, 3);
*/
#task 4

CALL aggressorPopulator(100, 100, 25);

# Task 5
DELIMITER //

CREATE PROCEDURE RemoveDuplicates()
BEGIN
-- Declare variables for cursors and rows
DECLARE done INT DEFAULT FALSE;
DECLARE cur_traducer CURSOR FOR SELECT TID FROM traducer;
DECLARE cur_discriminator CURSOR FOR SELECT DID FROM Discriminator;
DECLARE cur_resource CURSOR FOR SELECT RID FROM Resource;
DECLARE current_tid VARCHAR(20);
DECLARE current_did VARCHAR(20);
DECLARE current_rid VARCHAR(20);
DECLARE num_duplicates INT;

-- Open the cursors
OPEN cur_traducer;
OPEN cur_discriminator;
OPEN cur_resource;

-- Loop through the traducer cursor and delete duplicates
read_loop: LOOP
FETCH cur_traducer INTO current_tid;
-- Exit the loop when no more rows are left
IF done THEN
  LEAVE read_loop;
END IF;

-- Count the number of duplicates for the current TID
SELECT COUNT(*) INTO num_duplicates
FROM traducer
WHERE TID = current_tid;

-- If there are duplicates, delete all but one
IF num_duplicates > 1 THEN
  DELETE FROM traducer WHERE TID = current_tid LIMIT num_duplicates - 1;
END IF;
END LOOP;

-- Loop through the discriminator cursor and delete duplicates
read_loop: LOOP
FETCH cur_discriminator INTO current_did;
-- Exit the loop when no more rows are left
IF done THEN
  LEAVE read_loop;
END IF;

-- Count the number of duplicates for the current DID
SELECT COUNT(*) INTO num_duplicates
FROM Discriminator
WHERE DID = current_did;

-- If there are duplicates, delete all but one
IF num_duplicates > 1 THEN
  DELETE FROM Discriminator WHERE DID = current_did LIMIT num_duplicates - 1;
END IF;
END LOOP;

-- Loop through the resource cursor and delete duplicates
read_loop: LOOP
FETCH cur_resource INTO current_rid;
-- Exit the loop when no more rows are left
IF done THEN
  LEAVE read_loop;
END IF;

-- Count the number of duplicates for the current RID
SELECT COUNT(*) INTO num_duplicates
FROM Resource
WHERE RID = current_rid;

-- If there are duplicates, delete all but one
IF num_duplicates > 1 THEN
  DELETE FROM Resource WHERE RID = current_rid LIMIT num_duplicates - 1;
END IF;
END LOOP;

-- Close the cursors
CLOSE cur_traducer;
CLOSE cur_discriminator;
CLOSE cur_resource;
CLOSE
DELIMITER //
CREATE PROCEDURE RemoveDuplicates()
BEGIN
DECLARE done INT DEFAULT 0;
DECLARE tid VARCHAR(20);
DECLARE did VARCHAR(20);
DECLARE rid VARCHAR(20);

DECLARE tid_cur CURSOR FOR SELECT TID FROM traducer GROUP BY TID HAVING COUNT() > 1;
DECLARE did_cur CURSOR FOR SELECT DID FROM Discriminator GROUP BY DID HAVING COUNT() > 1;
DECLARE rid_cur CURSOR FOR SELECT RID FROM Resource GROUP BY RID HAVING COUNT(*) > 1;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

OPEN tid_cur;
REPEAT
FETCH tid_cur INTO tid;
DELETE FROM traducer WHERE TID = tid LIMIT 1;
UNTIL done END REPEAT;
CLOSE tid_cur;

SET done = 0;
OPEN did_cur;
REPEAT
FETCH did_cur INTO did;
DELETE FROM Discriminator WHERE DID = did LIMIT 1;
UNTIL done END REPEAT;
CLOSE did_cur;

SET done = 0;
OPEN rid_cur;
REPEAT
FETCH rid_cur INTO rid;
DELETE FROM Resource WHERE RID = rid LIMIT 1;
UNTIL done END REPEAT;
CLOSE rid_cur;
END //
DELIMITER ;

CALL RemoveDuplicates();
