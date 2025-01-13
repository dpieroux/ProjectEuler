#lang racket/base

(require rackunit "heap.rkt")

(check-true (let ([heap (make-heap <)]) (heap-empty? heap)))

(check-equal? (let ([heap (make-heap <)])
                (heap-add! heap 10)
                (heap-min heap))
              10)

(check-equal? (let ([heap (make-heap <)])
                (heap-add! heap 10)
                (heap-add! heap 5)
                (heap-min heap))
              5)

(check-equal? (let ([heap (make-heap <)])
                (for-each (\λ (x) (heap-add! heap x)) '(5 4 6 3 7 2 8 1 9))
                (let loop ((acc '()))
                  (if (heap-empty? heap)
                      (reverse acc)
                      (loop (cons (begin0 (heap-min heap) (heap-remove-min! heap)) acc)))))
              '(1 2 3 4 5 6 7 8 9))
