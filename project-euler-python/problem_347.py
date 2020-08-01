# ---------------------------------------------------------------
# Project Euler Problem 347 | Eshan Uniyal
# February 2018, Python 3
# The largest integer ≤ 100 that is only divisible by both the primes 2 and 3 is 96, as 96 = 32 * 3 = 2^5 * 3.
#   For two distinct primes p and q let M(p,q,N) be the largest positive integer ≤N only divisible by both p and q
#   and M(p,q,N)=0 if such a positive integer does not exist.
# E.g. M(2,3,100)=96.
# M(3,5,100)=75 and not 90 because 90 is divisible by 2 ,3 and 5.
# Also M(2,73,100)=0 because there does not exist a positive integer ≤ 100 that is divisible by both 2 and 73.
# Let S(N) be the sum of all distinct M(p,q,N). S(100)=2262.
# Find S(10 000 000).
# ---------------------------------------------------------------

import timer



upper = 10 ** 7

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

def alt(limit): # takes a minute to compute
    print("Generating primes... ")
    primes = generator(int(limit * 0.5) + 1)
    print("Primes generated.")
    runtime()

    total = 0
    for i in range(0, len(primes)):
        for j in range(i + 1, len(primes)):
            p = primes[i]
            q = primes[j]
            if p * q <= limit:
                maxpower1 = 1
                maxpower2 = 1
                while p ** (maxpower1 + 1) < int(limit / q) + 1:
                    maxpower1 += 1
                while q ** (maxpower2 + 1) < int(limit / p) + 1:
                    maxpower2 += 1
                powers = []
                for power1 in range(1, maxpower1 + 1):
                    for power2 in range(1, maxpower2 + 1):
                        product = p ** power1 * q ** power2
                        if product <= limit:
                            powers.append(product)
                        else:
                            break
                total += max(powers)
            else:
                break
    return(total)

timer.start()
print(alt(upper))
runtime()