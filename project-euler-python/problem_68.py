# ---------------------------------------------------------------
# Project Euler Problem 68 | Eshan Uniyal
# November 2018, Python 3
# Using the numbers 1 to 10, and depending on arrangements, it is possible to form 16- and 17-digit strings.
#   What is the maximum 16-digit string for a "magic" 5-gon ring?
# for more information, check problem page
# ---------------------------------------------------------------

import time
from itertools import permutations



def main():
    perms = [x for x in permutations([y for y in range(1, 11)])]
    print('perms generated')
    strings = []
    for perm in perms:
        row_1 = [perm[0], perm[5], perm[6]]
        row_2 = [perm[1], perm[6], perm[7]]
        if sum(row_1) == sum(row_2):
            row_3 = [perm[2], perm[7], perm[8]]
            if sum(row_2) == sum(row_3):
                row_4 = [perm[3], perm[8], perm[9]]
                if sum(row_4) == sum(row_3):
                    row_5 = [perm[4], perm[9], perm[5]]
                    if sum(row_5) == sum(row_4):
                        # print(perm)

                        rows = [row_1, row_2, row_3, row_4, row_5]
                        initials = [row[0] for row in rows]
                        min_initial = min(initials)
                        correct_index = 0
                        for row in rows:
                            if row[0] == min_initial:
                                correct_index = rows.index(row)
                                break
                        new_rows = []
                        for row in rows[correct_index: ]:
                            new_rows.append(row)
                        for row in rows[0: correct_index]:
                            new_rows.append(row)
                        string = ''

                        for row in new_rows:
                            for num in row:
                                string += str(num)
                        if len(string) == 16:
                            strings.append(int(string))
                            # print(perm)
                            # print(string)
    # print(strings)
    return(max(strings))



timer.start()
print(main())
timer.end()