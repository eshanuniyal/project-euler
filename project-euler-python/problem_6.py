# ---------------------------------------------------------------
# Project Euler Problem 6 | Eshan Uniyal
# November  2017, Python 3 | Updated March 2018
# Find the difference between the sum of the squares of the
#   first one hundred natural numbers and the square of the sum.
# ---------------------------------------------------------------

import timer



n = 100

def main(n):
    sum = n / 2 * (n + 1)
    square_of_sum = sum ** 2
    sum_of_squares = (n / 6) * (n + 1) * (2*n + 1)
    diff = int(square_of_sum - sum_of_squares)
    print(f"Alternative method: the difference between the two is {diff}.")

timer.start()
main(n)
timer.end()