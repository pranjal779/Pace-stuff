/*create procedure for 
homework 3
created by Pranav
 
*/ 
 
use imperial_defense; 
 
drop procedure if exists componentsummary; 
 
delimiter //

create procedure componentsummary(nname varchar(25)) 
 
 begin 
declare num_row,i int; 
declare msgHub,msgSwitch,msgRpter,h_hidd,s_sid,r_rid,nt_netname varchar(60); 
declare h_exit ,h_entry,s_exit ,s_entry,r__exit,r_entry int; 
-- declare variables 
declare cursor_network cursor for select h.hid,s.sid,r.rpid,nt.netname,h.entryport, h.exitport, s.entryport, s.exitport,r.entryport,r.exitport from network nt right join  
hub h on  
h.assignedto = nt.netname right join switch s on  
 h.assignedto = s.assignedto right join   
 repeater r on s.assignedto = r.assignedto where nt.netname = nname group by h.hid; 
-- declare cursor with select 
 
 
 
-- create temp table to store resultset from cursor 
drop table if exists abc; 
create table abc( 
 msg varchar(60), 
 nt_name varchar(60), 
 tb_hid varchar(60), 
 tb_sw varchar(60), 
 tb_rptr varchar(60), 
 hub_exit int  
 ,hub_entry int, 
 swit_exit int , 
 swit_entry int, 
 rpt__exit int, 
 rpt_entry int); 
 
-- open cursor 
open cursor_network;  
 
set num_row = found_rows(); 
set i =0; 
 
-- fetch resultset 
while i<num_row  
  do  
  fetch cursor_network into h_hidd,s_sid,r_rid,nt_netname, h_exit ,h_entry,s_exit ,s_entry,r__exit,r_entry ; 
   
  insert into abc(tb_HID,tb_sw,tb_rptr,nt_name,hub_exit ,hub_entry,swit_exit ,swit_entry,rpt__exit,rpt_entry) values(h_hidd,s_sid,r_rid,nt_netname,h_exit ,h_entry,s_exit ,s_entry,r__exit,r_entry); 
    
  set i = i + 1; 
   End while; 
 
  -- close cursor  
   close cursor_network; 
  

  
   select CONCAT('HUB ',tb_HID,'  SWITCH ',tb_sw,'  REPEATER ',tb_rptr,'\n HUB PORT RANGE: HUB HAS RANGE OF ',abs(abc.hub_exit - abc.hub_entry),'\r\n SWITCH PORT RANGE: switch HAS RANGE OF ',abs(swit_exit - swit_entry),'\n REPEATER PORT RANGE: REPEATER HAS RANGE OF ',abs(rpt__exit-rpt_entry),'\n all components assigned to : ',nt_name,'\n',' \n  msg \n') as message from abc ; 
 
END //
DELIMITER ; 
 

 
call componentsummary('Brore01wNET_TRACK');