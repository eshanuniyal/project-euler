# ---------------------------------------------------------------
# Project Euler Problem 23 | Eshan Uniyal
# December 2017, Python 3
# A perfect number is a number for which the sum of its proper divisors is exactly equal to the number.
#   For example, the sum of the proper divisors of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect number.
# A number n is called deficient if the sum of its proper divisors is less than n and it is called abundant if this sum exceeds n.
#   As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest number that can be written as the sum of
#   two abundant numbers is 24. By mathematical analysis, it can be shown that all integers greater than 28123 can be
#   written as the sum of two abundant numbers. However, this upper limit cannot be reduced any further by analysis
#   even though it is known that the greatest number that cannot be expressed as the sum of two abundant numbers is less
#   than this limit.
# Find the sum of all the positive integers which cannot be written as the sum of two abundant numbers.
# ---------------------------------------------------------------

import timer


upper = 28123

def divisorsSum(num):
    divisors = []
    for i in range(1, int(num ** 0.5) + 1):
        if num % i == 0:
            if i not in divisors:
                divisors.append(i)
            if num // i not in divisors:
                divisors.append(num // i)
    divisors.remove(num)
    return(sum(divisors))

def main(limit):
    abundant = [i for i in range(1, upper + 1) if divisorsSum(i) > i]

    d = {} # creates an empty dictionary to store truth value of whether positive numbers upto limit can be represented as the sum of two abundant numbers
    for i in range(1, limit + 1):
      d[i] = False
    for a in abundant:
      for b in abundant[abundant.index(a) : ]:
        if a + b in d:
          d[a + b] = True

    total = 0
    for key, value in d.items():
      if value == False:
        total += key
    return(total)

timer.start()
print(main(upper))
timer.end()