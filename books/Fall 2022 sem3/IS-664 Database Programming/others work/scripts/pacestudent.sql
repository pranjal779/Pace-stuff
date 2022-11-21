
Drop database if exists pacestudent;

Create database pacestudent;
use pacestudent;

create table student (
studentId varchar (20),
Lastname char (60),
Firstname char (60),
Age int,
Gender char (10),
Major char (5),
constraint PK_student PRIMARY KEY (studentId)
);

Insert into student values ('U0001','Anderson','Donald',23,'Male','CS');
Insert into student values ('U0002','Baker','Erika',24,'Female','IS');

create table mealplan (
studentmp varchar (20),
mealplancode varchar (15),
constraint PK_mealplan Primary Key (studentmp),
constraint FK_mealplan Foreign Key (studentmp) References student(studentId)
);

