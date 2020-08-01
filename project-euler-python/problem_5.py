# ---------------------------------------------------------------
# Project Euler Problem 5 | Eshan Uniyal
# November  2017, Python 3 | Updated March 2018
# What is the smallest positive number that is evenly divisible
#   by all of the numbers from 1 to 20?
# ---------------------------------------------------------------

import timer

import sys
sys.path.append('C:\\Users\\eshan\\Desktop\\python_projects\\other_programs')
from primes_generator import sieve




n = 20

def main(upper):
    primes = sieve(upper)
    print(primes)
    factors = []

    for prime in primes:
        i = prime
        while i * prime <= upper:
            i *= prime
        factors.append(i)

    i = 1
    for num in factors:
        i *= num
    return(i)


timer.start()
print(main(n))
timer.end()