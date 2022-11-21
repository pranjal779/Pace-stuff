drop database if exists pacestudents001;
create database pacestudents001;
use pacestudents001;


create table if not exists Students 
	(
		studentid VARCHAR(40) PRIMARY key ,
		lastnme varchar(30),
		firstname varchar(20),
		age int,
		gender VARCHAR(10),
		major VARCHAR(20)
		
	);

Describe Students;

create table if not exists mealplan
	(
		studentmp VARCHAR(40) primary key,
		mealplancode varchar(4),
		foreign key(studentmp) references STUDENTs(studentid)
);