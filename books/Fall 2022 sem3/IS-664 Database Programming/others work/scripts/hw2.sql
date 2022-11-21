
Create Database PranavHW2;
use PranavHW2;


-- creating all the relations

create table Passenger (
PNumber int,
PGender char (10),
PAge int,
constraint PK_Pass Primary Key (PNumber)
);

Load Data LOCAL INFILE 'D:\MIS\DBMS\Passenger.sql' INTO table Passenger;


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
