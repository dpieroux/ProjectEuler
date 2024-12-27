#|
Euler problem 1: Multiples of 3 or 5
====================================

Statement
---------

If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The
sum of these multiples is 23.

Find the sum of all the multiples of 3 or 5 below 1000.

Reference: https://projecteuler.net/problem=1


Generalisation
--------------

Find the sum of all the multiples of the numbers in 'ns' that are smaller than 'bound'.


Algorithm: Generation of the multiples
--------------------------------------

Using a generator of the multiples of the 'ns' numbers, generate the multiples smaller than 'bound'
and sum them together on the fly using an accumulator.

See also euler-1c, a variation of this algorithm for which the non-multiples are generated instead of
the multiples.
|#

#lang racket/base

(require "../lib/wheel.rkt")

(provide euler-1 test solve)

(define (euler-1 ns bound)
  (let ((multiple-gen (mk-multiple-gen ns)))
    (let loop ((m (multiple-gen)) (acc 0))
      (if (< m bound)
          (loop (multiple-gen) (+ acc m))
          acc))))

;;; Runme interface
(define (test) (= 23 (euler-1 '(3 5) 10)))
(define (solve) (euler-1 '(3 5) 1000))
