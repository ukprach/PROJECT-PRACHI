-- 1. Database Setup
CREATE DATABASE student_database;
\c student_database;

-- 2. Create student_table
CREATE TABLE student_table (
    Student_id serial PRIMARY KEY,
    Stu_name text,
    Department text,
    email_id text,
    Phone_no numeric,
    Address text,
    Date_of_birth date,
    Gender text,
    Major text,
    GPA numeric,
    Grade text
);

-- 3. Data Entry
INSERT INTO student_table (Stu_name, Department, email_id, Phone_no, Address, Date_of_birth, Gender, Major, GPA, Grade)
VALUES
    ('Miit Doe', 'Computer Science', 'Miit@example.com', 1234567890, '123 Main St', '1999-05-15', 'Male', 'Computer Science', 3.8, 'B'),
    ('Bhawya Smith', 'Mathematics', 'Bhawya@example.com', 9876543210, '456 Elm St', '2000-08-20', 'Female', 'Math', 4.2, 'A'),
    ('John Johnson', 'Physics', 'John@example.com', 5555555555, '789 Oak St', '1998-03-10', 'Male', 'Physics', 3.5, 'C'),
    ('Balaji Lee', 'Biology', 'Balaji@example.com', 3333333333, '567 Pine St', '2001-01-05', 'Female', 'Biology', 4.5, 'A'),
    ('David Brown', 'Chemistry', 'david@example.com', 4444444444, '345 Birch St', '1997-11-25', 'Male', 'Chemistry', 3.9, 'B'),
    ('Emily White', 'History', 'emily@example.com', 6666666666, '234 Cedar St', '1999-09-15', 'Female', 'History', 4.0, 'B'),
    ('Keerti Davis', 'Economics', 'Keerti@example.com', 7777777777, '432 Maple St', '2000-07-30', 'Male', 'Economics', 3.7, 'C'),
    ('Olivia Taylor', 'Psychology', 'olivia@example.com', 9999999999, '543 Walnut St', '1998-12-05', 'Female', 'Psychology', 4.3, 'A'),
    ('Krish Wilson', 'Political Science', 'krish@example.com', 8888888888, '876 Redwood St', '1996-04-18', 'Male', 'Political Science', 3.4, 'C'),
    ('Monica Anderson', 'English', 'Monica@example.com', 2222222222, '321 Cedar St', '2000-06-20', 'Female', 'English', 4.1, 'B');

-- 3. Student Information Retrieval
SELECT *
FROM student_table
ORDER BY Grade DESC;

-- 4. Query for Male Students
SELECT *
FROM student_table
WHERE Gender = 'Male';

-- 5. Query for Students with GPA less than 5.0
SELECT *
FROM student_table
WHERE GPA < 5.0;

-- 6. Update Student Email and Grade
UPDATE student_table
SET email_id = 'newemail@example.com', Grade = 'A'
WHERE Student_id = 1; -- Update the student with the specific ID

-- 7. Query for Students with Grade "B"
SELECT Stu_name, EXTRACT(YEAR FROM age(Date_of_birth)) AS Age
FROM student_table
WHERE Grade = 'B';

-- 8. Grouping and Calculation
SELECT Department, Gender, AVG(GPA) AS Average_GPA
FROM student_table
GROUP BY Department, Gender;

-- 9. Table Renaming
ALTER TABLE student_table RENAME TO student_info;

-- 10. Retrieve Student with Highest GPA
SELECT Stu_name
FROM student_info
ORDER BY GPA DESC
LIMIT 1;
