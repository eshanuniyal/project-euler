# Julia Solution to Project Euler Problem 93
# 23 August 2020
# Runtime: 10⁻¹ seconds

using Combinatorics  # permutations, combinations

"""
    findOutputLimit(digits)

Returns the largest `n` such that using each digit in `digits` exactly once and making use
of the four arithmetic operations (+, -, *, /) and brackets/parentheses, it is possible to from
all positive integers from `1` through `n`.
"""
function findOutputLimit(digits)

    # creating vector of valid operations, set of all results generated from digits
    ops, allResults = [+, -, *, /], Set{Int}()

    # iterating over different permutations of digits
    for (d₁, d₂, d₃, d₄) in collect(permutations(digits))
        results = Set{Float64}()  # all results from current permutation
        # iterating over all permutations (with repetition) of combinations
        for ø₁ in ops, ø₂ in ops, ø₃ in ops
            # pushing results of parenthesisations of d₁ ø₁ d₂ ø₂ d₃ ø₃ d₄
            push!(results, ø₃(ø₂(ø₁(d₁, d₂), d₃), d₄))  # ((d₁ ø₁ d₂) ø₂ d₃) ø₃ d₄
            push!(results, ø₃(ø₁(d₁, ø₂(d₂, d₃)), d₄))  # (d₁ ø₁ (d₂ ø₂ d₃)) ø₃ d₄
            push!(results, ø₂(ø₁(d₁, d₂), ø₃(d₃, d₄)))  # (d₁ ø₁ d₂) ø₂ (d₃ ø₃ d₄)
            push!(results, ø₁(d₁, ø₃(ø₂(d₂, d₃), d₄)))  # d₁ ø₁ ((d₂ ø₂ d₃) ø₃ d₄)
            push!(results, ø₁(d₁, ø₂(d₂, ø₃(d₃, d₄))))  # d₁ ø₁ (d₂ ø₂ (d₃ ø₃ d₄))
        end
        # inserting positive, integer results into allResults
        union!(allResults, [r for r in results if r > 0 && isinteger(r)])
    end

    # returning largest n such that positive integers 1 to n are all in allResults
    return findfirst(k -> k ∉ allResults, 1:9^4) - 1
end

"""
    findOptimalCombination(digits)

Returns `"abcd"` for four digits `a < b < c < d` such that using each digit exactly once and making use
of the four arithmetic operations (+, -, *, /) and brackets/parentheses, the longest set of consecutive
positive integers `1` to `n` can be obtained.
"""
function findOptimalCombination()

    # variables to keep track of largest limit found so far and associated combination
    maxLimit, optimalComb = 0, Int[]

    # iterating over all combinations of four digits
    for comb in collect(combinations(1:9, 4))
        combLimit = findOutputLimit(comb)  # 1 to combLimit can all be generated
        # updating variables as necessary
        if combLimit > maxLimit
            maxLimit, optimalComb = combLimit, comb
        end
    end

    # sorting optimalComb (digits should be in ascending order) and joining
    return optimalComb |> sort! |> join

end

# function call and benchmarking
@btime findOptimalCombination()