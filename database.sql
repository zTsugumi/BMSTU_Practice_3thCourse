DROP TABLE IF EXISTS groups;
DROP TABLE IF EXISTS classroom;
DROP TABLE IF EXISTS subject;
DROP TABLE IF EXISTS classes;

CREATE TABLE groups(
	id serial PRIMARY KEY,
	course INT NOT NULL,
	faculty VARCHAR(2) NOT NULL
);

CREATE TABLE classroom(
	id serial PRIMARY KEY,
	room_nr INT NOT NULL, 
	start_time TIME, 
	para INT
);

CREATE TABLE subject(
	id serial PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	faculty varchar(2)
);

CREATE TABLE classes(
	subject_id 	INT NOT NULL,
	classroom_id INT NOT NULL,
	day DATE NOT NULL,
	start_time TIME NOT NULL,
	class_type  VARCHAR(10) NOT NULL
);


ALTER TABLE classes
ADD CONSTRAINT pkey_classes   	PRIMARY KEY	(subject_id, classroom_id,),	
ADD CONSTRAINT fkey_subject_id FOREIGN KEY (subject_id) REFERENCES subject(id),
ADD CONSTRAINT fkey_classroom_id  FOREIGN KEY (classroom_id) REFERENCES classroom(id);

-- para = 90 min; break = 10 min
ALTER TABLE classroom ADD CONSTRAINT para_check CHECK (para BETWEEN 1 AND 7);
ALTER TABLE classroom ADD CONSTRAINT time_check CHECK (start_time >= '8:30');

COPY subject	(name, faculty)								FROM 'E:\6_sem\Summer_Practice\csv_data\subjects.csv' 	DELIMITER ',' CSV;
COPY groups		(course, faculty) 							FROM 'E:\6_sem\Summer_Practice\csv_data\groups.csv' 	DELIMITER ',' CSV;
COPY classroom	(room_nr, start_time, para) 				FROM 'E:\6_sem\Summer_Practice\csv_data\classroom.csv' 	DELIMITER ',' CSV;
COPY classes	(classroom_id, day, start_time, class_type) FROM 'E:\6_sem\Summer_Practice\csv_data\classes.csv' 	DELIMITER ',' CSV;