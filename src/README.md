# schedule-class project

# Requirements
[Quicklisp](https://www.quicklisp.org/beta/) - lib manager for Common Lisp.  

[Postmodern](https://marijnhaverbeke.nl/postmodern/) - Common Lisp library for interacting with PostgreSQL databases.  
Intallation: ```(ql:quickload :postmodern)```  

[local-time](https://github.com/dlowe-net/local-time) - provide date type for Common Lisp corresponding to PostgreSQL date/time.  
Installation: ```(ql:quickload :cl-postgres+local-time)```   

# Part 1: Import DB to SBCL
### Author 
Implementer: Nguyen Ngoc Hai - [zTsugumi]  
Email: <nguyenngochai.tin47@gmail.com>

### How to run
Compile defsystem ```schedule-class.asd``` on EMACS  
Load project with ```(ql:quickload :schedule-class```  
Run unit test  
```(schedule-class::test-load-table)```

# Part 2: Divide streams
### Task
  -> Divide groups into stream

### Author
Implementer: Helambage gavindu  
Email: <gavindu1995@gmail.com>

# Part 3: По списку аудиторий и варианту возможного времени начала занятий, сформировать список свободных аудиторий на неделю
### Author 
Implementer: Nguyen Ngoc Hai - [zTsugumi]  
Email: <nguyenngochai.tin47@gmail.com>

### How to run
Compile defsystem ```schedule-class.asd``` on EMACS  
Load project with ```(ql:quickload :schedule-class```  
Run solution function
```(schedule-class::solve)```
