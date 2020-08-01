# ---------------------------------------------------------------
# Project Euler Problem 40 | Eshan Uniyal
# January 2018, Python 3
# An irrational decimal fraction is created by concatenating the positive integers:
# 0.123456789101112131415161718192021...
# It can be seen that the 12th digit of the fractional part is 1.
# If dn represents the nth digit of the fractional part, find the value of the following expression.
# d1 × d10 × d100 × d1000 × d10000 × d100000 × d1000000
# ---------------------------------------------------------------

import timer



def main():
    num = "0."
    i = 1
    while len(num) < (10 ** 6) + 2: # length of fractional part must be a million; +2 because of "0."
        num += str(i)
        i += 1

    j = 0
    prod = 1
    for j in range(0, 7):
        print(num[(10 ** j) + 1])
        prod *= int(num[(10 ** j) + 1])
    return(prod)

timer.start()
print(main())
timer.end()