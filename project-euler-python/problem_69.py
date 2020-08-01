# ---------------------------------------------------------------
# Project Euler Problem 69 | Eshan Uniyal
# February 2018, Python 3
# Euler's Totient function, φ(n) [sometimes called the phi function], is used to determine the number of numbers less
    # than n which are relatively prime to n. For example, as 1, 2, 4, 5, 7, and 8, are all less than nine and relatively
    # prime to nine, φ(9)=6.
# It can be seen that n=6 produces a maximum n/φ(n) for n ≤ 10.
# Find the value of n ≤ 1,000,000 for which n/φ(n) is a maximum.
# ---------------------------------------------------------------

import timer



upper = 1000000

def checker(limit): # function to generate list of primes up to limit
    primes = [2]
    for num in range(2, limit + 1):
        condition = True
        for i in range(2, int(num ** 0.5) + 2):
                if num % i == 0:
                    condition = False
                    break
        if condition == True:
            primes.append(num)
    return(primes)


def pFactors(num, primes): #generates all unique prime factors of input number given list of primes upto that number
    pFactors = [] #creates a temporary list to store prime factorisation of x
    x = num #creates a variable num to be updated with every new prime factor
    while num != 1: #condition for terminating prime factorisation
        for prime in primes: #cycles through prime in allprimes
            if num % prime == 0: #checks whether num is divisible by prime
                if prime not in pFactors:
                    pFactors.append(prime) #if divisible, appends prime to pFactors
                num = num // prime #critical step: updates value of num so that smaller value can now be tested
                break
    return(pFactors)

def main(limit): # takes 2000 seconds for limit = one million
    # print("Compiling primes:")
    primes = checker(limit + 1)  # generates all primes upto limit
    # timer.end()

    # print("Compiling factors: ")
    phi = {}
    for num in range(2, limit + 1):
        if num in primes:
            phi_num = num - 1
        else:
            factors = pFactors(num, primes)
            phi_num = num
            for factor in factors:
                phi_num *= (1 - 1/factor)
        phi[num] = num / phi_num
    # print(phi)

    maxval = 0
    answer = 0
    for key, value in phi.items():
        if value > maxval:
            maxval = value
            answer = key

    return(answer)

timer.start()
print(main(upper))
timer.end()