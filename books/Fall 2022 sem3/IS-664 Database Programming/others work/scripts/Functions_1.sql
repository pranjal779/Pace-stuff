/* This is a demo script 
for functions. 
Created by Pranav */

Drop Database if exists functiondemo;
Create Database functiondemo;
use functiondemo;

DELIMITER //
Drop function if exists displayScriptAuthor;
Create Function displayScriptAuthor(N char(40))
Returns Char(40)
DETERMINISTIC

Begin
	Declare F Char(40);
	SET F = N;
	Return F;

End //

DELIMITER ;


 select displayScriptAuthor("Pranav") as Script_Author;


 -- Average five

DELIMITER //
Drop function if exists AvgFive;
Create Function AvgFive(A INT, B INT, C INT, D INT, E INT)
Returns INT(20)
DETERMINISTIC

Begin
	Declare F INT;
	SET F = (A+B+C+D+E)/5;
	Return F;

End //

DELIMITER ;


 select AvgFive(1,2,3,4,5) as Average;

-- Variance


 DELIMITER //
drop function if exists Var;
Create Function VarianceA(A INT)
Returns decimal(20,3)
DETERMINISTIC

Begin
	Declare F float;
	Declare V float;
	Declare N float;
	Set F= A;
	Set N = F*F-1;
	Set V = N/12;
	Return V;

End //

DELIMITER ;

select VarianceA(5) as variance ;

-- Standard Deviation

DELIMITER //
drop function if exists SigmaA;
Create Function SigmaA(A INT)
Returns decimal(5,3)
DETERMINISTIC

Begin
	Declare F float;
	Set F= sqrt(VarianceA(A)) ;
	Return F;

End //

DELIMITER ;

select SigmaA(5) as standard_deviation ;