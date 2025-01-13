# Euler project: Solving all the problems at once

This program computes the solutions to all of the Project Euler problems in
sequence.

Actually, the folder `challenges` is searched for all the files whose name
matches with `euler-<n>.rkt`, where `<n>` refers to a Euler problem number.

Each of these files defines two argumentless functions:
  * `test` computes the solution to the example problem and returns `#t` if
     the expected answer is found; otherwise, it returns `#f`.
  * `solve` computes the solution to the actual problem.

`test` is first called. If it returns `#t`, `solve` is called and its output is
displayed together with timing information. However, if `test` returns `#f`, the
failure is reported and no attempt is made to solve the actual problem.

At the end of the execution, the number of successful and failed (if any) tests
is reported.
