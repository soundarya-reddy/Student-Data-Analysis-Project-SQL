CREATE DATABASE student_data;
USE student_data;

-- DATABASE STRUCTURE
CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50),
    duration_months INT
);

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    gender VARCHAR(10),
    course_id INT,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

CREATE TABLE Marks (
    mark_id INT PRIMARY KEY,
    student_id INT,
    subject VARCHAR(50),
    marks INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

CREATE TABLE Attendance (
    attendance_id INT PRIMARY KEY,
    student_id INT,
    attendance_percentage DECIMAL(5,2),
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

-- INSERT DATASET
INSERT INTO Courses VALUES
(101, 'Data Science', 6),
(102, 'Web Development', 4),
(103, 'Machine Learning', 8),
(104, 'Cloud Computing', 5),
(105, 'Cybersecurity', 3),
(106, 'Data Science', 6);

INSERT INTO Students VALUES
(1, 'Mona', 20, 'Female', 101),
(2, 'Rahul ', 21, 'Male', 102),
(3, 'ANITA', NULL, 'Female', 101),
(4, 'john', 22, 'Male', 103),
(5, 'Priya', 0, 'Female', 102),
(6, 'Amit', 21, '', 101),
(7, 'Neha', 20, 'Female', 105),
(8, 'Kiran', 23, 'Male', 104),
(9, 'Arjun', 22, 'Male', 104),   
(10, 'Sara', 21, 'Female', 105);

INSERT INTO Marks VALUES
(1, 1, 'SQL', 85),
(2, 1, 'Python', 90),

(3, 2, 'HTML', 78),
(4, 2, 'CSS', 82),

(5, 3, 'Machine Learning', 63),
(6, 3, 'Statistics', 88),

(7, 4, 'Cloud Fundamentals', 92),
(8, 4, 'Networking', 75),

(9, 5, 'Cybersecurity', 80),
(10, 5, 'Cryptography', 67),   

(11, 6, 'SQL', 70),
(12, 6, 'Python', 85),

(13, 7, 'HTML', 88),
(14, 7, 'JavaScript', 90),

(15, 8, 'Machine Learning', 95),
(16, 8, 'Statistics', 89),

(17, 9, 'Cloud Fundamentals', 85),
(18, 9, 'Security', 79),      

(19, 10, 'Cybersecurity', 78),
(20, 10, 'Ethical Hacking', 83);

INSERT INTO Attendance VALUES
(1, 1, 85.50),
(2, 2, 95.00),
(3, 3, NULL),   
(4, 4, 120.00),   
(5, 5, -5.00),   
(6, 6, 70.25),
(7, 7, 60.00),
(8, 8, 88.75),
(9, 9, 92.00),
(10, 10, 0.00);   

-- DATA CLEANING 
SET sql_safe_updates =0;

DELETE c1 
FROM Courses c1 
JOIN Courses c2 
ON c1.course_name = c2.course_name 
AND c1.course_id > c2.course_id ;

UPDATE Students
SET name = TRIM(LOWER(name));

UPDATE Students
SET gender = 'Unknown'
WHERE gender = "" OR gender IS NOT NULL;

UPDATE Students
SET age = (
    SELECT ROUND(avg_age)
    FROM (
        SELECT AVG(age) AS avg_age
        FROM Students
    ) tmp
)
WHERE age IS NULL or age = 0;
 
UPDATE Attendance
SET attendance_percentage = NULL
WHERE attendance_percentage < 0 
   OR attendance_percentage > 100
   OR attendance_percentage = 0;
   
UPDATE Attendance
SET attendance_percentage = (
    SELECT avg_val
    FROM (
        SELECT ROUND(AVG(attendance_percentage),2) AS avg_val 
        FROM Attendance
    ) t
)
WHERE attendance_percentage IS NULL;

-- QUERIES

SELECT * FROM Students;

-- Find total number of students
SELECT COUNT(*) AS Total_Student
FROM Students;

-- Find average marks of all students
SELECT ROUND(AVG(marks),2) AS avg_marks
FROM Marks;

-- Find average marks of each student
SELECT student_id ,ROUND(AVG(marks),2) AS avg_marks
FROM Marks
GROUP BY student_id;

-- find Top 5 Students
SELECT student_id ,ROUND(AVG(marks),2) AS avg_marks
FROM marks
GROUP BY student_id
ORDER BY avg_marks DESC
LIMIT 5;

-- List students who have attendance less than 75%
SELECT s.name, a.attendance_percentage
FROM Students s
JOIN Attendance a ON s.student_id = a.student_id
WHERE a.attendance_percentage < 75;

-- Find total students in each course
SELECT c.course_name, COUNT(s.student_id) AS total_students
FROM Students s
JOIN Courses c ON s.course_id = c.course_id
GROUP BY c.course_name;

-- Find subject-wise average marks
SELECT subject, ROUND(AVG(marks),2) AS avg_marks
FROM Marks
GROUP BY subject;

-- Find highest marks in each subject
SELECT subject, max(marks) AS highest_marks
FROM Marks
GROUP BY subject;

-- Find students whose marks are above overall average
SELECT student_id ,ROUND(AVG(marks),2) AS avg_marks
FROM Marks
GROUP BY student_id
HAVING AVG(marks) > (SELECT AVG(marks) FROM Marks);

-- Rank students based on average marks
SELECT student_id, avg_marks,
RANK() OVER (ORDER BY avg_marks DESC) AS student_rank
FROM (
    SELECT student_id,
	AVG(marks) AS avg_marks
    FROM Marks
    GROUP BY student_id
) t;

-- Show student name, course name, subject, and marks
SELECT s.name,c.course_name, m.subject, m.marks 
FROM Students AS s
JOIN courses AS c ON s.course_id = c.course_id
JOIN marks AS m ON s.student_id = m.student_id;

-- Show student name,average marks and attendance_percentage
SELECT s.name, 
       ROUND(AVG(m.marks),2) AS avg_marks,
       a.attendance_percentage
FROM Students s
JOIN Marks m ON s.student_id = m.student_id
JOIN Attendance a ON s.student_id = a.student_id
GROUP BY s.name, a.attendance_percentage
ORDER BY  a.attendance_percentage DESC;


-- Find top student in each subject
SELECT *
FROM (
    SELECT subject, student_id, marks,
    RANK() OVER (PARTITION BY subject ORDER BY marks DESC) AS rnk
    FROM Marks
) t
WHERE rnk = 1;

-- Running Total of Marks for Each Student
SELECT student_id,subject, marks,
    SUM(marks) OVER (PARTITION BY student_id ORDER BY mark_id)
    AS running_total
FROM Marks;
