# ---------------------------------------------------------------
# Project Euler Problem 69 | Eshan Uniyal
# February 2018, Python 3
# It turns out that 12 cm is the smallest length of wire that can be bent to form an integer sided right angle triangle
# in exactly one way, but there are many more examples.
    # 12 cm: (3,4,5)
    # 24 cm: (6,8,10)
    # 30 cm: (5,12,13)
    # 36 cm: (9,12,15)
    # 40 cm: (8,15,17)
    # 48 cm: (12,16,20)
# In contrast, some lengths of wire, like 20 cm, cannot be bent to form an integer sided right angle triangle,
#   and other lengths allow more than one solution to be found; for example, using 120 cm it is possible to form
#   exactly three different integer sided right angle triangles.
# 120 cm: (30,40,50), (20,48,52), (24,45,51)
# Given that L is the length of the wire, for how many values of L ≤ 1,500,000 can exactly one integer sided
#   right angle triangle be formed?
# ---------------------------------------------------------------

import timer

upper = int(1.5 * 10 ** 6)

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

def main(limit): # runtime: 14 seconds
    # algorithm:
    # generate all primes up to limit
    primes = generator(limit + 1)

    # generate all prime factors for all numbers below said limit
    pFactors = {1 : [1]}
    for i in range(2, limit + 1):
        pFactors[i] = []

    for prime in primes:
        maxMult = (limit + 1) // prime
        while maxMult * prime > limit:
            maxMult -= 1
        for mult in range(1, maxMult + 1):
            pFactors[prime * mult].append(prime)

    # generating prime triplets
    triplets = []
    for n, nFactors in pFactors.items():
        maxM = int((- n + ((n ** 2 + 2 * limit) ** 0.5)) / 2) + 2
        if n % 2 == 0: # if n is even, then m can be even/odd
            ms = [x for x in range(n + 1, maxM)]
        else: # if n is even, m must be odd
            ms = [x for x in range(n + 1, maxM, 2)]

        if maxM > n:
            for m in ms:
                mFactors = pFactors[m]
                condition = True
                for factor in nFactors:
                    if factor in mFactors:
                        condition = False
                        break

                if condition == True:
                    a = m ** 2 - n ** 2
                    b = 2 * m * n
                    c = m ** 2 + n ** 2
                    if a + b + c <= limit:
                        triplet = [a, b, c]
                        triplet.sort()
                        triplets.append(triplet)

                        maxMult = int(limit / (a + b + c)) + 1
                        while (a + b + c) * maxMult > limit:
                            maxMult -= 1

                        for i in range(2, maxMult + 1):
                            newTriplet = [i * a, i * b, i * c]
                            triplets.append(newTriplet)

    # computing each triplets' totals
    totals = {}
    for triplet in triplets:
        total = 0
        for n in triplet:
            total += n
        if total not in totals:
            totals[total] = 1
        else:
            totals[total] += 1

    # checking the number of triplets per total
    count = 0
    for key, value in totals.items():
        if value == 1:
            count += 1

    return(count)

timer.start()
print(main(upper))
timer.end()