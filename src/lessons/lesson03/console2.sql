CREATE TABLE students (
                          student_id SERIAL PRIMARY KEY,
                          first_name VARCHAR(50) NOT NULL,
                          last_name VARCHAR(50) NOT NULL,
                          birth_date DATE NOT NULL,
                          email VARCHAR(100) UNIQUE,
                          group_id INT NOT NULL
);



INSERT INTO students (first_name, last_name, birth_date, email, group_id) VALUES
                                                                              ('Lappland', 'Lapp', '2005-03-15', 'lappland@example.com', 1),
                                                                              ('Amiya', 'Am', '2004-07-22', 'amiya@example.com', 1),
                                                                              ('Doctor', 'Doc', '2005-03-15', 'doctor@example.com', 2),
                                                                              ('Bleamshine', 'Bleam', '2005-01-10', 'bleamshine@example.com', 1),
                                                                              ('Nearl', 'The Knight', '2004-07-22', 'nearl@example.com', 3),
                                                                              ('Knight', 'Of Dusk', '2006-05-08', 'knightofdusk@example.com', 2),
                                                                              ('Sea', 'Sign', '2005-03-15', 'seasign@example.com', 3),
                                                                              ('Mariya', 'Linetta', '2005-11-30', 'mariyalinetta@example.com', 1),
                                                                              ('Bleamshine', 'Bleam', '2005-01-10', 'bleamshine2@example.com', 1),
                                                                              ('Doctor', 'Doc', '2005-03-15', 'doctor2@example.com', 2);


-- ------------------------------------------------

SELECT student_id, first_name, last_name, birth_date, email, group_id
FROM students
WHERE (first_name, last_name) IN (
    SELECT first_name, last_name
    FROM students
    GROUP BY first_name, last_name
    HAVING COUNT(*) > 1
)
ORDER BY first_name, last_name, student_id;

-- ------------------------------------------------

DELETE FROM students
WHERE student_id NOT IN (
    SELECT MIN(student_id)
    FROM students
    GROUP BY first_name, last_name
)
  AND (first_name, last_name) IN (
    SELECT first_name, last_name
    FROM students
    GROUP BY first_name, last_name
    HAVING COUNT(*) > 1
);


SELECT * FROM students
ORDER BY first_name, last_name, student_id;