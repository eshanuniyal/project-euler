# ---------------------------------------------------------------
# Project Euler Problem 63 | Eshan Uniyal
# January 2018, Python 3
# The 5-digit number, 16807=75, is also a fifth power. Similarly, the 9-digit number, 134217728=89, is a ninth power.
# How many n-digit positive integers exist which are also an nth power?
# ---------------------------------------------------------------

import timer
from math import factorial



def main():
    xn = []
    numbers = []
    count = 0
    for n in range(0, 22):
        for x in range(0, 10):
            if 10 ** (n-1) <= x ** n < 10 ** n:
                xn.append([n, x, x ** n])
                numbers.append(x ** n)
    print(numbers)
    print(len(numbers))

timer.start()
main()
timer.end()