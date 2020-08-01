# ---------------------------------------------------------------
# Project Euler Problem 4 | Eshan Uniyal
# November 2017, Python 3 | Updated March 2018
# Find the largest palindrome made from the product of two 3-digit numbers.
#  ---------------------------------------------------------------

import timer



n = [x for x in range(999, 99, -1)]

def isPalindrome(number): # defines a function to check for palindromes
    digitList = [int(x) for x in str(number)]
    reverseList = list(reversed(digitList))
    # print(number, digitList, reverseList)
    if reverseList == digitList:
        return(True)
    else:
        return(False)

def main(numbers):
    palindromes = []
    for x in numbers:
        for y in numbers[numbers.index(x) : ]:
            if isPalindrome(x * y) == True and x * y not in palindromes:
                # print(x, y, x * y)
                palindromes.append(x * y)
    print(f"The maximum palindrome in the list of products of numbers in range (100, 1000) is {max(palindromes)}.")

timer.start()
main(n)
timer.end()

