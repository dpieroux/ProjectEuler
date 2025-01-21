# Module: base

Basic mathematical functionalities.

## Functionality overview

* `(maximum ls)` returns the maximum value contained in the list `ls`.
* `(minimum ls)` returns the minimum value contained in the list `ls`.
* `(divisor? d n)` is `#t` if `d` is a divisor of `n`.
* `(multiple? m n)` is `#t` if `m` is a multiple of `n`.
* `(multiple-of-any? m ns)` is `#t` if `m` is a multiple of any number of the
  list `ns`.
* `(nbr-digits n (b 10))` returns the number of digits of `n` in the base `b`.
* `(digits n #:base (b 10))` returns the list of the digits of `n` in the base
  `b`.
