# ---------------------------------------------------------------
# Project Euler Problem 70 | Eshan Uniyal
# February 2018, Python 3
# Euler's Totient function, φ(n) [sometimes called the phi function], is used to determine the number of positive numbers
#   less than or equal to n which are relatively prime to n. For example, as 1, 2, 4, 5, 7, and 8, are all less than nine
#   and relatively prime to nine, φ(9)=6.
# The number 1 is considered to be relatively prime to every positive number, so φ(1)=1.
# Interestingly, φ(87109) = 79180, and it can be seen that 87109 is a permutation of 79180.
# Find the value of n, 1 < n < 10^7, for which φ(n) is a permutation of n and the ratio n/φ(n) produces a minimum.
# ---------------------------------------------------------------

import timer



upper = 10 ** 7

def digits(num): # finds and sorts all the digits of a number
    digits = []
    for digit in str(num):
        digits.append(int(digit))
    digits.sort()
    return(digits)

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

def main(limit): # takes 76 seconds for limit = 10 ** 7
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

    minRatio, answer = 10 ** 7,  0

    for num, factors in pFactors.items():
        if isPrime(num) == True: # condition for num being prime
            phi = num - 1
        else:
            phi = num
            for factor in factors:
                phi *= (1 - 1/factor)
            phi = int(phi)
        if num / phi < minRatio:
            if digits(phi) == digits(num):
                minRatio, answer = num / phi, num
                print(num, phi)
    return(answer)

timer.start()
print(main(upper))
timer.end()