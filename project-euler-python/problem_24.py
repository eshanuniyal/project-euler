# ---------------------------------------------------------------
# Project Euler Problem 24 | Eshan Uniyal
# December 2017, Python 3
# A permutation is an ordered arrangement of objects. For example, 3124 is one possible permutation of the digits 1, 2, 3 and 4.
#   If all of the permutations are listed numerically or alphabetically, we call it lexicographic order. The lexicographic permutations
#   of 0, 1 and 2 are: 012, 021, 102, 120, 201, 210
# What is the millionth lexicographic permutation of the digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?
# ---------------------------------------------------------------

import timer
import itertools



def lexicographies():
    digits = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    lexlists = list(itertools.permutations(digits))
    lexs = []
    ans = lexlists[(10 ** 6) - 1]
    ans = map(str, ans)
    answer = int(''.join(ans))
    return(answer)

timer.start()
print(lexicographies())
runtime()