# ---------------------------------------------------------------
# Project Euler Problem 52 | Eshan Uniyal
# February 2018, Python 3 | Updated February 2018
# It can be seen that the number, 125874, and its double, 251748, contain exactly the same digits, but in a different order.
# Find the smallest positive integer, x, such that 2x, 3x, 4x, 5x, and 6x, contain the same digits.
# ---------------------------------------------------------------

import timer


def digits(num):
    digits = []
    for digit in str(num):
        digits.append(int(digit))
    digits.sort()
    return(digits)

def main():
    condition = False
    i = 1
    while condition == False:
        # print(i)
        if digits(i) == digits(2 * i):
            if digits(2 * i) == digits(3 * i):
                if digits(3 * i) == digits(4 * i):
                    if digits(4 * i) == digits(5 * i):
                        if digits(5 * i) == digits(6 * i):
                            return(i)
        i += 1

timer.start()
print(main())
timer.end()