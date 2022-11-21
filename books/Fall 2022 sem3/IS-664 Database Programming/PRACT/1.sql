DROP DATABASE IF EXISTS PACESTUDENT;
CREATE DATABASE PACESTUDENT;
USE PACESTUDENT;

CREATE TABLE STUDENT2(
StudentID VARCHAR(6),
LastName VARCHAR(20),
FirstName VARCHAR(10),
Age INT(5),
Gender VARCHAR(20),
Major VARCHAR(10),
CONSTRAINT PK_STUDENT2 PRIMARY KEY (StudentID)
);

DESCRIBE TABLE STUDENT2;


INSERT INTO STUDENT2 (StudentID, LastName, FirstName, Age, Gender, Major) VALUES
    ('U0001', 'Anderson', 'Donald', 23, 'Male', 'CS'),
    ('U0002', 'Banker', 'Erica', 24, 'Female', 'IS');


SELECT * FROM STUDENT2;

CREATE TABLE MealPlan(
    StudentMP VARCHAR(10),
    MealPlanCode VARCHAR(10),
    -- StudentID VARCHAR(10),
    PRIMARY KEY (StudentMP),
    CONSTRAINT FK_MealPlan FOREIGN KEY (StudentMP) REFERENCES STUDENT2(StudentID)
);

DESCRIBE TABLE MealPlan;


INSERT INTO MealPlan (StudentMP, MealPlanCode) VALUES
    ('U0001', 'A678'),
    ('U0002', 'B789');

SELECT * FROM MealPlan;
