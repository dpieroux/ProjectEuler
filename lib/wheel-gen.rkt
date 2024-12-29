;;;---------------------------------------------------------------------------------------------------
;;; Module: wheel-gen.rkt
;;;---------------------------------------------------------------------------------------------------

#lang racket

(require racket/generator)

(require "base.rkt")

(provide make-wheel-gen make-multiples-gen make-non-multiples-gen)

;;;---------------------------------------------------------------------------------------------------
;;; make-wheel-gen
;;;---------------------------------------------------------------------------------------------------

(define (make-wheel-gen elems size)
  ;; Returns a wheel-gen with elements `elems` and size `size`.
  (define (make-new elems size rest offset cur)
    (letrec ((self (λ (cmd)
                     (match cmd
                       ;; Returns the latest produced element, or `#f` if no element has been produced
                       ;; yet.
                       ('current cur)

                       ;; Produces the next element and returns it.
                       ('next (when (null? rest)
                                (set! rest elems)
                                (set! offset (+ offset size)))
                              (set! cur (+ (car rest) offset))
                              (set! rest (cdr rest))
                              cur)

                       ;; Returns a deep copy of the  instance.
                       ('copy (make-new elems size (apply list rest) offset cur))))))
      self))
  (make-new elems size elems 0 #f))

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