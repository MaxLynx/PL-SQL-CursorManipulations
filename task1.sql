--amount of subjects that were repeated (not a total count of such repeats)
SELECT COUNT(DISTINCT cis_predm) as repeated_count
FROM zap_predmety
WHERE cis_predm IN (
        SELECT cis_predm
        FROM zap_predmety
        WHERE os_cislo = 500422
        GROUP BY os_cislo, cis_predm
        HAVING COUNT(cis_predm) > 1
);
SET SERVEROUTPUT ON
CREATE OR REPLACE FUNCTION Get_pocet_opakovani
(personal_number NUMBER)
RETURN NUMBER
IS
repeated_count NUMBER;
BEGIN
SELECT COUNT(DISTINCT cis_predm)
INTO repeated_count
FROM zap_predmety
WHERE cis_predm IN (
        SELECT cis_predm
        FROM zap_predmety
        WHERE os_cislo = personal_number
        GROUP BY os_cislo, cis_predm
        HAVING COUNT(cis_predm) > 1
);
DBMS_OUTPUT.PUT_LINE(repeated_count);
RETURN repeated_count;
END Get_pocet_opakovani;
/
DECLARE
res number;
BEGIN
res := Get_pocet_opakovani(500422);
END;
/
SELECT Get_pocet_opakovani(500422) FROM dual;