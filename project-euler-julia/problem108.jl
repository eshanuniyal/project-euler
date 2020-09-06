# Julia Solution to Project Euler Problem 108
# 6 September 2020
# Runtime: 10⁻¹ seconds

import AuxFunctions: nextPrimeFactorisation

""" Problem Analysis"
For each n, we wish to find the number of solutions in x and y such that 1/x + 1/y = 1/n.
Multiplying the equation by xyn, we have
        yn + xn = xy  
    ⟹  xy - xn - yn = 0  
    ⟹  xy - xn - yn + n² = n²
    ⟹  x(y - n) - n(y - n) = n²
    ⟹  (x - n)(y - n) = n²
Hence the number of solutions (x, y) is given by the number of factor pairs (s, t) of n².
"""

"""
    findMinimalReciprocal(nSols)

Returns the minimal `n` such that `1/x + 1/y = 1/n` has more then `nSols` solutions in `x` and `y`.
"""
function findMinimalReciprocal(nSols)

    # stored prime factorisations
    pfs = [Dict{Int, Int}()]

    # stored primes
    primes, primesSet = Vector{Int}(), Set{Int}()

    # function to find number of factor pairs of n²
    squareFactorPairs(n) = ([2m + 1 for m in values(pfs[n])] |> prod) ÷ 2
        # number of divisors of a number is given by the product over 2m + 1 where m is the multiplicity of its prime factors

    # iterating from n = 2 (n = 1 has only one proper divisor)
    n = 2
    while true
        # generating prime factorisation of n
        nextPrimeFactorisation(pfs, primes, primesSet)
        # if number of factor pairs of n² (which always has odd number of factors) exceeds nSols, break
        squareFactorPairs(n) > nSols && return n
        n += 1  # increment n
    end
end

@btime findMinimalReciprocal(10^3)