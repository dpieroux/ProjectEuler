# Euler problem 2: Even Fibonacci Numbers

## Statement

Each new term in the Fibonacci sequence is generated by adding the previous two
terms. By starting with $1$ and $2$, the first $10$ terms will be: $1, 2, 3, 5,
8, 13, 21, 34, 55, 89, \dots$

By considering the terms in the Fibonacci sequence whose values do not exceed
four million, find the sum of the even-valued terms.

Reference: https://projecteuler.net/problem=2

## Reformulation

Find the sum of the even terms in the Fibonacci sequence whose values do not
exceed a bound $N$.

## Algorithm

The even Fibonacci numbers appear with a period of 3 in the sequence. Let's
derive a recurrence formula to compute them directly:

* $f_{n+3} = f_{n+2} + f_{n+1} \Rightarrow f_{n+1} = (f_{n+3} - f_n)/2$
* $f_{n+2} = f_{n+1} + f_n = (f_{n+3} + f_n)/2$
* $f_{n+4} = f_{n+3} + f_{n+2} (3 f_{n+3} + f_n)/2$
* $f_{n+5} = f_{n+4} + f_{n+3} = (5 f_{n+3} + f_n)/2$
* $f_{n+6} = f_{n+5} + f_{n+4} = 4 f_{n+3} + f_n$

Thus every three Fibonacci numbers are bound together by the relation $f_{n+6} =
4 f_{n+3} + f_n$. Therefore, the even Fibonacci numbers are generated by the
relation $a_{n+2} = 4 a_{n+1} + a_{n}$, with $a_1=2$ and $a_2=8$.

The algorithm consists in generating the even Fibonacci terms $a$ up to $N$
included using the formula above and adding them together in an accumulator
$\sigma$.

1. Let $\sigma\leftarrow 0$.
2. For each term $a$ of the sequence $a_{n+2}=4a_{n+1}+a_{n}$ starting with $2$
   and $8$:
   1. If $a\le N$, 
      1. Update $\sigma\leftarrow \sigma+a$
      2. Loop back at 2.
   2. Otherwise the algorithm ends.

At the completion of the algorithm, the solution is $\sigma$.