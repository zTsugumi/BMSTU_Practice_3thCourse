# Creating a schedule of classes for students
Develop a program in Lisp that generates a class schedule for students.
# Tech/Framework used
* Emacs as an IDE  
* SLIME: Superior Lisp Interaction Mode for Emacs  
* SBCL: Steel Bank Common Lisp  
[See more](https://lispcookbook.github.io/cl-cookbook/emacs-ide.html)
# Problem statement
## Given
* List of groups 
  - at least 70 – can test with smaller number,
  -	group codes are different,
  -	3 faculties, 4 courses.
  For example: IU-36 (faculty – IU, course – 3, group – 6), SM-41, …
* Groups of the same faculty and the same course will be divided into stream – «поток»
  -	3, 4 or 5 groups in 1 stream (in this case, we can consider each course as a stream), 
  -	need at least 4 streams.
* List of classrooms
  -	at least 20,
  -	*?? можно связать с временем начала пар занятий, как в нашем расписании 6 дней в неделю ??*.
* List of subjects
  -	at least 15, 5 for each course,
  -	there can be 2 special cases:
    - a subject exists in 2 courses of the same faculty.
      For example: OS can exist in both IU-3x and IU-4x
    - a subject exists in 2 courses of 2 different faculties.
      For example: OS can exist in IU-xx and SM-xx
  -	1 lecture per stream per week,
  -	1 or 2 labs per group per week,
  -	1 seminar per group per week.
*	Information of groups, streams, classrooms and classes by subjects is saved in different DB or excel tables (for DB, we can use *?? Piton ??*)
## TASK 1
*	Copy information from DB tables to lists (develop the structure of the lists) or fill in lists by entering information using the keyboard;
*	Split groups into streams – a new list;
*	Create a list of available classrooms for the week based on the list of classrooms and the possible start time of classes.
