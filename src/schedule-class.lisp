;;;; schedule-class.lisp

(in-package #:schedule-class)

(local-time:set-local-time-cl-postgres-readers)

(defun load-table (table-name)
  "Parse table from DB to a list"
  (let ((params '("testdb" "postgres" "something" "localhost" :port 5432)))
    (pomo:with-connection params
      (pomo:query (:select '* :from table-name)))))

(defvar *t-groups* (load-table 'groups))

(defun test ()
  (let ((params '("testdb" "postgres" "something" "localhost" :port 5432)))
    (pomo:with-connection params
      (pomo:query (:copy 'groups :from "C:/Users/phieu/Desktop/Practice/db/csv_data/groups.csv" :with (:format 'csv))))))
