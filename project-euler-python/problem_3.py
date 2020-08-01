# ---------------------------------------------------------------
# Project Euler Problem 3 | Eshan Uniyal
# December 2017, Python 3 | Updated March 2018
# What is the largest prime factor of the number 600851475143 ?
# ---------------------------------------------------------------

import time

number = 600851475143
#currently able to manage up to 10 mil

def generator(limit): # brute-force; checks all numbers for being prime up to limit; much more effective than sieve of eratosthenes
    # takes 2 seconds to generate primes up to a million
    # takes 67 seconds to generate primes up to 10 million
    # takes 1161 seconds to generate primes up to 100 million
    primes = []
    for num in range(2, limit + 1):
        condition = True
        root = int(num ** 0.5) + 1
        for prime in primes:
            if num % prime == 0:
                condition = False
                break
            if prime > root:
                break
        if condition == True:
            primes.append(num)
    return(primes)

def main(num):
    n = int(num ** 0.5)
    primes = generator(n)
    primes.reverse() # reverses the list of primes to start searching from the highest primes
    for prime in primes:
        if num % prime == 0: #  returns the first prime to match
            return(prime)

timer.start()
print(main(number))
runtime()