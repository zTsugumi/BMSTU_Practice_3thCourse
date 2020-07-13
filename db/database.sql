CREATE DATABASE schedule_db;

\c schedule_db;

DROP TABLE IF EXISTS faculty_subjects;
DROP TABLE IF EXISTS groups;
DROP TABLE IF EXISTS classes;
DROP TABLE IF EXISTS subjects;
DROP TABLE IF EXISTS faculties;
DROP TABLE IF EXISTS classrooms;

CREATE TABLE groups(
	id serial PRIMARY KEY,
	course INT NOT NULL,
	faculty_id INT NOT NULL
);

CREATE TABLE faculties(
	id serial PRIMARY KEY,
	name VARCHAR(2) NOT NULL,
	subject_list TEXT[]
);

CREATE TABLE classrooms(
	id serial PRIMARY KEY,
	room_nr INT NOT NULL, 
	start_time TIME[6], 
	para INT[6]
);

CREATE TABLE subjects(
	id serial PRIMARY KEY,
	name VARCHAR(50) NOT NULL
);

CREATE TABLE classes(
	subject_id 	INT NOT NULL,
	classroom_id INT NOT NULL,
	day DATE NOT NULL,
	start_time TIME NOT NULL,
	class_type  VARCHAR(10) NOT NULL
);

CREATE TABLE faculty_subjects(
	faculty_id int NOT NULL,
	subject_id int NOT NULL
);

ALTER TABLE faculty_subjects
	ADD CONSTRAINT pkey_fs	PRIMARY KEY	(faculty_id, subject_id),	
	ADD CONSTRAINT fkey_fs_faculty_id FOREIGN KEY (faculty_id) REFERENCES faculties(id),
	ADD CONSTRAINT fkey_fs_subject_id FOREIGN KEY (subject_id) REFERENCES subjects(id);
	
ALTER TABLE classes
	ADD CONSTRAINT pkey_classes	PRIMARY KEY	(subject_id, classroom_id),	
	ADD CONSTRAINT fkey_subject_id FOREIGN KEY (subject_id) REFERENCES subjects(id),
	ADD CONSTRAINT fkey_classroom_id FOREIGN KEY (classroom_id) REFERENCES classrooms(id);

ALTER TABLE groups
	ADD CONSTRAINT fkey_faculty	FOREIGN KEY	(faculty_id) REFERENCES faculties(id);	

-- PARA = 90 min; BREAK = 10 min
-- ALTER TABLE classrooms ADD CONSTRAINT para_check CHECK (para BETWEEN 1 AND 7);
ALTER TABLE classrooms ADD CONSTRAINT time_check CHECK (start_time >= '{"8:30"}');


-- INSERT DATA FROM CSV FILE
<<<<<<< HEAD
COPY subjects (name) FROM '\BMSTU_Practice_3thCourse\db\subjects.csv' DELIMITER ',' CSV;
COPY faculties (name, subject_list) FROM '\BMSTU_Practice_3thCourse\db\faculties.csv' DELIMITER ',' CSV;
COPY classrooms (room_nr, start_time, para) FROM '\BMSTU_Practice_3thCourse\db\classrooms.csv' DELIMITER ',' CSV;
COPY groups	(course, faculty_id) FROM '\BMSTU_Practice_3thCourse\db\groups.csv' DELIMITER ',' CSV;
COPY classes (subject_id, classroom_id, day, start_time, class_type) FROM '\BMSTU_Practice_3thCourse\db\classes.csv' DELIMITER ',' CSV;
COPY faculty_subjects (faculty_id, subject_id) FROM '\BMSTU_Practice_3thCourse\db\fac_sub.csv' DELIMITER ',' CSV;
=======
\COPY subjects (name) FROM 'subjects.csv' DELIMITER ',' CSV;
\COPY faculties (name, subject_list) FROM 'faculties.csv' DELIMITER ',' CSV;
\COPY classrooms (room_nr, start_time, para) FROM 'classrooms.csv' DELIMITER ',' CSV;
\COPY groups	(course, faculty_id) FROM 'groups.csv' DELIMITER ',' CSV;
\COPY classes (subject_id, classroom_id, day, start_time, class_type) FROM 'classes.csv' DELIMITER ',' CSV;

>>>>>>> 431aa67ce53586833551885005d284f644973cba

-- INSERT DATA MANUALLY 
-- INSERT INTO classrooms (room_nr, start_time, para)
-- VALUES
-- 	(
-- 		511,
-- 		'{"8:30", "10:10", "8:30", "11:50", "8:30", "10:10"}',
-- 		'{4, 2, 5, 2, 3, 5}'
-- 	);

-- INSERT INTO faculties (name, subject_list)
-- VALUES
-- 	('SM', '{"Programming in C", "Logic and Theory Algorithms", "Data Structure", "DBMS", "Computer Design"}'),
-- 	('LR', '{"Probability Theory", "Advanced Mathematics", "Discrete mathematics", "Decision Theory", "Mathematical statistics"}'),
-- 	('EN', '{"Physics", "Mechatronics System", "Electric drive of machines", "Analysis of machine structures", "Basics of machine tools development"}');
