# Euler problem 15: Lattice Paths

## Statement
Starting in the top left corner of a $2 \times 2$ grid, and only being able to
move to the right and down, there are exactly $6$ routes to the bottom right
corner:

1. $\rightarrow\rightarrow\downarrow\downarrow$
2. $\rightarrow\downarrow\rightarrow\downarrow$
3. $\rightarrow\downarrow\downarrow\rightarrow$
4. $\downarrow\rightarrow\rightarrow\downarrow$
5. $\downarrow\rightarrow\downarrow\rightarrow$
5. $\downarrow\downarrow\rightarrow\rightarrow$

How many such routes are there through a $20 \times 20$ grid?

Reference: https://projecteuler.net/problem=15

## Reformulation 

How many such routes are there through a $M×N$ grid?

## Algorithm 

Basically, we have to do $M$ moves in one direction, and $N$ moves in the other
ones, but in any order. So, the number of possibilities is $C_{n+m}^n$. Here, we
have $n=m=20$, and thus the solution is $C_{40}^{20}$.