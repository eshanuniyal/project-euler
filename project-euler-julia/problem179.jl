# Julia Solution to Project Euler Problem 179
# 26 August 2020
# Runtime: ~3 seconds

import PrimeFunctions: generatePrimes
import AuxFunctions: nextDivisorCount

"""
    numConsecutiveProperDivisors(bound)

Returns the number of integers `1 < n < bound`, for which `n` and `n + 1` have the same number of 
positive divisors.
"""
function numConsecutiveProperDivisors(bound)

    # generating prime numbers (and set, for fast primality check)
    primes = generatePrimes(bound)
    primesSet = Set(primes)
    # vector of divisor counts 
    dCounts = Vector{Int}()  # dCounts[k] = number of positive divisors of k

    # finding and inserting divisor counts
    for n in 1:bound
        nextDivisorCount(dCounts, primes, primesSet)
    end

    # returning number of consecutive integers that have same number of divisors
    return count(n -> dCounts[n] == dCounts[n + 1], 2:bound - 1)
end

# function call and benchmarking
@btime numConsecutiveProperDivisors(10^7)