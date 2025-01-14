#lang racket/base

(require rackunit "heap.rkt")

(let ([heap (make-heap <)]) (check-true (heap-empty? heap)))

(let ([heap (make-heap <)])
  (heap-add! heap 10)
  (check-equal? (heap-min heap) 10))

(let ([heap (make-heap <)])
  (heap-add! heap 10)
  (heap-add! heap 5)
  (check-equal? (heap-min heap) 5))

(let ([heap (make-heap <)])
  (for-each (\λ (x) (heap-add! heap x)) '(5 4 6 3 7 2 8 1 9))
  (check-equal? 
   (let loop ((acc '()) (heap heap))
     (if (heap-empty? heap)
         (reverse acc)
         (loop (cons (heap-min heap) acc) (begin (heap-remove-min! heap) heap))))
   '(1 2 3 4 5 6 7 8 9)))

(let ([heap (make-heap < values)])
  (for-each (\λ (x) (heap-add! heap x)) '(5 4 6 3 7 2 8 1 9))
  (let ([heap2 (heap-clone heap)])
    (heap-remove-min! heap)
    (heap-add! heap 0)
    (heap-add! heap 10)
    (heap-remove-min! heap2)
    (heap-add! heap2 0)
    (heap-add! heap2 10)
    (check-equal? heap heap2)))    
    
