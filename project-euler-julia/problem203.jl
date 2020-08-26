# Julia Solution to Project Euler Problem 203
# 25 August 2020
# Runtime: ~1 second

import PrimeFunctions: sieve

"""
    squareFree(n, primes, primesSet)

Returns true if no square of a prime divides `n`, given `primes`, a vector of prime numbers,
    and `primesSet`, a set of the same prime numbers.
"""
function isSquareFree(n, primes, primesSet)

    nₜ = n  # temporary n variable (for finding prime factors)
    # iterating over primes
    for p in primes
        # reduce nₜ if nₜ is divisible by prime p
        if nₜ % p == 0
            nₜ ÷= p
            # return false if nₜ is further divisible by p
            nₜ % p == 0  && return false
            # in either case n == 1 or nₜ ∈ primeSet, nₜ cannot be divisible by a prime-square
            (nₜ == 1 || nₜ ∈ primesSet) && break
        end
    end

    # n passed square-free test ⟹ return true
    return true
end

"""
    squarefreeBinomialCoeffsSum(nRows)

Returns the sum of the distinct squarefree numbers in the first `nRows` rows of Pascal's triangle.
"""
function squarefreeBinomialCoeffsSum(nRows)

    # defining binomial function
    bin(n, k) = factorial(big(n)) ÷ (factorial(big(k)) * factorial(big(n - k)))

    # generating all unique binomial coefficients for n < nRows
    coeffs = Set([bin(n, k) for n in 1:nRows-1 for k in 0:n÷2])
    # generating enough primes to check whether coefficients are square free
    primes = Int(coeffs |> maximum |> isqrt) |> sieve
        # if k is not square-free, it is divisible by p² for some prime p
    # creating set of primes (for fast checking of primality)
    primesSet = Set(primes)

    # returning sum of binomial coefficients that are squarefree
    return filter(c -> isSquareFree(c, primes, primesSet), coeffs) |> sum
end

# function call and benchmarking
@btime squarefreeBinomialCoeffsSum(51)