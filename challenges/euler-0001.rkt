;;;---------------------------------------------------------------------------------------------------
;;; Project Euler 1: Multiples of 3 or 5
;;;---------------------------------------------------------------------------------------------------

#lang racket/base

(require "../lib/wheel-gen.rkt")

(provide test solve)


;;;---------------------------------------------------------------------------------------------------
;;; Solution
;;;---------------------------------------------------------------------------------------------------

(define (euler ns bound)
  (let ((multiples-gen (make-multiples-gen ns)))
    (let loop ((m (multiples-gen 'next)) (acc 0))
      (if (<= bound m)
          acc
          (loop (multiples-gen 'next) (+ acc m))))))


;;;---------------------------------------------------------------------------------------------------
;;; Runme interface
;;;---------------------------------------------------------------------------------------------------

(define (test) (= 23 (euler '(3 5) 10)))
(define (solve) (euler '(3 5) 1000))