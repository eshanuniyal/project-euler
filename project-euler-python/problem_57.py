# ---------------------------------------------------------------
# Project Euler Problem 57 | Eshan Uniyal
# March 2018, Python 3
# It is possible to show that the square root of two can be expressed as an infinite continued fraction.
    # √ 2 = 1 + 1/(2 + 1/(2 + 1/(2 + ... ))) = 1.414213...
# By expanding this for the first four iterations, we get:
    # 1 + 1/2 = 3/2 = 1.5
    # 1 + 1/(2 + 1/2) = 7/5 = 1.4
    # 1 + 1/(2 + 1/(2 + 1/2)) = 17/12 = 1.41666...
    # 1 + 1/(2 + 1/(2 + 1/(2 + 1/2))) = 41/29 = 1.41379...
# The next three expansions are 99/70, 239/169, and 577/408, but the eighth expansion, 1393/985, is the first
#   example where the number of digits in the numerator exceeds the number of digits in the denominator.
# In the first one-thousand expansions, how many fractions contain a numerator with more digits than denominator?
# ---------------------------------------------------------------

import timer



# algorithm:
# analysis of the pattern 3/2, 7/5, 17/12, 41/29 tells us that
# n_k = n_k-1 + 2d_k-1
# d_k = n_k-1 + d_k-1 which gives us d_k = n_k - d_k-1

expansions = 10 ** 3

def main(nExp):
    fractions = [[3, 2], [7, 5]]
    count = 0
    for i in range(0, nExp - 2):
        prev = fractions[-1]
        prevNum, prevDen = prev[0], prev[1]

        newNum = prevNum + 2 * prevDen
        newDen = newNum - prevDen
        if len(str(newNum)) > len(str(newDen)):
            count += 1

        fractions.append([newNum, newDen])

    print(fractions)

    return(count)

timer.start()
print(main(expansions))
timer.end()