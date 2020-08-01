# ---------------------------------------------------------------
# Project Euler Problem 65 | Eshan Uniyal
# March 2018, Python 3
# The square root of 2 can be written as an infinite continued fraction.
# The infinite continued fraction can be written, √2 = [1;(2)], (2) indicates that 2 repeats ad infinitum.
#   In a similar way, √23 = [4;(1,3,1,8)].
# It turns out that the sequence of partial values of continued fractions for square roots provide the best
#   rational approximations. Let us consider the convergents for √2.
# Hence the sequence of the first ten convergents for √2 are:
#   1, 3/2, 7/5, 17/12, 41/29, 99/70, 239/169, 577/408, 1393/985, 3363/2378, ...
# What is most surprising is that for the important mathematical constant,
#   e = [2; 1,2,1, 1,4,1, 1,6,1 , ... , 1,2k,1, ...].#
# The first ten terms in the sequence of convergents for e are:
#   2, 3, 8/3, 11/4, 19/7, 87/32, 106/39, 193/71, 1264/465, 1457/536, ...
# The sum of digits in the numerator of the 10th convergent is 1+4+5+7=17.
# Find the sum of digits in the numerator of the 100th convergent of the continued fraction for e.
# ---------------------------------------------------------------

import timer



n = 100 # only works for n that fit the format 3 * m + 1

def recursive(convergence, nIndex, fraction):
    # print(nIndex, convergence[nIndex], fraction)
    if nIndex == - 1:
        return(fraction)
    else:
        newFraction = [convergence[nIndex] * fraction[0] + fraction[1], fraction[0]]
        return(recursive(convergence, nIndex - 1, newFraction))


def main(limit):
    convergence = [2]
    i = 1
    while len(convergence) < limit:
        convergence.append(1)
        convergence.append(2 * i)
        convergence.append(1)
        i += 1

    while len(convergence) > limit - 1:
        convergence.pop()
    # print(convergence)

    print(convergence)

    numerator = recursive(convergence, len(convergence) - 1, [convergence[-2], 1])[0]

    total = 0
    for digit in str(numerator):
        total += int(digit)

    return(total)

timer.start()
print(main(n))
timer.end()

# print(recursive(1, [2, 1]))