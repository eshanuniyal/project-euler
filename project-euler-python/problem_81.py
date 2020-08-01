# ---------------------------------------------------------------
# Project Euler Problem 81 | Eshan Uniyal
# March 2018, Python 3
# In the 5 by 5 matrix below, the minimal path sum from the top left to the bottom right, by moving left, right, up,
# and down, is indicated in bold red and is equal to 2297.
    # * matrix given on Project Euler page*
# Find the minimal path sum, in matrix.txt (right click and "Save Link/Target As..."),
#   a 31K text file containing a 80 by 80 matrix, from the top left to the bottom right by moving left, right, up, and down.
# ---------------------------------------------------------------

import timer

numbersImport = open("Supporting texts\\Problem 81.txt", "r")
numbers = numbersImport.read().split("\n")[0 : -1] # 0 : -1 because the last element becomes a [' ']

matrix = []
for set in numbers:
    splitSet = set.split(',')
    row = []
    for num in splitSet:
        row.append(int(num))
    matrix.append(row)

# matrix = [[131, 673, 234, 103, 18], [201, 96, 342, 965, 150], [630, 803, 746, 422, 111], [537, 699, 497, 121, 956], [805, 732, 524, 37, 331]]

def recursive(index, dict, rows, size):
    # a recursive algorithm for dividing the problem into sub-problems
    if index in dict:
        return(dict[index])
    else:
        rowIndex = index[0]
        colIndex = index[1]

        if colIndex == rowIndex == size - 1:
            dict[index] = rows[rowIndex][colIndex]
            return(dict[index])

        elif rowIndex == size - 1:
            rightIndex = (rowIndex, colIndex + 1)
            rightPath = recursive(rightIndex, dict, rows, size)
            dict[index] = rightPath + rows[rowIndex][colIndex]

        elif colIndex == size - 1:
            downIndex = (rowIndex + 1, colIndex)
            downPath = recursive(downIndex, dict, rows, size)
            dict[index] = downPath + rows[rowIndex][colIndex]

        else:
            rightIndex = (rowIndex, colIndex + 1)
            downIndex = (rowIndex + 1, colIndex)

            rightPath = recursive(rightIndex, dict, rows, size)
            downPath = recursive(downIndex, dict, rows, size)

            if rightPath < downPath:
                dict[index] = rightPath + rows[rowIndex][colIndex]
            else:
                dict[index] = downPath + rows[rowIndex][colIndex]

        return(dict[index])

def main(rows):
    size = len(rows)
    dict = {}
    recursive((0, 0), dict, rows, size)
    return(dict[(0, 0)])

timer.start()
print(main(matrix))
timer.end()