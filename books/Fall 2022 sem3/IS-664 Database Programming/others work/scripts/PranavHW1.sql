/* 
This is the
Homework-1 script,
created by Pranav
Sept 2021 
*/

Create Database PranavHW1;
use PranavHW1;


-- creating all the relations

create table Passenger (
PNumber int,
PGender char (10),
PAge int,
constraint PK_Pass Primary Key (PNumber)
);


create table PassengerName (
PNumber int,
PName char (100),
constraint FK_Passname Foreign Key (PNumber) references Passenger(PNumber)
);


create table Companions (
PNumber int,
PSib int,
PPOC int,
constraint FK_Comp Foreign Key (PNumber) references Passenger(PNumber)
);


create table Ticketing (
PNumber int,
PClass varchar (100),
TicketNumber varchar(100),
FarePrice decimal (10,2),
Cabin varchar (100),
Embarked varchar (100),
constraint FK_Ticket Foreign Key (PNumber) references Passenger(PNumber) 
);


create table Survival (
PNumber int,
survived int,
constraint FK_Surv Foreign Key (PNumber) references Passenger(PNumber)
);


/*
Required Queries
for Homework 1 */


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





-- OUTPUT


Database changed
+-------------------+
| Number of females |
+-------------------+
|               314 |
+-------------------+
1 row in set (0.01 sec)

+-----------------+
| Number of males |
+-----------------+
|             577 |
+-----------------+
1 row in set (0.00 sec)

+---------------------------------+
| Passengers over 30 years of age |
+---------------------------------+
|                             305 |
+---------------------------------+
1 row in set (0.00 sec)

+----------------------------------+
| Passengers under 30 years of age |
+----------------------------------+
|                              561 |
+----------------------------------+
1 row in set (0.00 sec)

+----------------------------+
| Number of females survived |
+----------------------------+
|                        233 |
+----------------------------+
1 row in set (0.01 sec)

+--------------------------+
| Number of males survived |
+--------------------------+
|                      109 |
+--------------------------+
1 row in set (0.00 sec)

+------------------------------------+
| Number of females over 30 survived |
+------------------------------------+
|                                 83 |
+------------------------------------+
1 row in set (0.00 sec)

+-------------------------------------------+
| Number of first class passengers survived |
+-------------------------------------------+
|                                       136 |
+-------------------------------------------+
1 row in set (0.00 sec)

+------------------------------------------------+
| Number of first class male passengers survived |
+------------------------------------------------+
|                                             45 |
+------------------------------------------------+
1 row in set (0.00 sec)

+--------------------------------------------------+
| Number of first class female passengers survived |
+--------------------------------------------------+
|                                               91 |
+--------------------------------------------------+
1 row in set (0.00 sec)

+---------------------------------------------------------+
| Number of first class female passengers did not survive |
+---------------------------------------------------------+
|                                                       3 |
+---------------------------------------------------------+
1 row in set (0.00 sec)

+-------------------------------------------------------+
| Number of first class male passengers did not survive |
+-------------------------------------------------------+
|                                                    77 |
+-------------------------------------------------------+
1 row in set (0.00 sec)

+----------------------------------------------------------------+
| Number of first class male passengers under 20 did not survive |
+----------------------------------------------------------------+
|                                                             19 |
+----------------------------------------------------------------+
1 row in set (0.00 sec)

+------------------------------------------------------------------+
| Number of first class female passengers under 20 did not survive |
+------------------------------------------------------------------+
|                                                                1 |
+------------------------------------------------------------------+
1 row in set (0.00 sec)

+--------------------------------+
| Maximum age of female survivor |
+--------------------------------+
|                             63 |
+--------------------------------+
1 row in set (0.00 sec)

+--------------------------------+
| Minimum age of female survivor |
+--------------------------------+
|                              0 |
+--------------------------------+
1 row in set (0.00 sec)

+-----------------------------+
| Mean age of female survivor |
+-----------------------------+
|                     24.3948 |
+-----------------------------+
1 row in set (0.00 sec)

+------------------------------+
| Maximum age of male survivor |
+------------------------------+
|                           80 |
+------------------------------+
1 row in set (0.00 sec)

+------------------------------+
| Minimum age of male survivor |
+------------------------------+
|                            0 |
+------------------------------+
1 row in set (0.00 sec)

+---------------------------+
| Mean age of male survivor |
+---------------------------+
|                   23.2752 |
+---------------------------+
1 row in set (0.00 sec)