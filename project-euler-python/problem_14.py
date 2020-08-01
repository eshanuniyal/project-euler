# ---------------------------------------------------------------
# Project Euler Problem 14 | Eshan Uniyal
# November 2017, Python 3 | Updated March 2018
# The following iterative sequence is defined for the set of positive integers:
    # n → n/2 (n is even)
    # n → 3n + 1 (n is odd)
    # Using the rule above and starting with 13, we generate the following sequence:
    # 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
    # It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms.
        # Although it has not been proved yet (Collatz Problem), it is thought that all starting numbers finish at 1.
    # Which starting number, under one million, produces the longest chain?
    # NOTE: Once the chain starts the terms are allowed to go above one million.
# ---------------------------------------------------------------

import timer



upper = 10 ** 6

def collatz(limit):
    collatz = [] # creates an empty dictionary to host lengths of Collatz sequence of each number
    numbers = [x for x in range(1, limit + 1)]
    for n in numbers:
        collatzList = [] #creates an empty list to host Collatz sequence of each number
        while n != 1:
            collatzList.append(n) #appends to collatzList previous whichever calculation of n was done last
            if n % 2 == 0: #conditions for collatz progression
                n = n // 2
            else:
                n = 3 * n + 1
        collatzList.append(1) #appends 1 to the last of every collatzList (inelegant addition)
        collatz.append(len(collatzList)) #appends the length of collatzList for n to collatz, where it's stored at index n - 1

    #print(collatz)
    print("The number under %s for which the Collatz sequence is longest at %s is %s." % (limit, max(collatz), collatz.index(max(collatz)) + 1)) #prints the index number (+ 1) of the maximum value in collatz

def recursive(n, lengths): # recursive algorithm
    if n in lengths:
        return(lengths[n])
    elif n == 1: # terminating condition
        return(1)
    else:
        if n % 2 == 0:
            length = 1 + recursive(n // 2, lengths)
        else:
            length = 1 + recursive(3 * n + 1, lengths)
        lengths[n] = length
        return(length)

def main(limit):
    collatzLengths = {}
    for n in range(2, limit):
        recursive(n, collatzLengths)
    ans = 0
    maxLength = 0
    for key, value in collatzLengths.items():
        if value > maxLength:
            ans, maxLength = key, value
    return(ans)


timer.start()
print(main(upper))
timer.end()

timer.start()
collatz(upper)
timer.end()
