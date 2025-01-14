;;;---------------------------------------------------------------------------------------------------
;;; Module: prime-gen1.rkt
;;;---------------------------------------------------------------------------------------------------

#lang racket/base

(provide make-prime-gen1 make-prime-gen2 make-prime-gen3)

(require math/number-theory racket/match "heap.rkt" "wheel-gen.rkt")


;;;---------------------------------------------------------------------------------------------------
;;; make-prime-gen1
;;;---------------------------------------------------------------------------------------------------

(define (make-prime-gen1)
  (define (new current stage)
    (let ([stepper 'none])

      (define (stepper1)
               (set! stepper stepper2)                              
               (set! current 2))

      (define (stepper2)
        (set! current (next-prime current)))

      (set! stepper (match stage
                      [1 stepper1]
                      [2 stepper2]
                      [_ (error 'prime-gen "invalid stage: ~a" stage)]))

      (lambda (cmd)
        (match cmd
          ['current current]
          ['next    (stepper) current]
          ['clone   (new current stage)]
          [_        (error 'prime-gen "Unknown command: ~a" cmd)]))))

  (new 'none 1))


;;;---------------------------------------------------------------------------------------------------
;;; make-prime-gen2
;;;---------------------------------------------------------------------------------------------------

(define (make-prime-gen2 (fst-primes '(2 3 5 7 11)))
  
  (define (new current candidate-gen primes last-prime stage)
    
    (let ([stepper 'none])

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
          ['next    (stepper) current]
          ['clone   (new current candidate-gen primes last-prime stage)]
          [_        (error 'prime-gen "Unknown command: ~a" cmd)]))))
  
  (new 'none (make-non-multiples-gen fst-primes) 'none 'none 1))


;;;---------------------------------------------------------------------------------------------------
;;; make-prime-gen3
;;;---------------------------------------------------------------------------------------------------

(define (make-multiple-prime-gen wheel-gen)
  (let ((prime (wheel-gen 'current))
        (current (expt (wheel-gen 'current) 2)))
    (lambda (cmd)
      (match cmd
        ['current current]
        ['next (set! current (* prime (wheel-gen 'next)))
               current]))))

(define (make-prime-gen3 (fst-primes '(2 3 5 7 11)))
  (define (new current candidate-gen heap stage)
               
    (let ([stepper stage])            

      (define (stepper1)
        (cond [(pair? fst-primes)
               (set! current (car fst-primes))
               (set! fst-primes (cdr fst-primes))]
              [else
               (candidate-gen 'next) ; discards '1' as it is no prime.
               (set! current (candidate-gen 'next))
               (heap-add! heap (make-multiple-prime-gen (candidate-gen 'copy)))
               (set! stepper stepper2)]))

      (define (stepper2)
        (let candidate-loop ([candidate (candidate-gen 'next)])
          (let loop ((gen (heap-min heap)))
            (when (< (gen 'current) candidate)                    

              (let gen-loop ((value (gen 'current)))
                (when (< value candidate) (gen-loop (gen 'next))))

              (heap-update-min! heap gen)

              (loop (heap-min heap))))

          (cond [(< candidate ((heap-min heap) 'current))
                 ; candidate is a new prime.
                 (set! current candidate)
                 (heap-add! heap (make-multiple-prime-gen (candidate-gen 'copy)))]
                      
                [else
                 ; 'candidate' is not a new prime...
                 (candidate-loop (candidate-gen 'next))])))

        (set! stepper (match stage
                        [1 stepper1]
                        [2 stepper2]
                        [_ (error 'prime-gen "invalid stage: ~a" stage)]))

        (lambda (cmd)
          (match cmd
            ['current current]
            ['next    (stepper) current]
            ['clone   (new current (candidate-gen 'copy) (heap-clone heap) stage)]              
            [_        (error 'prime-gen "Unknown command: ~a" cmd)]))))

  (new 'none
       (make-non-multiples-gen fst-primes)
       (make-heap (\λ (l r) (< (l 'current) (r 'current))))
       1))