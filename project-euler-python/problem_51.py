# ---------------------------------------------------------------
# Project Euler Problem 51 | Eshan Uniyal
# February 2018, Python 3
# By replacing the 1st digit of the 2-digit number *3, it turns out that six of the nine possible values:
#   13, 23, 43, 53, 73, and 83, are all prime.
# By replacing the 3rd and 4th digits of 56**3 with the same digit, this 5-digit number is the first example having
#   seven primes among the ten generated numbers, yielding the family: 56003, 56113, 56333, 56443, 56663, 56773, and 56993.
#   Consequently 56003, being the first member of this family, is the smallest prime with this property.
# Find the smallest prime which, by replacing part of the number (not necessarily adjacent digits) with the same digit,
#   is part of an eight prime value family.
# ---------------------------------------------------------------

import timer



val = 8

def isPrime(num):
    condition = True
    if num < 2:
        condition = False
    else:
        for i in range(2, int(num ** 0.5) + 2):
            if num % i == 0:
                condition = False
                break
    return(condition)

def family(num):
    families = {}

    digits = [int(i) for i in str(num)]

    uniqueDigits = []
    for digit in digits:
        if digit not in uniqueDigits:
            uniqueDigits.append(digit)

    for uniqueDigit in digits:
        family = [num]

        for rep in range(1, 10):
            nDigits = [int(i) for i in str(num)] # creates a list nDigits to store all of digits in num to be tested
            for digit in nDigits:
                if digit == uniqueDigit: # replaces all digits in nDigit that are the same as unique digit
                    nDigits[nDigits.index(digit)] = rep

            n = ""
            for digit in nDigits:
                n += str(digit)
            n = int(n)
            if isPrime(n) == True and n not in family:
                family.append(n)
        families[uniqueDigit] = family

    return(families)

def main(size): # takes about 25 seconds to run
    condition = False
    init = 56003 + 1
    while condition == False:
        # print(init)
        families = family(init)
        for key, value in families.items():
            if len(value) == size:
                # print(key, value)
                return(init)
        init += 1

timer.start()
print(main(val))
runtime()

