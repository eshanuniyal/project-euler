# ---------------------------------------------------------------
# Project Euler Problem 58 | Eshan Uniyal
# February 2018, Python 3
# Starting with 1 and spiralling anticlockwise in the following way, a square spiral with side length 7 is formed.
    # 37 36 35 34 33 32 31
    # 38 17 16 15 14 13 30
    # 39 18  5  4  3 12 29
    # 40 19  6  1  2 11 28
    # 41 20  7  8  9 10 27
    # 42 21 22 23 24 25 26
    # 43 44 45 46 47 48 49
# It is interesting to note that the odd squares lie along the bottom right diagonal, but what is more interesting
#   is that 8 out of the 13 numbers lying along both diagonals are prime; that is, a ratio of 8/13 ≈ 62%.
# If one complete new layer is wrapped around the spiral above, a square spiral with side length 9 will be formed.
# If this process is continued, what is the side length of the square spiral for which the ratio of primes along
#   both diagonals first falls below 10%?
# ---------------------------------------------------------------

import time



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

def main(): # runtime of about 17 seconds
    diagonalNums = [1]
    condition, step, size, primeCount = False, 2, 3, 0

    while condition == False:
        init = max(diagonalNums)
        for i in range(init + step, init + 5 * step, step):
            diagonalNums.append(i)
            if isPrime(i) == True:
                primeCount += 1

        if primeCount / len(diagonalNums) < 0.1:
            return(size)

        step += 2
        size += 2


timer.start()
print(main())
timer.end()
