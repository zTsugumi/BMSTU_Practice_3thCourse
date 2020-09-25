(in-package #:schedule-class)

(defun split-streams ()
        (loop for (x y z) in *faculties*           ;loop through all faculties
                collect(list y z(loop for (p q r) in *groups*       ;loop through all groups
                             if(eql x q)                ;check whether course numbers are same in groups and faculties
                             collect r))))
