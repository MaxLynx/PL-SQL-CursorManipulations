--1) parameters
--2) dlzka
--3) skuska or zapocet
--4) format and to login.txt
SELECT * FROM student;
SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE make_report
IS
CURSOR outer_cur IS
        SELECT DISTINCT skrok
        FROM zap_predmety
        ORDER BY skrok;
tmp1 number := 0;
ind number := 0;
inner_ind number := 0;
BEGIN  
    OPEN outer_cur;
    LOOP
    FETCH outer_cur INTO tmp1;
    EXIT WHEN outer_cur%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Akademicky rok: ' || tmp1 || '/' || (tmp1+1));
        ind := 0;
        FOR tmp2 in 
        (SELECT DISTINCT cis_predm, nazov, meno, priezvisko
            FROM predmet_bod JOIN predmet USING (cis_predm)
            JOIN ucitel ON (predmet_bod.garant = ucitel.os_cislo)
            WHERE skrok = tmp1
            )
        LOOP
        ind := ind + 1;
            DBMS_OUTPUT.PUT_LINE('.     Predmet:' || ind || '     ' || tmp2.cis_predm || '       ' || tmp2.nazov
            || '        Garant: ' || tmp2.meno || ' ' || tmp2.priezvisko);
            inner_ind := 0;
            FOR tmp3 in 
            (SELECT meno, priezvisko, os_cislo, vysledok
                FROM zap_predmety JOIN student USING (os_cislo)
                JOIN os_udaje USING (rod_cislo)
                WHERE skrok = tmp1 AND cis_predm = tmp2.cis_predm
                )
            LOOP
            inner_ind := inner_ind + 1;
                DBMS_OUTPUT.PUT_LINE('.     ' || inner_ind || '     ' || tmp3.meno || ' ' || tmp3.priezvisko
                || '        ' || tmp3.os_cislo || ' ' || tmp3.vysledok);
            END LOOP;
            
        END LOOP;
    END LOOP;
    CLOSE outer_cur;
END; 
/
BEGIN
    make_report;
END;
/