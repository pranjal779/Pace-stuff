USE jsonTesting;

SELECT JSON_ARRAY(8,4,2,9,76);
SELECT JSON_ARRAY('A', 'pran');
SELECT JSON_ARRAY(JSON_ARRAY(8,4,2,9,76),'$[3]');
SELECT JSON_EXTRACT('["A","Pran",2]','$[1]');
SELECT JSON_EXTRACT('["A","Pran",2]','$[1]') AS MSG;

SELECT JSON_ARRAY('[8,[1,4,3],[9,1,2],76]');
SELECT JSON_EXTRACT('[8,[1,4,3],[9,1,2],76]','$[1][1]');

-- json array

-- Create a JSON Array from values
SET @MyList = JSON_ARRAY(1,2,3,4,5);
SELECT @MyList;

-- Select a value within a JSON Array
SELECT JSON_EXTRACT('[1,2,3,4,5]','$[0]');

-- Select all values within a JSON Array
SELECT JSON_EXTRACT('[1,2,3,4,5]','$[*]');

-- Create an Array that contains another Array
SELECT JSON_ARRAY("'[[1,2,3,4,5]','[6,7,8,9,10]]'");

-- Select an Array from an Array containing other arrays
SELECT JSON_EXTRACT('[[1,2,3,4,5],[6,7,8,9,10]]','$[1]');

-- Select an Value from an Array containing other arrays
SELECT JSON_EXTRACT('[[1,2,3,4,5],[6,7,8,9,10]]','$[1][2]');

-- Create an Array that contains another Array
SELECT JSON_ARRAY("'[[1,2,3,4,5]','[6,7,8,9,10]]'");

-- Select an Array from an Array containing other arrays
SELECT JSON_EXTRACT('[[1,2,3,4,5],[6,7,8,9,10]]','$[1]');

-- Assign a JSON Array to user-defined sessions variable
SELECT JSON_ARRAY("'[[1,2,3,4,5]','[5,6,7,8,9,10]]'") INTO @V;

-- display the contents of @v
SELECT @V;

-- Attempt to extract values from @V using JSON function
SELECT JSON_EXTRACT(@V,'$[0]');
SELECT JSON_EXTRACT(@V,'$[1]');

-- Attempt to convert @V to JSON ARRAY and extract values
SELECT JSON_EXTRACT(JSON_ARRAY(@V),'$[1]');

CREATE TABLE R1(
InfoID VARCHAR(20),
InfoArray JSON,
CONSTRAINT pk_R1 Primary KEY(InfoID)
);

INSERT INTO R1 VALUES('A1','[[1,2,3,4,5],[5,6,7,8,9,10]]');
INSERT INTO R1 VALUES('B1','[[11,2,31,4,51],[5,61,7,81,9,10]]');
INSERT INTO R1 VALUES('C1','[[1,22,3,42,5],[52,6,72,8,92,10]]');

SELECT * FROM R1;

SELECT JSON_EXTRACT(InfoArray,'$[0]') AS 'Array 1 of A1'
FROM R1
WHERE InfoID = 'A1';

SELECT JSON_EXTRACT(InfoArray,'$[1][2]') AS 'Value 3 in Array 2 of A1'
FROM pk_R1
WHERE InfoID = 'A1';

CREATE TABLE R2(
InfoID VARCHAR(20),
InfoArray JSON,
CONSTRAINT pk_R2 PRIMARY KEY(InfoID)
);

INSERT INTO R2 VALUES('A1',JSON_ARRAY(1,2,3,4,5,6,7,8,9,10));
INSERT INTO R2 VALUES('B2',JSON_ARRAY(JSON_ARRAY(1,2,3,4,5),JSON_ARRAY(6,7,8,9,10)));
INSERT INTO R2 VALEUS('C1',JSON_ARRAY(1,2,3,JSON_ARRAY(6,7,8,9,10)));

SELECT * FROM R2;

-- CREATE A JSON OBJECT
SELECT JSON_OBJECT("Monday",1, "Tuesday", 2,"Wednesday",3);

-- Create a json object
SELECT JSON_OBJECT("Monday",'[1,2,3]',"Tuesday",'[4,5,6]',"Wednesday",'[7,8,9]');

-- GET A VALUE ASSOCIATED WITH A KEY IN A JSON JSON OBJECT
SELECT JSON_EXTRACT('{"Monday": 1, "Tuesday": 2,"Wednesday": 3}','$.Tuesday');

-- Get a Value associated with a key in a json object
SELECT JSON_EXTRACT('{"Monday":[1,2,3], "Tuesday":[4,5,6],"Wednesday":[7,8,9]}','$.Tuesday');
SELECT JSON_EXTRACT('{"Monday":[1,2,3], "Tuesday":[4,5,6],"Wednesday":[7,8,9]}','$.Tuesday[0]');

CREATE TABLE R3(
InfoID VARCHAR(20)
InfoArray json,
CONSTRAINT pk_R3 PRIMARY KEY(InfoID)
);

INSERT INTO R3 VALUES('J01',JSON_OBJECT("Monday",JSON_ARRAY(1,2,3), "Tuesday",JSON_ARRAY(4,5,6)));
INSERT INTO R3 VALUES('J02',JSON_OBJECT("TrooperID",'ST-1',"TrooperAge",26));
INSERT INTO R3 VALUES('J03',JSON_OBJECT("TrooperID",JSON_ARRAY(1,2,JSON_ARRAY(4,5,6))));

SELECT * FROM R3;

SELECT JSON_EXTRACT(InfoArray,'$.Tuesday[0]') AS 'Values of Key Tuesday in J01'
FROM R3
WHERE InfoID = 'J01';

SELECT JSON_EXTRACT(InfoArray,'$.TrooperID') AS 'ID', JSON_EXTRACT(InfoArray,'$.TrooperAge') AS 'AGE'
FROM R3
WHERE InfoID = 'J02';

SELECT JSON_EXTRACT(InfoArray,'$.TrooperID[0]') AS 'First Element of Vlaue', JSON_EXTRACT(InfoArray,'$.TrooperID[2][1]') AS '2nd Number of Second Element of Value'
FROM R3
WHERE InfoID = 'J03';
