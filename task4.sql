SELECT os_cislo, ROUND(AVG(ects), 2)
    FROM zap_predmety
    GROUP BY os_cislo;
/
CREATE OR REPLACE PROCEDURE Get_average 
IS
    TYPE code_type IS TABLE of VARCHAR(10);
    TYPE average_type IS TABLE of NUMBER;
    cur1 code_type;
    cur2 average_type;
BEGIN  
   SELECT os_cislo, ROUND(AVG(ects), 2)
    BULK COLLECT INTO cur1, cur2
    FROM zap_predmety
    GROUP BY os_cislo;
    
    FOR j IN 1..cur1.COUNT
    LOOP
        DBMS_OUTPUT.PUT_LINE('Average of student with id ' || cur1 (j) || ' is ' || cur2 (j));
    END LOOP;
END; 
/
CREATE OR REPLACE PROCEDURE Get_average2 
IS
    CURSOR cur
        IS
        SELECT os_cislo, ROUND(AVG(ects), 2)
        FROM zap_predmety
        GROUP BY os_cislo;
    cur1 VARCHAR(10);
    cur2 NUMBER;
BEGIN  
    OPEN cur;
    LOOP
    FETCH cur INTO cur1, cur2;
    EXIT WHEN cur%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Average of student with id ' || cur1 || ' is ' || cur2);
    END LOOP;
    CLOSE cur;
END; 
/
CREATE OR REPLACE PROCEDURE Get_average3 
IS
    CURSOR cur
        IS
        SELECT os_cislo, ROUND(AVG(ects), 2) as average
        FROM zap_predmety
        GROUP BY os_cislo;
BEGIN  
    FOR tmp in cur
    
    LOOP
    DBMS_OUTPUT.PUT_LINE('Average of student with id ' || tmp.os_cislo || ' is ' || tmp.average);
    END LOOP;
END; 
/
CREATE OR REPLACE PROCEDURE Get_average4
IS
BEGIN  
    FOR tmp in 
    (SELECT os_cislo, ROUND(AVG(ects), 2) as average
        FROM zap_predmety
        GROUP BY os_cislo)
    LOOP
    DBMS_OUTPUT.PUT_LINE('Average of student with id ' || tmp.os_cislo || ' is ' || tmp.average);
    END LOOP;
END; 
/
BEGIN
    --Get_average;
    --Get_average2;
    --Get_average3;
    Get_average4;
END;
/