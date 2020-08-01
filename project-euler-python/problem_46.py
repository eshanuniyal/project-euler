# ---------------------------------------------------------------
# Project Euler Problem 45 | Eshan Uniyal
# February 2018, Python 3 | Updated February 2018
# It was proposed by Christian Goldbach that every odd composite number can be written as the sum of a prime and twice a square.
    # 9 = 7 + 2×12
    # 15 = 7 + 2×22
    # 21 = 3 + 2×32
    # 25 = 7 + 2×32
    # 27 = 19 + 2×22
    # 33 = 31 + 2×12
# It turns out that the conjecture was false.
# What is the smallest odd composite that cannot be written as the sum of a prime and twice a square?
# ---------------------------------------------------------------

import timer



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
    n = 9
    conjecture = True
    while conjecture == True:
        if isPrime(n) == False:
            # print(n)
            condition = False
            for i in range(1, int(n ** 0.5) + 1):
                sq = i ** 2
                if isPrime(n - (2 * sq)) == True:
                    condition = True
                    break
            if condition == False:
                    conjecture = False
        if conjecture == True:
            n += 2
    return(n)


timer.start()
print(main())
timer.end()