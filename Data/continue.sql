-- 1:M RELATIONSHIP (Parent Side)
CREATE TABLE IF NOT EXISTS departments (
    department_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- BASIC ENTITIES & 1:M (Child Side)
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

-- 1:1 RELATIONSHIP 
CREATE TABLE IF NOT EXISTS student_profiles (
    profile_id SERIAL PRIMARY KEY,
    -- UNIQUE constraint enforces the 1:1 restriction
    student_id INT UNIQUE NOT NULL REFERENCES students(student_id) ON DELETE CASCADE,
    emergency_contact VARCHAR(100),
    medical_notes TEXT
);

-- M:M RELATIONSHIP (Junction Table)
CREATE TABLE IF NOT EXISTS enrollments (
    student_id INT REFERENCES students(student_id) ON DELETE CASCADE,
    course_id INT REFERENCES courses(course_id) ON DELETE CASCADE,
    grade CHAR(2),
    PRIMARY KEY (student_id, course_id)
);

