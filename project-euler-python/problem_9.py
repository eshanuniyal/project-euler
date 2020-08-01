# ---------------------------------------------------------------
# Project Euler Problem 9 | Eshan Uniyal
# Devember 2017, Python 3 | Updated March 2018
# There exists exactly one Pythagorean triplet for which a + b + c = 1000.
# Find the product abc.
# ---------------------------------------------------------------

import timer

n = 1000
test = 24 # test for triplet 6, 8, 10

def main(limit):
    for a in range(1, limit):
        a2 = a ** 2
        for b in range(a, limit):
            c = (a2 + b ** 2) ** (1/2)
            if c.is_integer() and c <= limit:
                if a + b + c == limit:
                    return(int(a * b * c))
            if c > limit:
                break

timer.start()
print(main(n))
timer.end()