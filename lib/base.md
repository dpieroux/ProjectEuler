# Module: base

Basic mathematical functionalities.

## Functionality overview

* `(divisor? d n)` is `#t` if `d` is a divisor of `n`.
* `(multiple? m n)` is `#t` if `m` is a multiple of `n`.
* `(multiple-of-any? m ns)` is `#t` if `m` is a multiple of any number of the list `ns`.
* `(digits n #:base (b 10))` returns the list of the digits of `n` in the base
  `b`.
