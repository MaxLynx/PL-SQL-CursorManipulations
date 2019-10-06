DECLARE
subject_number CHAR(4);
subject_name VARCHAR2(100);
BEGIN
SELECT nazov
INTO subject_name
FROM predmet
WHERE cis_predm = '&subject_number';
DBMS_OUTPUT.PUT_LINE(subject_name);
exception
when others
then DBMS_OUTPUT.PUT_LINE('NO SUBJECT');
END;
/
DECLARE
subject_number CHAR(4);
subject_name VARCHAR2(100);
not_exist_exc EXCEPTION;
PRAGMA EXCEPTION_INIT(not_exist_exc, 100);
BEGIN
SELECT nazov
INTO subject_name
FROM predmet
WHERE cis_predm = '&subject_number';
DBMS_OUTPUT.PUT_LINE(subject_name);
exception
when not_exist_exc
then DBMS_OUTPUT.PUT_LINE('NO SUBJECT');
END;
/