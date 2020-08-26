# Julia Solution to Project Euler Problem 187
# 26 August 2020
# Runtime: ~1 seconds

import PrimeFunctions: generatePrimes

"""
    semiprimesSum(bound)

Returns the number of composite numbers under `bound` that have precisely two (not necessarily distinct)
prime factors.
"""
function semiprimesSum(bound)

    # generating primes
    primes = generatePrimes(bound ÷ 2)
    nPrimes = length(primes)  # number of primes
    count = 0  # counter for number of semiprimes

    # iterating over primes to find all unique products of two prime numbers
    for i₁ in 2:nPrimes
        for i₂ in i₁:nPrimes
            # increment count if p₁ × p₂ < bound, break otherwise
            primes[i₁] * primes[i₂] < bound ? (count += 1) : break
        end
    end

    return count
end

# function call and benchmarking
@btime semiprimesSum(10^8)