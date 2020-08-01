# ---------------------------------------------------------------
# Project Euler Problem 15 | Eshan Uniyal
# February 2018, Python 3
# Starting in the top left corner of a 2×2 grid, and only being able to move to the right and down,
# there are exactly 6 routes to the bottom right corner.
# How many such routes are there through a 20 × 20 grid?
# ---------------------------------------------------------------
# Analysis: Describing the problem on a Cartesian plane, we see that we need 20 down moves and 20 right moves to
#   reach the bottom right corner. We therefore essentially need to find the number of permutations of a list with 40 objects,
#   20 each being D and R.

import timer
from math import factorial


size = 400

def main(gridsize):
    return(factorial(2 * gridsize) // (factorial(gridsize) ** 2))

timer.start()
print(main(size))
runtime()