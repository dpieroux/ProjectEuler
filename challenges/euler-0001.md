# Euler problem 1: Multiples of 3 or 5

## Statement

If we list all the natural numbers below $10$ that are multiples of $3$ or $5$,
we get $3, 5, 6$ and $9$. The sum of these multiples is $23$.

Find the sum of all the multiples of $3$ or $5$ below $1000$

Reference: https://projecteuler.net/problem=1

## Reformulation

Let $N$ be a natural number and $L$ a list of numbers, find the sum $\sigma$ of
the natural numbers $n<N$ such that $n$ is a multiple of an element of $L$.

## Algorithm 

Generate all the multiples $m$ of the numbers in $L$ up to $N$ excluded and
add them together on the fly using an accumulator $\sigma$:

1. Let $\sigma\leftarrow 0$.
2. For each $m$ multiple of an element of $L$, in increasing order:
   1. If $m \ge N$, return the solution $\sigma$.
   2. Update $\sigma\leftarrow \sigma+m$
   3. Loop back to 2.
 
## Discussion

In the actual problem, a number wheel can be used to generate all the multiples
of $3$ and $5$.