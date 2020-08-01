# ---------------------------------------------------------------
# Project Euler Problem 26 | Eshan Uniyal
# January 2018, Python 3
# A unit fraction contains 1 in the num. The decimal representation of the unit fractions with dens 2 to 10 are given:
#     1/2	= 	0.5
#     1/3	= 	0.(3)
#     1/4	= 	0.25
#     1/5	= 	0.2
#     1/6	= 	0.1(6)
#     1/7	= 	0.(142857)
#     1/8	= 	0.125
#     1/9	= 	0.(1)
#     1/10	= 	0.1
# Where 0.1(6) means 0.166666..., and has a 1-digit recurring cycle. It can be seen that 1/7 has a 6-digit recurring cycle.
# Find the value of d < 1000 for which 1/d contains the longest recurring cycle in its decimal fraction part.
# ---------------------------------------------------------------

# import timer
from decimal import Decimal, getcontext



upper = 1000

def decimals(n):
    digits, num, den = [], 1, n

    while len(digits) < 3 * n and num != 0:
        if num * 10 >= den:
            digit = int((num * 10 - ((num * 10) % den)) / den)
            digits.append(digit)
            num = num * 10 % den
        else:
            digits.append(0)
            num = num * 10

    if num != 0:
        for i in range(0, len(digits)):
            length = 1
            while length < len(digits[i + 1 : ]):
                if digits[i : i + length] == digits[i + length : i + 2 * length] == digits[i + 2 * length : i + 3 * length]:
                    return(length)
                else:
                    length += 1
    else:
        return(0)

def main(limit):
    ans, max = 0, 0

    for i in range(limit, 0, -1):
        # print(i, decimals(i))
        if decimals(i) > max:
            ans = i
        if decimals(i) == i - 1:
            print(i)
    return(ans)


#timer.start()
print(main(upper))
#timer.end()