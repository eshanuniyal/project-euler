# Julia Solution to Project Euler Problem 1
# 5 August 2020
# Runtime: ~10⁻² seconds

"""
    multiplesSum(factors, bound)

Return the sum of all numbers in [1, `bound`] that are divisible by at least 
one factor in `factors`.
"""
function multiplesSum(factors::Vector{Int}, bound::Integer)    
    return [k for k ∈ 1:bound - 1 if any(f-> k % f == 0, factors)] |> sum
end

# function call
@time println("Problem 1: ", multiplesSum([3, 5], 1000))