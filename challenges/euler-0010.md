# Euler problem 10: Summation of Primes

## Statement

The sum of the primes below $10$ is $2 + 3 + 5 + 7 = 17$.

Find the sum of all the primes below two million.

Reference: https://projecteuler.net/problem=10

## Reformulation 

Find the sum of all the primes below $N$.

## Algorithm 

1. Create a sieve of Eratosthenes of size $N$.
2. Sum the indices of the sieve for which the corresponding value is `#t`.