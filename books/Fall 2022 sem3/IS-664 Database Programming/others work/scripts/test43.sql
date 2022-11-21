
















		/* Open Net_cursor;
		Set row_count = FOUND_ROWS();
		set i = 0;
		while i < row_count do
			fetch Net_cursor into N_name;
			set H_range = hubrange(N_name);
			set S_range = sw_range(N_name);
			set R_range = rp_range(N_name);
			select N_name, H_range, S_range, R_range as msg;
			set row_count = row_count + 1;
		end while ;
		close Net_cursor ; 



END//

DELIMITER ; */

CALL componentSummary('Brore06vNET_SURV');