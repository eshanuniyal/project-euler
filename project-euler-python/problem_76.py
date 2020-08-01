# ---------------------------------------------------------------
# Project Euler Problem 76 | Eshan Uniyal
# February 2018, Python 3
# It is possible to write five as a sum in exactly six different ways:
    # 4 + 1
    # 3 + 2
    # 3 + 1 + 1
    # 2 + 2 + 1
    # 2 + 1 + 1 + 1
    # 1 + 1 + 1 + 1 + 1
# How many different ways can one hundred be written as a sum of at least two positive integers?
# ---------------------------------------------------------------

import timer



n = 100

def main(total):
    ways = [1]
    for n in range(0, total):
        ways.append(0)
    for n in range(1, total):
        for j in range(n, total + 1):
            ways[j] += ways[j - n]
    return(ways[total])

timer.start()
print(main(n))
timer.end()