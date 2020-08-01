# ---------------------------------------------------------------
# Project Euler Problem 67 | Eshan Uniyal
# February 2018, Python 3
# By starting at the top of the triangle below and moving to adjacent numbers on the row below, the maximum total from top to bottom is 23.
# 3
# 7 4
# 2 4 6
# 8 5 9 3
# That is, 3 + 7 + 4 + 9 = 23.
# Find the maximum total from top to bottom in triangle.txt (right click and 'Save Link/Target As...'), a 15K text file
#   containing a triangle with one-hundred rows.
# NOTE: This is a much more difficult version of Problem 18. It is not possible to try every route to solve this problem,
#   as there are 299 altogether! If you could check one trillion (10^ 12) routes every second it would take over twenty
#   billion years to check them all. There is an efficient algorithm to solve it.)
# ---------------------------------------------------------------

import time



numbersImport = open("Supporting texts\\Problem 67.txt", "r")
numbers = numbersImport.read().split("\n")[0 : -1] # 0 : -1 because the last element becomes a [' ']

triangle = []
for set in numbers:
    splitSet = set.split(' ')
    row = []
    for num in splitSet:
        row.append(int(num))
    triangle.append(row)

def recursive(index, dict, rows, nRows):
    # a recursive algorithm for dividing the problem into sub-problems
    if index in dict:
        return(dict[index])
    else:
        rowIndex = index[0]
        numIndex = index[1]

        if rowIndex == nRows - 1:
            dict[index] = rows[rowIndex][numIndex]
            return(dict[index])
        else:
            lowerIndex1 = (rowIndex + 1, numIndex)
            lowerIndex2 = (rowIndex + 1, numIndex + 1)

            path1 = recursive(lowerIndex1, dict, rows, nRows)
            path2 = recursive(lowerIndex2, dict, rows, nRows)

            if path1 > path2:
                dict[index] = path1 + rows[rowIndex][numIndex]
            else:
                dict[index] = path2 + rows[rowIndex][numIndex]

        return(dict[index])

def main(rows):
    nRows = len(rows)
    dict = {}

    recursive((0, 0), dict, rows, nRows)
    print(dict)
    return(dict[(0, 0)])

timer.start()
print(main(triangle))
runtime()