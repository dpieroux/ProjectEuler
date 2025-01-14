#lang racket/base

(provide make-heap heap-empty? heap-min 
         heap-add! heap-remove-min! heap-update-min!
         heap-clone)

(struct Node (val weight left right) #:mutable #:transparent)

(define (make-null-node) (Node #f 0 #f #f))

(define (left node) 
  (or (Node-left node)
      (let ([new-node (make-null-node)])
        (set-Node-left! node new-node) new-node)))

(define (right node)
  (or (Node-right node)
      (let ([new-node (make-null-node)])
        (set-Node-right! node new-node) new-node)))
  
(define (empty-node? node) (zero? (Node-weight node)))

(define (node-copy node clone-val)
  (let iter ((node node))
    (cond ((not node) #f) 
          ((empty-node? node) (make-null-node))
          (else (Node (clone-val (Node-val node))
                      (Node-weight node)
                      (iter (Node-left node))
                      (iter (Node-right node)))))))

(struct Heap (top smaller? clone) #:transparent)

(define (make-heap smaller? (clone 'none))
  (Heap (make-null-node) smaller? clone))

(define (heap-empty? heap)
  (empty-node? (Heap-top heap)))

(define (heap-min heap)
  (Node-val (Heap-top heap)))

(define (heap-add! heap val)
  (let ([smaller? (Heap-smaller? heap)])
    
    (define (node-insert! node val)
      (let ([weight (Node-weight node)]
            [cur    (Node-val node)])
        (cond [(zero? weight)  (set-Node-val! node val)]
              [(smaller? val cur) (select-branch-and-insert! node cur)
                                (set-Node-val! node val)]
              [else (select-branch-and-insert! node val)])
        (set-Node-weight! node (add1 weight))))

    (define (select-branch-and-insert! node val)
      (let ([l-node (left node)]
            [r-node (right node)])

        (if (< (Node-weight r-node) (Node-weight l-node))
            (node-insert! r-node val)
            (node-insert! l-node val))))
  
    (node-insert! (Heap-top heap) val)))

(define (heap-remove-min! heap)
  (let ([smaller? (Heap-smaller? heap)])
    (define (node-rm! node)
      (let ([weight (Node-weight node)]
            [l-node (left node)]
            [r-node (right node)])
        (when (< 1 weight)
          (merge! (if (or (empty-node? l-node)
                          (and (not (empty-node? r-node))
                               (smaller? (Node-val r-node) (Node-val l-node))))
                      r-node
                      l-node)
                  node))          
        (set-Node-weight! node (sub1 weight))))

    (define (merge! branch node)
      (set-Node-val! node (Node-val branch))
      (node-rm! branch))
  
    (when (empty-node? (Heap-top heap)) (error "heap/remove-min!: empty heap"))
    (node-rm! (Heap-top heap))))


(define (heap-update-min! heap val)
  (let ([smaller? (Heap-smaller? heap)])

    (define (node-relocate! node val)
      (let* ([l-node (left  node)]
             [r-node (right node)]
             [child (cond [(empty-node? l-node) r-node]
                          [(empty-node? r-node) l-node]
                          [(smaller? (Node-val l-node) (Node-val r-node)) l-node]
                          [else r-node])]
             [child-val   (Node-val child)])

        (cond [(smaller? child-val val) (set-Node-val! node child-val)
                                      (node-relocate! child val)]
              [else (set-Node-val! node val)])))
      
    (when (empty-node? (Heap-top heap)) (error "heap/remove-add-min!: empty heap"))
    (node-relocate! (Heap-top heap) val)))

(define (heap-clone heap)
  (struct-copy Heap heap (top (node-copy (Heap-top heap) (Heap-clone heap)))))