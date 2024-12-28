#lang racket/base

(provide divisor? multiple? multiple-of-any?)

;;;---------------------------------------------------------------------------------------------------
;;; divisor?; multiple?; multiple-of-any?
;;;---------------------------------------------------------------------------------------------------

(define (divisor? d n) (zero? (remainder n d)))
(define (multiple? m n) (divisor? n m))
(define (multiple-of-any? m ns) (for/or ((n ns)) (multiple? m n)))