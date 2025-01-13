# Euler problem 6: Sum Square Difference

## Statement

The sum of the squares of the first ten natural numbers is, 

$$1^2 + 2^2 + ...+10^2 = 385.$$

The square of the sum of the first ten natural numbers is, 

$$(1 + 2 + ... +10)^2 = 55^2 = 3025.$$

Hence the difference between the sum of the squares of the first ten natural
numbers and the square of the sum is 

$$3025 - 385 = 2640.$$

Find the difference between the sum of the squares of the first one hundred
natural numbers and the square of the sum.

Reference: https://projecteuler.net/problem=6

## Reformulation 

Compute $\sigma(n):=(\sum_{i=1}^n i)^2-(\sum_{i=1}^n i^2)$ for any natuarl $n$.

## Algorithm 

This is straightforward knowing that
  * $\sum_{i=1}^n i = n(n+1)/2$
  * $\sum_{i=1}^n i^2 = n(n+1)(2n+1)/6$

Thus $\sigma(n) = n^2 (n+1)^2/4 - n(n+1)(2n+1)/6 = n (n^2-1) (3n+2)/12$