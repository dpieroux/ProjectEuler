# Euler project: solving all problems at once

This program runs all the Euler solutions in sequence.

Actually, the folder `challenges` is searched for all the files whose name
matches with `euler-<id><tag>.rkt`, where 
* `<id>` is a number referring to the Euler problem it solved;
* `<tag>` is a letter referring to the algorithm variant.

Each of these files must defined two argumentless functions:
   - 'test', which computes the solution for the example problem. It must return
     #t if the expected answer is found, and #f otherwise.
   - 'solve', which computes the solution for the actual problem.

The 'test' function is first called. If it returns #t, the 'solve' function is
then called and its output is displayed together with timing information.
However, if the test function reports #f, the failure is reported and no attempt
is made to solve the actual problem.

At the end of the execution, the number of successful and failed (if any) tests
is reported.
