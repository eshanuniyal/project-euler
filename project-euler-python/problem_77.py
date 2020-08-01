# ---------------------------------------------------------------
# Project Euler Problem 77 | Eshan Uniyal
# April 2018, Python 3 | Updated December 2018
# It is possible to write ten as the sum of primes in exactly five different ways:
    # 7 + 3
    # 5 + 5
    # 5 + 3 + 2
    # 3 + 3 + 2 + 2
    # 2 + 2 + 2 + 2 + 2
# What is the first value which can be written as the sum of primes in over five thousand different ways?
# ---------------------------------------------------------------

import timer, sys
sys.path.append('C:\\Users\\eshan\\Desktop\\python_projects\\other_programs')
from primes_generator import sieve



n = 5000

def pFactors(num, primes, dict): #generates all unique prime factors of input number given list of primes upto that number
    if num in dict:
        return(dict[num])
    else:
        pFactors = [] #creates a temporary list to store prime factorisation of x
        x = num #creates a variable num to be updated with every new prime factor
        while num != 1: #condition for terminating prime factorisation
            for prime in primes: #cycles through prime in allprimes
                if num % prime == 0: #checks whether num is divisible by prime
                    if prime not in pFactors:
                        pFactors.append(prime) #if divisible, appends prime to pFactors
                    num = num // prime #critical step: updates value of num so that smaller value can now be tested
                    break
        dict[num] = sum(pFactors)
        return(sum(pFactors))


def kappa(n, primes, pFactorsSums, kappaDict):
    # algorithm from https://programmingpraxis.com/2012/10/19/prime-partitions/
    sopf_n = pFactors(n, primes, pFactorsSums)
    sigma = 0

    for j in range(2, n):
        sopf_j = pFactors(j, primes, pFactorsSums)
        sigma += sopf_j * kappaDict[n - j]

    kappa_n = (1 / n) * (sopf_n + sigma)
    kappaDict[n] = kappa_n
    return(kappa_n)


def main(nWays):
    primes, condition, i = sieve(10 ** 2), False, 2
    pFactorsSums, kappaDict = {x : x for x in primes}, {1 : 0}

    while condition == False:
        kappa(i, primes, pFactorsSums, kappaDict)

        if kappaDict[i] > nWays:
            return(i)
        else:
            i += 1


timer.start()
print(main(n))
timer.end()