# ---------------------------------------------------------------
# Project Euler Problem 71 | Eshan Uniyal
# February 2018, Python 3
# Consider the fraction, n/d, where n and d are positive integers. If n<d and HCF(n,d)=1, it is called a
#   reduced proper fraction.
# If we list the set of reduced proper fractions for d ≤ 8 in ascending order of size, we get:
# 1/8, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 3/8, 2/5, 3/7, 1/2, 4/7, 3/5, 5/8, 2/3, 5/7, 3/4, 4/5, 5/6, 6/7, 7/8
# It can be seen that 2/5 is the fraction immediately to the left of 3/7.
# By listing the set of reduced proper fractions for d ≤ 1,000,000 in ascending order of size, find the numerator of
#   the fraction immediately to the left of 3/7.
# ---------------------------------------------------------------

import time



d = 10 ** 6

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

def main(maxDen): # takes about 10 minutes to run
    print("Generating primes...")
    primes = generator(d)
    print("Primes generated.")
    timer.end()
    print("Generating fractions...")
    fractions = []
    for den in range(2, maxDen + 1):
        print(den)
        factors = pFactors(den, primes)
        for num in range(int(den * (42857 / 10 ** 5)), int(den * (3 / 7)) + 1):
            condition = True
            for factor in factors:
                if num % factor == 0:
                    condition = False
                    break
            if condition == True:
                fractions.append([num, den, num / den]) # only appends to the list of fractions if ratio is less than 3 / 7
    print("Fractions generated.")
    timer.end()
    # print(fractions)
    calc = [fraction[2] for fraction in fractions]
    calc.sort()

    # print(calc)
    desiredVal = calc[-2]

    for fraction in fractions:
        if fraction[2] == desiredVal:
            return(fraction)

timer.start()
print(main(d))
timer.end()

