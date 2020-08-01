# ---------------------------------------------------------------
# Project Euler Problem 21 | Eshan Uniyal
# November 2017, Python 3
# Let d(n) be defined as the sum of proper divisors of n (numbers less than n which divide evenly into n).
# If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable pair and each of a and b are called amicable numbers.
# Evaluate the sum of all the amicable numbers under 10000.
# ---------------------------------------------------------------

import timer



nums = [x for x in range(10000)] #generates a range of numbers to check

def factorsTotal(n): # function to return total of all factors
    nroot = int(n ** 0.5) + 1
    list = [x for x in range(1, nroot)]
    factors = []
    for num in list:
        if n % num == 0:
            if num not in factors:
                factors.append(num)
            if n // num not in factors and n // num < n:
                factors.append(n // num)

    return(sum(factors))

def main(numbers):
    pairs = []                                          # creates empty list to host all pairs of numbers and factorTotals
    for number in numbers:
        pairs.append([number, factorsTotal(number)])    # adds number-factorTotal pair to pairs

    amicable = []                                       # creates an empty list to host amicable pairs
    for [i, j] in pairs:
        if [j, i] in pairs and i != j and [j, i] not in amicable:
            amicable.append([i, j])

    total = 0
    for [i, j] in amicable:                             # to compute total
        total += i + j
    return(total)

timer.start()
print(main(nums))
timer.end()