CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    dob DATE NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE fees (
    fee_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(student_id),
    amount NUMERIC(10, 2) NOT NULL,
    payment_date DATE,
    payment_method VARCHAR(50)
);

CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    course_code VARCHAR(10)
);

CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(student_id),
    enrollment_date DATE NOT NULL
);

CREATE TABLE lecturers (
    lecturer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE lecturer_course_assignment (
    lecturer_assignment_id SERIAL PRIMARY KEY,
    lecturer_id INT REFERENCES lecturers(lecturer_id),
    course_id INT REFERENCES courses(course_id)
);

CREATE TABLE tas (
    ta_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE lecturer_ta_assignment (
    ta_assignment_id SERIAL PRIMARY KEY,
    lecturer_id INT REFERENCES lecturers(lecturer_id),
    ta_id INT REFERENCES tas(ta_id)
);

INSERT INTO students (first_name, last_name, dob, email)
VALUES
('Sena', 'Anyomi', '2004-07-14', 'sdanyomi@st.ug.edu.gh'),
('Nhyira', 'Nsaako', '2004-08-20', 'annsaako@st.ug.edu.gh'),
('Ishaan', 'Bhardwaj', '2005-03-25', 'ibhardwaj@st.ug.edu.gh'),
('Samia', 'Solemani', '2004-12-10', 'ssolemani@st.ug.edu.gh'),
('Adwoa', 'Dabanka', '2004-06-14', 'hmagdabanka@st.ug.edu.gh');

INSERT INTO fees (student_id, amount, payment_date, payment_method)
VALUES
(1, 530.00, '2024-01-01', 'credit card'),
(2, 500.00, '2024-01-15', 'mobile money'),
(3, 450.00, '2024-02-20', 'bank'),
(4, 300.00, '2024-03-25', 'credit card'),
(5, 480.00, '2024-01-05', 'mobile money');

INSERT INTO courses (course_name, course_code)
VALUES
('Computer Systems Design', 214),
('Data Structures and Algorithms', 204),
('Software Engineering', 208),
('Academic Writing 2', 210),
('Linear Circuits', 206),
('Differential Equations', 202),
('Data Communications', 212);

INSERT INTO enrollments (student_id, enrollment_date)
VALUES
(1, '2024-02-01'),
(2, '2024-02-01'),
(3, '2024-02-01'),
(4, '2024-02-01'),
(5, '2024-02-01');

INSERT INTO lecturers (first_name, last_name, email)
VALUES
('Agnes', 'Wilson', 'a.wilson@gmail.com'),
('George', 'Brown', 'g.brown@gmail.com'),
('James', 'Antwi', 'j.antwi@gmail.com'),
('Gloria', 'Aseidu', 'g.aseidu@gmail.com'),
('David', 'Agyei', 'd.agyei@gmail.com'),
('William', 'Busby', 'w.busby@gmail.com'),
('Robert', 'Johnson', 'r.johnson@gmail.com');

INSERT INTO lecturer_course_assignment (lecturer_id, course_id)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7);

INSERT INTO tas (first_name, last_name, email)
VALUES
('Collins', 'Davis', 'c.davis@gmail.com'),
('Darris', 'Evans', 'd.evans@gmail.com');

INSERT INTO lecturer_ta_assignment (lecturer_id, ta_id)
VALUES
(1, 1),
(2, 2),
(3, 1),
(4, 2),
(5, 1),
(6, 2),
(7, 1);

CREATE OR REPLACE FUNCTION calculate_outstanding_fees()
RETURNS JSON AS $$
DECLARE
    result JSON;
BEGIN
    SELECT json_agg(row_to_json(t))
    INTO result
    FROM (
        SELECT s.student_id, s.first_name, s.last_name, COALESCE(SUM(f.amount), 0) AS total_paid
        FROM students s
        LEFT JOIN fees f ON s.student_id = f.student_id
        GROUP BY s.student_id, s.first_name, s.last_name
    ) t;

    RETURN result;
END;
$$ LANGUAGE plpgsql;
