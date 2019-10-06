SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE Get_average4
IS
ind number := 0;
last_avg number := 0;
BEGIN  
    FOR tmp in 
    (SELECT os_cislo, ROUND(AVG(ects), 1) as average
        FROM zap_predmety
        GROUP BY os_cislo
        ORDER BY average)
    LOOP
    ind := ind + 1;
    IF ((ind > 10) AND (tmp.average <> last_avg)) THEN EXIT;
    END IF;
    DBMS_OUTPUT.PUT_LINE(ind || '. Average of student with id ' || tmp.os_cislo || ' is ' || tmp.average);
    IF ind = 10 THEN last_avg := tmp.average;
    END IF;
    END LOOP;
END; 
/
BEGIN
    Get_average4;
END;
/