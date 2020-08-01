# ---------------------------------------------------------------
# Project Euler Problem 20 | Eshan Uniyal
# November 2017, Python 3 | Updated March 2018
# Find the sum of the digits in the number 100!
# ---------------------------------------------------------------

n = 102

import time
from math import factorial




def alt(number):
    digits = [int(digit) for digit in str(factorial(number))]
    return(sum(digits))

timer.start()
print(main(n))
timer.end()