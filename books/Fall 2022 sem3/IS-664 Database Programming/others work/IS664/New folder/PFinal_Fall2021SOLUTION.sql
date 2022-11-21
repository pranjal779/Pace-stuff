USE imperial_defense;

DROP FUNCTION IF EXISTS secured;
DELIMITER //
CREATE FUNCTION secured (S INT)
RETURNS VARCHAR(30)
DETERMINISTIC

BEGIN
	DECLARE V VARCHAR(30);
	IF S = 1 THEN 
		SET V = 'Secure';
	ELSE
		SET V = 'Open';
	END IF;
	RETURN V;
END //
DELIMITER ;

DROP FUNCTION IF EXISTS switched;
DELIMITER //
CREATE FUNCTION switched (S INT)
RETURNS VARCHAR(30)
DETERMINISTIC

BEGIN
	DECLARE V VARCHAR(30);
	IF S = 1 THEN 
		SET V = 'Switched';
	ELSE
		SET V = 'Not Switched';
	END IF;
	RETURN V;
END //
DELIMITER ;

DROP FUNCTION IF EXISTS modStatus;
DELIMITER //
CREATE FUNCTION modStatus(N VARCHAR(50))
RETURNS VARCHAR(100)
DETERMINISTIC

BEGIN
	DECLARE S1 VARCHAR(100); DECLARE S2 VARCHAR(100); DECLARE S3 VARCHAR(100);
	DECLARE S4 VARCHAR(10);
	DECLARE S_OUT VARCHAR(100);
	SELECT NetStatus INTO S1 FROM network WHERE NetName = N;
	SELECT NetType INTO S2 FROM network WHERE NetName = N;
	SELECT NetName INTO S3 FROM network WHERE NetName = N;
	SET S4 = REGEXP_SUBSTR(S3,'_.*');
	SET S4 = SUBSTRING(S4 FROM 2);
	SET S_OUT = CONCAT(S4,' ', S2,' Network ',N,' is currently ', S1);
	RETURN S_OUT;
END //
DELIMITER ;

DROP FUNCTION IF EXISTS bwToArray;
DELIMITER //
CREATE FUNCTION bwToArray(N VARCHAR(50))
RETURNS JSON
NOT DETERMINISTIC
READS SQL DATA

BEGIN
	DECLARE BW DECIMAL(10,3); DECLARE OBW DECIMAL(10,3);
	DECLARE MXBW DECIMAL(10,3); DECLARE MNBW DECIMAL(10,3);
	DECLARE A JSON;
	SELECT Bandwidth INTO BW FROM network WHERE NetName = N;
	SELECT OptimumBW INTO OBW FROM network WHERE NetName = N;
	SELECT MaxBW INTO MXBW FROM network WHERE NetName = N;
	SELECT MinBW INTO MNBW FROM network WHERE NetName = N;
	SET A = JSON_ARRAY(BW,OBW,MXBW,MNBW);
	RETURN A;
END //
DELIMITER ;

DROP FUNCTION IF EXISTS sumBW;
DELIMITER //
CREATE FUNCTION sumBW(V JSON)
RETURNS DECIMAL(10,3)
DETERMINISTIC

BEGIN
	DECLARE BW_SUM DECIMAL(10,3); DECLARE I INT;
	SET BW_SUM = 0;	
	SET I = 0;
	WHILE I < JSON_LENGTH(V) DO 
		SET BW_SUM = BW_SUM + JSON_EXTRACT(V,CONCAT('$[',I,']'));
		SET I = I + 1;
	END WHILE;
	RETURN BW_SUM;
END //
DELIMITER ;

DROP FUNCTION IF EXISTS avgBW;
DELIMITER //
CREATE FUNCTION avgBW(V JSON)
RETURNS DECIMAL(10,3)
DETERMINISTIC

BEGIN
	DECLARE BW_MU DECIMAL(10,3);
	SET BW_MU = sumBW(V) / JSON_LENGTH(V);
	RETURN BW_MU;
END //
DELIMITER ;

DROP FUNCTION IF EXISTS sigma2BW;
DELIMITER //
CREATE FUNCTION sigma2BW(V JSON)
RETURNS DECIMAL(10,3)
DETERMINISTIC

BEGIN
	DECLARE BW_SIGMA2 DECIMAL(10,3);
	DECLARE I INT;
	DECLARE BW_MU DECIMAL(10,3);
	SET I = 0;
	SET BW_MU = avgBW(V);
	SET BW_SIGMA2 = 0;
	WHILE I < JSON_LENGTH(V) DO 
		SET BW_SIGMA2 = BW_SIGMA2 + POW((JSON_EXTRACT(V,CONCAT('$[',I,']')) - BW_MU),2);
		SET I = I + 1;
	END WHILE;
	SET BW_SIGMA2 = BW_SIGMA2 / (JSON_LENGTH(V) - 1);
	RETURN BW_SIGMA2;
END //
DELIMITER ;

DROP FUNCTION IF EXISTS sigmaBW;
DELIMITER //
CREATE FUNCTION sigmaBW(V JSON)
RETURNS DECIMAL(10,3)
DETERMINISTIC

BEGIN
	DECLARE SIGMA DECIMAL(10,2);
	SET SIGMA = SQRT(sigma2BW(V));
	RETURN SIGMA;
END //
DELIMITER ;

DROP FUNCTION IF EXISTS muSigma2Sigma;
DELIMITER //
CREATE FUNCTION muSigma2Sigma(V JSON)
RETURNS JSON
DETERMINISTIC

BEGIN
	DECLARE MU DECIMAL(10,3); DECLARE SIGMA2 DECIMAL(10,3); DECLARE SIGMA DECIMAL(10,3);
	DECLARE A JSON;
	SET MU = avgBW(V);
	SET SIGMA2 = sigma2BW(V);
	SET SIGMA = sigmaBW(V);
	SET A = JSON_ARRAY(MU,SIGMA2,SIGMA);
	RETURN A;
END //
DELIMITER ;

DROP FUNCTION IF EXISTS normalize;
DELIMITER //
CREATE FUNCTION normalize(V DECIMAL(10,3),MU DECIMAL(10,3),SIGMA DECIMAL(10,3))
RETURNS DECIMAL(10,3)
DETERMINISTIC

BEGIN
	DECLARE ZSCORE DECIMAL(10,3);
	SET ZSCORE = (V - MU) / SIGMA;	
	RETURN ZSCORE;
END //
DELIMITER ;

DROP FUNCTION IF EXISTS normalizedBW;
DELIMITER //
CREATE FUNCTION normalizedBW(B JSON)
RETURNS JSON
DETERMINISTIC

BEGIN
	DECLARE JSON_B JSON; DECLARE V DECIMAL(10,3);
	DECLARE I INT; DECLARE MU DECIMAL(10,3); DECLARE SIGMA DECIMAL(10,3);
	SET MU = avgBW(B);
	SET SIGMA = sigmaBW(B);	
	SET I = 0;
	SET JSON_B = JSON_ARRAY();	
	WHILE I < JSON_LENGTH(B) DO		
		SET V = normalize(JSON_EXTRACT(B,CONCAT('$[',I,']')),MU,SIGMA);
		SET JSON_B = JSON_ARRAY_INSERT(JSON_B,CONCAT('$[',I,']'),V);
		SET I = I + 1;
	END WHILE;
	RETURN JSON_B;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS widgetNetworkAnalysis;
DELIMITER //
CREATE PROCEDURE widgetNetworkAnalysis(V1 INT, V2 INT)

BEGIN

	-- UTILITY VARIABLES
	DECLARE I INT; DECLARE FROWS INT;

	-- CURSOR VARIABLES
	DECLARE NNAME VARCHAR(20); DECLARE NBW DECIMAL(10,3); DECLARE NOBW DECIMAL(10,3); 
	DECLARE NMXBW DECIMAL(10,3); DECLARE NMNBW DECIMAL(10,3); 
	DECLARE NSWITCH INT; DECLARE NSTATUS VARCHAR(20);

	DECLARE WWID VARCHAR(20); DECLARE WWTYPE VARCHAR(20); DECLARE WWLOC VARCHAR(20);
	DECLARE WWSEC INT; 

	DECLARE SSNAME VARCHAR(20); DECLARE SX INT; DECLARE SY INT; 

	-- FUNCTION VARIABLES
	DECLARE WSEC_V VARCHAR(20); DECLARE NSW_ST VARCHAR(100); DECLARE NSW_V VARCHAR(20);
	DECLARE NBW_J JSON; DECLARE NBWN_J JSON; DECLARE NSL_J VARCHAR(50);
	 

	-- DECLARE CURSOR
	DECLARE NS_CURSOR CURSOR FOR
	SELECT N.NetName, N.Bandwidth, N.OptimumBW, N.MaxBW, N.MinBW, N.CSwitched, N.NetStatus,
	W.WID, W.WType, W.Location, W.Secure, S.SiteName, S.XCoord, S.YCoord
	FROM Network N 
	JOIN Widget W ON W.AssignedTo = N.NetName
	JOIN Site S ON S.SiteName = W.Location
	WHERE W.WID LIKE CONCAT('%#',V1,'%',V2);

	-- CREATE TABLE
	DROP TABLE IF EXISTS widgetNET;
	CREATE TABLE widgetNET(
	WID_ID_Type VARCHAR(30),
	WID_IsSecure VARCHAR(50),
	NET_Status VARCHAR(100),
	NET_IsSwitched VARCHAR(50),
	NET_BandWidths JSON,
	NET_BandWidthsStats JSON,
	SITE_Name_Location VARCHAR(50),	
	CONSTRAINT PK_WN PRIMARY KEY(WID_ID_Type)	
	);

	-- OPEN CURSOR
	OPEN NS_CURSOR;
	SET FROWS = FOUND_ROWS();
	SET I = 0;
	WHILE I < FROWS DO 
		-- FETCH CURSOR
		FETCH NS_CURSOR INTO NNAME,NBW,NOBW,NMXBW,NMNBW,NSWITCH,NSTATUS,
		WWID,WWTYPE,WWLOC,WWSEC,SSNAME,SX,SY;

		SET WSEC_V = secured(WWSEC);
		SET NSW_ST = modStatus(NNAME);
		SET NSW_V = switched (NSWITCH);
		SET NBW_J = bwToArray(NNAME);			
		SET NBWN_J = muSigma2Sigma(NBW_J);		
		SET NSL_J = CONCAT(SSNAME,' at ','Coordinates: ','(',SX,',',SY,')');

		INSERT INTO widgetNET VALUES(CONCAT(WWID,' ',WWTYPE),WSEC_V,NSW_ST,NSW_V,NBW_J,NBWN_J,NSL_J);
		SET I = I + 1;
	END WHILE;	

	-- CLOSE CURSOR
	CLOSE NS_CURSOR;
	-- DISPLAY TABLE
	SELECT * FROM widgetNET LIMIT 10;

END //
DELIMITER ;
CALL widgetNetworkAnalysis(1,6);
CALL widgetNetworkAnalysis(2,5);
CALL widgetNetworkAnalysis(3,4);




