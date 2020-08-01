# ---------------------------------------------------------------
# Project Euler Problem 36| Eshan Uniyal
# February 2018, Python 3
# The decimal number, 585 = 10010010012 (binary), is palindromic in both bases.
# Find the sum of all numbers, less than one million, which are palindromic in base 10 and base 2.
# (Please note that the palindromic number, in either base, may not include leading zeros.)
# ---------------------------------------------------------------

import time



upper = 1000000

def isPalindrome(num): # checks whether num is a palindrome
    condition = True
    for i in range(0, int(len(str(num)) / 2)):
        if str(num)[i] != str(num)[-(i + 1)]:
            condition = False
            break
    return(condition)

def main(limit):
    palindromes = []
    total = 0
    for i in range(1, limit):
        if isPalindrome(i) == True:
            binary = int(str(bin(i))[2 : ])
            if isPalindrome(binary) == True:
                palindromes.append([i, binary])
                total += i
    # print(palindromes)
    return(total)

timer.start()
print(main(upper))
runtime()