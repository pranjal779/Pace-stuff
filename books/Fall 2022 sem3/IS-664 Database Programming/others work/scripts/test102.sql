use imperial_defense;

select NetName, group_concat(DISTINCT RID order by RID) as RID, group_concat(DISTINCT RPID order by RPID) as RPID, group_concat(DISTINCT HID order by HID) as HID, 
	group_concat(DISTINCT SID order by SID) as SID, COUNT(DISTINCT RID), Count(DISTINCT RPID), Count(DISTINCT HID), Count(DISTINCT SID) 
	from router r join repeater b on r.assignedto = b.assignedto
	join hub h on h.assignedto = b.assignedto
	join switch s on s.assignedto = h.assignedto
	join network n on n.netname = s.assignedto
	AND n.netname = 'Brore03yNET_SAT'
 


