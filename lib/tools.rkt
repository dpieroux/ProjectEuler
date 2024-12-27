#|
Module: tools
=============

This module provides various basic functionalities used by the other software modules.
|#

#lang racket

(provide divides? merge-increasing)

#|
(divides? n m) returns #t if n divides m.
|#
(define (divides? n m) (equal? 0 (remainder m n)))

#|
(merge-increasing ns ms) merges the lists ns and ms of strictly increasing numbers. The result list is
also strictly increasing. As a consequence, it contains only single instance of numbers found in both
lists.
|#

(define (merge-increasing ns ms)
  (let iter ((ns ns) (ms ms) (acc '()))
    (cond ((null? ns) (append (reverse acc) ms))
          ((null? ms) (append (reverse acc) ns))
          (else (let ((n (car ns))
                      (m (car ms)))
                  (cond ((< n m) (iter (cdr ns)      ms  (cons n acc)))
                        ((> n m) (iter      ns  (cdr ms) (cons m acc)))
                        (else    (iter (cdr ns) (cdr ms) (cons n acc)))))))))

