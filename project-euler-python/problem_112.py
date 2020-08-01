# ---------------------------------------------------------------
# Project Euler Problem 112 | Eshan Uniyal
# February 2018, Python 3
# Working from left-to-right if no digit is exceeded by the digit to its left it is called an increasing number; for example, 134468.
# Similarly if no digit is exceeded by the digit to its right it is called a decreasing number; for example, 66420.
# We shall call a positive integer that is neither increasing nor decreasing a "bouncy" number; for example, 155349.
# Clearly there cannot be any bouncy numbers below one-hundred, but just over half of the numbers below one-thousand (525) are bouncy.
# In fact, the least number for which the proportion of bouncy numbers first reaches 50% is 538.
# Surprisingly, bouncy numbers become more and more common and by the time we reach 21780 the proportion of bouncy numbers is equal to 90%.
# Find the least number for which the proportion of bouncy numbers is exactly 99%.
# ---------------------------------------------------------------

import timer



def isBouncy(num):
    digits = [int(x) for x in str(num)]
    increasing = True
    decreasing = True
    for i in range(0, len(digits) - 1):
        if digits[i + 1] < digits[i]:
            increasing = False
    for i in range(0, len(digits) - 1):
        if digits[i + 1] > digits[i]:
            decreasing = False
    if increasing == False and decreasing == False:
        return (True)
    else:
        return (False)

def main(): # runtime in the order of ten seconds
    bouncy = 0
    i = 1
    condition = False
    while condition == False:
        if isBouncy(i) == True:
            bouncy += 1
            # print(i, bouncy, bouncy / i)
        if bouncy / i >= 0.99:
            return(i)
        i += 1

timer.start()
print(main())
timer.end()