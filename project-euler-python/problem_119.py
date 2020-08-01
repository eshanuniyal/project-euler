# ---------------------------------------------------------------
# Project Euler Problem 119 | Eshan Uniyal
# June 2018, Python 3
# The number 512 is interesting because it is equal to the sum of its digits raised to some power: 5 + 1 + 2 = 8, and 83 = 512.
#   Another example of a number with this property is 614656 = 284.
# We shall define an to be the nth term of this sequence and insist that a number must contain at least two digits to have a sum.
# You are given that a2 = 512 and a10 = 614656.
# Find a30.
# ---------------------------------------------------------------

import time, math


n = 20

def digitSum(n):
    return(sum([int(digit) for digit in str(n)]))

def alt(n):
    integers = []
    powersDict = {}
    powers = []
    for i in range(2, 200):
        powersDict[i] = [i ** power for power in range(1, 10)]
    for key, powers in powersDict.items():
        for power in powers:
            if digitSum(power) == key and len(str(power)) >= 2:
                integers.append(power)
        integers.sort()

    return(integers[29])

timer.start()
print(alt(n))
timer.end()