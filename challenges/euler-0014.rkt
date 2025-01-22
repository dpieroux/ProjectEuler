;;;---------------------------------------------------------------------------------------------------
;;; Project Euler 14: Longest Collatz Sequence
;;;---------------------------------------------------------------------------------------------------

#lang racket/base

(provide test solve)

;;;---------------------------------------------------------------------------------------------------
;;; Solution
;;;---------------------------------------------------------------------------------------------------

(define (euler n m)
  (letrec
      ([vec-size (* n m)]

       [memo (make-vector vec-size 0)]

       [collatz-next (lambda (n) (if (even? n) (/ n 2) (add1 (* 3 n))))]
                           
       [collatz-length (lambda (n)
                         (if (< n vec-size)
                             (let ([v (vector-ref memo n)])
                               (when (zero? v)
                                 (set! v (add1 (collatz-length (collatz-next n))))
                                 (vector-set! memo n v))
                               v)
                             (add1 (collatz-length (collatz-next n)))))])

    (vector-set! memo 1 1)

    (for/fold ([best-length (cons 1 1)])
              ([ix (in-range 2 n)])
      (let ([length (collatz-length ix)])
        (if (< length (cdr best-length))
            best-length
            (cons ix length))))))


;;;---------------------------------------------------------------------------------------------------
;;; Runme interface
;;;---------------------------------------------------------------------------------------------------

(define (test) (equal? '(3 . 8) (euler 6 2)))
(define (solve) (car (euler 1000000 4)))