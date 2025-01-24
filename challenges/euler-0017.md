# Euler problem <Id>: Number Letter Counts

## Statement

If the numbers $1$ to $5$ are written out in words: one, two, three, four, five,
then there are $3 + 3 + 5 + 4 + 4 = 19$ letters used in total.

If all the numbers from $1$ to $1000$ (one thousand) inclusive were written out
in words, how many letters would be used? 

**NOTE:** Do not count spaces or hyphens. For example, $342$ (three hundred and
forty-two) contains $23$ letters and $115$ (one hundred and fifteen) contains
$20$ letters. The use of "and" when writing out numbers is in compliance with
British usage.


Reference: https://projecteuler.net/problem=17

## Reformulation 

Compute the number of letters needed to write the numbers from $1$ to $n$.

## Algorithm 

1. Let $\sigma\leftarrow0$ be an accumulator used to compute the result.
2. For each number $i$ in $1..n$:
   1. Let $w$ be the word form of $i$.
   2. Filter off the spaces and dashes from $w$.
   3. Let $s$ be the number of characters left after the filtering.
   4. Update $\sigma\leftarrow \sigma+s$.

At the end of the algorithm, the result is $\sigma$. 