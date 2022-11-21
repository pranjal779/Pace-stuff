c fn sigm5( a INT ........)
Returns DECIMA(10, 2)
Deterministic

begin
    declare n decimal(10,2);
    set n = sqrt(varience(a,b.....))
    return n;
end //
delimiter ;

select sigma5(1,2,3,5..) AS MSG
