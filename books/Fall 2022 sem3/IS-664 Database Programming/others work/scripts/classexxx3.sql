


use doctext;

drop procedure if exists wordcounter;

delimiter //

create procedure wordcounter(A varchar(20), B varchar(20), C varchar(20))

	BEGIN
-- Create Utility Variables
	DECLARE cont_rows, i int;
-- Create Cursor Variables
	Declare id varchar(40);
	Declare scoreA, scoreB, scoreC decimal(10,8);

-- Declare Cursor
	DECLARE doc_cursor CURSOR FOR select concat('Document ', docid), match(doc) against (A IN BOOLEAN MODE), match(doc) against(B IN BOOLEAN MODE), 
	match(doc) against(C IN BOOLEAN MODE) from documents;


-- Create Table
	drop table if exists docscoring;
	create table docscoring(
		Doc VARCHAR(40),
		DocScore_A VARCHAR(20),
		DocScore_B VARCHAR(20),
		DocScore_C VARCHAR(20),
		CONSTRAINT PK_docs PRIMARY KEY(Doc));



-- Open Cursor
	Open doc_cursor;
		set cont_rows = FOUND_ROWS() ;
		set i = 0 ;
-- Fetch Cursor
		IF i = 0 THEN
			INSERT INTO docscoring VALUES ('D Search', A,B,C) ;
			INSERT INTO docscoring VALUES ('D->','----','----','----') ;
		END IF;

		while i < FOUND_ROWS() Do
			Fetch doc_cursor into id, scoreA, scoreB, scoreC;

			Insert Into docscoring(Doc, DocScore_A, DocScore_B, DocScore_C) VALUES (id, scoreA, scoreB, scoreC) ;
			set i = i + 1 ;

		end while;


	select * from docscoring;

END //

delimiter ;

call wordcounter('submarine','Trident','Ohio' );

call wordcounter('submarines','sonar','Seawolf' );

call wordcounter('submarine','SSN','Virginia' );



