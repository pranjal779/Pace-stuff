use IMPERIAL_DEFENSE;

DROP PROCEDURE componentSummary;
DELIMITER //
CREATE PROCEDURE componentSummary(p_netname VARCHAR(20))

BEGIN
-- CREATE VARIABLES
   declare  r_counter int ;
   declare  r_count int  ;
   declare msg varchar(600);
   declare n_id varchar(20); declare n_name varchar(20); declare n_hid varchar(20); declare n_hrange varchar(20);
   declare n_sid varchar(20); declare n_srange varchar(20); declare n_rpid varchar(20);declare n_rrange varchar(20);
  


-- DECLARE CURSOR

declare NW_cursor cursor for select n.netname,h.hid, abs(h.entryport - h.exitport) as hubrange, 
                                    s.SID, abs(s.entryport - s.exitport) as switchrange, 
                                    r.rpid, abs(r.entryport - r.exitport) as repeater_port
                                    from network n inner JOIN hub h 
                                    on n.netname = h.assignedto
                                    inner JOIN switch s
                                    on n.netname = s.assignedto 
                                    inner JOIN repeater r
                                    on n.netname = r.assignedto
                                    where n.netname = p_netname order by s.sid, r.rpid;


-- open cursor                                   
open NW_cursor;
     SET r_count = FOUND_ROWS();
     SET r_counter = 0;
-- FETCH CURSOR   
   while r_counter < r_count Do
   fetch NW_cursor into n_name, n_hid, n_hrange, n_sid, n_srange, n_rpid, n_rrange;
      set msg = concat('HUB:',n_hid, '  Switch: ', n_sid, ' Repeater: ', n_rrange,'\n');
      set msg = concat(msg,'HUB Port Range: HUB has range of',n_hrange,'\n','Switch Port Range: Switch has range of',n_srange,'\n',
                       'Repeater Port Range: Switch has range of',n_rrange,'\n',
                        'All Components Assigned To: ', n_name);
-- Display Data       
      select msg as 'MSG';
      set r_counter = r_counter + 1;
   end while;

close nw_cursor;

END //
DELIMITER ;

CALL componentSummary('Brore01wNET_TRACK');
