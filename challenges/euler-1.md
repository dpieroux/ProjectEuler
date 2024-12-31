# Euler problem 1: Multiples of 3 or 5

## Statement

If we list all the natural numbers below $10$ that are multiples of $3$ or $5$,
we get $3, 5, 6$ and $9$. The sum of these multiples is $23$.

Find the sum of all the multiples of $3$ or $5$ below $1000$

Reference: https://projecteuler.net/problem=1

## Reformulation

Let $N$ be a natural number and $L$ a list of numbers, find the sum $\sigma$ of
the natural numbers $n<N$ such that $n$ is a multiple of an element of $L$.

## Algorithm A

This algorithm is a direct implementation of the reformulated statement:
1. Let $\sigma\leftarrow 0$.
2. For $n$ in $1\ldots N$: 
   1. $\sigma\leftarrow s+n$ If $n$ is a multiple of any element of $l$.

## Algorithm B

Generates all the multiples $m$ of the numbers in $L$ up to $N$ excluded using a
wheel generator, and add them together on the fly using an accumulator $\sigma$.

1. Let $\sigma\leftarrow 0$.
2. For each $m$ multiple of an element of $L$, in increasing order:
   1. If $m < N$, 
      1. Update $\sigma\leftarrow \sigma+m$
      2. Loop back to 2.
   2. Otherwise, the solution is $\sigma$.


## Algorithm C

Generate all the _non_-multiples m of the elements of $L$ up to $N$ excluded
using a wheel generator, and add them together on the fly using an accumulator
$\sigma$. Then, Subtract $\sigma$ from the sum of all numbers from 1 to $N$,
which is given by $(N-1)N/2$. 

1. Let $\sigma\leftarrow 0$.
2. For each $m$ non-multiple of an element of $L$, in increasing order:
   1. If $m < N$, 
      1. Update $\sigma\leftarrow \sigma+m$ 
      2. Loop back to 2.
   2. Otherwise, exit the loop.
3. The solution is $(N-1)N/2 - \sigma$

## Discussion

Algorithm A is the most simple of all the approaches as it does not require a
generator for the (non-)multiples of a set of numbers. The only thing to care of
is to stop checking if the current number is a multiple of a number in $L$ as
soon as such a number has been found. That being said, it is also somewhat
inefficient as it spends time checking numbers for being-a-multiple and
rejecting some of them.

Algorithm B is a direct answer to the problem. However, it requires an efficient
generation of all the multiples of a set of numbers. See the `wheel-gen` module.

Algorithm C takes the opposite view of algorithm B. It generates the numbers
that don't fulfil the be-a-multiple-of condition, and subtract them for the sum
of all the number smaller than $N$.

Which of the approaches B and C is better depends on the circumstances. If the
fraction of the multiples to consider is less than 50% of the naturals, then
algorithm B is better; otherwise it is algorithm C. In the context of the Euler
problem, the common multiples of 3 and 5 represent 1/3 + 1/5 - 1/15 = 7/15 of
the numbers, so algorithm B is better in this case.