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

(defun create-start-time (res)
  "Create a default start-time list"
  (setq res (nconc res (list (local-time:encode-timestamp 0 0 30 8 1 3 2000))))
  (nconc res (list (local-time:encode-timestamp 0 0 15 10 1 3 2000)))
  (nconc res (list (local-time:encode-timestamp 0 0 00 12 1 3 2000)))
  (nconc res (list (local-time:encode-timestamp 0 0 50 13 1 3 2000)))
  (nconc res (list (local-time:encode-timestamp 0 0 40 15 1 3 2000)))
  (nconc res (list (local-time:encode-timestamp 0 0 25 17 1 3 2000)))
  (nconc res (list (local-time:encode-timestamp 0 0 10 19 1 3 2000)))
)

(defvar *groups* (load-table 'groups))
(defvar *faculties* (load-table 'faculties))
(defvar *classrooms* (load-table 'classrooms))
(defvar *subjects* (load-table 'subjects))
(defvar *classes* (load-table 'classes))
(defvar *faculties_subjects* (load-table 'faculty_subject))
(defvar *day-names* '("Sun" "Mon" "Tue" "Wed" "Thu" "Fri" "Sat"))
(defvar *start-time* (create-start-time ()))

(defun find-class-by-classroomid (classes id res)
  "Return all classes in classroom with id"
  (if (null classes) res
      (let
	((head (car classes))
	 (tail (cdr classes)))
	(find-class-by-classroomid
	 tail id (cond
		   ((eql id (nth 1 head)) (nconc res (cons head nil)))
		   (t res))
	)
      )
  )
)

(defun position-of-time (item sequence &optional (res 0))
  "Find position of item in sequence using timestamp-comparison"
  (cond
    ((null sequence) -1)
    ((local-time:timestamp= item (car sequence)) res)
    (t (position-of-time item (cdr sequence) (+ res 1)))
  )
)

(defun get-day-of-class (class)
  "Get day of week for class"
  (- (local-time:timestamp-day-of-week (nth 3 class)) 1)
)

(defun check-class (classes day time)
  "Check if exist class at the given time and day"
  (cond
    ((null classes) nil)
    ((and (eql day (get-day-of-class (car classes)))
	  (local-time:timestamp= time (nth 4 (car classes))))
     t)
    (t (check-class (cdr classes) day time))
  )
)

(defun find-free-classroom (classes start-times paras)
  "Find all free time of all classrooms during the week"
  (loop for day in '(0 1 2 3 4 5)           ; Loop through all days of week [0 1 2 .. 6] ~ ["Mon" "Tue" .. "Sat"]
     do
       (let ((time (elt start-times day))   ; time: start-time of the given "day"
	     (para (elt paras day))         ; para: number of para of the given "day"
	     (first-index 0)
	     (last-index 0)
	     (free-slot '()))
	 (setq first-index (position-of-time time *start-time*)) ; first-index: index time of first para of the day
	 (setq last-index (- (+ first-index para) 1))            ; last-index: index time of last para of the day
 
	 (setq free-slot                    ; Check the status of time slots of the given classroom.
	       (mapcar                      ; NIL - busy, T - free
		(lambda (tmp)
		  (cond
		    ((local-time:timestamp< tmp time) nil)                           ; time slot < first para    
		    ((local-time:timestamp> tmp (nth last-index *start-time*)) nil)  ; time slot > last para
		    ((check-class classes day tmp) nil)
		    (t t)
		  )
		)
		*start-time*)
	 )

	 (print free-slot)
       )
  )
)

(defun solve ()
  "Loop through every classrooms, check at what time the room is free based on classes schedule"
  (loop for classroom in *classrooms*
     do
       (multiple-value-bind (id room-nr start-time para) (values-list classroom)
	 (format t "Classroom id: ~a Room num: ~a" id room-nr)
	 (let ((classes '()))
	   (setq classes (find-class-by-classroomid *classes* id ()))
	   (find-free-classroom classes start-time para)
	 )
	 (format t "~%~%")))
)
