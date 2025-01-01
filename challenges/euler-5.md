# Euler problem 5: Smallest Multiple

## Statement

$2520$ is the smallest number that can be divided by each of the numbers from
$1$ to $10$ without any remainder.

What is the smallest positive number that is *evenly divisible* (divisible with
no remainder) by all of the numbers from $1$ to $20$?

Reference: https://projecteuler.net/problem=5

## Reformulation

Find the smallest positive number $s$ that is evenly divisible by all of the
numbers from $1$ to $n$.

## Algorithm 

Let $p \le n$ be a prime number and $e$ the greatest natural such that $p^e \le
n$. Obviously, $p^e$ being in the range $1\ldots n$, $s$ must be divisible by
$p^e$; at the same time, $s$ is not divisible by $p^{e+1}$ as $p^{e+1}$ is
beyond that range by definition of $e$. Therefore, the $p$ prime factor of $s$
is $p^e$.

With this in mind, the algorithm is as follows:

1. Let $s \leftarrow 1$.
2. For each prime $p$, in increasing order:
   1. If $p\le n$, 
      1. Compute the largest value $q=p^e\le n$:
         1. Let $q \leftarrow 1$
         2. While $q \le ⌊n/p⌋$: $q \leftarrow q p$.                  
      2. Update $s \leftarrow sq$.
      3. Loop back to 2.
   3. Otherwise, the algorithm ends.

At the completion of the algorithm, the solution is $s$.
   
## Discussion

$s$ is nothing else than the least common multiple (lcm) of the numbers from $1$
to $n$. Since Racket provides a `lcm` function, a trivial implementation
consists in applying `lcm` to the sequence of number $1\ldots n$: 
```
(apply lcm (range 1 (add1 n)))
```

For a small value of $n$, the two approaches are quite fast. However, for a
large-enough $n$, the `lcm`-based function becomes much more slower. For
instance:

```
> (- (euler 100000) (apply lcm (range 1 100001)))
0

> (collect-garbage 'major) (time (euler 100000) 'done)
cpu time: 15 real time: 59 gc time: 0
'done

> (collect-garbage 'major) (time (apply lcm (range 1 100001)) 'done)
cpu time: 1765 real time: 1949 gc time: 31
'done

> (collect-garbage 'major) (time (euler 250000) 'done)
cpu time: 187 real time: 232 gc time: 0
'done

> (collect-garbage 'major) (time (apply lcm (range 1 250001)) 'done)
cpu time: 10859 real time: 12164 gc time: 31
'done
```