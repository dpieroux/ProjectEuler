# Euler problem 14: Longest Collatz Sequence

## Statement

The following iterative sequence is defined for the set of positive integers:

* $n \to n/2$ ($n$ is even)</br>
* $n \to 3n + 1$ ($n$ is odd)</br>

Using the rule above and starting with $13$, we generate the following sequence:
$$13 \to 40 \to 20 \to 10 \to 5 \to 16 \to 8 \to 4 \to 2 \to 1.$$

It can be seen that this sequence (starting at $13$ and finishing at $1$) contains $10$ terms. Although it has not been proved yet (Collatz Problem), it is thought that all starting numbers finish at $1$.

Which starting number, under one million, produces the longest chain?

**NOTE:** Once the chain starts the terms are allowed to go above one million.

Reference: https://projecteuler.net/problem=14

## Reformulation 

Which starting number $n$, under $N$, produces the longest chain?

## Algorithm 

The function $\text{len}$ that computes the length of a Collatz sequence
starting from a given number $n$ is defined by the following relation:
* $\text{len}(1) = 1$
* $\text{len}(n) = 1 + \text{len}(\text{next}(n))$
where $\text{next}$ is the Collatz function given above.

The algorithm is straightforward: 
1. Let $l \leftarrow 1$ be the longest path know up to now.
2. Let $n \leftarrow 1$ be the number $n$ corresponding to the longest path.
3. For each $i$ from 2 up to $N$ excluded,
   1. Update $l\leftarrow \text{len}(i)$ and $n \leftarrow i$ if $l < \text{len}(i)$.

At the end of the loop, $n$ contains the answer to the problem.

## Discussion

A naive and direct implementation of this algorithm is very slow as $\text{len}$
will be called repeatedly many times for same values of its argument. Therefore,
to have a decent speed, it is necessary to store the results of $\text{len}$ in
a table whose indices are the argument values. Doing so, whenever $\text{len}$
is called for a given $n$, it first checks if the table contains the result. If
it is the case, it returns it. Otherwise, it computes the result and stores it
in the table. Note that this look-up step is performed for every recursive call
of $\text{len}$, and not just for the first one.

If a fixed-length vector is used for the table, as we did, its index should at
least range from $1$ to $N-1$. However, a larger vector can be used as the
argument will go beyond $N-1$ during some of the recursive calls. At the same
time, it is difficult to assess the size that such a vector should have to store
all the values that the argument of $\text{len}$ will ever take for an initial
argument ranging from $1$ to $N-1$. So the approach that has been chosen is to
size the table up to a small multiple of $N$, and to just not use it for
arguments that are beyond its bound.  
