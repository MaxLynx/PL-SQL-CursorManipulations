CREATE OR REPLACE FUNCTION Get_finished_subjects 
   (rodne_cislo IN varchar2) 
RETURN number
IS 
   subjects_count number;
BEGIN  
   SELECT COUNT(vysledok)
   INTO subjects_count
    FROM os_udaje JOIN student USING (rod_cislo)
    JOIN zap_predmety USING(os_cislo)
    WHERE rod_cislo = rodne_cislo
    AND vysledok IN ('A', 'B', 'C', 'D', 'E');
    DBMS_OUTPUT.PUT_LINE(subjects_count);
   RETURN(subjects_count);
END Get_finished_subjects; 
/
DECLARE
res number;
BEGIN
res := Get_finished_subjects('830914/7748');
res := Get_finished_subjects('840312/7845');
END;
/
select os_cislo, vysledok
from os_udaje join student using(rod_cislo)
join zap_predmety using(os_cislo)
where rod_cislo = '840312/7845' OR 
rod_cislo = '860907/1259' OR
rod_cislo = '841106/3456';
-- returns nothing so there is no problem for exception handling