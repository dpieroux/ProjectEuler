#|
Module: wheel
=============

This module implements a number generator engine based on number wheels. Such a generator is typically
used to generated all the multiples of a set of numbers, or all the non-multiples of a set of numbers.


Introduction
------------

Imaging a number wheel divided in n sectors numbered from 0 to n-1, and hidden behind a wall with an
aperture, so that only one sector is visible. Then erase some of the numbers, but not all of them.

Let assume that smallest number left on the wheel is visible through the aperture. By repeatedly
stepping the wheel until the next number becomes visible, all the numbers of the wheel are displayed
in increasing order until the largest one is reached. Stepping one more time, the smallest number
displays again and the process restarts from the beginning. Now, by adding an offset equal to the
number of sectors times the number of full rotations completed by the wheel, an increasing sequence of
numbers is generated.

For instance, the 6-sectors wheel displaying the numbers 0, 2, 3, and 4 generates the following
sequence: 0, 2, 3, 4, 6, 8, 9, 10, 12, 14, 15, 16..., that is, the multiples of 2 or 3.

Similarly, the 6-sectors wheel displaying the numbers 1 and 5 generates the sequence of non-multiples
of 2 or 3: 1, 5, 7, 11, 13, 17, 19, 23, 25, 29...


Functionality overview
----------------------

- High-level:
  - (mk-multiple-gen ns) returns a generator of the multiples of the numbers in ns.
  - (mk-non-multiple-gen ns) returns a generator of the non-multiples of the numbers in ns.

- Low-level:
  - (wheel elements size) returns a wheel struct with the provided elements and size.
  - (multiple-wheel ns) returns a wheel to build the multiples of the numbers in the list ns.
  - (mk-wheel-engine wheel) returns a wheel engine; calling it repeatedly generates the sequence of
    numbers corresponding to the provided wheel.

Example:
  (define my-gen (mk-non-multiple-gen '(2 3)))
  (build-list 7 (λ (_) (my-gen)))

  => '(1 5 7 11 13 17 19)
|#

#lang racket

(require racket/generator)

(require "tools.rkt")

(provide mk-multiple-gen mk-non-multiple-gen)
(provide wheel mk-multiple-wheel mk-non-multiple-wheel mk-wheel-engine)

(struct wheel (elements size) #:transparent)

(define (mk-gen-multiple-wheel f)
  (lambda (ns)
    (let ((size (apply * ns)))
      (wheel (filter (λ (e) (f (for/or ((n ns)) (divides? n e)))) (range size)) size))))

(define mk-multiple-wheel (mk-gen-multiple-wheel identity))

(define mk-non-multiple-wheel (mk-gen-multiple-wheel not))

(define (mk-wheel-engine wheel)
  (generator ()
             (let loop ((elems (wheel-elements wheel)) (offset 0))
               (if (null? elems)
                   (loop (wheel-elements wheel) (+ offset (wheel-size wheel)))
                   (begin
                     (yield (+ (car elems) offset))
                     (loop (cdr elems) offset))))))

(define (mk-multiple-gen     ns) (mk-wheel-engine (    mk-multiple-wheel ns)))
(define (mk-non-multiple-gen ns) (mk-wheel-engine (mk-non-multiple-wheel ns)))
