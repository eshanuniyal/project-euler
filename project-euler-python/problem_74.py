# ---------------------------------------------------------------
# Project Euler Problem 74 | Eshan Uniyal
# February 2018, Python 3
# The number 145 is well known for the property that the sum of the factorial of its digits is equal to 145:
    # 1! + 4! + 5! = 1 + 24 + 120 = 145
# Perhaps less well known is 169, in that it produces the longest chain of numbers that link back to 169;
#   it turns out that there are only three such loops that exist:
    # 169 → 363601 → 1454 → 169
    # 871 → 45361 → 871
    # 872 → 45362 → 872
# It is not difficult to prove that EVERY starting number will eventually get stuck in a loop. For example,
    # 69 → 363600 → 1454 → 169 → 363601 (→ 1454)
    # 78 → 45360 → 871 → 45361 (→ 871)
    # 540 → 145 (→ 145)
# Starting with 69 produces a chain of five non-repeating terms, but the longest non-repeating chain with a
#   starting number below one million is sixty terms.
# How many chains, with a starting number below one million, contain exactly sixty non-repeating terms?
# ---------------------------------------------------------------

import time
from math import factorial



upper = 10 ** 6

def main(limit):
    count = 0
    for num in range(1, limit + 1):
        condition = False
        chain = [num]
        while condition == False:
            next = 0
            for digit in str(chain[-1]):
                next += factorial(int(digit))
            if next not in chain:
                chain.append(next)
            else:
                # print(num, len(chain), chain)
                condition = True
        if len(chain) == 60:
            count += 1
    return(count)

timer.start()
print(main(upper))
timer.end()