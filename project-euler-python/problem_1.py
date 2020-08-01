# ---------------------------------------------------------------
# Project Euler Problem 1 | Eshan Uniyal
# November 2017, Python 3 | Updated March 2018
# Find the sum of all the multiples of 3 or 5 below 1000.
# ---------------------------------------------------------------

import timer

def main():
    list = [x for x in range(1, 1000) if x % 3 == 0 or x % 5 == 0]
    return(sum(list))

timer.start()
print(main())
timer.end()