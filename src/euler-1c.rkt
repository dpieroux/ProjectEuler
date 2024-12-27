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


Algorithm: Generation of the Non-Multiples
------------------------------------------

* Generate all the non-multiples of the 'ns' numbers and add them together on the fly using an
  accumulator.
* Subtract the obtained number from (bound-1) bound/2, i.e., the sum of all numbers from 1 to 'bound'
  excluded.


Comment
-------

The algorithm described here is more efficient than generating the multiples of the 'ns' numbers and
adding them together (as in euler-1) if these multiples represent more than 50% of the naturals. This
is not the case for the multiples of 3 and 5 as they represent 1/3 + 1/5 - 1/15 = 7/15 of all the
naturals.
|#

#lang racket/base

(require "../lib/wheel.rkt")

(provide euler-1c test solve)

(define (euler-1c ns bound)
  (let ((generate (mk-non-multiple-gen ns)))
    (- (/ (* bound (sub1 bound)) 2)
       (let loop ((m (generate)) (acc 0))
         (if (< m bound)
             (loop (generate) (+ acc m))
             acc)))))

;;; Runme interface
(define (test) (= 23 (euler-1c '(3 5) 10)))
(define (solve) (euler-1c '(3 5) 1000))
