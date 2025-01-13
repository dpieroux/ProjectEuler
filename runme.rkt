;;;---------------------------------------------------------------------------------------------------
;;; Module: runme.rkt
;;;---------------------------------------------------------------------------------------------------

#lang racket/base

(require racket/runtime-path)
(require racket/format)

;;;---------------------------------------------------------------------------------------------------
;;; Compute the src folder path.
;;;---------------------------------------------------------------------------------------------------

(define-runtime-path basedir "runme.rkt")
(define root-dir (call-with-values (λ () (split-path basedir)) (λ ls (car ls))))
(define src-dir (build-path root-dir "challenges" ))


;;;---------------------------------------------------------------------------------------------------
;;; Define regexps
;;;---------------------------------------------------------------------------------------------------

(define euler-src-file-rx #px".*euler-\\d{4}[.]rkt$")
(define id-rx  #px"\\d{4}")


;;;---------------------------------------------------------------------------------------------------
;;; Reporting function
;;;---------------------------------------------------------------------------------------------------

(define (report ok nok)
  (displayln "----+----------+----------------------------")
  (if (= 0 nok)
      (printf "SUCCESS! Solved: ~a.\n" ok)
      (printf "FAILURE! Solved: ~a; failed: ~a.\n" ok nok))
  (displayln "--------------------------------------------"))


;;;---------------------------------------------------------------------------------------------------
;;; Main program
;;;---------------------------------------------------------------------------------------------------

(define (main test-only)
  (displayln "----+----------+----------------------------")
  (displayln " Id |  Result  | Timing (cpu/wall/gc) [ms]  ")
  (displayln "----+----------+----------------------------")
  (let loop ((paths (directory-list src-dir #:build? #t))
             (ok 0)
             (nok 0))
    (if (null? paths)
        (report ok nok)
        (let ((current-path (car paths))
              (other-paths (cdr paths)))
          (if (regexp-match? euler-src-file-rx current-path)
              (let* ((afile (path->string current-path))
                     (id  (car (regexp-match id-rx afile)))
                     (test`(,(dynamic-require current-path 'test)))
                     (solve `(,(dynamic-require current-path 'solve))))
                (printf "~a| " (~a id #:width 4 #:align 'right))
                (cond [(eval test)
                       (let-values (((result cpu wall gc)
                                     (time-apply (λ () (if test-only "test" (eval solve))) '())))
                         (printf "~a | ~a \n"
                                 (~a (car result) #:width 8 #:align 'right)
                                 (~a (format "~a / ~a / ~a" cpu wall gc))))
                       (loop other-paths
                             (add1 ok) nok)]
                      [else (displayln "failure! |")
                            (loop other-paths ok (add1 nok))]))
              (loop other-paths ok nok))))))


;;;---------------------------------------------------------------------------------------------------
;;; Execute the main program
;;;---------------------------------------------------------------------------------------------------

(current-namespace (make-base-namespace))
(main #f)