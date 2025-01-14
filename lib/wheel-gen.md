# Module: wheel-gen

This module implements the concept of number wheel generator, or wheel-gen for
short. Such a generator is typically used to produce the sequence of the
multiples, or the non-multiples, of a set of numbers.

## Introduction

Imaging a disk divided into n equal sectors numbered from 0 to n-1 in a
clockwise direction. Some sectors (at least one) display their number, while the
others are left black. The disk is positioned behind a wall with an aperture, so
that only one sector is visible at a time.

Set the initial position of the disk so that its smallest number aligns with the
aperture. Then rotate the disk clockwise. As you rotate, the numbers on the disk
become visible through the aperture in increasing order until the largest number
is reached. At that point, the next number to appear is the smallest one, and
the disk is back in its initial position. By adding an offset equal to the
number of sectors every time the disk completes a full rotation, an increasing
sequence of numbers is generated.

For instance, the 6-sector wheel displaying the numbers 0, 2, 3, and 4 generates
all the non-negative numbers that are a multiple of 2 or 3: 0, 2, 3, 4, 6, 8, 9,
10, 12, 14, 15, 16, ...

Similarly, the 6-sector wheel displaying the numbers 1 and 5 generates all the
non-negative numbers that are a not a multiple of 2 or 3: 1, 5, 7, 11, 13, 17,
19, 23, 25, 29...

## Functionalities 
### Wheel-gen interface

With `gen` being a wheel generator:
* `(gen 'next)` produces the next element and returns it.
* `(gen 'current)` returns the latest produced element, or `#f` if no element
  has been produced yet.
* `(gen 'clone)` returns a deep copy of the  instance.

### Wheel-gen constructors
* `(make-wheel-gen elems size)` returns a wheel-gen with elements `elems` and
  size `size`.
* `(make-multiples-gen ns)` returns a wheel-gen that produces the multiples of
  the `ns` elements.
* `(make-non-multiples-gen ns)` returns a wheel-gen that produces the
  non-multiples of the `ns` elements.

### Example

```
> (define my-gen (make-multiples-gen '(2 3)))
> (build-list 7 (λ (_) (my-gen)))
(1 5 7 11 13 17 19)
````