# ---------------------------------------------------------------
# Project Euler Problem 7 | Eshan Uniyal
# November 2017, Python 3 | Updated March 2018
# What is the 10001st prime number?
# ---------------------------------------------------------------

import timer


n = 10001

def generator(n): # function that takes input n (representing the position of the nth prime number) and computes it
    primes, num = [], 2
    while True:
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
            if len(primes) == n:
                return(primes[-1])
        num += 1

timer.start()
print(generator(n))
timer.end()