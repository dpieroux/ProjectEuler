# Euler problem 9: Special Pythagorean Triplet

## Statement

A Pythagorean triplet is a set of three natural numbers, $a \lt b \lt c$, for
which, 

$$a^2 + b^2 = c^2.$$

For example, $3^2 + 4^2 = 9 + 16 = 25 = 5^2$.

There exists exactly one Pythagorean triplet for which $a + b + c =
1000$.

Find the product $abc$.

Reference: https://projecteuler.net/problem=9

## Reformulation 

Find the product $abc$ of the triplet $(a, b, c)$ such that
1. $1 <= a < b < c$,
2. $a+b+c=N$,
3. $(a, b, c)$ is a pythagorean triplet $a^2+b^2=c^2$,
4. $a$ is the smallest possible value satisfying the three conditions above.

## Algorithm 

Using Eq. 1 and 2, it comes $b \ge a+1$ and $c \ge b+1 \ge a+2$. Therefore $N\ge
3a+3$, that is:

$$ 1 \le a < ⌊N/3⌋$$

Eliminating $c$ from Eq. 3 using Eq. 2, and resolving for $b$, it comes:

$$ b = \frac{N(N-2a)}{2(N-a)}$$
  
So the algorithm is as follows:
1. Let $a\leftarrow 1$.
2. While $a<⌊N/3⌋$
   1. Let $b\leftarrow N(N-2a)/(2(N-a))$
   2. If $b$ is integer, then the solution is $ab(N-a-b)$.
   3. Otherwise, 
      1. Update $a\leftarrow a+1$
      2. Loop back to 2
3. No solution exists if this point is reached.