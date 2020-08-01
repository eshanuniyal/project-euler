# ---------------------------------------------------------------
# Project Euler Problem 39 | Eshan Uniyal
# January 2018, Python 3
# If p is the perimeter of a right angle triangle with integral length sides, {a,b,c}, there are exactly three solutions for p = 120.
# {20,48,52}, {24,45,51}, {30,40,50}
# For which value of p ≤ 1000, is the number of solutions maximised?
# ---------------------------------------------------------------

import timer



n = 500
def triplets(limit):
    triplets = []
    totals = []
    for a in range(1, limit):
        for b in range(a, limit):
            c = (a ** 2 + b ** 2) ** (1/2)
            if c.is_integer() and c <= limit:
                triplets.append([a, b, int(c)])
                totals.append(a + b + int(c))
    print(triplets)
    print(totals)
    return(max(set(totals), key = totals.count)) # returns the number that has the maximum count in list totals

timer.start()
print(triplets(n))
timer.end()