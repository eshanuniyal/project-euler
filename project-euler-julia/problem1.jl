function findSumOfMultiples(factors::Array{Int}, bound::Int)::Int
    # generic solution; takes input factors and returns the sum of all numbers
    # in [1, bound] that are divisible by at least one factor in factors
    return sum([k for k in 1:bound - 1 if any(f-> k % f == 0, factors)])
end

println("Problem 1: ", findSumOfMultiples([3, 5], 1000))
