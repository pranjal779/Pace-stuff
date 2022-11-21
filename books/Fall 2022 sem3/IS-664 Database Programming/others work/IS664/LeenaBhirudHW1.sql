/* 

creation Of A Titanic Database Including Passenger, Passengername, Companions,
ticketing, Survival Tables.
created By Leena On 25th September 

*/


-- Namespace For Titanic Db 

drop Database If Exists Titanicdb;
create Database Titanicdb;
use Titanicdb;


-- Create Table Passenger 

create Table If Not Exists Passenger
	(
		pnumber Int Primary Key  Default '0',
		pgender Varchar(8) Not Null Default 'unk',
		page    Int Not Null Default '0'
	);

-- Display Datatype And Constraints Of Passenger Table

 Describe Passenger;

-- To Fetch Records From The Table

select * From Passenger Limit 10;


-- Create Table Passengername

create Table If Not Exists Passengername
     (
     	pnumber Int Primary Key  Default '0',
     	pname   Varchar(100) Not Null Default 'unk'
     );	
     	

 -- Display Datatype And Constraints Of Passenger Name Table

 Describe Passengername;     	

-- Create Table Companions

create Table If Not Exists Companions
     (
     	pnumber Int Primary Key  Default '0',
     	psib   Int(3) Not Null Default '0',
     	ppoc   Int(3) Not Null Default '0'
     );	
     	

-- Display Datatype And Constraints Of Companions Table

 Describe Companions;     	

 -- Create Table Ticketing

create Table If Not Exists Ticketing 
     (
     	pnumber Int Primary Key  Default '0',
     	pclass  Int(3) Not Null Default '0',
     	ticketnumber   Varchar(20) Not Null Default 'unk',
     	fareprice      Decimal(10,2) Not Null Default '0.0',
     	cabin	       Varchar(20) Not Null Default 'unk',
     	embarked       Varchar(3) Not Null Default 'unk'
     );	
     	

-- Display Datatype And Constraints Of Ticketing Table

 Describe Ticketing;

  -- Create Table Survival	

create Table If Not Exists Survival 
     (
     	pnumber   Int Primary Key Default '0',
     	survived  Int Not Null Default '0'
     );	
     	

 -- Display Datatype And Constraints Of Survival Table

 Describe Survival;

 -- To Fetch Records From The Table

 Select * From Survival Limit 10;



-- Queries:

-- Query 1 - How Many Passengers Are Female?

 Select Count(*) As female_count From Passenger Where Pgender = 'female';  

-- Output: 314


-- Query 2 - How Many Passengers Are Male?
 
 Select Count(*) as male_count From Passenger Where Pgender = 'male';

-- Output: 577


-- Query 3 - How Many Passengers Are Over 30 Years Of Age?
 
 Select Count(*)  As Agecount From Passenger Where Page >30;

-- Output: 305

-- Query 4 - How Many Passengers Are Under 30?
 
 Select Count(*) As Agecount From Passenger Where Page <30;

-- Output: 561

-- Query 5 - How Many Female Passengers Survived?

select Count(*) As female_count 
From Survival As S
left Outer Join Passenger As P
             On P.pnumber = S.pnumber
          Where P.pgender = 'female'
            And S.survived = 1;

-- Output: 233

-- Query 6 - How Many Male Passengers Survived?

select Count(*) As Male_count 
From Survival As S
left Outer Join Passenger As P 
             On P.pnumber = S.pnumber
          Where P.pgender = 'male' 
            And S.survived = 1;

-- Output: 109

-- Query 7 - How Many Female Passengers Over 30 Survived?

select Count(*) As female_count 
From Survival As S
left Outer Join Passenger As P
             On P.pnumber = S.pnumber
          Where P.pgender = 'female'
            And P.page > 30
            And S.survived = 1;

-- Output: 83

-- Query 8 - How Many First-class Passengers Survived?

select Count(*) As female_count 
From Survival As S
left Outer Join Ticketing As T
             On T.pnumber = S.pnumber
          Where T.pclass = 1
            And S.survived = 1;

-- Output: 136


-- Query 9 - How Many First-class Male Passengers Survived?

select Count(distinct P.pnumber) As Fclass_female 
From Passenger  As P
inner Join Ticketing As T 
     		On T.pnumber = P.pnumber
inner Join Survival  As S
            On S.pnumber = P.pnumber
            Where S.survived = 1
            And P.pgender = 'male'
            And T.pclass = 1; 

-- Output: 45

-- Query 10 - How Many First-class Female Passengers Survived?

select Count(distinct P.pnumber) As Fclass_male
From Passenger  As P
inner Join Ticketing As T 
     		 On T.pnumber = P.pnumber
inner Join Survival  As S
            On S.pnumber = P.pnumber            
            Where S.survived = 1
            And T.pclass = 1
            And P.pgender = 'female'; 

-- Output: 91


-- Query 11 - How Many First-class Female Passengers Did Not Survive?

select Count(distinct P.pnumber) As Fclass_count 
From Passenger  As P
inner Join Ticketing As T 
     		on T.pnumber = P.pnumber     		 
inner Join Survival  As S
            On S.pnumber = P.pnumber
            Where P.pgender = 'female'
            And T.pclass = 1
            And S.survived = 0;      
               		   
-- Output: 3

-- Query 12 - How Many First-class Male Passengers Did Not Survive?

select Count(*) As Fclass_count 
From Passenger  As P
inner Join Ticketing As T 
     		on T.pnumber = P.pnumber   		 
inner Join Survival  As S
            On S.pnumber = P.pnumber
            Where P.pgender = 'male'
            And T.pclass = 1
            And S.survived = 0 ;  
               		   
-- Output: 77

-- Query 13 - How Many First-class Male Passengers Under 20 Did Not Survive?

Select Count(*) As Fclass_count 
From Passenger  As P
inner Join Ticketing As T 
     		 On T.pnumber = P.pnumber   		 
inner Join Survival  As S
            On S.pnumber = P.pnumber
            Where P.pgender = 'male'
             And P.page < 20
             And T.pclass = 1
             And S.survived = 0 ;  

-- Output: 19


-- Query 14 - How Many First-class Female Passengers Under 20 Did Not Survive?

select Count(*) As Fclass_count 
From Passenger  As P
inner Join Ticketing As T 
     		 On T.pnumber = P.pnumber   		 
inner Join Survival  As S
            On S.pnumber = P.pnumber
            Where P.pgender = 'female'
             And P.page < 20
             And T.pclass = 1
             And S.survived = 0 ; 
-- Output: 1

-- Query 15 - Maximum Age Of Female Survivors?
select Max(p.page) As Maxage
From Passenger As P
Inner Join Survival As S 
              On P.pnumber = S.pnumber
              Where P.pgender = 'female'
                And S.survived = 1;

-- Output: 63

-- Query 16 - Minimum Age Of Female Survivors?

select Min(p.page) As Minage
From Passenger As P
Inner Join Survival As S 
              On P.pnumber = S.pnumber
              Where P.pgender = 'female'
                And S.survived = 1;
-- Output: 0 

-- Query 17 - Mean Age Of Female Survivors?

select Avg(p.page) As Meanage
From Passenger As P
Inner Join Survival As S 
              On S.pnumber = P.pnumber
              Where P.pgender = 'female'
                And S.survived = 1;

-- Output:  24.3948

-- Query 18 - Maximum Age Of Male Survivors?
select Max(p.page) As Maxage
From Passenger As P
Inner Join Survival As S 
              On P.pnumber = S.pnumber
              Where P.pgender = 'male'
                And S.survived = 1;

-- Output: 80 

-- Query 19 - Minimum Age Of Male Survivors?
select Min(p.page) As Minage
From Passenger As P
Inner Join Survival As S 
              On S.pnumber = P.pnumber
              Where P.pgender = 'male'
                And S.survived = 1;
-- Output: 0

-- Query 20 - Mean Age Of Male Survivors?
select Avg(p.page) As Meanage
From Passenger As P
Inner Join Survival As S 
              On S.pnumber = P.pnumber
              Where P.pgender = 'male'
                And S.survived = 1;

-- Output:  23.2752

