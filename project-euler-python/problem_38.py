# ---------------------------------------------------------------
# Project Euler Problem 32 | Eshan Uniyal
# February 2018, Python 3
# Take the number 192 and multiply it by each of 1, 2, and 3:
#     192 × 1 = 192
#     192 × 2 = 384
#     192 × 3 = 576
# By concatenating each product we get the 1 to 9 pandigital, 192384576. We will call 192384576 the concatenated product of 192 and (1,2,3)
# The same can be achieved by starting with 9 and multiplying by 1, 2, 3, 4, and 5, giving the pandigital, 918273645,
#   which is the concatenated product of 9 and (1,2,3,4,5).
# What is the largest 1 to 9 pandigital 9-digit number that can be formed as the concatenated product of
#   an integer with (1,2, ... , n) where n > 1?
# ---------------------------------------------------------------

import time



def main():
    products = []

    i = 1
    limitReached = False
    while limitReached == False:
        concatenated = ""
        j = 1
        while len(concatenated) < 9:
            concatenated += str(i * j)
            j += 1
        if len(concatenated) == 9:
            condition = True
            for digit in range(1, 9):
                if str(digit) not in concatenated:
                    condition = False
                    break
            if condition == True:
                products.append(int(concatenated))
                # print(i, concatenated)
        limitTest = ""
        for j in range(1, 3):
            limitTest += str(i * j)
        if len(limitTest) > 9:
            limitReached = True
        i += 1

    return(max(products))



timer.start()
print(main())
runtime()