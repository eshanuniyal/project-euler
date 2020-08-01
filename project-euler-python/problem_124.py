# ---------------------------------------------------------------
# Project Euler Problem 124 | Eshan Uniyal
# June 2018, Python 3
# The radical of n, rad(n), is the product of the distinct prime factors of n.
#   For example, 504 = 23 × 32 × 7, so rad(504) = 2 × 3 × 7 = 42.
# Let E(k) be the kth element in the sorted n column; for example, E(4) = 8 and E(6) = 9.
# If rad(n) is sorted for 1 ≤ n ≤ 100000, find E(10000).
# ---------------------------------------------------------------

import timer, itertools
from math import factorial



upper = 10 ** 5
e = 10 ** 4

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
    # generates prime factors up to 10 ** 7 in 28 seconds
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
            if factor not in dict[num]: # remove this line to generate non-unique prime factors as well
                dict[num].append(factor)
        return(dict[num])

def main(limit, E):

    primes = sieve(limit)

    dict = {}
    for prime in primes:
        dict[prime] = [prime]
    for num in range(2, limit + 1):
        recFactors(num, primes, dict)

    # print(dict)

    for n, factors in dict.items():
        rad_n = 1
        for factor in factors:
            rad_n *= factor
        dict[n] = rad_n

    dict[1] = 1 # to add 1 to the dictionary, which wasn't included up till now for primes' sake

    list = [x for x in range(1, limit + 1)]
    return(sorted(dict, key = dict.get)[E - 1])


timer.start()
print(main(upper, e))
timer.end()