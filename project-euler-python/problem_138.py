# ---------------------------------------------------------------
# Project Euler Problem 138 | Eshan Uniyal
# February 2018, Python 3
# Consider the isosceles triangle with base length, b = 16, and legs, L = 17.
# By using the Pythagorean theorem it can be seen that the height of the triangle,
#   h = √(172 − 82) = 15, which is one less than the base length.
# With b = 272 and L = 305, we get h = 273, which is one more than the base length, and this is the second smallest
# isosceles triangle with the property that h = b ± 1.
# Find ∑ L for the twelve smallest isosceles triangles for which h = b ± 1 and b, L are positive integers.
# ---------------------------------------------------------------

import timer



def isSquare(num): # function to check if a number is a square, to eliminate perfect square values of D
    if (num ** 0.5) % 1 == 0:
        return(True)
    else:
        return(False)

def main():
    triangles = []
    count, L = 0, 1
    while count != 12:
        print(count, L)
        for b in range(1, L + 1):
            h2 = L ** 2 - (b / 2) ** 2
            # print(L, b, h2, h2 ** 0.5)
            if isSquare(h2) == True:
                h = int(h2 ** 0.5)
                if h == b - 1 or h == b + 1:
                    print(L, b, h)
                    count += 1
                    triangles.append([L, b, h])
        L += 1
    print(triangles)
    total = 0
    for triangle in triangles:
        total += triangle[0]
    print(total)

timer.start()
main()
timer.end()
