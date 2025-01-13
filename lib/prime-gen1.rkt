;;;---------------------------------------------------------------------------------------------------
;;; Module: prime-gen1.rkt
;;;---------------------------------------------------------------------------------------------------

#lang racket/base

(provide make-prime-gen)

(require racket/generator math/number-theory racket/match)


;;;---------------------------------------------------------------------------------------------------
;;; make-prime-gen
;;;---------------------------------------------------------------------------------------------------

(define (make-prime-gen)
  (define (new current stage)
    (let ([stepper 'null])

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
          ['copy    (new current stage)]
          [_        (error 'prime-gen "Unknown command: ~a" cmd)]))))

  (new 'null 1))