# ---------------------------------------------------------------
# Project Euler Problem 32 | Eshan Uniyal
# February 2018, Python 3 | Updated December 2018
# The primes 3, 7, 109, and 673, are quite remarkable.
# By taking any two primes and concatenating them in any order the result will always be prime.
# For example, taking 7 and 109, both 7109 and 1097 are prime. The sum of these four primes, 792,
#   represents the lowest sum for a set of four primes with this property.
# Find the lowest sum for a set of five primes for which any two primes concatenate to produce another prime.
# ---------------------------------------------------------------

import timer, sys
from itertools import combinations
sys.path.append("C:\\Users\\eshan\\Desktop\\python_projects\\other_programs")
from primes_generator import sieve
from prime_checker import is_prime




upper = 10 ** 4


def checker(items):
    p1 = items[0]
    p2 = items[1]
    if is_prime(int(str(p1) + str(p2))) == True:
        if is_prime(int(str(p2) + str(p1))) == True:
            return(True)
        else:
            return(False)
    else:
        return(False)

def main(limit):
    # arrives to a solution in 28 seconds
    primes = sieve(limit)
    print('Primes generated.')

    length = len(primes)

    for i in range(0, length):
        p1 = primes[i]

        for j in range(i + 1, length):
            p2 = primes[j]

            if checker([p1, p2]) == True:
                for k in range(j + 1, length):
                    p3 = primes[k]

                    if checker([p2, p3]) == True and checker([p1, p3]) == True:
                        for l in range(k + 1, length):
                            p4 = primes[l]

                            if checker([p1, p4]) == True and checker([p2, p4]) == True and checker([p3, p4]) == True:
                                # print([p1, p2, p3, p4])
                                for m in range(l + 1, length):
                                    p5 = primes[m]

                                    if checker([p1, p5]) == True and checker([p2, p5]) == True\
                                            and checker([p3, p5]) == True and checker([p4, p5]) == True:
                                        return(sum([p1, p2, p3, p4, p5]))

timer.start()
print(main(upper))
runtime()