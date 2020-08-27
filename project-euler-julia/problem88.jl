# Julia Solution to Project Euler Problem 88
# 23 August 2020
# Runtime: ~1 second

import PrimeFunctions: generatePrimes
import AuxFunctions: nextFactorisations

"""
    findMinProductSumNumbersSum(bound)

Returns the sum of all minimum product-sum numbers (as defined in Project Euler Problem 88)
for sets of size `2 ≤ k ≤ bound`.
"""
function findMinProductSumNumbersSum(bound)

    factorisations = Vector{Set{Vector{Int}}}()  # vector of sets of factorisations of each number
    primes = generatePrimes(bound)  # vector of prime numbers

    minProdSumNumbers = Set{Int}()  # set of known minimum product sum numbers
    
    # iterating over set sizes 
    for k in 2:bound
        n = k  # minimum possible product-sum number for a set of size k is k (1 + 1 + ... 1 = k)
        # iterating till we find first (and therefore minimum) product sum number
        while true
            # updating factorisations as necessary
            while n > length(factorisations)
                nextFactorisations(factorisations, primes)
            end
            # checking if n is a product sum number for a set of size k
            if checkProductSumNumber(n, k, factorisations)
                push!(minProdSumNumbers, n)
                break
            end
            n += 1  # increment n to continue search
        end
    end

    # return sum of all minimum product-sum numbers
    return sum(minProdSumNumbers)
end


"""
    checkProductSumNumber(n, k, fs)

Returns whether any factorisation `f ∈ fs` of `n` can be used to create a product and sum of size
`k` that equals `n`.
"""
checkProductSumNumber(n, k, fs) = any(f -> sum(f) + k - length(f) == n, fs[n])

# function call and benchmarking
@btime findMinProductSumNumbersSum(12000)

