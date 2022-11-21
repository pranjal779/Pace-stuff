Begin
    declare my decimal(10,2);
    set mu = 0;
    set i = 0;
    while i < json(a) do
        set mu = mu + json_extract(a, concat('$[',I,']'));
        set i = i + 1;
    end while;
    set mu = mu / json_lenght(a);
    return mu;

