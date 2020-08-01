# ---------------------------------------------------------------
# Project Euler Problem 43 | Eshan Uniyal
# January 2018, Python 3
# The number, 1406357289, is a 0 to 9 pandigital number because it is made up of each of the digits 0 to 9 in some order, but it also has a rather interesting sub-string divisibility property.
# Let d1 be the 1st digit, d2 be the 2nd digit, and so on. In this way, we note the following:
#     d2d3d4=406 is divisible by 2
#     d3d4d5=063 is divisible by 3
#     d4d5d6=635 is divisible by 5
#     d5d6d7=357 is divisible by 7
#     d6d7d8=572 is divisible by 11
#     d7d8d9=728 is divisible by 13
#     d8d9d10=289 is divisible by 17
# Find the sum of all 0 to 9 pandigital numbers with this property.
# ---------------------------------------------------------------

import timer, itertools


def main(): # runtime: 12 seconds
    digits = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

    potentials = list(itertools.permutations(digits))

    pandigitals = []
    for potential in potentials:
        if potential[0] != 0:
            pandigitals.append(potential)

    goodpans = []
    primes = [2, 3, 5, 7, 11, 13, 17]
    for pan in pandigitals:
        condition = True
        # print(pan)
        for i in range(1, 8):
            string = ""
            for j in range(i, i + 3):
                string += str(pan[j])
            if int(string) % primes[i - 1] != 0:
                condition = False
                break
        if condition == True:
            pan = map(str, pan)
            pandigital = int(''.join(pan))
            goodpans.append(pandigital)

    print(goodpans)

    total = 0
    for pandigital in goodpans:
        total += pandigital
    return(total)

timer.start()
print(main())
timer.end()