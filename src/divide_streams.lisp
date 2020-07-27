;;;; divide-streams.lisp
;;divide streams (("IU" 1(A B C)....("FN" 1(A B C) .... ) like this as a one list

;;list_1 faculties: ((1 "IU" 1)(2 "IU" 2)(3 "IU" 3)(4 "IU" 4)(5 "FN" 1)(6 "FN" 2)(7 "FN" 3)(8 "FN" 4))
;to intial list elements ((x y z)()()
;here x is id ,y is faculty name,z is course number

;list_2 groups: ((1 1 "A")(2 1 "B")(3 1 "C")(4 2 "A")(5 2 "B")(6 2 "C")(7 3 "A")(8 3 "B")(9 3 "C")(10 4 "A")
;  (11 4 "B")(12 4 "C")(13 5 "A")(14 5 "B")(15 5 "C")(16 6 "A")(17 6 "B")(18 6 "C")(19 7 "A")(20 7 "B")(21 7 "C")(22 8 "A")(23 8 "B")(24 8 "C"))

;to intial list elements ((p q r)()()
;here p is id ,q is course number,r is group 

;expect result: (((IU 1(A B C)(IU 2(A B C)(IU 3(A B C)(IU 4(A B C))(FN 1(A B C)(FN 2(A B C)(FN 3(A B C)(FN 4(A B C)))




(defun split-streams ()
        (loop for (x y z) in *faculties*           ;loop through all faculties
                collect(list y z(loop for (p q r) in *groups*       ;loop through all groups
                             if(eql x q)                ;check whether course numbers are same in groups and faculties
                             collect r))))
