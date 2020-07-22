--CREATE DATABASE schedule_db;

\c schedule_db;

DROP TABLE IF EXISTS faculty_subject;
DROP TABLE IF EXISTS classes;
DROP TABLE IF EXISTS groups CASCADE;
DROP TABLE IF EXISTS faculties CASCADE;
DROP TABLE IF EXISTS subjects CASCADE;
DROP TABLE IF EXISTS classrooms CASCADE;


CREATE TABLE faculties(
	id serial PRIMARY KEY,
	name VARCHAR(2) NOT NULL,
	course INT NOT NULL
);

CREATE TABLE groups(
	id serial PRIMARY KEY,
	faculty_id INT NOT NULL,
	name VARCHAR(1) NOT NULL
);

CREATE TABLE subjects(
	id serial PRIMARY KEY,
	name VARCHAR(50) NOT NULL
);

CREATE TABLE faculty_subject(
	faculty_id int NOT NULL,
	subject_id int NOT NULL
);

CREATE TABLE classrooms(
	id serial PRIMARY KEY,
	room_nr INT NOT NULL, 
	start_time TIME[6], 
	para INT[6]
);

CREATE TABLE classes(
	subject_id 	INT NOT NULL,
	classroom_id INT NOT NULL,
	group_id INT NOT NULL,
	day DATE NOT NULL,
	start_time TIME NOT NULL,
	class_type VARCHAR(10) NOT NULL
);


ALTER TABLE faculties
	ADD CONSTRAINT unique_faculity_name UNIQUE (name, course);

ALTER TABLE groups
	ADD CONSTRAINT unique_group_name UNIQUE (faculty_id, name),
	ADD CONSTRAINT fkey_faculty_id FOREIGN KEY (faculty_id) REFERENCES faculties(id);

ALTER TABLE faculty_subject
	ADD CONSTRAINT pkey_fs PRIMARY KEY (faculty_id, subject_id),
	ADD CONSTRAINT fkey_fs_faculty_id FOREIGN KEY (faculty_id) REFERENCES faculties(id),
	ADD CONSTRAINT fkey_fs_subject_id FOREIGN KEY (subject_id) REFERENCES subjects(id);
	
ALTER TABLE classes
	ADD CONSTRAINT pkey_classes	PRIMARY KEY	(subject_id, classroom_id, group_id),
	ADD CONSTRAINT fkey_subject_id FOREIGN KEY (subject_id) REFERENCES subjects(id),
	ADD CONSTRAINT fkey_classroom_id FOREIGN KEY (classroom_id) REFERENCES classrooms(id),
	ADD CONSTRAINT fkey_group_id FOREIGN KEY (group_id) REFERENCES groups(id);

--ALTER TABLE classrooms ADD CONSTRAINT para_check CHECK (para BETWEEN 1 AND 7);
ALTER TABLE classrooms ADD CONSTRAINT time_check CHECK (start_time >= '{"8:30"}');


CREATE VIEW subject_groups_view as
	SELECT subject_id, groups.id as group_id
	FROM faculty_subject as fc
	INNER JOIN groups USING (faculty_id)
	ORDER BY subject_id ASC;

	
CREATE OR REPLACE FUNCTION check_group_availability() 
RETURNS trigger AS $check_group_availability$
    BEGIN
        -- Check that group_id exists for the given subject_id
        IF NEW.group_id NOT IN
		(	
			SELECT	group_id
			FROM 	subject_groups_view as sg_view
			WHERE 	sg_view.subject_id = NEW.subject_id
		)
        THEN
			RAISE EXCEPTION 'Subject does not belong to group';
        END IF;
		RETURN NEW;
    END; $check_group_availability$ 
LANGUAGE plpgsql;


CREATE TRIGGER check_group_availability
BEFORE INSERT OR UPDATE ON classes
FOR EACH ROW 
EXECUTE PROCEDURE check_group_availability();


-- INSERT DATA FROM CSV FILE
\COPY faculties (name, course) FROM 'faculties.csv' DELIMITER ',' CSV;
\COPY groups (faculty_id, name) FROM 'groups.csv' DELIMITER ',' CSV;
\COPY subjects (name) FROM 'subjects.csv' DELIMITER ',' CSV;
\COPY classrooms (room_nr, start_time, para) FROM 'classrooms.csv' DELIMITER ',' CSV;
\COPY classes (subject_id, classroom_id, group_id, day, start_time, class_type) FROM 'classes.csv' DELIMITER ',' CSV;
\COPY faculty_subject (faculty_id, subject_id) FROM 'fac_sub.csv' DELIMITER ',' CSV;


-- INSERT DATA MANUALLY 
--	INSERT INTO classes (subject_id, classroom_id, group_id, day, start_time, class_type)
--	VALUES 
--		(1, 4, 1, '2020-07-13', '8:30', 'seminar'); 	-- successfuly pass check_group_availability trigger
--		(1, 1, 18, '2020-07-13', '8:30', 'seminar'); 	-- raise exception when subject_id doesn't belong to group_id