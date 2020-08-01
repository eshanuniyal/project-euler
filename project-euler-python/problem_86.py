# ---------------------------------------------------------------
# Project Euler Problem 86 | Eshan Uniyal
# March 2018, Python 3
# A spider, S, sits in one corner of a cuboid room, measuring 6 by 5 by 3, and a fly, F, sits in the opposite corner.
#   By travelling on the surfaces of the room the shortest "straight line" distance from S to F is 10 and the path is
#   shown on the diagram. *diagram on problem page*
# However, there are up to three "shortest" path candidates for any given cuboid and the shortest route doesn't
#   always have integer length.
# It can be shown that there are exactly 2060 distinct cuboids, ignoring rotations, with integer dimensions,
#   up to a maximum size of M by M by M, for which the shortest route has integer length when M = 100.
#   This is the least value of M for which the number of solutions first exceeds two thousand; the number
#   of solutions when M = 99 is 1975.
# Find the least value of M such that the number of solutions first exceeds one million.
# ---------------------------------------------------------------

import timer



desiredCount = 10 ** 6

def isSquare(num):  # function to check if a number is a square, to eliminate perfect square values of D
    if (num ** 0.5) % 1 == 0:
        return (True)
    else:
        return (False)

def main(desCount):
    M = 2
    count = 0
    while count < desCount:
        M2 = M ** 2
        for ab in range(2, 2 * M + 1):
            if isSquare(ab ** 2 + M2) == True:
                for a in range(1, M + 1):
                    for b in range(a, M + 1):
                        if a + b == ab:
                            count += 1
        if count < desCount:
            M += 1
            print(M, count)
    print(M, count)
    return(M)

timer.start()
print(main(desiredCount))
timer.end()
