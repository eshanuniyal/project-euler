# ---------------------------------------------------------------
# Project Euler Problem 16 | Eshan Uniyal
# November 2017, Python 3 | Updated March 2018
# What is the sum of the digits of the number 2^1000?
# ---------------------------------------------------------------

import timer



n = 2 ** 1000

def main(n):
    digits = [int(digit) for digit in str(n)]
    return(sum(digits))

timer.start()
print(main(n))
timer.end()