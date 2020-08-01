# ---------------------------------------------------------------
# Project Euler Problem 35 | Eshan Uniyal
# January 2018, Python 3
# The number, 197, is called a circular prime because all rotations of the digits: 197, 971, and 719, are themselves prime.
# There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37, 71, 73, 79, and 97.
# How many circular primes are there below one million?
# ---------------------------------------------------------------

import timer



upper = 1000000

def checker(limit): # brute-force; checks all numbers for being prime up to limit; much more effective than sieve of eratosthenes
    # takes 6 seconds to generate primes upto a million
    primes = []
    for num in range(2, limit + 1):
        condition = True
        for i in range(2, int(num ** 0.5) + 1):
                if num % i == 0:
                    condition = False
                    break
        if condition == True:
            primes.append(num)
    return(primes)

def main(limit):
    primes = checker(limit)
    circularPrimes = []
    for prime in primes:
        digits = [x for x in str(prime)]
        condition = True
        rotations = [prime]
        for digitpos in range(1, len(digits)):
            digit = digits[digitpos]
            rotation = str(digit)
            for i in range(digitpos + 1, len(digits)):
                rotation += str(digits[i])
            for i in range(0, digitpos):
                rotation += str(digits[i])
            rotation = int(rotation)
            rotations.append(rotation)
            if int(rotation) not in primes or len(str(rotation)) != len(str(prime)):
                condition = False
                break
        if condition == True:
            print(rotations)
            circularPrimes.append(prime)
    print(circularPrimes)
    return(len(circularPrimes))

timer.start()
print(main(upper))
timer.end()
