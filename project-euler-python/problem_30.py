# ---------------------------------------------------------------
# Project Euler Problem 30 | Eshan Uniyal
# January 2018, Python 3
# Surprisingly there are only three numbers that can be written as the sum of fourth powers of their digits:
#     1634 = 14 + 64 + 34 + 44
#     8208 = 84 + 24 + 04 + 84
#     9474 = 94 + 44 + 74 + 44
# As 1 = 14 is not a sum it is not included.
# The sum of these numbers is 1634 + 8208 + 9474 = 19316.
# Find the sum of all the numbers that can be written as the sum of fifth powers of their digits.
# ---------------------------------------------------------------

import timer



n = 5 # n defines the power of each digit

def limit(power): # function to find the maximum possible such number
    # i.e. the number, greater than which any number exceeds the maximum possible sum (the sum when each digit is 9)
    # of the fifth powers of its digits
    i = 1
    while (10 ** i) < (i * (9 ** power)):
        i += 1
    lim = i * (9 ** power)
    return(lim)

def main(power):
    print("Running...")
    lim = limit(power)
    list = [] # creates a list to host integers that satisfy the condition
    for num in range(2, lim):
        sum = 0
        for digit in str(num):
            sum += int(digit) ** power
        if sum == num:
            list.append(num)
    print("The list of integers wherein, for each integer, the sum of the nth power of each digit equals said integer "
          "(where n is %s) is %s." % (power, list))
    ans = 0
    for num in list:
        ans += num
    return("The sum of each of these integers is %s." % ans)

timer.start()
print(main(n))
timer.end()