drop function if exists convertcountry;
delimiter //
create function covertcountry(c varchar(20))
RETURNS Varchar(50)
DETERMINISTIC

begin
    DECLARE V VARCHAR(50);
    if c = 'us' then
    .
    .
    ..

end //
DELIMITER ;

drop function if exists timelambda;
delimiter //
create function timelambda(c varchar(20))
RETURNS Varchar(50)
NOT DETERMINISTIC
READS SQL data

begin

end //
DELIMITER ;

drop function if exists massdensity_lamda;
delimiter //
create function massdensity_lamda(c varchar(20))
RETURNS Varchar(50)
NOT DETERMINISTIC
READS SQL data

begin

end //
DELIMITER ;

DROP PROCEDURE IF EXISTS specLambda;
DELIMITER //
CREATE PROCEDURE specLambda(A JOSN)
BEGIN

    -- UTILITY VARIABLES
    DECALRE I INT; DECALRE R INT; DECALRE J INT;


    -- CURSOR VARIABLES


    -- OUTPUT VARIABLES

    -- CURSOR
    DEClare xc cursor foreign
    select R.Designation, R.Country, SP.Diameter, SP.Mass, SP.INclination, SP.Rotation
    from registry R
    join specification SP on R.Designation = sp.designation;
    -- where

    -- CREATE TABLE
    CREATE TABLE specLambdaAnalysis(
        Designation VARCHAR(50),
        country ENUM('United states','United Kingdom',....)
        countrycode varchar(20) generated always as () STORED,
        specs JSON,
        timelambda json,
        mdlamda json,
        constraint PK_la PRIMARY key(),
        constraint FK_la foreign key(), references registry())

    -- EXECUTE
    SET I = 0;
    SET R = FOUND_ROWS();
    while I < R DO
        fetch XC INTO ..
            WHILE J < JSON_LENGTH(A) DO

                Set j = j + 1;
            end while;

        set i = i + 1;
    end while ;

    -- SHOW TABLE
    select * from lambdaAnalysis

END //
DELIMITER ;

CALL specLambda(JSON_ARRAY());
