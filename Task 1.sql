-- Database Creation
CREATE TABLE StudentInfo (
    STU_ID INT PRIMARY KEY,
    STU_NAME VARCHAR(50),
    DOB DATE,
    PHONE_NO VARCHAR(15),
    EMAIL_ID VARCHAR(100),
    ADDRESS VARCHAR(200)
);

CREATE TABLE CoursesInfo (
    COURSE_ID INT PRIMARY KEY,
    COURSE_NAME VARCHAR(50),
    COURSE_INSTRUCTOR_NAME VARCHAR(50)
);

CREATE TABLE Enrollmentinfo (
    ENROLLMENT_ID INT PRIMARY KEY,
    STU_ID INT,
    COURSE_ID INT,
    ENROLL_STATUS VARCHAR(20),
    FOREIGN KEY (STU_ID) REFERENCES StudentInfo(STU_ID),
    FOREIGN KEY (COURSE_ID) REFERENCES CoursesInfo(COURSE_ID)
);

-- Data Creation
-- Sample data for StudentInfo
INSERT INTO StudentInfo (STU_ID, STU_NAME, DOB, PHONE_NO, EMAIL_ID, ADDRESS)
VALUES
    (1, 'Miit Sajnani', '1999-12-27', '123-456-7890', 'miit@email.com', 'ABC Chennai road'),
    (2, 'Bhawya Puri', '2002-06-25', '987-654-3210', 'Bhawya@email.com', 'DEF Pondycherry road'),
	(3, 'Ganesh', '1996-10-25', '980-604-3010', 'Ganesh@email.com', 'PQR Bangalore road');

-- Sample data for CoursesInfo
INSERT INTO CoursesInfo (COURSE_ID, COURSE_NAME, COURSE_INSTRUCTOR_NAME)
VALUES
    (101, 'Math 101', 'Prof. Krish'),
    (102, 'Science 101', 'Prof. Keerthana');

-- Sample data for Enrollmentinfo
INSERT INTO Enrollmentinfo (ENROLLMENT_ID, STU_ID, COURSE_ID, ENROLL_STATUS)
VALUES
    (1, 1, 101, 'Enrolled'),
    (2, 1, 102, 'Enrolled'),
    (3, 2, 101, 'Enrolled');

-- Retrieve Student Information
-- a) Retrieve student details, including name, contact information, and enrollment status
SELECT SI.STU_NAME, SI.PHONE_NO, SI.EMAIL_ID, EI.ENROLL_STATUS
FROM StudentInfo SI
INNER JOIN Enrollmentinfo EI ON SI.STU_ID = EI.STU_ID;

-- b) Retrieve a list of courses in which a specific student is enrolled
SELECT CI.COURSE_NAME
FROM CoursesInfo CI
INNER JOIN Enrollmentinfo EI ON CI.COURSE_ID = EI.COURSE_ID
WHERE EI.STU_ID = 1;

-- c) Retrieve course information, including course name and instructor information
SELECT CI.COURSE_NAME, CI.COURSE_INSTRUCTOR_NAME
FROM CoursesInfo CI;

-- d) Retrieve course information for a specific course
SELECT CI.COURSE_NAME, CI.COURSE_INSTRUCTOR_NAME
FROM CoursesInfo CI
WHERE CI.COURSE_ID = 101;

-- e) Retrieve course information for multiple courses
SELECT CI.COURSE_NAME, CI.COURSE_INSTRUCTOR_NAME
FROM CoursesInfo CI
WHERE CI.COURSE_ID IN (101, 102);

-- f) Test the queries to ensure accurate retrieval of student information

-- Reporting and Analytics (Using Joining Queries)
-- a) Retrieve the number of students enrolled in each course
SELECT CI.COURSE_NAME, COUNT(EI.STU_ID) AS ENROLLED_STUDENTS
FROM CoursesInfo CI
LEFT JOIN Enrollmentinfo EI ON CI.COURSE_ID = EI.COURSE_ID
GROUP BY CI.COURSE_NAME;

-- b) Retrieve the list of students enrolled in a specific course
SELECT SI.STU_NAME
FROM StudentInfo SI
INNER JOIN Enrollmentinfo EI ON SI.STU_ID = EI.STU_ID
WHERE EI.COURSE_ID = 101;

-- c) Retrieve the count of enrolled students for each instructor
SELECT CI.COURSE_INSTRUCTOR_NAME, COUNT(EI.STU_ID) AS ENROLLED_STUDENTS
FROM CoursesInfo CI
LEFT JOIN Enrollmentinfo EI ON CI.COURSE_ID = EI.COURSE_ID
GROUP BY CI.COURSE_INSTRUCTOR_NAME;

-- d) Retrieve the list of students who are enrolled in multiple courses
SELECT SI.STU_NAME
FROM StudentInfo SI
INNER JOIN Enrollmentinfo EI ON SI.STU_ID = EI.STU_ID
GROUP BY SI.STU_ID
HAVING COUNT(EI.ENROLLMENT_ID) > 1;

-- e) Retrieve the courses that have the highest number of enrolled students
SELECT CI.COURSE_NAME, COUNT(EI.STU_ID) AS ENROLLED_STUDENTS
FROM CoursesInfo CI
LEFT JOIN Enrollmentinfo EI ON CI.COURSE_ID = EI.COURSE_ID
GROUP BY CI.COURSE_NAME
ORDER BY ENROLLED_STUDENTS DESC;
