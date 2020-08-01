# ---------------------------------------------------------------
# Project Euler Problem 48 | Eshan Uniyal
# February 2018, Python 3 | Updated February 2018
# The series, 1^1 + 2^2 + 3^3 + ... + 10^10 = 10405071317.
# Find the last ten digits of the series, 1^1 + 2^2 + 3^3 + ... + 1000^1000.
# ---------------------------------------------------------------

import timer



upper = 1000

def main(limit):
    total = 0
    for n in range(1, upper + 1):
        # print(total)
        total = (total + n ** n) % (10 ** 10)
    return(total)

timer.start()
print(main(upper))
timer.end()