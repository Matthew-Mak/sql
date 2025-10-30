CREATE TABLE students (
                          student_id INT PRIMARY KEY,
                          full_name VARCHAR(100),
                          age INT,
                          group_id INT
);

CREATE TABLE groups (
                        group_id INT PRIMARY KEY,
                        group_name VARCHAR(50)
);

CREATE TABLE subjects (
                          subject_id INT PRIMARY KEY,
                          subject_name VARCHAR(50)
);

CREATE TABLE grades (
                        grade_id INT PRIMARY KEY,
                        student_id INT,
                        subject_id INT,
                        grade INT,
                        FOREIGN KEY (student_id) REFERENCES students(student_id),
                        FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);

-- --------------------------------------------------------------------------------------


INSERT INTO groups (group_id, group_name) VALUES
                                              (1, 'OP Reserve Team A1'),
                                              (2, 'OP Reserve Team A2'),
                                              (3, 'OP Reserve Team A3'),
                                              (4, 'OP Reserve Team A4');

INSERT INTO subjects (subject_id, subject_name) VALUES
                                                    (1, 'Математика'),
                                                    (2, 'Физика'),
                                                    (3, 'Базы Данных'),
                                                    (4, 'Робототехника'),
                                                    (5, 'Оперативные Системы');

INSERT INTO students (student_id, full_name, age, group_id) VALUES
                                                                (1, 'Amiya Am', 20, 1),
                                                                (2, 'Doctor Doc', 19, 1),
                                                                (3, 'Bleamshine Bleam', 21, 2),
                                                                (4, 'Knight Of Dusk', 20, 2),
                                                                (5, 'Sea Sign', 22, 1),
                                                                (6, 'Linz Sato', 19, 3),
                                                                (7, 'Ruppert Undead', 20, 3),
                                                                (8, 'Ivi Miller', 21, 4),
                                                                (9, 'Phazies Thal', 20, 1),
                                                                (10, 'Zilfaton Kirvesmason', 22, 2);

INSERT INTO grades (grade_id, student_id, subject_id, grade) VALUES
                                                                 (1, 1, 1, 9),
                                                                 (2, 1, 2, 8),
                                                                 (3, 1, 3, 7),
                                                                 (4, 2, 1, 10),
                                                                 (5, 2, 2, 9),
                                                                 (6, 2, 4, 8),
                                                                 (7, 3, 1, 8),
                                                                 (8, 3, 2, 7),
                                                                 (9, 3, 5, 9),
                                                                 (10, 4, 2, 9),
                                                                 (11, 4, 3, 8),
                                                                 (12, 4, 4, 9),
                                                                 (13, 5, 1, 7),
                                                                 (14, 5, 5, 8),
                                                                 (15, 6, 3, 6),
                                                                 (16, 6, 4, 7),
                                                                 (17, 7, 1, 9),
                                                                 (18, 7, 2, 8),
                                                                 (19, 8, 4, 10),
                                                                 (20, 8, 5, 9),
                                                                 (21, 9, 1, 8),
                                                                 (22, 9, 3, 7),
                                                                 (23, 10, 2, 8),
                                                                 (24, 10, 5, 9);

-- --------------------------------------------------------------------------------------

SELECT COUNT(*) as total_students
FROM students;

-- --------------------------------------------------------------------------------------

SELECT ROUND(AVG(age), 2) as average_age
FROM students;

-- --------------------------------------------------------------------------------------

SELECT MIN(age) as min_age, MAX(age) as max_age
FROM students;

-- --------------------------------------------------------------------------------------

SELECT COUNT(*) as total_grades
FROM grades;

-- --------------------------------------------------------------------------------------

SELECT g.group_id, g.group_name, COUNT(s.student_id) as student_count
FROM groups g
         LEFT JOIN students s ON g.group_id = s.group_id
GROUP BY g.group_id, g.group_name
ORDER BY g.group_id;

-- --------------------------------------------------------------------------------------


SELECT g.group_id, g.group_name, ROUND(AVG(s.age), 2) as average_age
FROM groups g
         LEFT JOIN students s ON g.group_id = s.group_id
GROUP BY g.group_id, g.group_name
ORDER BY g.group_id;

-- --------------------------------------------------------------------------------------


SELECT s.subject_id, s.subject_name, ROUND(AVG(g.grade), 2) as average_grade
FROM subjects s
         LEFT JOIN grades g ON s.subject_id = g.subject_id
GROUP BY s.subject_id, s.subject_name
ORDER BY s.subject_id;

-- --------------------------------------------------------------------------------------


SELECT s.subject_id, s.subject_name, COUNT(DISTINCT g.student_id) as student_count
FROM subjects s
         LEFT JOIN grades g ON s.subject_id = g.subject_id
GROUP BY s.subject_id, s.subject_name
ORDER BY s.subject_id;

-- --------------------------------------------------------------------------------------


SELECT g.group_id, g.group_name, COUNT(s.student_id) as student_count
FROM groups g
         LEFT JOIN students s ON g.group_id = s.group_id
GROUP BY g.group_id, g.group_name
HAVING COUNT(s.student_id) > 1
ORDER BY student_count DESC;

-- --------------------------------------------------------------------------------------


SELECT s.subject_id, s.subject_name, ROUND(AVG(g.grade), 2) as average_grade
FROM subjects s
         LEFT JOIN grades g ON s.subject_id = g.subject_id
GROUP BY s.subject_id, s.subject_name
HAVING AVG(g.grade) > 8
ORDER BY average_grade DESC;

-- --------------------------------------------------------------------------------------


SELECT s.student_id, s.full_name, ROUND(AVG(g.grade), 2) as average_grade
FROM students s
         LEFT JOIN grades g ON s.student_id = g.student_id
GROUP BY s.student_id, s.full_name
HAVING AVG(g.grade) > 8.5
ORDER BY average_grade DESC;

