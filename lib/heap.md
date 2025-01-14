# Module: heap

This module implements a heap that does not modify the topology of its
underlying binary tree, excepted when a new node has to be added. It does so by
(1) allowing the values that are stored in the heap to move from one node to
another node, (2) nullifying nodes that have no more value instead of deleting
them, and (3) reusing previously nullified nodes instead of creating new nodes
when possible. Doing so, there is no memory garbage to be collected, which leads
to a major efficiency boost compared to the default heap provided by Racket.

## Functionality overview

* `(make-heap smaller? [clone])` creates an empty heap. 
  * Its elements are sorted according the predicate `smaller?`: the smallest
    element of the heap, according to that predicate, is found at the top of the
    heap. 
  * The `clone` function is optional. It is used to clone the values storing in
    the heap. It must only be provided if the heap has to be cloned using
    `heap-clone`.
* `(heap-empty? heap)` returns `#t` if `heap` is empty.
* `(heap-min heap)` returns the smallest element of `heap`.
* `(heap-add! heap val)` adds the value `val` to `heap`. 
* `(heap-remove-min! heap)` removes the smallest element of `heap`.
* `(heap-update-min! heap val)` is functionally equivalent to calling
  `(heap-remove-min! heap)` followed by `(heap-add! heap val)`; however, it is
  more efficient.
* `(heap-clone heap)` returns a deep copy of `heap`. This requires the `clone` function to be provided at construction.

Note that calling `heap-remove-min!` and `heap-update-min!` on an empty heap
results in an error. 