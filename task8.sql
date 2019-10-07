SET SERVEROUTPUT ON FORMAT WRAPPED
CREATE OR REPLACE PROCEDURE make_report
IS
CURSOR outer_cur IS
        SELECT DISTINCT skrok
        FROM zap_predmety
        ORDER BY skrok;
-- cursor with parameter
CURSOR inner_cur (syear number) IS
        SELECT DISTINCT cis_predm, nazov, meno, CASE 
                                                --some subjects don't have them
                                                WHEN priezvisko = 'Garant' THEN '?'
                                                ELSE priezvisko
                                                END
            FROM predmet_bod JOIN predmet USING (cis_predm)
            JOIN ucitel ON (predmet_bod.garant = ucitel.os_cislo)
            WHERE skrok = syear;
tmp1 number := 0;
ind number := 0;
inner_ind number := 0;
subject_id char(4);
subject_name varchar(180);
teacher_name varchar2(15);
teacher_surname varchar2(30);
BEGIN  
    OPEN outer_cur;
    LOOP
    FETCH outer_cur INTO tmp1;
    EXIT WHEN outer_cur%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Akademicky rok: ' || tmp1 || '/' || (tmp1+1));
        ind := 0;
        OPEN inner_cur(tmp1);
        LOOP
        FETCH inner_cur INTO subject_id, subject_name, teacher_name, teacher_surname;
        EXIT WHEN inner_cur%NOTFOUND;
        ind := ind + 1;
            DBMS_OUTPUT.PUT_LINE('.     Predmet:' || ind || '     ' || subject_id || '       ' || rpad(subject_name, 60)
            || ' Garant: ' || teacher_name || ' ' || teacher_surname);
            inner_ind := 0;
            FOR tmp3 in 
            (SELECT meno, priezvisko, os_cislo, 
                    CASE 
                    WHEN vysledok IS NOT NULL THEN vysledok
                    ELSE ' '
                    END AS grade,
                    CASE
                    WHEN rocnik IN (0, 1, 2, 3) THEN 'BC.'
                    WHEN rocnik IN (4, 5) THEN 'Ing.'
                    ELSE ''
                    END AS title
                FROM zap_predmety JOIN student USING (os_cislo)
                JOIN os_udaje USING (rod_cislo)
                WHERE skrok = tmp1 AND cis_predm = subject_id
                )
            LOOP
            inner_ind := inner_ind + 1;
                DBMS_OUTPUT.PUT_LINE('.     ' || inner_ind || '     ' 
                || rpad(CONCAT(tmp3.meno, CONCAT(' ', tmp3.priezvisko)), 30)
                || '  ' || tmp3.os_cislo || ' ' || tmp3.grade || '  ' || tmp3.title);
            END LOOP;
            
        END LOOP;
        CLOSE inner_cur;
    END LOOP;
    CLOSE outer_cur;
END;
/
BEGIN
    make_report;
END;
/