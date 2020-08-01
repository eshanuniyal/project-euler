# ---------------------------------------------------------------
# Project Euler Problem 55| Eshan Uniyal
# February 2018, Python 3
# If we take 47, reverse and add, 47 + 74 = 121, which is palindromic.
# Not all numbers produce palindromes so quickly. For example,
    # 349 + 943 = 1292,
    # 1292 + 2921 = 4213
    # 4213 + 3124 = 7337
# That is, 349 took three iterations to arrive at a palindrome.
# Although no one has proved it yet, it is thought that some numbers, like 196, never produce a palindrome.
#   A number that never forms a palindrome through the reverse and add process is called a Lychrel number.
#   Due to the theoretical nature of these numbers, and for the purpose of this problem, we shall assume that a number
#   is Lychrel until proven otherwise. In addition you are given that for every number below ten-thousand, it will either
#   (i) become a palindrome in less than fifty iterations, or, (ii) no one, with all the computing power that exists,
#   has managed so far to map it to a palindrome. In fact, 10677 is the first number to be shown to require over
#   fifty iterations before producing a palindrome: 4668731596684224866951378664 (53 iterations, 28-digits).
# Surprisingly, there are palindromic numbers that are themselves Lychrel numbers; the first example is 4994.
# How many Lychrel numbers are there below ten-thousand?
# ---------------------------------------------------------------

import timer



upper = 10000

def isPalindrome(num): # checks whether num is a palindrome
    condition = True
    for i in range(0, int(len(str(num)) / 2)):
        if str(num)[i] != str(num)[-(i + 1)]:
            condition = False
            break
    return(condition)

def operation(num):
    digits = [x for x in str(num)]
    reverse = ""
    for i in range(len(digits) - 1, -1, - 1):
        reverse += digits[i]
    return(int(reverse) + num)

def main(limit):
    lychrel = []

    for num in range(1, limit):
        i = 0
        currentInt = num
        while i != 50:
            result = operation(currentInt)
            # print(num, result)
            if isPalindrome(result) == False:
                currentInt = operation(currentInt)
                i += 1
            else:
                # print(num, i, result)
                break
        if isPalindrome(operation(currentInt)) == False:
            lychrel.append(num)

    return(len(lychrel))


timer.start()
print(main(upper))
timer.end()