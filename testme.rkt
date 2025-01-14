#lang racket/base


(require (only-in "lib/prime-gen1.rkt" (make-prime-gen make-prime-gen1)))
(require (only-in "lib/prime-gen2.rkt" (make-prime-gen make-prime-gen2)))
(require (only-in "lib/prime-gen3.rkt" (make-prime-gen make-prime-gen3)))


;(define limit 94000) ; limit 1 -> 2 (~0.5s)
;(define limit 1060000) ; limit 2 -> 3 (~16.5s)

(define (harness gen)
  (time (let loop ([i 1] [p (gen 'next)])
          (if (= i limit) p (loop (add1 i) (gen 'next))))))

(define (test1) (harness (make-prime-gen1)))
(define (test2) (harness (make-prime-gen2)))
(define (test3) (harness (make-prime-gen3)))


