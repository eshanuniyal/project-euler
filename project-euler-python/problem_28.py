# ---------------------------------------------------------------
# Project Euler Problem 28 | Eshan Uniyal
# February 2018, Python 3
# Starting with the number 1 and moving to the right in a clockwise direction a 5 by 5 spiral is formed as follows:
    # 21 22 23 24 25
    # 20  7  8  9 10
    # 19  6  1  2 11
    # 18  5  4  3 12
    # 17 16 15 14 13
# It can be verified that the sum of the numbers on the diagonals is 101.
# What is the sum of the numbers on the diagonals in a 1001 by 1001 spiral formed in the same way?
# ---------------------------------------------------------------

import timer



gridSize = 1001

def main(size):
    diagonalNums = [1]
    primeCount = 0
    condition = False
    step = 2
    length = 2
    while max(diagonalNums) < size ** 2:
        init = max(diagonalNums)
        for i in range(init + step, init + 5 * step, step):
            diagonalNums.append(i)
        step += 2
        length += 1

    print(diagonalNums)

    total = 0
    for num in diagonalNums:
        total += num
    return(total)

timer.start()
print(main(gridSize))
timer.end()