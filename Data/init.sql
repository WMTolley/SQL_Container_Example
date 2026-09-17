-- Clears Database
DROP TABLE IF EXISTS enrollments CASCADE;
DROP TABLE IF EXISTS student_profiles CASCADE;
DROP TABLE IF EXISTS courses CASCADE;
DROP TABLE IF EXISTS students CASCADE;
DROP TABLE IF EXISTS departments CASCADE;


-- ==========================================
-- Code Identical to Data/continue.sql
-- ==========================================
CREATE TABLE IF NOT EXISTS departments (
    department_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS courses (
    course_id SERIAL PRIMARY KEY,
    course_code VARCHAR(10) UNIQUE NOT NULL,
    title VARCHAR(100) NOT NULL,
    -- Foreign Key pointing to Department (1 Department -> Many Courses)
    department_id INT REFERENCES departments(department_id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS student_profiles (
    profile_id SERIAL PRIMARY KEY,
    -- UNIQUE constraint enforces the 1:1 restriction
    student_id INT UNIQUE NOT NULL REFERENCES students(student_id) ON DELETE CASCADE,
    emergency_contact VARCHAR(100),
    medical_notes TEXT
);

CREATE TABLE IF NOT EXISTS enrollments (
    student_id INT REFERENCES students(student_id) ON DELETE CASCADE,
    course_id INT REFERENCES courses(course_id) ON DELETE CASCADE,
    grade CHAR(2),
    PRIMARY KEY (student_id, course_id)
);


-- --- SEED DATA ---
INSERT INTO departments (name) VALUES ('Computer Science'), ('Mathematics');

INSERT INTO students (first_name, last_name, email) VALUES
('Alice', 'Smith', 'alice@school.edu'),
('Bob', 'Johnson', 'bob@school.edu');

-- 1:1 Students to Profiles
INSERT INTO student_profiles (student_id, emergency_contact, medical_notes) VALUES
(1, 'John Smith (Father) - 555-0199', 'No known allergies'),
(2, 'Mary Johnson (Mother) - 555-0122', 'Penicillin allergy');

-- 1:M Departments to Courses
INSERT INTO courses (course_code, title, department_id) VALUES
('CS101', 'Introduction to Computer Science', 1),
('MATH201', 'Calculus I', 2);

-- M:M Students to Courses
INSERT INTO enrollments (student_id, course_id, grade) VALUES
(1, 1, 'A'), (1, 2, 'B'), (2, 1, 'A');
