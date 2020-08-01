# ---------------------------------------------------------------
# Project Euler Problem 50 | Eshan Uniyal
# February 2018, Python 3 | Updated February 2018
# The prime 41, can be written as the sum of six consecutive primes:
# 41 = 2 + 3 + 5 + 7 + 11 + 13
# This is the longest sum of consecutive primes that adds to a prime below one-hundred.
# The longest sum of consecutive primes below one-thousand that adds to a prime, contains 21 terms, and is equal to 953.
# Which prime, below one-million, can be written as the sum of the most consecutive primes?
# ---------------------------------------------------------------

import timer



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

def main(limit):
    primes = generator(limit)
    totals = {}
    for startPrime in primes[0 : -1]:
        # print(startPrime)
        startIndex = primes.index(startPrime)
        i = 1
        total = startPrime
        while total <= limit:
            total += primes[startIndex + i]
            if isPrime(total) == True and total not in totals and total <= limit:
                totals[total] = i + 1
            i += 1
    # print(totals)
    maxval = 0
    ans = 0
    for key, value in totals.items():
        if value > maxval:
            maxval = value
            ans = key
    print(ans)

timer.start()
main(upper)
timer.end()