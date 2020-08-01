# ---------------------------------------------------------------
# Project Euler Problem 32 | Eshan Uniyal
# February 2018, Python 3
# We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once;
# for example, the 5-digit number, 15234, is 1 through 5 pandigital.
# The product 7254 is unusual, as the identity, 39 × 186 = 7254, containing multiplicand, multiplier, and product is 1 through 9 pandigital.
# Find the sum of all products whose multiplicand/multiplier/product identity can be written as a 1 through 9 pandigital.
# HINT: Some products can be obtained in more than one way so be sure to only include it once in your sum.
# ---------------------------------------------------------------

import timer



def main():
    products = []

    limitReached = False
    a = 2

    while limitReached == False:
        b = 1
        str_a = str(a)
        if len(str_a) + len(str(b)) + len(str(a * b)) > 9:
            limitReached = True
            break
        while len(str_a) + len(str(b)) + len(str(a * b)) <= 9:
            str_b = str(b)
            product = a * b
            str_product = str(product)

            condition = True
            for digit in range(1, 10):
                str_digit = str(digit)
                if str_digit not in str_a and str_digit not in str_b and str_digit not in str_product:
                    condition = False
                    break
            if condition == True:
                if product not in products:
                    products.append(product)
            b += 1
        a += 1

    total = 0
    for product in products:
        total += product
    return (total)

timer.start()
print(main())
timer.end()