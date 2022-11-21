USE imperial_defense;

DROP PROCEDURE IF EXISTS widget_refactor;
DELIMITER //

CREATE PROCEDURE widget_refactor()
BEGIN

    DROP TABLE IF EXISTS R_widget;

    CREATE TABLE R_widget(
    RWID INT NOT NULL AUTO_INCREMENT,
    WidgetID VARCHAR(20),
    RType ENUM('IDEV','IPAD','ITERM'),
    NetAssigned Varchar(40),
    RNetType ENUM('SAT','TRACK','SURV','DEF','CIV'),
    RLocation VARCHAR(100),
    RAccess ENUM('A1','B2','C3','D4'),
    RSecure ENUM('Encrypted','Plain Text'),
    RUser json,
    CONSTRAINT PK_R_WIDGET PRIMARY KEY(RWID),
    CONSTRAINT UK_R_WIDGET UNIQUE KEY (WidgetID)
    );

    INSERT INTO R_widget(WidgetID, NetAssigned, RType, RAccess, RSecure)
    SELECT WID, AssignedTo,
    CASE
        WHEN WType="Terminal" THEN "ITERM"
        WHEN WType="Pad" THEN "IPAD"
        WHEN WTYPE="Device" THEN "IBEV"
    END
    , CASE
        WHEN SUBSTRING_INDEX(AccessCode,-1) = "A" THEN "A1"
        WHEN SUBSTRING_INDEX(AccessCode,-1) = "B" THEN "B2"
        WHEN SUBSTRING_INDEX(AccessCode,-1) = "C" THEN "C3"
    , CASE
        WHEN Secure=True THEN "Encrypted"
        WHEN Secure=False THEN "Plain Text"
    END




    FROM Widget;

    SELECT WidgetID, NetAssigned, RType, RSecure FROM R_widget LIMIT 10;
    #CONCAT()


END //
DELIMITER ;

CALL widget_refactor();
