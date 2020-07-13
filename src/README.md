# schedule-class project
This is a project to import tables from a given DB to SBCL using Postmodern lib

### Author 
Implementer: Nguyen Ngoc Hai - [zTsugumi]  
Email: <nguyenngochai.tin47@gmail.com>

### Requirements
[Quicklisp](https://www.quicklisp.org/beta/) - lib manager for Common Lisp.  

[Postmodern](https://marijnhaverbeke.nl/postmodern/) - Common Lisp library for interacting with PostgreSQL databases.  
Intallation: ```(ql:quickload :postmodern)```  

[local-time](https://github.com/dlowe-net/local-time) - provide date type for Common Lisp corresponding to PostgreSQL date/time.  
Installation: ```(ql:quickload :cl-postgres+local-time)```   

### How to run
Compile defsystem ```schedule-class.asd``` on EMACS  
Load project with ```(ql:quickload :schedule-class```  
Run unit test  
```(schedule-class::test-load-table)```
