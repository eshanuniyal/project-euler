# ---------------------------------------------------------------
# Project Euler Problem 33 | Eshan Uniyal
# January 2018, Python 3
# The fraction 49/98 is a curious fraction, as an inexperienced mathematician in attempting to simplify it may
#   incorrectly believe that 49/98 = 4/8, which is correct, is obtained by cancelling the 9s.
# We shall consider fractions like, 30/50 = 3/5, to be trivial examples.
# There are exactly four non-trivial examples of this type of fraction, less than one in value, and containing
#   two digits in the numerator and denominator.
# If the product of these four fractions is given in its lowest common terms, find the value of the denominator.
# ---------------------------------------------------------------

import timer
from fractions import Fraction

def main():
    fractions1 = []
    for den in range(10, 100):
        for num in range(10, den):
            fractions1.append([num, den])
    answers = []
    # print(fractions1)
    fractions = []
    for fraction in fractions1:
        if fraction[0] % 11 != 0 and fraction[1] % 11 != 0:
            fractions.append(fraction)
    # print(fractions)
    for fraction in fractions:
        strnum = str(fraction[0])
        strden = str(fraction[1])
        for dignum in strnum:
            for digden in strden:
                if dignum == digden and dignum != "0":
                    contnum = strnum.replace(dignum, "")
                    contden = strden.replace(digden, "")
                    if contden != "0" and contnum != "0":
                        if int(contnum) / int(contden) == int(strnum) / int(strden):
                            answers.append([int(strnum), int(strden)])
    multiple = 1
    for fraction in answers:
        multiple *= fraction[0]
        multiple /= fraction[1]
    print(Fraction(multiple).limit_denominator())

timer.start()
main()
timer.end()

