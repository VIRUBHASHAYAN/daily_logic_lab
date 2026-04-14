create database SchoolDB;

CREATE TABLE students (
    student_id   INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(50),
    class        VARCHAR(10),
    city         VARCHAR(30)
);
INSERT INTO students VALUES
(1, 'Ananya',  '10A', 'Chennai'),
(2, 'Rohit',   '10B', 'Mumbai'),
(3, 'Priya',   '10A', 'Delhi'),
(4, 'Karthik', '10B', 'Bangalore'),
(5, 'Sneha',   '10A', 'Chennai');

CREATE TABLE teachers (
    teacher_id   INT PRIMARY KEY AUTO_INCREMENT,
    teacher_name VARCHAR(50),
    department   VARCHAR(30),
    salary       DECIMAL(8,2)
);

INSERT INTO teachers VALUES
(1, 'Mr. Sharma',  'Science',  55000),
(2, 'Ms. Rao',     'Maths',    62000),
(3, 'Mr. Nair',    'English',  48000),
(4, 'Ms. Verma',   'Science',  58000),
(5, 'Mr. Das',     'Maths',    62000);

CREATE TABLE exams (
    exam_id    INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    subject    VARCHAR(30),
    marks      INT,
    exam_date  DATE,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

INSERT INTO exams VALUES
(1, 1, 'Maths',   88, '2024-03-01'),
(2, 2, 'Maths',   76, '2024-03-01'),
(3, 3, 'Maths',   88, '2024-03-01'),
(4, 4, 'Maths',   91, '2024-03-01'),
(5, 5, 'Maths',   60, '2024-03-01'),
(6, 1, 'Science', 74, '2024-03-05'),
(7, 2, 'Science', 85, '2024-03-05'),
(8, 3, 'Science', 90, '2024-03-05'),
(9, 4, 'Science', 78, '2024-03-05'),
(10,5, 'Science', 85, '2024-03-05');

CREATE TABLE fees (
    fee_id     INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    amount     DECIMAL(8,2),
    paid_date  DATE,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

INSERT INTO fees VALUES
(1, 1, 12000, '2024-01-10'),
(2, 2,  8000, '2024-01-15'),
(3, 3, 15000, '2024-02-05'),
(4, 4,  8000, '2024-02-20'),
(5, 5, 12000, '2024-03-01');

# Problem 1 — RANK() : Rank students by marks within each subject

SELECT
    s.student_name,
    e.subject,
    e.marks,
    RANK() OVER (
        PARTITION BY e.subject
        ORDER BY e.marks DESC
    ) AS rank_in_subject
FROM exams e
JOIN students s ON e.student_id = s.student_id;

# Problem 2 — DENSE_RANK() : Rank teachers by salary within each department

SELECT
    teacher_name,
    department,
    salary,
    DENSE_RANK() OVER (
        PARTITION BY department
        ORDER BY salary DESC
    ) AS salary_rank
FROM teachers;

# Problem 3 — SUM() OVER() : Running total of fees collected (ordered by date)

SELECT
    s.student_name,
    f.paid_date,
    f.amount,
    SUM(f.amount) OVER (
        ORDER BY f.paid_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM fees f
JOIN students s ON f.student_id = s.student_id;

# Problem 4 — AVG() OVER() + COUNT() OVER() : Compare each student's marks to the subject average

SELECT
    s.student_name,
    e.subject,
    e.marks,
    ROUND(AVG(e.marks) OVER (
        PARTITION BY e.subject
    ), 2) AS subject_avg,
    COUNT(*) OVER (
        PARTITION BY e.subject
    ) AS students_appeared,
    e.marks - AVG(e.marks) OVER (
        PARTITION BY e.subject
    ) AS diff_from_avg
FROM exams e
JOIN students s ON e.student_id = s.student_id;

# LAG() + LEAD() : Compare each fee payment to the one before and after it
SELECT
    s.student_name,
    f.paid_date,
    f.amount,
    LAG(f.amount)  OVER (ORDER BY f.paid_date) AS prev_payment,
    LEAD(f.amount) OVER (ORDER BY f.paid_date) AS next_payment
FROM fees f
JOIN students s ON f.student_id = s.student_id;

# ------------------- TASK 1 completed  ---------------------------
# Procedure 1 — No Parameters : Get all students with their total marks

DELIMITER $$

CREATE PROCEDURE GetAllStudentResults()
BEGIN
    SELECT
        s.student_name,
        s.class,
        SUM(e.marks)   AS total_marks,
        ROUND(AVG(e.marks), 2) AS average_marks
    FROM students s
    JOIN exams e ON s.student_id = e.student_id
    GROUP BY s.student_id, s.student_name, s.class
    ORDER BY total_marks DESC;
END $$
DELIMITER ;
CALL GetAllStudentResults();

# Procedure 2 — Input Parameters : Get marks for a specific student

DELIMITER $$

CREATE PROCEDURE GetStudentMarks(
    IN p_student_id INT
)
BEGIN
    SELECT
        s.student_name,
        e.subject,
        e.marks,
        e.exam_date
    FROM exams e
    JOIN students s ON e.student_id = s.student_id
    WHERE e.student_id = p_student_id
    ORDER BY e.exam_date;
END $$

DELIMITER ;

CALL GetStudentMarks(1);

# Procedure 3 — Input + Output Parameters : Get subject average and return student count

DELIMITER $$

CREATE PROCEDURE GetSubjectStats(
    IN  p_subject   VARCHAR(30),
    OUT p_count     INT
)
BEGIN
    SELECT COUNT(*)
    INTO   p_count
    FROM   exams
    WHERE  subject = p_subject;
    SELECT
        s.student_name,
        e.marks,
        ROUND(AVG(e.marks) OVER (), 2)  AS subject_avg,
        RANK() OVER (ORDER BY e.marks DESC) AS rank_in_subject
    FROM exams e
    JOIN students s ON e.student_id = s.student_id
    WHERE e.subject = p_subject;
END $$

DELIMITER ;
CALL GetSubjectStats('Maths', @cnt);
SELECT @cnt AS total_students_appeared;