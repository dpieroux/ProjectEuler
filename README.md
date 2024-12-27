Project Euler Solutions
=======================

This repository contains my solutions to the [Project
Euler](https://projecteuler.net) challenge. These solutions are implemented in
the wonderful [Racket](https://www.racket-lang.org/) programming language.

**SPOILER ALERT:** This repository contains actual algorithm implementations
solving the problems proposed by the [Project Euler](https://projecteuler.net).
Please do not consult its contents if your goal is to solve the problems by
yourself.


Contents
--------
The root level contains the following files and folders:
  * `README.md`: the text you are reading now.
  * `LICENSE.md`: the license text under which the repository contents are
    released. 
  * `runme.rkt`: application to compute all the solutions at once. For each
    problem, a solution is first computed for the example mentioned in the
    problem statement. If it is equal to the provided solution, the solution to
    the actual problem is computed and displayed together with some timing
    information; otherwise, the failure of the algorithm is reported. Just type
    `racket runme.rkt` in the root folder to run it.
* `src/`: implementations of the solution(s) to the problems. That folder
    contains files named as `euler-<tag>.rkt`, where tag is a number referring
    to a problem and optionally followed by a letter designing an alternative
    solution, if any. For instance `euler-1.rkt` is my preferred solution to the
    first problem, while `euler-1b.rkt` and `euler-1c.rkt` are two alternatives.
    Each source file contains a comprehensive description of the approach used.
* `lib/`: implementation of general functionalities.


License
-------

The contents of this repository are released under the [MIT
license](https://opensource.org/license/mit). See `LICENSE.md`.