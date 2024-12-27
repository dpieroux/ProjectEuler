#|
Euler project: solving all problems at once
===========================================

This program searches in the folder "src" for all the files whose name matches with "euler-<tag>.rkt,
where <tag> is a number optionally followed by a letter (to allow for algorithm variants). These files
must defined two argumentless functions:
   - 'test' computes the solution for the example problem. It must return #t if the expected answer is
     found, and #f otherwise.
   - 'solve' computes and returns the solution for the actual problem.

For each problem, the 'test' function is first called. If it returns #t, the 'solve' function is then
called and its output is displayed together with timing information. However, if the test function
reports #f, the failure is reported and no attempt is made to solve the actual problem.

At the end of the execution, the number of successful and failed (if any) tests is reported.
|#

#lang racket/base

(require racket/runtime-path)
(require racket/format)

;;; Compute the src folder path.
(define-runtime-path basedir "runme.rkt")
(define root-dir (call-with-values (λ () (split-path basedir)) (λ ls (car ls))))
(define src-dir (build-path root-dir "src" ))


;;; Define regexps
(define euler-src-file-rx #px".*euler-\\d+\\w*[.]rkt$")
(define tag-rx #px"\\d+\\w*")
(define id-rx #px"^\\d+")
(define variant-rx #px"[a-z]*$")

;;; Reporting function
(define (report ok nok)
  (displayln "------+----------+----------------------------")
  (if (= 0 nok)
      (printf "SUCCESS! Solved: ~a.\n" ok)
      (printf "FAILURE! Solved: ~a; failed: ~a.\n" ok nok))
  (displayln "----------------------------------------------"))

;;; Main program
(define (main)
  (displayln "------+----------+----------------------------")
  (displayln "  Id  |  Result  | Timing (cpu/wall/gc) [ms]  ")
  (displayln "------+----------+----------------------------")
  (let loop ((paths (directory-list src-dir #:build? #t))
             (ok 0)
             (nok 0))
    (if (null? paths)
        (report ok nok)
        (let ((current-path (car paths))
              (other-paths (cdr paths)))
          (if (regexp-match? euler-src-file-rx current-path)               
              (let* ((afile (path->string current-path))
                     (tag (car (regexp-match tag-rx afile)))
                     (id  (car (regexp-match id-rx tag)))
                     (variant (car (regexp-match variant-rx tag)))
                     (test`(,(dynamic-require current-path 'test)))
                     (solve `(,(dynamic-require current-path 'solve))))                 
                (printf " ~a~a | " (~a id #:width 3 #:align 'right) (~a variant #:width 1))
                (if (eval test)
                    (begin (let-values (((result cpu wall gc) (time-apply (λ () (eval solve)) '())))
                             (printf "~a | ~a \n"
                                     (~a (car result) #:width 8 #:align 'right)
                                     (~a (format "~a / ~a / ~a" cpu wall gc))))
                           (loop other-paths (if (= 0 (string-length variant)) (add1 ok) ok) nok))
                    (begin (displayln "failure! |")
                           (loop other-paths ok (add1 nok)))))
              (loop other-paths ok nok))))))

(current-namespace (make-base-namespace))
(main)