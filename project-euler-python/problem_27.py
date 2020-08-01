# ---------------------------------------------------------------
# Project Euler Problem 27 | Eshan Uniyal
# January 2018, Python 3 | Updated December 2018
# Euler discovered the remarkable quadratic formula:
# n2 + n + 41
# It turns out that the formula will produce 40 primes for the consecutive integer values 0 ≤ n ≤ 39.
# However, when n = 40,40^2 + 40 + 41 = 40(40 + 1) + 41 is divisible by 41, and certainly when n = 41, 41^2 + 41 + 41 is clearly divisible by 41.
# The incredible formula n^2 − 79n + 1601 was discovered, which produces 80 primes for the consecutive values 0 ≤ n ≤ 79.
# The product of the coefficients, −79 and 1601, is −126479.
# Considering quadratics of the form:
#     n^2 + an + b
# , where |a| < 1000 and |b| ≤ 1000
# Find the product of the coefficients, a and b, for the quadratic expression that produces the maximum number of
# primes for consecutive values of n, starting with n = 0.
# ---------------------------------------------------------------

import timer

import sys
sys.path.append("C:\\Users\\eshan\\Desktop\\python_projects\\other_programs")
from prime_checker import is_prime



def equation(a, b, n):
    return((n ** 2) + (a * n) + b)

def main():
    abn = []
    for a in range(-999, 1000):
        for b in range(-1000, 1001):
            n = 0
            while is_prime(equation(a, b, n)) == True:
                n += 1
            if n > 0:
                abn.append([a, b, n])
    nlens = []
    for set in abn:
        nlens.append(set[2])
    nMax = max(nlens)
    for set in abn:
        if set[2] == nMax:
            answer = set[0] * set[1]
            return(answer)


timer.start()
print(main())
timer.end()