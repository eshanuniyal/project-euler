# ---------------------------------------------------------------
# Project Euler Problem 87 | Eshan Uniyal
# March 2018, Python 3
# The smallest number expressible as the sum of a prime square, prime cube, and prime fourth power is 28.
# In fact, there are four numbers below fifty that can be expressed in such a way:
#   28 = 2^2 + 2^3 + 2^4
#   33 = 3^2 + 2^3 + 2^4
#   49 = 5^2 + 2^3 + 2^4
#   47 = 2^2 + 3^3 + 2^4
# How many numbers below 50 million can be expressed as the sum of a prime square, prime cube, and prime fourth power?
# ---------------------------------------------------------------

import timer



upper = 5 * 10 ** 7

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

def main(limit):
    primes = generator(int(limit ** 0.5) + 1)
    totals = {}
    for p1 in primes:
        # print(p1)
        a = p1 ** 2
        for p2 in primes:
            b = p2 ** 3
            if a + b < limit:
                for p3 in primes:
                    c = p3 ** 4
                    total = a + b + c
                    if total < limit:
                        if total not in totals:
                            totals[total] = 1
                        else:
                            totals[total] += 1
                    else:
                        break
            else:
                break
    # print(totals)
    return(len(totals))

timer.start()
print(main(upper))
timer.end()