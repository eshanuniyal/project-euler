# Julia Solution to Project Euler Problem 2
# 5 August 2020
# Runtime: ~10⁻² seconds

"""
    evenFibonacciSum(bound)

Return the sum of all even Fibonacci numbers less than or equal to `bound`.
"""
function evenFibonacciSum(bound::Integer)

    ∑ = 0  # initialising sum variable
    Fᵢ₋₁, Fᵢ = 0, 1  # initialising base cases

    # iterating until we reach bound 
    while Fᵢ₋₁ + Fᵢ ≤  bound
        Fᵢ₋₁, Fᵢ = Fᵢ, Fᵢ₋₁ + Fᵢ  # generating next Fibonacci number and updating state variables
        Fᵢ % 2 == 0 && (∑ += Fᵢ)  # adding to total if even
    end

    return ∑
end

# function call
@time println("Problem 2: ", evenFibonacciSum(4 * 10^6))