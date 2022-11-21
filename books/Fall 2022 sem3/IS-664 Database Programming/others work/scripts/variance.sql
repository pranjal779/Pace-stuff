drop Database if exists functiondemo;
Create Database functiondemo;
use functiondemo;

DELIMITER //
drop function if exists Var;
Create Function Var(A INT)
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

select Var(5) as variance ;

-- Standard Deviation

DELIMITER //
drop function if exists Stddeviation;
Create Function Stddeviation(A INT)
Returns decimal(5,3)
DETERMINISTIC

Begin
	Declare F float;
	Declare V float;
	Declare N float;
	Declare D float;
	Set F= A;
	Set N = F*F-1;
	Set V = N/12;
	Set D = sqrt(V);
	Return D;

End //

DELIMITER ;

select Stddeviation(5) as standard_deviation ;