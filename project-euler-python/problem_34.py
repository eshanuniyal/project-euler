# ---------------------------------------------------------------
# Project Euler Problem 30 | Eshan Uniyal
# January 2018, Python 3
# 145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.
# Find the sum of all numbers which are equal to the sum of the factorial of their digits.
# Note: as 1! = 1 and 2! = 2 are not sums they are not included.
# ---------------------------------------------------------------

import timer
from math import factorial



def limit(): # function to find the maximum possible number that might satisfy the condition
    # i.e. the number, greater than which any number exceeds the maximum possible sum (the sum when each digit is 9)
    # of the factorials of its digits
    i = 1
    while (10 ** i) < (i * factorial(9)):
        i += 1
    lim = i * factorial(9)
    return(lim)

def main():
    print("Running...")
    lim = limit()
    list = [] # creates a list to host integers that satisfy the condition
    for num in range(3, lim):
        sum = 0
        for digit in str(num):
            sum += factorial(int(digit))
        if sum == num:
            list.append(num)
    print("The list of integers for which the sum of the factorial of each of their digits equals them is %s." % (list))
    ans = 0
    for num in list:
        ans += num
    return("The sum of each of these integers is %s." % ans)

timer.start()
print(main())
timer.end()