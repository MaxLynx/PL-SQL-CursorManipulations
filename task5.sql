CREATE OR REPLACE PROCEDURE Get_average4
IS
ind number := 0;
BEGIN  
    FOR tmp in 
    (SELECT os_cislo, ROUND(AVG(ects), 2) as average
        FROM zap_predmety
        GROUP BY os_cislo
        ORDER BY average)
    LOOP
    ind := ind + 1;
    DBMS_OUTPUT.PUT_LINE(ind || '. Average of student with id ' || tmp.os_cislo || ' is ' || tmp.average);
    IF ind = 10 THEN EXIT;
    END IF;
    END LOOP;
END; 
/
BEGIN
    Get_average4;
END;
/