USE imperial_defense;

DESCRIBE widget;

ALTER TABLE widget MODIFY WType RType ENUM('ITERM','IPAD','IDEV');
ALTER TABLE widget CHANGE AssignedTo RNetType VARCHAR(40);
ALTER TABLE widget CHANGE Location RLocation VARCHAR(100);
ALTER TABLE widget CHANGE AccessCode RAccess enum('A1','B2','C3','D4');
-- ALTER TABLE widget CHANGE User RUser json;
select * from widget;

-- DESCRIBE widget;
