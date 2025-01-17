# Module: primes

## Functionality overview

An efficient generation of the prime number sequence ([OEIS
A000040](https://oeis.org/A000040)) is necessary for solving some [Project
Euler](https://projecteuler.net/) problems. 

A well-known, simple and efficient approach to generate prime numbers is the
[Sieve of Eratosthenes](https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes).
However, it requires an a-priori knowledge of the upper bound of the primes to
generate, and determining such a bound can be part of the problem itself. Also
three generators requiring no a-priori bound knowledge have also been developed.

### Sieve of Eratosthenes

`(prime-sieve n)` returns a [bit-vector](https://docs.racket-lang.org/data/bit-vector.html) of size $n$ such that, the $i$'th element with $0\le i<n$ is `#t` if $i$ is prime. 

### Generators

The interface is identical for the three generators, but for an extra-option in
the constructor of two of them, as discussed below.

`(make-prime-gen<n>)` with `<n>` being `1`, `2` or `3` returns a generator. As
an option for the second and third generators, a list of the first prime numbers
can be provided; e.g. `(make-prime-gen2 (2 3 5))`; otherwise, the sequence `(2 3
5 7 11)` is used by default. These prime numbers are used to bootstrap the
sequence generation. See the algorithm description below for a comprehensive
explanation.

With `gen` being a prime generator,
  * `(gen 'next)` produces and returns the next prime number;
  * `(gen 'current)` returns the latest produced prime number, or `'none` if no
    prime has been produced yet.
  * `(gen 'clone)` returns a deep copy of the generator. 

Example:
```
> (define prime-gen (make-prime-gen2))
> (build-list 10 (λ (_) (prime-gen 'next)))
'(2 3 5 7 11 13 17 19 23 29)
> (prime-gen 'current)
29
```

## Implementation

### Sieve of Eratosthenes

The implementation is a direct implementation of the Eratosthenes sieve
algorithm. A bit-vector is first created with all its elements set to `#t`. Then
the elements 0 and 1 are set to `#f` as $0$ and $1$ are not prime. From here,
the elements from index $2$ to $⌊\sqrt n⌋ included $ are checked. If such an element is
found to be `#t`, it is prime. In such a case, its multiples are set to `#f` in
the vector.

### Generator approach 1: Using racket `next-prime`

Racket offers the `next-prime` function, which returns the prime number
following the function argument. Therefore, generating primes consists in
calling that function repeatedly. 

### Generator approach 2: Number wheel based

The second algorithm requires that the first $n$ prime numbers, $p_1$, ..., and
$p_n$ be provided at the creation of the generator. If not provided, the
sequence `(2 3 5 7 11)` is used by default, as seen above. 

There is obviously no need to compute these $n$ first prime numbers as they are
provided to the generator at creation. So, it is enough to record and return
them one after another as output to the first $n$ calls. In addition, no
multiple of these prime numbers are themselves prime. So, the only prime
candidates left are the non-multiples of $p_1$, ..., and $p_n$, which can be
generated efficiently by a [number wheel](wheel-gen.md). In what follows, we
refer to that wheel that generates the prime candidates as `candidate-gen`.

The first number returned by `candidate-gen` is 1, which is immediately
discarded as 1 is not prime. The next number is the smaller natural larger than
1 that is not a multiple of any of the first $n$ prime numbers: it is $(n+1)$'th
prime number $p_{n+1}$. That number is stored in a list of primes, `primes`,
before being returned by the generator.

From now, every time a prime candidate is generated by `candidate-gen`, it is
checked if it is exactly divisible by an element of `primes`. If it is not the
case, the candidate is prime; it is then stored in `primes` before being
returned by the generator.

Notes: 
  * it is not necessary to store the prime numbers provided to the constructor
    in `primes` as `candidate-gen` generates only numbers that are not their
    multiples.
  * When checking if a candidate is divisible by an element of `primes`, it is
    enough to check for primes not larger than the candidate square root. 

### Generator approach 3: number wheel based revisited  

A more efficient approach based on number wheels is described in [M.E. O’NEILL
(2009)](https://www.cambridge.org/core/journals/journal-of-functional-programming/article/genuine-sieve-of-eratosthenes/FD3E90871269020CA6C64C25AB8A4FBD).
The algorithm is identical to the previous one, up to the generation of
$p_{n+1}$, but it does not store the prime numbers found beyond $p_n$ in a list
`primes`.

However, it still ensure that any further prime candidate that is a multiple of
$p_{n+1}$ gets discarded. Obviously, any such number that is also a multiple of
$p_1$, ..., or $p_n$ does not have to be considered as it will not be generated
by `candidate-gen`. So, we are left discarding only the prime candidates that
are equal to the product of $p_{n+1}$ with the non-multiple numbers of $\{p_1$,
..., $p_n\}$, the latter being equal to the current value of `candidate-gen`,
i.e. $p_{n+1}$, and the values that it will generate in the future. Therefore,
all we need to do is to clone `candidate-gen` and to create a new number
generator, `gen<1>`, that simply multiplies the values of that clone by
$p_{n+1}$. 

As a next step, we ask `candidate-gen` for other prime candidates until one is
found that it not generated by `gen<1>`. As this number is the smallest number
that is not a multiple of $p_1$, ..., $p_n$, or $p_{n+1}$, it is the next prime
number $p_{n+2}$. 

Similarly to what was done for $p_{n+1}$, it is necessary to ensure that any
further prime candidate that is a multiple of $p_{n+2}$ gets discarded. As
before, any such number that would also be a multiple of $p_1$, ..., or $p_n$
does not have to be considered as it will not be generated by `candidate-gen`.
So, following a similar reasoning as before, we create a new number generator
`gen<2>`, that simply multiplies the values of a new clone `candidate-gen` by
$p_{n+2}$. 

Continuing iteratively, we obtain the following algorithm. Suppose that 'n+m'
prime numbers have already been found. There are thus also `m` generators
`gen<1>`, `gen<2>`, ..., `gen<m>`.

  1. Ask `candidate-gen` to generate other prime candidates until one is found
     that it not generated by any of the `gen<i>`'s. That number is the next
     prime, $p_{n+m+1}$.
  2. Create the generator `gen<m+1>` by cloning `candidate-gen` and multiplying
     its output by $p_{n+m+1}$.
  3. Loop back at 1.

#### Using a heap

Each number generator, be it `candidate-gen` or one of the `gen<i>`'s, produces
an increasing sequence of numbers. Therefore, it is useless to test the
candidate prime against the current value of a `gen<n+i>` generator if the
latter is greater than the candidate prime. As a consequence, the `gen<n+i>`
generators are stored in a heap according to the current value, the generator
with the smallest current value being on the top of the heap. Doing so, the
following algorithm can be used:
* While the current value of the generator `gen<n+i>` at the top of the heap is
  smaller than the prime candidate, do:
  * iterate `gen<n+i>` until its value is equal or larger than the prime
    candidate;
  * update the heap as `gen<n+i>` could not be the generator with the smallest
    value anymore.
* At this stage, the value of the generator at the top of the heap is either
  equal to the prime candidate, or greater:
  * If it is equal, the prime candidate is actually a multiple of a previously
    found prime number; therefore it is not prime.
  * Otherwise, it is the next prime.

Note: Racket provides a heap. However, it is not possible to update the top
element: it is mandatory to remove it and to add it back. The drawback here is
that the topology of the heap is updated twice, with the deletion of one node
following by the creation of a new node. This leads to a lot of garbage to
collect, which is a major source of inefficiency. To avoid this, we have
developed a heap that allows updating the top element by moving it in the
existent heap tree. Thank to this, no node are deleted or created, which results
in a major boost of the performance. 

#### Redundant generation of the multiples of prime numbers

The multiples of $p_{n+1}.p_{n+2}$ that are not multiples of $p_1$, ..., or
$p_n$ are generated by both `gen<1>` and `gen<2>`. More generally, `gen<1>`,
`gen<2>`, ..., and `gen<m>` will produce all the multiples of the product
$p_{n+1}$ ... $p_{n+m}$ that are not multiples of $p_1$, ..., or $p_n$. This is
somewhat a source of inefficiency. Would it be possible to avoid that `gen<j>`
generates the multiples of $p_i$ for $i<j$? Well, this would require that
`gen<j>` be the product of $p_j$ with the output of a non-multiple wheel of
$p_1$, ..., and $p_{j-1}$. Unfortunately, the size of such a wheel increases as
the product of those primes numbers, as shown in the table below, and therefore
only a few prime numbers can reasonably be accounted for. Otherwise said, we
have to accept that inefficiency source.

| # Primes | # Wheel elements |
| :------: | :--------------: |
|    2     |        2         |
|    3     |        8         |
|    4     |        48        |
|    5     |       480        |
|    6     |       5760       |
|    7     |      92160       |

### Generator performance

The performance of the three algorithms has been compared and the result is that
the fastest algorithm depends on the number of prime numbers to generate:

Fastest algorithm | number of primes
------------------|-----------------
Algo 1 | below 94,000
Algo 2 | between 94,000 and 1,060,000
Algo 3 | above 1,060,000

In term of memory, the first algorithm stores no data; so, its memory
consumption does not depends on the number of prime numbers generated. Algorithm
2 stores the prime numbers found; so its memory consumption is proportional to
the number of prime numbers already generated (but the first $n$ ones).
Algorithm 3 makes a copy of the `candidate-gen` every time a new prime number is
found, and thus its memory consumption is also proportional to the number of
prime numbers already generated (excepted,again, the first $n$ ones). However,
such a copy consumes more memory than a mere number in a list. Therefore, its
footprint is significantly higher than for the algorithm 2. 