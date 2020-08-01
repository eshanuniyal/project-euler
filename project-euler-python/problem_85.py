# ---------------------------------------------------------------
# Project Euler Problem 85 | Eshan Uniyal
# November 2018, Python 3
# By counting carefully it can be seen that a rectangular grid measuring 3 by 2 contains eighteen rectangles.
#   (check Project Euler for diagram)
# Although there exists no rectangular grid that contains exactly two million rectangles, find the area of the grid with the nearest solution.
# ---------------------------------------------------------------

import time



n = 2 * 10 ** 6

def nRect(a, b):
    return((a * b * (a + 1) * (b + 1)) // 4)

def main(desired):
    i, total = 1, 0
    while total < n:
        total += i
        i += 1

    dict = {}

    for a in range(1, i):
        for b in range(a, i):
            dict[(a, b)] = nRect(a, b)

    closest_diff = n
    current_area = 0

    for key, value in dict.items():
        if abs(n - value) < closest_diff:
            current_area = key[0] * key[1]
            closest_diff = abs(n - value)

    return(current_area)

timer.start()
print(main(n))
timer.end()