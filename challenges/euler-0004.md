# Euler problem 4: Largest Palindrome Product

## Statement

A palindromic number reads the same both ways. The largest palindrome made from
the product of two $2$-digit numbers is $9009 = 91 \times 99$.

Find the largest palindrome made from the product of two $3$-digit numbers.

Reference: https://projecteuler.net/problem=4

## Reformulation

Find the largest palindrome made from the product of two $n$-digit numbers.

## Algorithm 

The approach consists in 
1. Iterating over all the pairs of $n$-digit numbers $i$ and $j$ with $i\le j$,
   by lexicographic decreasing order.
2. Recording the largest product $ij$ that is palindromic and was generated so
   far.
3. Stopping iterating as soon as the pairs not yet considered are not in
   position to produce a larger palindrome anymore.

The corresponding algorithm is as follows:
1. Let
   1. $b_0\leftarrow 10^{n-1}$ be the smallest $n$-digit number.
   2. $b_1\leftarrow 10^n-1$ bet the largest $n$-digit number.
   3. $p\leftarrow -1$ be the largest palindromic number found so far.
2. For each number $i$ from $b_1$ down to $b_0$ included:
   1. Stop if $b_1i\le p$ as $b_1i$ is the largest number that can be generated
      from $i$.
   2. For each number $j$ in decreasing order from $b_1$ down to $i$ included:
      1. Update $p\leftarrow ij$ if $p<ij$.

The algorithm stops when the condition in step 2.1 is fulfilled. $p$ then
contains the solution to the problem.

Note: the algorithm would still work without the step 2.1. However, it would be
much slower as many more pairs ($i$, $j$) would be considered uselessly.