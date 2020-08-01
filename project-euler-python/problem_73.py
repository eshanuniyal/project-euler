# ---------------------------------------------------------------
# Project Euler Problem 73 | Eshan Uniyal
# February 2018, Python 3
# Consider the fraction, n/d, where n and d are positive integers. If n<d and HCF(n,d)=1, it is called a reduced proper fraction.
# If we list the set of reduced proper fractions for d ≤ 8 in ascending order of size, we get:
# 1/8, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 3/8, 2/5, 3/7, 1/2, 4/7, 3/5, 5/8, 2/3, 5/7, 3/4, 4/5, 5/6, 6/7, 7/8
# It can be seen that there are 3 fractions between 1/3 and 1/2.
# How many fractions lie between 1/3 and 1/2 in the sorted set of reduced proper fractions for d ≤ 12,000?
# ---------------------------------------------------------------

import timer



d = 12000

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

def pFactors(limit, primes):
    # generates dictionary of all unique prime factors of all numbers up to input number given list of primes
    pFactors = {}
    for i in range(2, limit + 1):
        pFactors[i] = []

    for prime in primes:
        maxMult = (limit + 1) // prime
        while maxMult * prime > limit:
            maxMult -= 1
        for mult in range(1, maxMult + 1):
            pFactors[prime * mult].append(prime)
    return(pFactors)

def main(maxDen): # takes about 10 minutes to run
    print("Generating primes...")
    primes = generator(d)
    print("Primes generated.")
    timer.end()
    print("Generating prime factors...")
    factors = pFactors(maxDen, primes)

    fractions = []
    for den, denFactors in factors.items():
        for num in range(int(den * (1 / 3)) - 1, int(den * (1 / 2)) + 1):
            condition = True
            for factor in denFactors:
                if num % factor == 0:
                    condition = False
                    break
            if condition == True and num / den > 1 / 3 and num / den < 1 /2:
                fractions.append([num, den, num / den]) # only appends to the list of fractions if ratio is less than 3 / 7
    print("Fractions generated.")

    timer.end()
    return(len(fractions))

timer.start()
print(main(d))
timer.end()
