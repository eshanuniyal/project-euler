# ---------------------------------------------------------------
# Project Euler Problem 62 | Eshan Uniyal
# February 2018, Python 3
# The cube, 41063625 (345^3), can be permuted to produce two other cubes: 56623104 (384^3) and 66430125 (405^3).
# In fact, 41063625 is the smallest cube which has exactly three permutations of its digits which are also cube.
# Find the smallest cube for which exactly five permutations of its digits are cube.
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
    ans = 0
    while condition == False:
        # print(i)
        lower = int((10 ** (i - 1)) ** (1 / 3)) + 1
        upper = int((10 ** i) ** (1 / 3)) + 1
        cubes = [(x ** 3) for x in range(lower, upper)]
        # print(cubes)
        for cube1 in cubes:
            count = 0
            digits1 = digits(cube1)
            for cube2 in cubes[cubes.index(cube1) : ]:
                if digits1 == digits(cube2):
                    count += 1
            if count == 5:
                condition = True
                ans = cube1
                break
        i += 1
    return(ans)


timer.start()
print(main())
timer.end()