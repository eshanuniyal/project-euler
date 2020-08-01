# ---------------------------------------------------------------
# Project Euler Problem 120 | Eshan Uniyal
# July 2018, Python 3
# Let r be the remainder when (a−1)n + (a+1)n is divided by a2.
# For example, if a = 7 and n = 3, then r = 42: 63 + 83 = 728 ≡ 42 mod 49.
#   And as n varies, so too will r, but for a = 7 it turns out that rmax = 42.
# For 3 ≤ a ≤ 1000, find ∑ rmax.
# ---------------------------------------------------------------

import timer
from math import sqrt



floor, ceiling = 3, 1000

def main(floor, ceiling):
    """algorithm: through some experimentation, found out that the for all odd a, the maximum remainder r
        is always a^2 - a, and that for all even a, it's a^2 - 2a"""
    total = 0
    for a in range(floor, ceiling + 1):
        if a % 2 == 1: # if a is odd
            total += a**2 - a
        else:
            total += a**2 - 2*a
    return(total)


timer.start()
print(main(floor, ceiling))
timer.end()