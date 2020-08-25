# Julia Solution to Project Euler Problem 357
# 25 August 2020
# Runtime: ~8 seconds

import PrimeFunctions: sieve


"""
    checkNumber(n, primes, primesSet)

Returns true if `n` is a prime-generating integer (as defined in Problem 357)
    given a vector of prime numbers up to at least `n` and a set of the same prime numbers.
"""
function checkNumber(n, primes, primesSet)

    # exceptional case: n = 1 is a prime-generating integer
    n == 1 && return true

    """
    Optimisation 1: we must have n = 2k for some odd k, otherwise
        Case 1: n = 4k' = 2 × 2k', and 2 + 2k' = 2(1 + k') ∉ primes,
        Case 2: n = 2k' + 1 = 1 × (2k' + 1), and  1 + 2k' + 1 = 2(1 + k') ∉ primes  
    """
    # return false if n ≠ 2k for any odd k
    n % 4 == 2 || return false

    """
    Optimisation 2: n must not have a factor that is a perfect square of a prime, otherwise
        n = c × p² = cp × p, and cp + p = c(p + 1) ∉ primes
    """
    nₜ = n  # temporary n variable (for finding prime factors)
    # iterating over primes
    for p in primes
        # return false if nₜ is divisible by some prime square
        nₜ % p^2 == 0 && return false
        # reduce nₜ if nₜ is divisible by prime p
        if nₜ % p == 0
            nₜ ÷= p
            # in either case n == 1 or nₜ ∈ primeSet, nₜ cannot be divisible by a prime-square
            (nₜ == 1 || nₜ ∈ primesSet) && break
        end
    end

    """ Checking if n is a prime generating integer """
    # iterating over factor pairs of number
    for k in 1:isqrt(n)
        # return false if k divides n and k + n/k is not a prime
        (n % k == 0 && k + n ÷ k ∉ primesSet) && return false
    end

    # n passed all checks -> n is a prime-generating integer
    return true
end

"""
    primeGeneratingIntegersSum(bound)

Returns the sum of all prime-generating integers `n ≤ bound`.
"""
function primeGeneratingIntegersSum(bound)

    # generating prime numbers up to bound + 1 
        # (+1 since we also need to check if bound is a prime-generating integer)
    primes = sieve(bound + 1)
    # creating set of primes for easy checking of primality
    primesSet = Set(primes)

    # optimisation: every prime-generating number n must be 1 less than a prime number, since
        # otherwise, n = n × 1 and n + 1 ∉ primes
    return [p - 1 for p in primes if checkNumber(p - 1, primes, primesSet)] |> sum
end

# function call and benchmarking
@btime primeGeneratingIntegersSum(10^8)