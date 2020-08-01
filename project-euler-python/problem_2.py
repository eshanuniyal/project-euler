# ---------------------------------------------------------------
# Project Euler Problem 2 | Eshan Uniyal
# November 2017, Python 3 | Updated March 2018
# By considering the terms in the Fibonacci sequence whose values
#   do not exceed four million, find the sum of the even-valued terms.
# ---------------------------------------------------------------

import timer

def fibonacci():
    fibo = [1, 1]

    while fibo[-1] < 4 * 10 ** 6:
        fibo.append(fibo[-1] + fibo[-2])
    fibo.pop() # necessary to remove last term of fibo, which exceeds 4 mil

    evenFibo = [x for x in fibo if x % 2 == 0]

    return(sum(evenFibo))

timer.start()
print(fibonacci())
timer.end()