# Julia Solution to Project Euler Problem 1
# 5 August 2020

function findSumOfMultiples(factors::Vector{Int}, bound::Int)::Int
    # generic solution; takes input factors and returns the sum of all numbers
    # in [1, bound] that are divisible by at least one factor in factors
    return sum([k for k ∈ 1:bound - 1 if any(f-> k % f == 0, factors)])
end

function main()
    @time println("Problem 1: ", findSumOfMultiples([3, 5], 1000))
end

main()
