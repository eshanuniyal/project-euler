# ---------------------------------------------------------------
# Project Euler Problem 91 | Eshan Uniyal
# February 2018, Python 3
# Given that 0 ≤ x1, y1, x2, y2 ≤ 50, how many right triangles can be formed with the third point at the origin?
# ---------------------------------------------------------------

import timer



max = 50

def main(size):
    count = 0
    points = []
    for x in range(0, size + 1):
        for y in range(0, size + 1):
            if x == 0 and y == 0:
                pass
            else:
                points.append([x, y, x ** 2 + y ** 2]) # appends x, y, distance of point from origin

    for A in points:
        OA = A[2]
        for B in points[points.index(A) : ]:
            if A == B:
                pass
            else:
                OB = B[2]
                AB = (A[0] - B[0]) ** 2 + (A[1] - B[1]) ** 2
                if OA + OB == AB or OA + AB == OB or OB + AB == OA:
                    count += 1
    return(count)

timer.start()
print(main(max))
timer.end()