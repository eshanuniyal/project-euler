# Julia Solution to Project Euler Problem 135
# 31 August 2020
# Runtime: ~10⁻¹ seconds

""" Problem Analysis
If x, y, z are positive integers and terms of an arithmetic progression such that x² - y² - z² = n > 0, we must have x > y > z. 
We can therefore write (x, y, z) = (α + 2δ, α + δ, α) for positive integers α and δ. 

Applying this to the equality, we have
    (α + 2δ)² - (α + δ)² - α² = n  ⟹  3δ² + 2αδ - α² = n
    
Let f(α, δ) = 3δ² + 2αδ - α². We note that f is strictly increasing with respect to δ and find, given α, the minimum value of δ 
such that f(α, δ) ≥ 1. In other words,
    f(α, δ) ≥ 1 ⟹ 3δ² + 2αδ - α² - 1 ≥ 0  
                ⟹ δ ≥ (-α + √(4α² + 12)) / 3     ( ∵ quadratic formula, δ > 0)
Therefore, for any α > 0, we will only consider δ ≥ δₘ = ⌈(-α + √(4α² + 3)) / 3⌉.

Generating the sequence f(α, δₘ(α)), we get
    4, 3, 15, 12, 7, 27, 20, 11, 39, 28, 15, 51, 36, 19, 63, 44, 23, 75, 52, 27, 87
we observe the subsequences 
    s₁ = 4, 12, 20, 28, 36, ...     ⟹ f(α, δₘ(α)) = 4 + 8(α - 1)     for α = 1, 4, 7, ... 
    s₂ = 3, 7, 11, 15, 19, ...      ⟹ f(α, δₘ(α)) = 3 + 4(α - 1)     for α = 2, 5, 8, ... 
    s₃ = 15, 27, 39, 51, 63, ...    ⟹ f(α, δₘ(α)) = 15 + 12(α - 1)   for α = 3, 6, 9, ...
are all strictly increasing and that s₂ has the smallest terms. 

Since for any given α, f(α, δ) is strictly increasing as well,
we may stop iterating when we reach the first α such that f(α, δₘ(α)) ≥ N and lies in s₂.
Let this value of α be the k'th term in the sequence (2, 5, 8, ...). We then have the inequality
    3 + 4(k - 1) ≥ N  ⟹ k ≥ (N - 3) / 4 + 1 
Since each α in this sequence corresponds to 2 + 3(k - 1), we have
    α = 2 + 3(k - 1) ≥ 2 + 3((N - 3) / 4 + 1 - 1) = 2 + 3((N - 3) / 4)
The maximum valid value of α is therefore given by
    α < 2 + 3((N - 3) / 4) ⟹ A = 2 + 3((N - 3) / 4) - 1 = 3((N - 3) / 4) + 1
"""

function sameDifferences(nSols, N)

    # function to find n
    f(α, δ) = 3δ^2 + 2α*δ - α^2

    # function find minimum valid δ for given α
    δₘ(α) = ceil(Int128, (-α + √(4α^2 + 3)) / 3)

    # function to find maximum valid α
    Α(N) = ceil(Int128, 3((N - 3) / 4) + 1)  # approximately ≈ 0.75α - 1

    # solutions[n] = number of arithmetic progressions that give n
    solutions = zeros(Int, N - 1)

    # iterating over all valid α
    for α in 1:Α(N)
        # iterating from minimum valid δ given α
        δ = δₘ(α)
        while (n = f(α, δ)) < N
            solutions[n] += 1  # incrementing number of known solutions for n
            δ += 1  # incrementing δ
        end
    end

    # returning number of values of n that have nSols solutions
    return count(n -> solutions[n] == nSols, eachindex(solutions))
end

# function call and benchmarking
@btime sameDifferences(10, 10^6)