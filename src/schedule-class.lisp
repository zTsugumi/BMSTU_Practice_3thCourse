;;;; schedule-class.lisp

(in-package #:schedule-class)

(local-time:set-local-time-cl-postgres-readers)

(defun load-table (table-name &key (db-name "schedule_db")(db-user "postgres")(db-pwd "something"))
  "Parse table from DB to a list"
  (let ((params (list db-name db-user db-pwd "localhost" :port 5432)))
    (pomo:with-connection params
      (pomo:query (:select '* :from table-name)))))

(defun test-load-table ()
  "Unit test for load-table"
  (format t "Groups: ~a~%Faculties: ~a~%Classrooms: ~a~%Subjects: ~a~%Classes: ~a~%" *groups* *faculties* *classrooms* *subjects* *classes*))

(defvar *groups* (load-table 'groups))
(defvar *faculties* (load-table 'faculties))
(defvar *classrooms* (load-table 'classrooms))
(defvar *subjects* (load-table 'subjects))
(defvar *classes* (load-table 'classes))
(defvar *faculties_subjects* (load-table 'faculty_subject))

(defvar *day-names*
  '("Sun" "Mon" "Tue" "Wed" "Thu" "Fri" "Sat"))

(defun classes-get-day-list ()
  "From *classes* convert date to day of week"
  (mapcar
   (lambda (class)
     (nth (local-time:timestamp-day-of-week (nth 3 class)) *day-names*))
   *classes*)
)

(defun solve ()
  "Loop through every classrooms, check at what time the room is free based on classes schedule"
  (loop for classroom in *classrooms*
     do
       (multiple-value-bind (id room-nr start-time para) (values-list classroom)
	 (format t "id: ~a" id)
	 (loop for class in *classes*
	    do
	      (let ((classroom-id (nth 1 class)))
		(if (eql id classroom-id) (print class))))
	 (format t "~%~%")))
)
