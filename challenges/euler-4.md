# Euler problem 4: Largest Palindrome Product

## Statement

A palindromic number reads the same both ways. The largest palindrome made from
the product of two $2$-digit numbers is $9009 = 91 \times 99$.

Find the largest palindrome made from the product of two $3$-digit numbers.

Reference: https://projecteuler.net/problem=4

## Algorithm 

**Generalisation:** Find the largest palindrome made from the product of two
`n`-digit numbers.

The approach consists in 
1. Iterating over all the pairs of `n`-digit numbers `i` and `j` with `i≤j`,
   by lexicographic decreasing order.
2. Recording the largest product `i*j` that is palindromic and was generated so
   far.
3. Stopping iterating as soon as the pairs not yet considered are not in
   position to produce a larger palindrome anymore.

The corresponding algorithm is as follows:
1. Let's define the following values:
   1. `top` is the largest `n`-digit number: $10^n-1$.
   2. `bot` is the smallest `n`-digit number: $10^{n-1}$.
   3. `current` is the largest palindromic number currently found; it is  
      initialised to -1 as no palindrome has been found yet. 
2. For each number `i` from `top` down to `bot`:
   1. `i*top` being the largest number that can be generated using `i`, the
      algorithm stops if `i*top` is smaller than or equal to `current`.
   2. For each number `j` in decreasing order from `top` down to `i` included:
      1. Update `current` to `i*j` if that product is palindromic and larger
         than `current`.

The algorithm stops when the condition in step 2.1 is fulfilled. `current` then
contains the solution to the problem.

Note: the algorithm would still work without the step 2.1. However, it would be
much slower as many more pairs (`i`, `j`) would be considered uselessly.