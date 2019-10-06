SET SERVEROUTPUT ON
--Get_average7(10, 2) znamena ze od tretieho do 12ho alebo viac, ak 13. bude mat tu istu znamku co 12. atd.
CREATE OR REPLACE PROCEDURE Get_average7
(user_limit IN number, user_offset IN number)
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
    IF ((ind > user_limit + user_offset) AND (tmp.average <> last_avg)) THEN EXIT;
    END IF;
        IF ind > user_offset THEN
        DBMS_OUTPUT.PUT_LINE(ind || '. Average of student with id ' || tmp.os_cislo || ' is ' || tmp.average);
        END IF;
    IF ind = user_limit + user_offset THEN last_avg := tmp.average;
    END IF;
    END LOOP;
END; 
/
BEGIN
    Get_average7(12, 2);
END;
/