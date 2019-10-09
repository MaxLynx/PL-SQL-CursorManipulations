CREATE OR REPLACE TYPE person_type
AS OBJECT(
idno NUMBER,
first_name VARCHAR2(20),
last_name VARCHAR2(25),
email VARCHAR(30),
phone VARCHAR(15),
MAP MEMBER FUNCTION get_idno RETURN NUMBER, 
MEMBER PROCEDURE display_details ( SELF IN OUT NOCOPY person_type )
);
/
CREATE OR REPLACE TYPE BODY person_type AS
  MAP MEMBER FUNCTION get_idno RETURN NUMBER IS
  BEGIN
    RETURN idno;
  END;
  MEMBER PROCEDURE display_details ( SELF IN OUT NOCOPY person_type ) IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE(TO_CHAR(idno) || ' ' || first_name || ' ' || last_name);
    DBMS_OUTPUT.PUT_LINE(email || ' '  || phone);
  END;
END;
/
CREATE TABLE person OF person_type
(CONSTRAINT person_pk_constraint primary key (idno));
DESC person;
INSERT INTO person
VALUES(NEW person_type(1, 'Maksym', 'Zhyrov', 'zhirmax@ukr.net', '+42123456789'));
SELECT * FROM person;
SELECT VALUE(p) FROM person p;