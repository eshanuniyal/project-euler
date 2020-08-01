# ---------------------------------------------------------------
# Project Euler Problem 72 | Eshan Uniyal
# February 2018, Python 3
# Consider the fraction, n/d, where n and d are positive integers. If n<d and HCF(n,d)=1, it is called a reduced proper fraction.
# If we list the set of reduced proper fractions for d ≤ 8 in ascending order of size, we get:
    # 1/8, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 3/8, 2/5, 3/7, 1/2, 4/7, 3/5, 5/8, 2/3, 5/7, 3/4, 4/5, 5/6, 6/7, 7/8
# It can be seen that there are 21 elements in this set.
# How many elements would be contained in the set of reduced proper fractions for d ≤ 1,000,000?
# ---------------------------------------------------------------

import time



upper = 10 ** 6

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

def isPrime(num):
    condition = True
    if num < 2:
        condition = False
    elif num == 2:
        condition = True
    else:
        for i in range(2, int(num ** 0.5) + 2):
            if num % i == 0:
                condition = False
                break
    return(condition)

def main(limit): # takes ten  seconds for limit = 10 ** 6
    # algorithm:
    # for any denominator d, the number of numerators n such that n / d is in reduced form is given by
    # the number of numbers smaller than d that are relatively prime to it, or the totient function of d
    print("Compiling primes...")
    primes = generator(limit + 1)  # generates all primes upto limit
    timer.end()

    pFactors = {}
    for i in range(2, limit + 1):
        pFactors[i] = []

    for prime in primes:
        maxMult = (limit + 1) // prime
        while maxMult * prime > limit:
            maxMult -= 1
        for mult in range(1, maxMult + 1):
            pFactors[prime * mult].append(prime)

    print("Compiling totient functions...")
    count = 0
    for num, factors in pFactors.items():
        if isPrime(num) == True: # condition for num being prime
            phi = num - 1
        else:
            phi = num
            for factor in factors:
                phi *= (1 - 1 / factor)
            phi = int(phi)
        # print(num, factors, phi)
        count += phi

    return(count)

timer.start()
print(main(upper))
timer.end()