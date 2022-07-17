-- 16.
DECLARE
    counter NUMBER := 0;
BEGIN
    LOOP
        counter := counter + 1;
        DBMS_OUTPUT.PUT_LINE(counter);
        IF counter = 5 THEN
            EXIT;
        END IF;
    END LOOP;
END;
/

-- 17.
DECLARE
    counter NUMBER := 0;
BEGIN
    LOOP
        counter := counter + 1;
        DBMS_OUTPUT.PUT_LINE(counter);
        EXIT WHEN counter = 5;
    END LOOP;
END;
/

-- 18.
<<outer_loop>>
DECLARE
    var NUMBER := 0;
BEGIN

    LOOP
        <<inner_loop>>
        DECLARE
            var number := 0;
        BEGIN
            LOOP

                DBMS_OUTPUT.PUT_LINE(outer_loop.var || ' ' || inner_loop.var);
                inner_loop.var := inner_loop.var + 1;

                EXIT WHEN inner_loop.var = 6;
            END LOOP;
        END;
        outer_loop.var := outer_loop.var + 1;

        EXIT WHEN outer_loop.var = 3;
    END LOOP;
END;

-- 19.
DECLARE
    factorial NUMBER;
    counter NUMBER;
    temporal_variable NUMBER;
BEGIN
    counter := 10;
    factorial := 1;
    temporal_variable := factorial;

    WHILE counter > 0
    LOOP
        temporal_variable := temporal_variable * counter;
        DBMS_OUTPUT.PUT_LINE(counter || '   ' || temporal_variable);
        counter := counter - 1;
    END LOOP;

    factorial := temporal_variable;
    DBMS_OUTPUT.PUT_LINE(factorial);
END;
/

-- 20.
DECLARE
    counter NUMBER;
BEGIN
    FOR counter IN 1..10 LOOP
        DBMS_OUTPUT.PUT_LINE(counter);
    END LOOP;
END;
/

-- 21.
DECLARE
    counter NUMBER;
BEGIN
    FOR counter IN REVERSE 1 .. 10
    LOOP
        DBMS_OUTPUT.PUT_LINE(counter);
    END LOOP;
END;
/