# ---------------------------------------------------------------
# Project Euler Problem 18 | Eshan Uniyal
# January 2018, Python 3 | Updated March 2018
# By starting at the top of the triangle below and moving to adjacent numbers on the row below, the maximum total from top to bottom is 23.
# 3
# 7 4
# 2 4 6
# 8 5 9 3
# That is, 3 + 7 + 4 + 9 = 23.
# Find the maximum total from top to bottom of the triangle below:
# 75
# 95 64
# 17 47 82
# 18 35 87 10
# 20 04 82 47 65
# 19 01 23 75 03 34
# 88 02 77 73 07 63 67
# 99 65 04 28 06 16 70 92
# 41 41 26 56 83 40 80 70 33
# 41 48 72 33 47 32 37 16 94 29
# 53 71 44 65 25 43 91 52 97 51 14
# 70 11 33 28 77 73 17 78 39 68 17 57
# 91 71 52 38 17 14 91 43 58 50 27 29 48
# 63 66 04 68 89 53 67 30 73 16 69 87 40 31
# 04 62 98 27 23 09 70 98 73 93 38 53 60 04 23
# ---------------------------------------------------------------

import timer



delta = """75
95 64
17 47 82
18 35 87 10
20 04 82 47 65
19 01 23 75 03 34
88 02 77 73 07 63 67
99 65 04 28 06 16 70 92
41 41 26 56 83 40 80 70 33
41 48 72 33 47 32 37 16 94 29
53 71 44 65 25 43 91 52 97 51 14
70 11 33 28 77 73 17 78 39 68 17 57
91 71 52 38 17 14 91 43 58 50 27 29 48
63 66 04 68 89 53 67 30 73 16 69 87 40 31
04 62 98 27 23 09 70 98 73 93 38 53 60 04 23"""#.replace("\n", " ")

numbers = delta.split("\n")
# print(numbers)

triangle = []
for stringRow in numbers:
    row = stringRow.split(" ")
    finalRow = [int(num) for num in row]
    triangle.append(finalRow)

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
    # print(dict)
    return(dict[(0, 0)])

timer.start()
print(main(triangle))
timer.end()