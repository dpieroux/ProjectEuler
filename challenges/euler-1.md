# Euler problem 1: Multiples of 3 or 5

## Statement

If we list all the natural numbers below $10$ that are multiples of $3$ or $5$,
we get $3, 5, 6$ and $9$. The sum of these multiples is $23$.

Find the sum of all the multiples of $3$ or $5$ below $1000$

Reference: https://projecteuler.net/problem=1

## Approach A

**Generalisation:** Find the sum of all the naturals smaller than `bound`  and
that are a multiple of at least one number contained in the list `ns` .

Iterate over all the naturals smaller than `bound` and add together on the fly
those that are multiple of at least one of the `ns` in an accumulator.

## Approach B

**Generalisation:** Find the sum of all the multiples of the numbers in `ns`
that are smaller than `bound`.

Generates all the multiples of the `ns` numbers up to `bound` excluded using a
wheel generator, and add them together on the fly using an accumulator.

## Approach C

**Generalisation:** Find the sum of all the multiples of the numbers in `ns`
that are smaller than `bound`.


1. Generate all the _non_-multiples of the `ns` numbers up to `bound` excluded
   using a wheel generator, and add them together on the fly using an
   accumulator.
2. Subtract the sum obtained from the sum of all numbers from 1 to `bound`
   excluded, which is given by (`bound`-1)*`bound`/2. 

## Discussion

The approach A is the most simple of all the approaches as it does not require a
generator for the (non-)multiples of a set of numbers. The only thing to care of
is to stop checking if the current number is a multiple of a number in `ns` as
soon as such a number has been found. That being said, it is also somewhat
inefficient as it spends time checking numbers for being-a-multiple and
rejecting some of them.

The approach B is a direct answer to the problem. However, it requires an
efficient generation of all the multiples of a set of numbers. See the
`wheel-gen` module.

The approach C takes the opposite view of approach B. It generates the numbers
that don't fulfil the be-a-multiple-of condition, and subtract them for the sum
of all the number smaller than `bound`.

Which of the approaches B and C is better depends on the circumstances. If the
fraction of the multiples to consider is less than 50% of the naturals, then
approach B is better; otherwise it is approach C. In the context of the Euler
problem, the common multiples of 3 and 5 represent 1/3 + 1/5 - 1/15 = 7/15 of
the numbers, so approach B is better in this case.