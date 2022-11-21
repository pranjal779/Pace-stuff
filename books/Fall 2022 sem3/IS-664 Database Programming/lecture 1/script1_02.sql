USE locklearFall2022;

SET @A = 1; SET @B = 2; SET @C = 3; SET @d = NULL;

-- IF FUNCTION
SELECT IF(@A > @B, 'A Greater','A Not Greater') AS 'T1';

-- IFNULL Function
-- Return Expression 1 if NOT NULL else Return Expression 2
SELECT IFNULL(@A, 'A IS NULL') AS 'T2';
SELECT IFNULL(@D, 'D IS NULL') AS 'T3';

-- CASE Allow for Pattern Matching
SELECT CASE @A
    WHEN 1 THEN 'A is equal to 1'
    WHEN 2 THEN 'A is equal to 2'
    ELSE 'A is not equal to 1 or 2'
    END
AS 'T4';

SELECT CASE @C
    WHEN 1 THEN 'C is equal to 1'
    WHEN 2 THEN 'C is equal to 2'
    ELSE 'C is not equal to 1 or 2'
    END
AS 'T5';