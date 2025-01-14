;;;---------------------------------------------------------------------------------------------------
;;; Module: wheel-gen.rkt
;;;---------------------------------------------------------------------------------------------------

#lang racket

(require "base.rkt")

(provide make-wheel-gen make-multiples-gen make-non-multiples-gen)


;;;---------------------------------------------------------------------------------------------------
;;; make-wheel-gen
;;;---------------------------------------------------------------------------------------------------

(define (make-wheel-gen elems size)
 
  (define (make-new current elems size rest offset)
    (\λ (arg)
      (match arg
        ['next 
         (when (null? rest)
           (set! rest elems)
           (set! offset (+ offset size)))
         
           (set! current (+ offset (car rest)))
           (set! rest (cdr rest))
           current]

        ['current current]
        
        ['clone (make-new current elems size rest offset)]
            
        [_ (error 'wheel-gen "Unknown command: ~a" arg)])))

  (make-new 'none elems size elems 0))


;;;---------------------------------------------------------------------------------------------------
;;; make-multiples-gen & make-non-multiples-gen.
;;;---------------------------------------------------------------------------------------------------

(define (make-filter-wheel-gen size keep?)
  ;; Returns a wheel-gen of size `size` whose elements fulfil the predicate `keep?`.
  (make-wheel-gen (filter keep? (range size)) size))

(define (make-multiples-gen ns)
  ;; Returns a wheel-gen that produces the multiples of the `ns` elements.
  (make-filter-wheel-gen (apply * ns) (λ (m) (multiple-of-any? m ns))))

(define (make-non-multiples-gen ns)
  ;; Returns a wheel-gen that produces the non-multiples of the `ns` elements.
  (make-filter-wheel-gen (apply * ns) (λ (m) (not (multiple-of-any? m ns)))))