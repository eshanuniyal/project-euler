# ---------------------------------------------------------------
# Project Euler Problem 92 | Eshan Uniyal
# January 2018, Python 3
# A number chain is created by continuously adding the square of the digits in a number to form a new number until it has been seen before.
# For example,
#   44 → 32 → 13 → 10 → 1 → 1
#   85 → 89 → 145 → 42 → 20 → 4 → 16 → 37 → 58 → 89
# Therefore any chain that arrives at 1 or 89 will become stuck in an endless loop.
# What is most amazing is that EVERY starting number will eventually arrive at 1 or 89.
# How many starting numbers below ten million will arrive at 89?
# ---------------------------------------------------------------

import timer



n = 10 ** 7 # defines the upper limit

def main(limit):
    print("Running...")
    count = 0
    for num in range(1, limit):
        i = num
        while i != 1 and i != 89:
            j = 0
            for digit in str(i):
                j += int(digit) ** 2
            i = j
        if i == 89:
            count += 1
    return(count)

timer.start()
print("The number of integers below %s for which the sequence ends in 89 is %s." % (n, main(n)))
timer.end()