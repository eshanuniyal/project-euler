# ---------------------------------------------------------------
# Project Euler Problem 49 | Eshan Uniyal
# February 2018, Python 3 | Updated February 2018
# The arithmetic sequence, 1487, 4817, 8147, in which each of the terms increases by 3330,
#   is unusual in two ways: (i) each of the three terms are prime, and,
#   (ii) each of the 4-digit numbers are permutations of one another.
# There are no arithmetic sequences made up of three 1-, 2-, or 3-digit primes, exhibiting this property,
#   but there is one other 4-digit increasing sequence.
# What 12-digit number do you form by concatenating the three terms in this sequence?
# ---------------------------------------------------------------

import time



def generator(limit):
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
    else:
        for i in range(2, int(num ** 0.5) + 2):
            if num % i == 0:
                condition = False
                break
    return(condition)

def main():
    primes = generator(10 ** 4)
    startIndex = 0
    for prime in primes:
        if len(str(prime)) == 4:
            startIndex = primes.index(prime)
            break

    concatenated = []

    for p1 in primes[startIndex : ]:
        for p2 in primes[primes.index(p1) + 1 : ]:
            diff = p2 - p1
            p3 = p2 + diff
            if isPrime(p3) == True:

                digits1 = [x for x in str(p1)]
                digits2 = [x for x in str(p2)]
                digits3 = [x for x in str(p3)]
                digits1.sort()
                digits2.sort()
                digits3.sort()

                if digits1 == digits2 and digits2 == digits3:
                    concatenated.append(str(p1) + str(p2) + str(p3))

    return(concatenated[-1])


timer.start()
print(main())
timer.end()