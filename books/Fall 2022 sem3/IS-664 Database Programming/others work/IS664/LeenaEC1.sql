/*
First SQL script cretaed by Leena on 23 Sept 2021
to calculate house cost 
*/


drop database if exists leena;
create database leena;
use leena;

-- create variables for sq. feet
set @h1_sf = 12000;
set @h2_sf = 18560;
set @h3_sf = 23450;

-- calculate time 
set @h1_time =  @h1_sf / 10;
set @h2_time =  @h2_sf / 10;
set @h3_time =  @h3_sf / 10;


-- calculate labour cost 

set @h1_labour = @h1_time * 24.50;
set @h2_labour = @h2_time * 24.50;
set @h3_labour = @h3_time * 24.50;

-- calculate paint
set @h1_paint = @h1_sf * 25;
set @h2_paint = @h2_sf * 25;
set @h3_paint = @h3_sf * 25;

-- calculate total cost

set @h1_total = @h1_labour + @h1_paint;
set @h2_total = @h2_labour + @h2_paint;
set @h3_total = @h3_labour + @h3_paint;


-- Display cost 
select concat('The cost to  paint the  house1 is $', format(@h1_total,2),'US dollars') as cost;
select concat('The cost to  paint the  house2 is $', format(@h2_total,2),'US dollars') as cost;
select concat('The cost to  paint the  house3 is $', format(@h3_total,2),'US dollars') as cost;
