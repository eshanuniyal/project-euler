# ---------------------------------------------------------------
# Project Euler Problem 80 | Eshan Uniyal
# February 2018, Python 3
# It is well known that if the square root of a natural number is not an integer, then it is irrational.
# The decimal expansion of such square roots is infinite without any repeating pattern at all.
# The square root of two is 1.41421356237309504880..., and the digital sum of the first one hundred decimal digits is 475.
# For the first one hundred natural numbers,
# find the total of the digital sums of the first one hundred decimal digits for all the irrational square roots.
# ---------------------------------------------------------------

import time
from decimal import getcontext, Decimal



upper = 100
getcontext().prec = 102

def main(limit):
    roots = []
    total = 0
    for n in range(1, limit + 1):
        root = Decimal(n).sqrt()
        rootTotal = 0
        if root % 1 != 0:
            strRoot = str(root)
            for digit in strRoot[0 : 101]:
                if digit != ".":
                    rootTotal += int(digit)
            # print(root, rootTotal)
            total += rootTotal
    return(total)

timer.start()
print(main(upper))
timer.end()