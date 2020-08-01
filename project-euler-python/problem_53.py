# ---------------------------------------------------------------
# Project Euler Problem 53 | Eshan Uniyal
# January 2018, Python 3
# There are exactly ten ways of selecting three from five, 12345:
# 123, 124, 125, 134, 135, 145, 234, 235, 245, and 345
# In combinatorics, we use the notation, 5C3 = 10.
# In general,
# nCr = n!/r!(n−r)!
# 	,where r ≤ n, n! = n×(n−1)×...×3×2×1, and 0! = 1.
# It is not until n = 23, that a value exceeds one-million: 23C10 = 1144066.
# How many, not necessarily distinct, values of  nCr, for 1 ≤ n ≤ 100, are greater than one-million?
# ---------------------------------------------------------------

import timer
from math import factorial



upper = 100
base = 10 ** 6

def combinations(n, r):
    nCr = int(factorial(n) / (factorial(r) * factorial(n - r)))
    return(nCr)

def main(limit, floor):
    greater = []
    for n in range(1, limit + 1):
        for r in range(1, n + 1):
            nCr = combinations(n, r)
            if nCr > floor:
                # print(n, r, nCr)
                greater.append([n, r, nCr])
    return(len(greater))

timer.start()
print(main(upper, base))
timer.end()