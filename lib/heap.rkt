#lang racket/base

(provide make-heap heap-empty? heap-min heap-add! heap-remove-min! heap-update-min!)

(require racket/match)

(struct node (val weight left right) #:mutable #:transparent)

(define (make-null-node) (node #f 0 #f #f))

(define (left node) 
  (or (node-left node)
      (let ([new-node (make-null-node)])
        (set-node-left! node new-node) new-node)))

(define (right node)
  (or (node-right node)
      (let ([new-node (make-null-node)])
        (set-node-right! node new-node) new-node)))
  
(define (node-null? node) (zero? (node-weight node)))

(struct heap (top prior?) #:transparent)

(define (make-heap prior?)
  (heap (make-null-node) prior?))

(define (heap-empty? heap)
  (node-null? (heap-top heap)))

(define (heap-min heap)
  (node-val (heap-top heap)))

(define (heap-add! heap val)
  (let ([prior? (heap-prior? heap)])
    
    (define (node-insert! node val)
      (let ([weight (node-weight node)]
            [cur    (node-val node)])
        (cond [(zero? weight)  (set-node-val! node val)]
              [(prior? val cur) (select-branch-and-insert! node cur)
                                (set-node-val! node val)]
              [else (select-branch-and-insert! node val)])
        (set-node-weight! node (add1 weight))))

    (define (select-branch-and-insert! node val)
      (let ([l-node (left node)]
            [r-node (right node)])

        (if (< (node-weight r-node) (node-weight l-node))
            (node-insert! r-node val)
            (node-insert! l-node val))))
  
    (node-insert! (heap-top heap) val)))

(define (heap-remove-min! heap)
  (let ([prior? (heap-prior? heap)])
    (define (node-rm! node)
      (let ([weight (node-weight node)]
            [l-node (left node)]
            [r-node (right node)])
        (when (< 1 weight)
          (merge! (if (or (node-null? l-node)
                          (and (not (node-null? r-node))
                               (prior? (node-val r-node) (node-val l-node))))
                      r-node
                      l-node)
                  node))          
        (set-node-weight! node (sub1 weight))))

    (define (merge! branch node)
      (set-node-val! node (node-val branch))
      (node-rm! branch))
  
    (when (node-null? (heap-top heap)) (error "heap/remove-min!: empty heap"))
    (node-rm! (heap-top heap))))


(define (heap-update-min! heap val)
  (let ([prior? (heap-prior? heap)])

    (define (node-relocate! node val)
      (let* ([l-node (left  node)]
             [r-node (right node)]
             [child (cond [(node-null? l-node) r-node]
                          [(node-null? r-node) l-node]
                          [(prior? (node-val l-node) (node-val r-node)) l-node]
                          [else r-node])]
             [child-val   (node-val child)])

        (cond [(prior? child-val val) (set-node-val! node child-val)
                                      (node-relocate! child val)]
              [else (set-node-val! node val)])))

      
    (when (node-null? (heap-top heap)) (error "heap/remove-add-min!: empty heap"))
    (node-relocate! (heap-top heap) val)))
