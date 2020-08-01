# ---------------------------------------------------------------
# Project Euler Problem 56 | Eshan Uniyal
# January 2018, Python 3
# A googol (10^100) is a massive number: one followed by one-hundred zeros; 100^100 is almost unimaginably large:
# one followed by two-hundred zeros. Despite their size, the sum of the digits in each number is only 1.
# Considering natural numbers of the form, ab, where a, b < 100, what is the maximum digital sum?
# ---------------------------------------------------------------

import time



upper = 100

def main(limit):
    ablens = []
    for a in range(1, upper):
        for b in range(1, upper):
            num = a ** b
            strnum = str(num)
            total = 0
            for digit in strnum:
                total += int(digit)
            ablens.append([a, b, total])
    lens = []
    for ablen in ablens:
        lens.append(ablen[2])
    return(max(lens))

timer.start()
print(main(upper))
runtime()