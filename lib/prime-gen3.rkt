;;;---------------------------------------------------------------------------------------------------
;;; Module: prime-gen3.rkt
;;;---------------------------------------------------------------------------------------------------

#lang racket

(require racket/generator "heap.rkt" "wheel-gen.rkt")

(provide make-prime-gen)


;;;---------------------------------------------------------------------------------------------------
;;; make-prime-gen
;;;---------------------------------------------------------------------------------------------------

(define (make-multiple-prime-gen wheel-gen)
  (let ((prime (wheel-gen 'current))
        (current (expt (wheel-gen 'current) 2)))
    (lambda (cmd)
      (match cmd
        ['current current]
        ['next (set! current (* prime (wheel-gen 'next)))
               current]))))

(define (make-prime-gen (fst-primes '(2 3 5 7 11)))
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
            ['copy    (new current candidate-gen heap stage)]              
            [else     (error 'prime-gen "Unknown command: ~a" cmd)]))))

  (new 'null
       (make-non-multiples-gen fst-primes)
       (make-heap (\λ (l r) (< (l 'current) (r 'current))))
       1))