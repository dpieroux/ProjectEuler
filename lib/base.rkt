;;;---------------------------------------------------------------------------------------------------
;;; Module: base.rkt
;;;---------------------------------------------------------------------------------------------------

#lang racket/base

(require math/number-theory)
(require racket/generator)

(provide divisor? multiple? multiple-of-any?)
(provide digits)
(provide make-prime-gen)


;;;---------------------------------------------------------------------------------------------------
;;; divisor?; multiple?; multiple-of-any?
;;;---------------------------------------------------------------------------------------------------

(define (divisor? d n) (zero? (remainder n d)))
(define (multiple? m n) (divisor? n m))
(define (multiple-of-any? m ns) (for/or ((n ns)) (multiple? m n)))


;;;---------------------------------------------------------------------------------------------------
;;; digits
;;;---------------------------------------------------------------------------------------------------

(define (digits n #:base (b 10))
  (let loop ((n n) (ds '()))
    (let-values (((q r) (quotient/remainder n b)))
      (if (zero? q)
          (cons r ds)
          (loop q (cons r ds))))))

;;;---------------------------------------------------------------------------------------------------
;;; make-prime-gen
;;;---------------------------------------------------------------------------------------------------

(define (make-prime-gen)
  (generator ()
             (let loop ([current 2])
               (yield current)
               (loop (next-prime current)))))
