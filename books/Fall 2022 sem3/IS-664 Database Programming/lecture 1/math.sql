SET @A = 10;
SET @B = 20;
SET @C = 8;

SET @AB = @A * @B;
SET @A_C = @A - @C;
SET @SumAB = @A + @B;
SET @Div_AC = @A / @C;
SET @IntDiv_AC = @A DIV @C;
SET @MODac = @A MOD @C;
SET @ModAC = @A MOD @C;
SET @ModAC1 = @A % @C;

SELECT @AB AS V1;
SELECT @A_C AS V2;
SELECT @SumAB AS V3;
SELECT @Div_AC AS V4;
SELECT @IntDiv_AC AS V5;
SELECT @ModAC AS V6;
SELECT @ModAC1 AS V7;