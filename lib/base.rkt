;;;---------------------------------------------------------------------------------------------------
;;; Module: base.rkt
;;;---------------------------------------------------------------------------------------------------

#lang racket/base

(provide maximum minimum)
(provide divisor? multiple? multiple-of-any?)
(provide digits nbr-digits)

;;;---------------------------------------------------------------------------------------------------
;;; maximum, minimum
;;;---------------------------------------------------------------------------------------------------

(define (maximum ls) (apply max ls))
(define (minimum ls) (apply min ls))

;;;---------------------------------------------------------------------------------------------------
;;; divisor?; multiple?; multiple-of-any?
;;;---------------------------------------------------------------------------------------------------

(define (divisor? d n) (zero? (remainder n d)))
(define (multiple? m n) (divisor? n m))
(define (multiple-of-any? m ns) (for/or ((n ns)) (multiple? m n)))


;;;---------------------------------------------------------------------------------------------------
;;; digits
;;;---------------------------------------------------------------------------------------------------

(define (nbr-digits n (b 10))
  (let loop ([n n] [nd 0])
    (if (zero? n)
        nd
        (loop (quotient n b) (add1 nd)))))      
  
(define (digits n #:base (b 10))
  (let loop ((n n) (ds '()))
    (let-values (((q r) (quotient/remainder n b)))
      (if (zero? q)
          (cons r ds)
          (loop q (cons r ds))))))
