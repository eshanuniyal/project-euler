# ---------------------------------------------------------------
# Project Euler Problem 10 | Eshan Uniyal
# November 2017, Python 3 | Updated December 2018
# Find the sum of all primes below two million.
# ---------------------------------------------------------------

import timer

import sys
sys.path.append("C:\\Users\\Eshan\\Desktop\\python_projects\\other_programs")
from primes_generator import segmented_sieve



n = 2 * 10**6

timer.start()
print(sum(segmented_sieve(n)))
timer.end()