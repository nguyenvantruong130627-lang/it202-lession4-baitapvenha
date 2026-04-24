CREATE DATABASE OnlineLearningSystem;

USE OnlineLearningSystem;

-- BẢNG CHA  
CREATE TABLE Students (
	student_id INT PRIMARY KEY AUTO_INCREMENT, 
    full_name VARCHAR(50) NOT NULL,
    dob DATE NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Teachers (
	teacher_id INT PRIMARY KEY AUTO_INCREMENT, 
    full_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE
);

-- BẢNG CON
CREATE TABLE Courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL,
    course_description TEXT, 
    total_lessons INT CHECK (total_lessons > 0),
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES Teachers(teacher_id)  -- Một khóa học chỉ do một giảng viên phụ trách 
);

CREATE TABLE Enrollments (
	enrollment_id INT PRIMARY KEY AUTO_INCREMENT, 
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    registration_date DATE DEFAULT(CURRENT_DATE),
	UNIQUE (student_id, course_id), -- Không được đăng ký trùng cùng một khóa học cho cùng một sinh viên
    FOREIGN KEY (student_id) REFERENCES Students(student_id), -- Một khóa học có thể có nhiều sinh viên 
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

CREATE TABLE Scores (
	score_id INT PRIMARY KEY AUTO_INCREMENT,
	student_id INT NOT NULL,
    course_id INT NOT NULL,
    midterm_score FLOAT NOT NULL CHECK (midterm_score >= 0 and midterm_score <= 10), -- Điểm nằm trong khoảng từ 0 đến 10 
    final_score FLOAT NOT NULL CHECK (final_score >= 0 and final_score <= 10),
    UNIQUE (student_id, course_id), -- Mỗi sinh viên chỉ có một kết quả cho mỗi khóa học 
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- thêm dữ liệu

INSERT INTO Students (full_name, dob, email)
VALUES
('Nguyễn Nam', '2003-05-10', 'nam@gmail.com'),
('Trần Lan', '2002-08-15', 'lan@gmail.com'),
('Lê Lợi', '2003-01-20', 'loi@gmail.com'),
('Nguyễn Du', '2001-12-05', 'du@gmail.com'),
('Đinh Tiên Hoàng', '2002-03-18', 'hoang@gmail.com');

INSERT INTO Teachers (full_name, email)
VALUES
('Nguyễn Văn A', 'nva@gmail.com'),
('Trần Thị B', 'ttb@gmail.com'),
('Lê Văn C', 'lvc@gmail.com'),
('Phạm Thị D', 'ptd@gmail.com'),
('Hoàng Văn E', 'hve@gmail.com');

INSERT INTO Courses (course_name, course_description, total_lessons, teacher_id)
VALUES
('SQL Basic', 'Cơ bản SQL', 20, 1),
('Java Core', 'Lập trình Java cơ bản', 25, 2),
('Web Development', 'HTML CSS JS', 30, 3),
('Data Structures', 'Cấu trúc dữ liệu', 28, 4),
('Database Design', 'Thiết kế CSDL', 22, 5);

INSERT INTO Enrollments (student_id, course_id)
VALUES
(1, 1),
(1, 2),
(2, 1),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO Scores (student_id, course_id, midterm_score, final_score)
VALUES
(1, 1, 7.5, 8.0),
(1, 2, 6.5, 7.0),
(2, 1, 8.0, 8.5),
(3, 3, 5.5, 6.0),
(4, 4, 9.0, 9.5),
(5, 5, 7.0, 7.5);


-- cập nhật email, mô tả, điểm

UPDATE Students
SET email = 'nguyennamdeptrais1tg@gmail.com'
WHERE student_id = 1;

UPDATE Courses
SET course_description = 'Nhập môn Java'
WHERE course_id = 2;

UPDATE Scores
SET final_score = 10
WHERE student_id = 5 AND course_id = 5;


-- 1. Xóa kết quả học tập trước (nếu có)
DELETE FROM Scores
WHERE student_id = 2 AND course_id = 1;

-- 2. Xóa lượt đăng ký học không hợp lệ
DELETE FROM Enrollments
WHERE student_id = 4 AND course_id = 4;

-- Lấy thông tin tất cả sinh viên
SELECT * FROM Students;
--Lấy thông tin giảng viên
SELECT * FROM Teachers;
-- Lấy danh sách các khóa học
SELECT * FROM Courses;
-- Lấy thông tin các lượt đăng ký khóa học
SELECT * FROM Enrollments;
-- Lấy thông tin các lần đánh giá kết quả
SELECT * FROM Scores;
