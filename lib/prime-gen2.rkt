;;;---------------------------------------------------------------------------------------------------
;;; Module: prime-gen2.rkt
;;;---------------------------------------------------------------------------------------------------

#lang racket

(require racket/generator "heap.rkt" "wheel-gen.rkt")

(provide make-prime-gen)


;;;---------------------------------------------------------------------------------------------------
;;; make-prime-gen
;;;---------------------------------------------------------------------------------------------------


(define (make-prime-gen (fst-primes '(2 3 5 7 11)))
  
  (define (new current candidate-gen primes last-prime stage)
    
    (let ([stepper 'null])

      (define (stepper-1)
        (if (pair? fst-primes)
            (begin (set! current (car fst-primes))
                   (set! fst-primes (cdr fst-primes)))
            (begin (candidate-gen 'next) ; discards '1' as it is no prime.
                   (set! current (candidate-gen 'next))
                   (set! primes (mcons current '()))
                   (set! last-prime primes)
                   (set! stage 2)
                   (set! stepper stepper-2))))

      (define (stepper-2)
        (let loop ([candidate (candidate-gen 'next)])
          (if (for/or ([p primes]
                       #:break (< candidate (* p p)))
                (zero? (modulo candidate p)))
              (loop (candidate-gen 'next))
              (begin
                (set! current candidate)
                (set-mcdr! last-prime (mcons candidate '()))
                (set! last-prime (mcdr last-prime))))))

      (set! stepper (match stage
                      [1 stepper-1]
                      [2 stepper-2]
                      [_ (error 'prime-gen "invalid stage: ~a" stage)]))
      
      (lambda (cmd)
        (match cmd
          ['current current]
          ['next (stepper) current]
          ['copy (new current candidate-gen primes last-prime stage)]
          [_     (error 'prime-gen "Unknown command: ~a" cmd)]))))
  
  (new 'null (make-non-multiples-gen fst-primes) 'null 'null 1))
