SET @A = 'Hello pran';
SET @B = 20;
SET @C = DATE '2021-09-09';
SET @D = '2021-09-09';
SET @E_vALUE = b'1001'+0;
SET @F_true = TRUE;
SET @F_false = FALSE;
SET @G = NULL;
SET @G_Null;
SET @G_NoValue = '';

SELECT @A AS a;
SELECT @B AS b;
SELECT @C AS c;
SELECT @D AS d;

SELECT @E_Value AS e;
# 1 IS TRUE 0 IS FALSE
SELECT @F_true AS ft;
SELECT @F_false AS ff;
# ALL OF THESE ARE NULL
SELECT @G AS g;
SELECT @G_Null AS e;
SELECT @G_NoValue AS gnv;
