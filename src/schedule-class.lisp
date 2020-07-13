;;;; schedule-class.lisp

(in-package #:schedule-class)

(local-time:set-local-time-cl-postgres-readers)

(defun load-table (table-name
		   &optional (db-name "schedule_db") (db-user "postgres") (db-pwd "something"))
  "Parse table from DB to a list"
  (let ((params (list db-name db-user db-pwd "localhost" :port 5432)))
    (pomo:with-connection params
      (pomo:query (:select '* :from table-name)))))

(defvar *groups* (load-table 'groups))
(defvar *faculties* (load-table 'faculties))
(defvar *classrooms* (load-table 'classrooms))
(defvar *subjects* (load-table 'subjects))
(defvar *classes* (load-table 'classes))
(defvar *faculties_subjects* (load-table 'faculty_subjects))
