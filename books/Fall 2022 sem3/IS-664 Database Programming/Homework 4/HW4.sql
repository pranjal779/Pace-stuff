USE droneff;

DELIMITER //
CREATE FUNCTION displayAuthorName()
RETURNS VARCHAR(30)
DETERMINISTIC

BEGIN
    DECLARE MyName VARCHAR(30);
    SET MyName = "Pranjal Shukla";
    RETURN MyName;

END //
DELIMITER ;


-- finding flight time using speed, time, distance formula, i.e time = distance/speed
DROP FUNCTION IF EXISTS flighttime;
DELIMITER //
CREATE FUNCTION flighttime(A INT, B INT)
RETURNS DECIMAL(5,2)
DETERMINISTIC

BEGIN

    DECLARE C DECIMAL(5,2);
    SET A = DRange.dronetypes;
    SET B = DSpeed.dronetypes;
    SET C = A/B;
    RETURN C;
END //

DELIMITER ;

-- totalCapcity
DROP FUNCTION IF EXISTS getTotalCapacity;
DELIMETER //
CREATE FUNCTION getTotalCapacity(A INT, B INT)
RETURNS VARCHAR(50)
DETERMINISTIC

BEGIN
    DECALRE C VARCHAR(50);
    SET A = DronesReady FROM droneunits;
    SET B = DCapacity FROM dronetypes;
    SET C = A * B
    RETURN C;

END //

DELIMITER ;

-- RequiredCapacity
DROP FUNCTION IF EXISTS getRequiredCapacity;
DELIMITER //
CREATE FUNCTION getRequiredCapacity(A VARCHAR(20))
RETURNS VARCHAR(20)
DETERMINISTIC

BEGIN //
    DECLARE S VARCHAR(20);
    IF A = 'A' THEN
        SET S = '400,000';
    END IF;
    IF A = 'B' THEN
        SET S = '600,000';
    END IF;
    IF A = 'C' THEN
        SET S = '800,000';
    END IF;
    IF A = 'D' THEN
        SET S = '900,000';
    END IF;
    RETURN E;
END //
DELIMETER ;

-- getTotalMissionCost
DROP FUNCTION IF EXISTS Totalcost;
DELIMITER //
CREATE FUNCTION Totalcost(A INT, B DECIMAL(10,2))
RETURNS VARCHAR(40);
DETERMINISTIC

BEGIN
    DECLARE Z (VARCAHR(50));
    SET A = DronesReady FROM droneunits;
    SET B = MissionCost FROM dronetypes;
    SET Z = A * B;
    RETURN Z;

END //

-- stored procedure
DROP PROCEDURE IF EXISTS showAvailbleUnits;
DELIMITER //
CREATE PROCEDURE showAvailbleUnits;

BEGIN //
    CREATE TEMPORARY TABLE availability av AS(
        SELECT UnitID FROM droneunits,
        SELECT du.UnitID , airf.AF_Location, actFir.Fire_Location, drTy.DRange, drTy.DSpeed, du.DronesOperational, du.DronesReady
        FROM droneunits du, airfields airf, activefires actFir, dronetypes drTy
        JOIN    airf.AF_Location AS UnitLocation ON airf.AFID
        JOIN    actFir.Fire_Location AS FireLocation ON actFir.Fire_Location
        JOIN    drTy.DRange AS DroneRange ON drTy.DRange
        JOIN    drTy.DSpeed AS DroneSpeed ON drTy.DSpeed
        JOIN    du.DronesOperational AS DronesOperational ON du.DronesOperational
        JOIN    du.DronesReady AS DronesReady ON du.DronesReady

        SELECT flighttime AS FlightTimeToFire,
        SELECT getTotalCapacity AS TotalCapacity,
        SELECT getRequiredCapacity AS RequiredCapacity,
        SELECT Totalcost AS TotalMissionCost;
    );

END //
DELIMITER ;
CALL showAvailbleUnits('F1-1-11');
CALL showAvailbleUnits('F1-11-11');



