;;;---------------------------------------------------------------------------------------------------
;;; Project Euler 17: Number Letter Counts
;;;---------------------------------------------------------------------------------------------------

#lang racket/base

(provide test solve)


;;;---------------------------------------------------------------------------------------------------
;;; Solution
;;;---------------------------------------------------------------------------------------------------

(define words-19
  (vector-immutable
   "zero" "one" "two" "three" "four" "five" "six" "seven" "eight" "nine" "ten" "eleven"
   "twelve" "thirteen" "fourteen" "fifteen" "sixteen" "seventeen" "eighteen" "nineteen"))

(define words-99
  (vector-immutable
   "zero" "ten" "twenty" "thirty" "forty" "fifty" "sixty" "seventy" "eighty" "ninety"))

(define (num-to-string n) (num-5-digits n))
  
(define (num-5-digits n)
  (let-values ([(n1 n2) (quotient/remainder n 1000)])
    (let ([rest (num-3-digits n2)])
      (cond [(< 1 n1) (format "~a thousands ~a" (num-3-digits n1) rest)]
            [(= 1 n1) (if (zero? n2) (format "one thousand") (format "one thousand ~a" rest))]
            [else rest]))))

(define (num-3-digits n)
  (let-values ([(n1 n2) (quotient/remainder n 100)])
    (let ([rest (num-2-digits n2)])
      (cond [(zero? n1) rest]
            [(zero? n2) (format "~a hundred" (num-2-digits n1))]
            [else (format "~a hundred and ~a" (num-2-digits n1) rest)]))))

(define (num-2-digits n)
  (if (< n 20)
      (vector-ref words-19 n)      
      (let-values ([(n1 n2) (quotient/remainder n 10)])
        (let ([rest (num-2-digits n2)])
          (if (zero? n2)
              (vector-ref words-99 n1)
              (format "~a-~a" (vector-ref words-99 n1) (vector-ref words-19 n2)))))))

(define (nbr-letters n)
  (length (filter char-alphabetic? (string->list (num-to-string n)))))

(define (euler n)
  (for/sum [(ix (in-range 1 (add1 n)))]
    (nbr-letters ix)))

;;;---------------------------------------------------------------------------------------------------
;;; Runme interface
;;;---------------------------------------------------------------------------------------------------

(define (test) (= 3773 (euler 237)))
(define (solve) (euler 1000))