# Euler problem 8: Largest Product in a Series

## Statement

The four adjacent digits in the $1000$-digit number that have the greatest
product are $9 \times 9 \times 8 \times 9 = 5832$.

73167176531330624919225119674426574742355349194934
96983520312774506326239578318016984801869478851843
85861560789112949495459501737958331952853208805511
12540698747158523863050715693290963295227443043557
66896648950445244523161731856403098711121722383113
62229893423380308135336276614282806444486645238749
30358907296290491560440772390713810515859307960866
70172427121883998797908792274921901699720888093776
65727333001053367881220235421809751254540594752243
52584907711670556013604839586446706324415722155397
53697817977846174064955149290862569321978468622482
83972241375657056057490261407972968652414535100474
82166370484403199890008895243450658541227588666881
16427171479924442928230863465674813919123162824586
17866458359124566529476545682848912883142607690042
24219022671055626321111109370544217506941658960408
07198403850962455444362981230987879927244284909188
84580156166097919133875499200524063689912560717606
05886116467109405077541002256983155200055935729725
71636269561882670428252483600823257530420752963450

Find the thirteen adjacent digits in the $1000$-digit number that have the
greatest product. What is the value of this product?

## Reformulation 

Find the largest product $p$ of $n$ consecutive numbers in a sequence $S$ of $N$
numbers.

## Algorithm 

Assuming $i+n-1\le N$, $p_i=\prod_{j=0}^{n-1} S_{i+j}$ is the $i$'th product of
$n$ digits. Noting that $p_{i+1} = a_{i+n} p_i / a_i$ if $a_i \ne 0$, it is easy
to develop an algorithm with $O(N)$ time complexity. 

To start with, the product of any sub-sequence of $n$ numbers containing a zero
is equal to 0. So, the first step is to break $S$ at its 0's, so that no
subsequence $S_i$ contains 0. In addition, any $S_i$ containing less than $n$
elements can be discarded.

Doing so, the algorithm is
1. Let $\{S_i\}$ be the set of subsequences obtained by breaking $S$ at its zero
elements.
2. Update $\{S_i\}$ by filtering off the $S_i$'s whose lengths are smaller than
   $n$. 
3. Find the largest product $p_i$ of $n$ consecutive numbers in each sequence
   $S_i$.

The largest $p_i$ is the solution to the problem.

### Algorithm for Step 3

Step 3 decomposes as follows: To find the largest product $p$ of $n$ consecutive
non-zero numbers in a sequence $S$ of at least $n$ element:
1. Split $S_i$ in its first $n$'th elements and the rest:
   1. Let $[a] \leftarrow [l'_1, ..., l_n]$.
   2. Let $[b] \leftarrow [l_{n+1}, ...]$.
2. Let $c \leftarrow \prod a_i$ be the value of the current product.
3. Let $p \leftarrow c$ be the largest product so far.
4. While $[b]$ is not empty:
   1. Let $q \leftarrow b_1 p / l_1$.
   2. Update $p \leftarrow q$ if $p<q$.
   3. Update $[l] \leftarrow [l_2, ...]$.
   4. Update $[b] \leftarrow [b_2, ...]$.
   5. Loop back to 4. 

At the completion of the algorithm, the solution is $p$.

# Discussion

Another approach to find $p$ is to compute all the $p_i$'s and to record at all
steps the greatest one computed so far. This approach is more straightforward,
but it has $O(nN)$ time complexity.