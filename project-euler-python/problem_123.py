# ---------------------------------------------------------------
# Project Euler Problem 123 | Eshan Uniyal
# February 2018, Python 3
# Let Pn be the nth prime: 2, 3, 5, 7, 11, ..., and let r be the remainder when (Pn − 1)^n + (Pn + 1)^n is divided by Pn^2.
# For example, when n = 3, P3 = 5, and 43 + 63 = 280 ≡ 5 mod 25.
# The least value of n for which the remainder first exceeds 10^9 is 7037.
# Find the least value of n for which the remainder first exceeds 10^10.
# ---------------------------------------------------------------

import timer



def generator(limit): # brute-force; checks all numbers for being prime up to limit; much more effective than sieve of eratosthenes
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

def main():
    primes = generator(10 ** 6)
    for i in range(0, len(primes)):
        prime = primes[i]
        index = i + 1
        remainder = ((prime - 1) ** index + (prime + 1) ** index) % (prime ** 2)
        # print(remainder)
        if remainder >= 10 ** 10:
            return(index)

timer.start()
print(main())
timer.end()

