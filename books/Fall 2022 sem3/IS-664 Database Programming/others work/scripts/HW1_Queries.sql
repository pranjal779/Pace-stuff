/*
Required Queries
for Homework 1 */

Use PranavHW1;

-- 1

select count(PNumber) as "Number of females" 
from Passenger
where PGender = 'female';

-- 2

select count(PNumber) as "Number of males" 
from Passenger
where PGender = 'male';

-- 3 

select count(PNumber) as "Passengers over 30 years of age" 
from Passenger
where PAge > '30';

-- 4

select count(PNumber) as "Passengers under 30 years of age" 
from Passenger
where PAge < '30';

-- 5

select count(Survival.PNumber) as "Number of females survived" 
from Survival,Passenger
where Survival.PNumber = Passenger.PNumber
and survived = '1' 
and PGender = 'female';

-- 6

select count(Survival.PNumber) as "Number of males survived" 
from Survival,Passenger
where Survival.PNumber = Passenger.PNumber
and survived = '1' 
and PGender = 'male';


-- 7

select count(Survival.PNumber) as "Number of females over 30 survived" 
from Survival,Passenger
where Survival.PNumber = Passenger.PNumber
and survived = '1' 
and PGender = 'female'
and Passenger.PAge > '30';

-- 8

select count(Survival.PNumber) as "Number of first class passengers survived" 
from Survival,Ticketing
where Survival.PNumber = Ticketing.PNumber
and survived = '1' 
and PClass = '1';

-- 9

select count(Survival.PNumber) as "Number of first class male passengers survived" 
from Survival,Ticketing,Passenger
where Survival.PNumber = Ticketing.PNumber
and Passenger.PNumber = Ticketing.PNumber
and survived = '1' 
and PClass = '1'
and PGender = 'male';

-- 10

select count(Survival.PNumber) as "Number of first class female passengers survived" 
from Survival,Ticketing,Passenger
where Survival.PNumber = Ticketing.PNumber
and Passenger.PNumber = Ticketing.PNumber
and survived = '1' 
and PClass = '1'
and PGender = 'female';

-- 11

select count(Survival.PNumber) as "Number of first class female passengers did not survive" 
from Survival,Ticketing,Passenger
where Survival.PNumber = Ticketing.PNumber
and Passenger.PNumber = Ticketing.PNumber
and survived = '0' 
and PClass = '1'
and PGender = 'female';

-- 12

select count(Survival.PNumber) as "Number of first class male passengers did not survive" 
from Survival,Ticketing,Passenger
where Survival.PNumber = Ticketing.PNumber
and Passenger.PNumber = Ticketing.PNumber
and survived = '0' 
and PClass = '1'
and PGender = 'male';

-- 13

select count(Survival.PNumber) as "Number of first class male passengers under 20 did not survive" 
from Survival,Ticketing,Passenger
where Survival.PNumber = Ticketing.PNumber
and Passenger.PNumber = Ticketing.PNumber
and survived = '0' 
and PClass = '1'
and PGender = 'male'
and PAge < '20';

-- 14

select count(Survival.PNumber) as "Number of first class female passengers under 20 did not survive" 
from Survival,Ticketing,Passenger
where Survival.PNumber = Ticketing.PNumber
and Passenger.PNumber = Ticketing.PNumber
and survived = '0' 
and PClass = '1'
and PGender = 'female'
and PAge < '20';

-- 15

select MAX(PAge) as "Maximum age of female survivor"
from Survival,Passenger
where Survival.PNumber = Passenger.PNumber
and survived = '1' 
and PGender = 'female' ;


-- 16

select  MIN(PAge) as "Minimum age of female survivor"
from Survival,Passenger
where Survival.PNumber = Passenger.PNumber
and survived = '1' 
and PGender = 'female' ;


-- 17

select  AVG(PAge) as "Mean age of female survivor"
from Survival,Passenger
where Survival.PNumber = Passenger.PNumber
and survived = '1' 
and PGender = 'female' ;


-- 18

select MAX(PAge) as "Maximum age of male survivor"
from Survival,Passenger
where Survival.PNumber = Passenger.PNumber
and survived = '1' 
and PGender = 'male' ;


-- 19

select  MIN(PAge) as "Minimum age of male survivor"
from Survival,Passenger
where Survival.PNumber = Passenger.PNumber
and survived = '1' 
and PGender = 'male' ;


-- 20

select  AVG(PAge) as "Mean age of male survivor"
from Survival,Passenger
where Survival.PNumber = Passenger.PNumber
and survived = '1' 
and PGender = 'male' ;