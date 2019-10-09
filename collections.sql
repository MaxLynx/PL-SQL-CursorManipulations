SET SERVEROUTPUT ON
DECLARE
    TYPE t_pole IS VARRAY(10) OF INTEGER;
    TYPE t_table IS TABLE OF INTEGER;
    pole t_pole;
    nested_table t_table;
BEGIN
    pole := t_pole(2, 4, 5, 6, 98);
    nested_table := t_table(2, 4, 5, 6, 98);
    DBMS_OUTPUT.PUT_LINE(pole.count);
    DBMS_OUTPUT.PUT_LINE(pole.last);
    DBMS_OUTPUT.PUT_LINE(nested_table.count);
    DBMS_OUTPUT.PUT_LINE(nested_table.last);
    pole.extend(1);
    nested_table.extend(1);
    pole(6) := 8;
    nested_table(6) := 8;
    DBMS_OUTPUT.PUT_LINE(pole.last);
    DBMS_OUTPUT.PUT_LINE(nested_table.last);
    pole(3) := null;
    nested_table.delete(3, 4);
    
    FOR i IN nested_table.first..nested_table.last 
    LOOP
        IF nested_table.exists(i) THEN
            DBMS_OUTPUT.PUT_LINE(nested_table(i));
        END IF;
    END LOOP;
END;