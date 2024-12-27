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


Algorithm: Filter Numbers
-------------------------

Iterate over all the non-negative integers smaller than 'bound' and add together those that are
multiple of a 'ns' number using an accumulator.

|#

#lang racket/base

(require "../lib/tools.rkt")

(provide euler-1b test solve)

(define (euler-1b ns bound)
  (let iter ((m 1) (acc 0))
    (if (< m bound)
        (iter (add1 m) (if (for/or ((n ns)) (divides? n m)) (+ acc m) acc))
        acc)))

;;; Runme interface
(define (test) (= 23 (euler-1b '(3 5) 10)))
(define (solve) (euler-1b '(3 5) 1000))
