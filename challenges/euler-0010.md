# Euler problem 10: Summation of Primes

## Statement

The sum of the primes below $10$ is $2 + 3 + 5 + 7 = 17$.

Find the sum of all the primes below two million.

Reference: https://projecteuler.net/problem=10

## Reformulation 

Find the sum of all the primes below $N$.

## Algorithm 

1. Let `gen` be a prime generator.
2. Let $\sigma\leftarrow 0$ be an accumulator.  
3. Let $p\leftarrow$ be the first prime number generated by `gen`.
4. while $p<N$:
   1. Update $\sigma\leftarrow \sigma+p$.
   2. Update $p\leftarrow$ the next prime number from `gen`.

At the completion of the algorithm, the solution is $\sigma$.