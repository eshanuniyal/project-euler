# ---------------------------------------------------------------
# Project Euler Problem 37 | Eshan Uniyal
# February 2018, Python 3
# The number 3797 has an interesting property. Being prime itself, it is possible to continuously remove digits from left to right, and remain prime at each stage: 3797, 797, 97, and 7. Similarly we can work from right to left: 3797, 379, 37, and 3.
# Find the sum of the only eleven primes that are both truncatable from left to right and right to left.
# NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.
# ---------------------------------------------------------------

import timer



def main(): # runs in 37 seconds
    primes = []
    truncatable = []
    cases = 0 # number of truncatable primes discovered
    num = 2
    while cases != 11:
        condition = True
        for k in range(2, int(num ** 0.5) + 1):
                if num % k == 0:
                    condition = False
                    break
        if condition == True:
            primes.append(num)
            length = len(str(num))
            trunc_condition = True
            strnum = str(num)
            # print(num)
            for i in range(1, length):
                # check = strnum[0 : i]
                if int(strnum[0: i]) not in primes:
                    trunc_condition = False
                    break
                if int(strnum[i : ]) not in primes:
                    trunc_condition = False
                    break
            if trunc_condition == True and len(strnum) > 1:
                truncatable.append(num)
                cases += 1
                # print(cases, num)
        num += 1

    total = 0
    for prime in truncatable:
        total += prime
    return(total)

timer.start()
print(main())
timer.end()
