;;;---------------------------------------------------------------------------------------------------
;;; Project Euler 2: Even Fibonacci Numbers (Approach A)
;;;---------------------------------------------------------------------------------------------------

#lang racket/base

(require "../lib/tools.rkt")

(provide test solve)


;;;---------------------------------------------------------------------------------------------------
;;; Solution
;;;---------------------------------------------------------------------------------------------------

(define (algo seq-gen bound predicate accumulator initial)
  (let loop ((m (seq-gen)) (res initial))
    (if (<= m bound)
        (loop (seq-gen) (if (predicate m) (accumulator m res) res))
        res)))

(define (euler bound)
  (algo (make-sequence-gen + 1 2) bound even? + 0))


;;;---------------------------------------------------------------------------------------------------
;;; Runme interface
;;;---------------------------------------------------------------------------------------------------

(define (test) (= 44 (euler 100)))
(define (solve) (euler 4000000))
