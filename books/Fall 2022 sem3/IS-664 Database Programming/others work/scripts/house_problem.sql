/* 
My first SQL PRogramming Problem
Created by Pranav 
Sept 2021
*/

DROP DATABASE IF EXISTS Pranav;
Create DATABASE Pranav;
USE Pranav;

-- Create Variables for square feet

set @H1_SF = '12000';
set @H2_SF = '18560';
set @H3_SF = '23450';

-- Calculate Time

set @T1 = @H1_SF/10;
set @T2 = @H2_SF/10;
set @T3 = @H3_SF/10;

-- Calculate Labor

set @H1_Labor = 24.50 * @T1;
set @H2_Labor = 24.50 * @T2;
set @H3_Labor = 24.50 * @T3;

-- Calculate Paint

set @H1_Paint = @H1_SF * 25;
set @H2_Paint = @H2_SF * 25;
set @H3_Paint = @H3_SF * 25;

-- Calculate Total Cost

set @H1_Total = @H1_Labor + @H1_Paint;
set @H2_Total = @H2_Labor + @H2_Paint;
set @H3_Total = @H3_Labor + @H3_Paint;

-- Display Cost

select concat ('The cost to Paint House 1 is $', @H1_Total,'USD') AS MSG1;
select concat ('The cost to Paint House 2 is'$, @H2_Total,'USD') AS MSG2;
select concat ('The cost to Paint House 3 is'$, @H3_Total,'USD') AS MSG3;
