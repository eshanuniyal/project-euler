# ---------------------------------------------------------------
# Project Euler Problem 47 | Eshan Uniyal
# February 2018, Python 3 | Updated February 2018
# The first two consecutive numbers to have two distinct prime factors are:
    # 14 = 2 × 7
    # 15 = 3 × 5
# The first three consecutive numbers to have three distinct prime factors are:
    # 644 = 2² × 7 × 23
    # 645 = 3 × 5 × 43
    # 646 = 2 × 17 × 19.
# Find the first four consecutive integers to have four distinct prime factors each. What is the first of these numbers?
# ---------------------------------------------------------------

import time



def pFactors(num, primes): #generates all unique prime factors of input number given list of primes upto that number
    pFactors = [] #creates a temporary list to store prime factorisation of x
    x = num #creates a variable num to be updated with every new prime factor
    while num != 1: #condition for terminating prime factorisation
        for prime in primes: #cycles through prime in allprimes
            if num % prime == 0: #checks whether num is divisible by prime
                if prime not in pFactors:
                    pFactors.append(prime) #if divisible, appends prime to pFactors
                num = num // prime #critical step: updates value of num so that smaller value can now be tested
                break
    return(pFactors)

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

def main():
    i = 1
    primes = generator(10 ** 6)
    condition = False
    while condition == False:
        # print(i)
        len1 = len(pFactors(i, primes))
        if len1 == 4:
            len2 = len(pFactors(i + 1, primes))
            if len2 == 4:
                len3 = len(pFactors(i + 2, primes))
                if len3 == 4:
                    len4 = len(pFactors(i + 3, primes))
                    # print(len1, len2, len3, len4)
                    if len4 == 4:
                        print(i, i + 1, i + 2, i + 3)
                        condition = True
                        return(i)
        i += 1

timer.start()
print(main())
runtime()