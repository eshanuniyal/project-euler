# ---------------------------------------------------------------
# Project Euler Problem 41 | Eshan Uniyal
# January 2018, Python 3
# We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once.
# For example, 2143 is a 4-digit pandigital and is also prime.
# What is the largest n-digit pandigital prime that exists?
# ---------------------------------------------------------------

import timer, itertools, sys
sys.path.append("C:\\Users\\eshan\\Desktop\\python_projects\\other_programs")
from prime_checker import is_prime



def main():
    pandigitals = []
    for n in range(1, 10):
        digits = [x for x in range(1, n + 1)]
        potentials = list(itertools.permutations(digits))
        for potential in potentials:
            pan = map(str, potential)
            pandigital = int(''.join(pan))
            pandigitals.append(pandigital)

    primes = []
    for pandigital in pandigitals:
        if is_prime(pandigital) == True:
            primes.append(pandigital)

    return(max(primes))

timer.start()
print(main())
timer.end()