DROP TABLE USERS;

CREATE TABLE USERS ( 
     ID           VARCHAR2(20) CONSTRAINT USERS_ID_PK PRIMARY KEY,
     PASSWORD     VARCHAR2(100 CHAR) NOT NULL,
     ROLE         VARCHAR2(20  CHAR),
     NAME		  VARCHAR2(20  CHAR),
     PHONE_NUMBER CHAR(13 CHAR)
);

COMMIT;
