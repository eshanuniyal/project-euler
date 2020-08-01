# ---------------------------------------------------------------
# Project Euler Problem 64 | Eshan Uniyal
# February 2018, Python 3
# Exactly four continued fractions representing N^1/2, for N ≤ 13, have an odd period.
# How many continued fractions for N ≤ 10000 have an odd period?
# ---------------------------------------------------------------

import timer



upper = 13


def isSquare(num):  # function to check if a number is a square, to eliminate perfect square values of D
    if (num ** 0.5) % 1 == 0:
        return (True)
    else:
        return (False)


def main(limit):
    representations = {}

    for N in range(2, limit + 1):
        if isSquare(N) == False:
            rep = []
            init = (N ** 0.5) % 1
            condition = False
            count = 0
            while count != 20:
                new = 1 / init
                newInit = new - (new % 1)
                rep.append(int(newInit))
                init = new % 1
                count += 1
            print(N, rep)

            condition = False
            for i in range(1, 10):
                if rep.count(i) == len(rep):
                    representations[N] = [i]
                    condition = True
                    break

            if condition == False:
                for length in range(2, 6):
                    if rep[0 : length] == rep[length : 2 * length] == rep[2 * length : 3* length]:
                        representations[N] = rep[0 : length]
                        break

            print(len(representations[N]))



    print(representations)
timer.start()
main(upper)
timer.end()