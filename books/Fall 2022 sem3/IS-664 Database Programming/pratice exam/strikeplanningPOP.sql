CALL populate_Targeting(JSON_OBJECT('targets',JSON_ARRAY('T-001','Satellite','2022-01-01')
	,'targetLocation',JSON_ARRAY('T-001',JSON_ARRAY(10,12)),'targetValue',JSON_ARRAY('T-001','North',120000),
	'targetDimensions',JSON_ARRAY('T-001',50,50),'targetList',JSON_ARRAY('APT-001','T-001',1,'Immediate'),'strikeAssets',JSON_ARRAY('A1','Aircraft',1000),
	'resourcesRequired',JSON_ARRAY('APT-001','Aircraft',4)));

CALL populate_Targeting(JSON_OBJECT('targets',JSON_ARRAY('T-002','Ground Observer','2022-01-03')
	,'targetLocation',JSON_ARRAY('T-002',JSON_ARRAY(18,18)),'targetValue',JSON_ARRAY('T-002','South',125000),
	'targetDimensions',JSON_ARRAY('T-002',20,50),'targetList',JSON_ARRAY('APT-002','T-002',1,'Routine'),'strikeAssets',JSON_ARRAY('A2','Aircraft',1000),
	'resourcesRequired',JSON_ARRAY('APT-002','Aircraft',2)));

CALL populate_Targeting(JSON_OBJECT('targets',JSON_ARRAY('T-003','Satellite','2022-01-05')
	,'targetLocation',JSON_ARRAY('T-003',JSON_ARRAY(130,12)),'targetValue',JSON_ARRAY('T-003','East',125000),
	'targetDimensions',JSON_ARRAY('T-003',50,90),'targetList',JSON_ARRAY('APT-003','T-003',1,'Immediate'),'strikeAssets',JSON_ARRAY('S1','System',8000),
	'resourcesRequired',JSON_ARRAY('APT-003','System',4)));

CALL populate_Targeting(JSON_OBJECT('targets',JSON_ARRAY('T-004','Airborne Observer','2022-01-02')
	,'targetLocation',JSON_ARRAY('T-004',JSON_ARRAY(10,120)),'targetValue',JSON_ARRAY('T-004','North',180000),
	'targetDimensions',JSON_ARRAY('T-004',10,50),'targetList',JSON_ARRAY('APT-004','T-004',1,'High'),'strikeAssets',JSON_ARRAY('A3','Aircraft',1000),
	'resourcesRequired',JSON_ARRAY('APT-004','Aircraft',6)));

CALL populate_Targeting(JSON_OBJECT('targets',JSON_ARRAY('T-005','Satellite','2022-01-07')
	,'targetLocation',JSON_ARRAY('T-005',JSON_ARRAY(110,125)),'targetValue',JSON_ARRAY('T-005','West',160000),
	'targetDimensions',JSON_ARRAY('T-005',50,150),'targetList',JSON_ARRAY('APT-005','T-005',1,'Immediate'),'strikeAssets',JSON_ARRAY('S2','System',8000),
	'resourcesRequired',JSON_ARRAY('APT-005','System',2)));

