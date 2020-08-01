# ---------------------------------------------------------------
# Project Euler Problem 25 | Eshan Uniyal
# November 2017, Python 3 | Updated March 2018
# What is the index of the first term in the Fibonacci sequence to contain 1000 digits?
# ---------------------------------------------------------------

import timer

desiredLen = 1000  #reasonable upper bound on fibonacci for a thousand digits

def main(length):
    fibo = [1, 1, 2]
    while len(str(fibo[-1])) < length:
        newFib = fibo[-1] + fibo[-2]
        fibo.append(newFib)
    return(len(fibo))

timer.start()
print(main(desiredLen))
timer.end()