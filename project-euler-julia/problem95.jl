# Julia Solution to Project Euler Problem 94
# 21 August 2020
# Runtime: ~4 seconds

import PrimeFunctions: sieve
import AuxFunctions: insertProperDivisors

"""
    generateDivisorSums(bound)

Returns a vector containing the sums of all proper divisors of `k` for `k ∈ 1:bound`.
"""
function generateDivisorSums(bound::Integer)

    # generating primes
    primes = sieve(bound)

    # creating relevant vectors
    properDivisors = Vector{Set{Int}}()  # properDivisors[k] = vector of proper divisors of k
    divisorSums = Vector{Int}()  # divisorSums[k] = sum(properDivisors[k])

    # generating proper divisors and proper divisor sums
    for n in 1:bound
        insertProperDivisors(n, properDivisors, primes)
        push!(divisorSums, sum(properDivisors[n]))
    end

    return divisorSums
end

"""
    longestAmicableChain(bound)

Returns the smallest element in the longest amicable chain 
(as defined in Project Euler Problem 95) where no element exceeds `bound`.
"""
function longestAmicableChain(bound::Integer)

    divisorSums = generateDivisorSums(bound)  # divisorSums[k] = sum of proper divisors of k
    numChecked = fill(false, bound)  # we check each number only once
        # numChecked[k] == true if k does not lie in any chain 
        # or a chain with k has already been found

    # length of maximum chain found so far, minimum element in such a chain
    maxChainLength, minElement = 0, 0

    # iterating over unchecked numbers
    for k in 2:bound
        numChecked[k] && continue  # if k already checked, continue

        # create a new chain starting with k
        chain = [k]
        chainAmicable = true  # by default, we assume
            # either chain or some subchain ending at last element is amicable

        # iterating to generate chain
        while true
            # finding next number in chain
            next = divisorSums[chain[end]]
            # if next ∉ 1:bound or already checked, we won't get an amicable chain
            if next ∉ 1:bound || numChecked[next]
                chainAmicable = false
                break
            end
            # if next is already in chain, break
            next ∈ chain && break
            # push next element in chain
            push!(chain, next)
        end

        # checking if amicable chain found
        if chainAmicable
            # extracting amicable chain from chain
            amicableChain = chain[findfirst(num -> num == divisorSums[chain[end]], chain) : end]
                # we take elements starting from the element that should come immediately after the last, to the last
            # if length is largest found so far, update maxChainLength, minElement    
            if length(amicableChain) > maxChainLength
                maxChainLength = length(amicableChain)
                minElement = minimum(amicableChain)
            end
        end
        # update numChecked
        for num in chain
            numChecked[num] = true
        end
        
    end

    return minElement
end

# function call and benchmarking
@btime longestAmicableChain(10^6)