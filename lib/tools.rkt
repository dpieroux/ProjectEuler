#lang racket

(require racket/generator compatibility/mlist)

(provide merge-increasing mk-sequence-gen)

;;;---------------------------------------------------------------------------------------------------
;;; merge-increasing
;;;---------------------------------------------------------------------------------------------------

(define (merge-increasing ns ms)
  (let iter ((ns ns) (ms ms) (acc '()))
    (cond ((null? ns) (append (reverse acc) ms))
          ((null? ms) (append (reverse acc) ns))
          (else (let ((n (car ns))
                      (m (car ms)))
                  (cond ((< n m) (iter (cdr ns)      ms  (cons n acc)))
                        ((> n m) (iter      ns  (cdr ms) (cons m acc)))
                        (else    (iter (cdr ns) (cdr ms) (cons n acc)))))))))



;;;---------------------------------------------------------------------------------------------------
;;; mk-sequence-gen
;;;---------------------------------------------------------------------------------------------------

;;; (last-mpair ls) returns the last mpair of the 'ls' mlist.
(define (last-mpair ls) (if (null? (mcdr ls)) ls (last-mpair (mcdr ls))))

(define (mk-sequence-gen f . terms)
  (generator
   ()
   (let loop ((terms (list->mlist terms))) ; Convert to a mutable list to add new terms at its end.
     (yield (mcar terms))
     (set-mcdr! (last-mpair terms) (mlist (apply f (mlist->list terms))))
     (loop (mcdr terms)))))