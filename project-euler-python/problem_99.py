# ---------------------------------------------------------------
# Project Euler Problem 99 | Eshan Uniyal
# February 2018, Python 3
# Comparing two numbers written in index form like 211 and 37 is not difficult, as any calculator would confirm that 211 = 2048 < 37 = 2187.
# However, confirming that 632382518061 > 519432525806 would be much more difficult, as both numbers contain over three million digits.
# Using base_exp.txt (right click and 'Save Link/Target As...'), a 22K text file containing one thousand lines with a base/exponent pair on each line, determine which line number has the greatest numerical value.
# NOTE: The first two lines in the file represent the numbers in the example given above.
# ---------------------------------------------------------------

import timer
from math import log



def main():
    pairsImport = open("Supporting texts\\Problem 99.txt", "r")
    pairs = pairsImport.read().split('\n')

    baseExponents = []
    for pair in pairs:
        commaIndex = pair.index(",")
        base = int(pair[0 : commaIndex])
        exponent = int(pair[commaIndex + 1 : ])
        baseExponents.append([base, exponent])

    results = []
    for pair in baseExponents:
        base = pair[0]
        exponent = pair[1]
        results.append(exponent * log(base))
    # print(results)
    
    return(results.index(max(results)) + 1)

timer.start()
print(main())
timer.end()