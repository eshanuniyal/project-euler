# ---------------------------------------------------------------
# Project Euler Problem 78 | Eshan Uniyal
# April 2018, Python 3
# Let p(n) represent the number of different ways in which n coins can be separated into piles.
# For example, five coins can be separated into piles in exactly seven different ways, so p(5)=7.
    # OOOOO
    # OOOO   O
    # OOO   OO
    # OOO   O   O
    # OO   OO   O
    # OO   O   O   O
    # O   O   O   O   O
# Find the least value of n for which p(n) is divisible by one million.
# ---------------------------------------------------------------

import timer
from itertools import combinations



n = 10 ** 6

def sieve(limit):
    # currently takes about 23 seconds to compute primes upto 10 million

    numbers = set([x for x in range(2, limit + 1)]) # creates an empty dictionary to hold numbers

    composites = set([])
    for num in range(2, int(limit ** 0.5) + 1):
        maxMult = limit // num + 1

        for mult in range(2, maxMult + 1):
            composites.add(num * mult)

    primes = list(numbers.difference(composites))
    primes.sort()

    return(primes)

def recFactors(num, primes, dict):  # uses a recursive algorithm to generate distinct prime factors of
    # input number, and stores its results in an external dictionary
    # significantly faster than pFactors;
    # generates primes up to 10 ** 7 in 28 seconds
    # to generate all prime factors up to a limit, use in main:
        # dict = {}
        # for prime in primes:
        #     dict[prime] = [prime]
        # for num in range(2, limit + 1):
        #     recFactors(num, primes, dict)
    if num in dict:
        return (dict[num])
    else:
        x = num
        for prime in primes:
            if num % prime == 0:
                x = num // prime
                dict[num] = [prime]
                break
        for factor in recFactors(x, primes, dict):
            dict[num].append(factor)
        return(dict[num])

def kappa(n, factorsSumsDict, kappaDict):
    # algorithm from https://en.wikipedia.org/wiki/Partition_(number_theory)#Generating_function > Other Recurrence Relations
    summation = 0
    for k in range(0, n):
        summation += factorsSumsDict[n - k] * kappaDict[k]
    kappa_n = (1 / n) * summation
    kappaDict[n] = kappa_n
    return(kappa_n)


def main(req):
    primes, condition, i = sieve(10 ** 4), False, 2
    primeFactorsDict = {x : [x] for x in primes}
    factorsSumsDict = {1 : 1}
    kappaDict = {0 : 1, 1: 1} # by convention, p(0) = 1
    i = 2

    while condition == False:
        primeFactors = recFactors(i, primes, primeFactorsDict)
        combs = set([])
        for combLen in range(1, len(primeFactors) + 1):
            for subset in combinations(primeFactors, combLen):
                combs.add(subset)

        positiveFactors = [1]
        for combination in combs:
            product = 1
            for int in combination:
                product *= int
            positiveFactors.append(product)

        factorsSumsDict[i] = sum(positiveFactors)

        kappa_i = kappa(i, factorsSumsDict, kappaDict)
        print(i, kappa_i)

        if kappa_i % req == 0:
            print(i, kappaDict[i])
            print(kappaDict)
            return(i)

        i += 1


timer.start()
print(main(n))
runtime()