;;;---------------------------------------------------------------------------------------------------
;;; Project Euler 7: 10001th Prime
;;;---------------------------------------------------------------------------------------------------

#lang racket/base

(provide test solve)

(require "../lib/prime-gen2.rkt")


;;;---------------------------------------------------------------------------------------------------
;;; Solution
;;;---------------------------------------------------------------------------------------------------

(define (euler n)
  (let ((gen (make-prime-gen)))
    (let loop ((i 0)
               (res (void)))
      (if (= i n)
          res
          (loop (add1 i) (gen 'next))))))


;;;---------------------------------------------------------------------------------------------------
;;; Runme interface
;;;---------------------------------------------------------------------------------------------------

(define (test) (= 13 (euler 6)))
(define (solve) (euler 10001))