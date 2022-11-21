USE asteroids;

DROP PROCEDURE IF EXISTS  asteroid_prospectus;

DELIMITER //
-- TASK

-- Argument C = Country Name, N = Asteroid Name
CREATE PROCEDURE  asteroid_prospectus(C VARCHAR(30), N VARCHAR(50), js JSON)
BEGIN

    -- Utility Variables
    DECLARE COUNTER INT; DECLARE ROW_COUNT INT; DECLARE close_dist DECIMAL(10,2); DECLARE most_dist DECIMAL(10,2);
    -- CURSOR VAIBLES
    DECLARE N_N (VARCHAR(20)); DECLARE N_oN (VARCHAR(20)); DECLARE N_close_dist(VARCHAR(20)); DECLARE N_most_dist(VARCHAR(20));
    -- DECLARE

    -- DECLAREING CURSOR
    DECALRE CR_US CURSOR FOR SELECT spatialcoord.x, spatialcoord.y, spatialcoord.z, registry.country, composition_simple.Content_Rock, composition_simple.Content_Metal, surface_feature.Water, surface_feature.Surface WHERE Designation = C;
    DECALRE CR_RUSSIA CURSOR FOR SELECT spatialcoord.x, spatialcoord.y, spatialcoord.z, registry.country, composition_simple.Content_Rock, composition_simple.Content_Metal, surface_feature.Water, surface_feature.Surface WHERE Designation = C;
    DECALRE CR_UK CURSOR FOR SELECT spatialcoord.x, spatialcoord.y, spatialcoord.z, registry.country, composition_simple.Content_Rock, composition_simple.Content_Metal, surface_feature.Water, surface_feature.Surface WHERE Designation = C;
    DECALRE CR_CHINA CURSOR FOR SELECT spatialcoord.x, spatialcoord.y, spatialcoord.z, registry.country, composition_simple.Content_Rock, composition_simple.Content_Metal, surface_feature.Water, surface_feature.Surface WHERE Designation = C;

    -- CHECKING for COUNTRY NAME / ASTEROID DESIGNATION NAME
    IF N = "US" THEN
    OPEN CR_US;
    SET COUNTER = 0;
    SELECT FOUND_ROWS() INTO ROW_COUNT;
    WHILE COUNTER < ROW_COUNT DO
    FETCH CR_US INTO close_dist, most_dist,
        SET DISTANCE = POW((POW((X - X1),2) + POW((Y - Y1),2) + POW((Z - Z1),2)),0.5);
        INSERT INTO CONCAT(N, 'is Closest to', Designation,'(',DISTANCE,')', JSON_EXTRACT(js, '$.'))

    SET COUNTER  = COUNTER + 1;
    END WHILE;

    CLOSE CR_US;

    -- CHECKING for COUNTRY NAME / ASTEROID DESIGNATION NAME
    IF N = "RUSSIA" THEN
    OPEN CR_RUSSIA;
    SET COUNTER = 0;
    SELECT FOUND_ROWS() INTO ROW_COUNT;
    WHILE COUNTER < ROW_COUNT DO
    FETCH CR_US INTO close_dist, most_dist,
        SET DISTANCE = POW((POW((X - X1),2) + POW((Y - Y1),2) + POW((Z - Z1),2)),0.5);


    SET COUNTER  = COUNTER + 1;
    END WHILE;

    CLOSE CR_RUSSIA;

    -- CHECKING for COUNTRY NAME / ASTEROID DESIGNATION NAME
    IF N = "UK" THEN
    OPEN CR_UK;
    SET COUNTER = 0;
    SELECT FOUND_ROWS() INTO ROW_COUNT;
    WHILE COUNTER < ROW_COUNT DO
    FETCH CR_US INTO close_dist, most_dist,
        SET DISTANCE = POW((POW((X - X1),2) + POW((Y - Y1),2) + POW((Z - Z1),2)),0.5);


    SET COUNTER  = COUNTER + 1;
    END WHILE;

    CLOSE CR_UK;

    -- CHECKING for COUNTRY NAME / ASTEROID DESIGNATION NAME
    IF N = "CHINA" THEN
    OPEN CR_CHINA;
    SET COUNTER = 0;
    SELECT FOUND_ROWS() INTO ROW_COUNT;
    WHILE COUNTER < ROW_COUNT DO
    FETCH CR_US INTO close_dist, most_dist,
        SET DISTANCE = POW((POW((X - X1),2) + POW((Y - Y1),2) + POW((Z - Z1),2)),0.5);


    SET COUNTER  = COUNTER + 1;
    END WHILE;

    CLOSE CR_CHINA;

    -- feature of surface

    DROP FUNCTION IF EXISTS SURFACE_FEATURE;
    DELIMITER //
    CREATE FUNCTION SURFACE_FEATURE(V VARCHAR(20))
    RETURNS VARCHAR(20)
    DETERMINISTIC

    BEGIN
    DECLARE SUR VARCHAR(20);

    IF V = 'Medium' THEN
        SET SUR = 'IDEAL';
    ELSEIF V = 'Medium-Soft' THEN
        SET SUR = 'IDEAL';
    ELSEIF V = 'Soft' THEN
        SET SUR = 'ACCEPTABLE';
    ELSEIF V = 'Hard' THEN
        SET SUR = 'UNACCEPTABLE';
    ELSEIF V = 'Hard-Medium' THEN
        SET SUR = 'UNACCEPTABLE';
    END IF;

    RETURN SUR;
    END //
    DELIMITER ;

    -- IS Water

END //
DELIMITER ;

CALL asteroid_prospectus();
