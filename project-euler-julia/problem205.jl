# Julia Solution to Project Euler Problem 205
# 25 August 2020
# Runtime: 10⁻⁴ seconds

using Combinatorics  # with_replacement_combinations

"""
    diceGame(d₁, d₂, n₁, n₂)

Returns the probability that player 1 will win (i.e., get a higher total) given player 1 has 
`n₁` dice of `d₁` sides and player 2 has `n₂` dice of `d₂` sides.
"""
function diceGame(d₁, d₂, n₁, n₂)

    # finding sets of unique rolls for each player
    rolls₁, totalRolls₁ = with_replacement_combinations(1:d₁, n₁), d₁^n₁
    rolls₂, totalRolls₂ = with_replacement_combinations(1:d₂, n₂), d₂^n₂
    
    # creating dictionary of probabilities for each player's total
    prob₁ = Dict{Int, Float64}(s => 0 for s in 1:d₁*n₁)
    prob₂ = Dict{Int, Float64}(s => 0 for s in 1:d₂*n₂)

    # pre-computing factorials
    ft₁, ft₂ = factorial(n₁), factorial(n₂)

    # iterating over unique rolls for player 1
    for roll in rolls₁
        # finding number of unique permutations of the roll 
        rollPerms = ft₁ ÷ ([count(x -> x == f, roll) |> factorial for f in 1:d₁] |> prod)
        # adding probability of some permutation of this roll to probability of sum(roll)
        prob₁[sum(roll)] += rollPerms / totalRolls₁
    end

    # iterating over unique rolls for player 2
    for roll in rolls₂
        # finding number of unique permutations of the roll 
        rollPerms = ft₂ ÷ ([count(x -> x == f, roll) |> factorial for f in 1:d₂] |> prod)
        # adding probability of some permutation of this roll to probability of sum(roll)
        prob₂[sum(roll)] += rollPerms / totalRolls₂
    end

    # computing win probability for player 1
    winProb = sum([p₁ * p₂ for (s₁, p₁) in prob₁, (s₂, p₂) in prob₂ if s₁ > s₂])
    
    # rounding win probability to 7 digits and returning answer
    return round(winProb, digits = 7)
end

# function call and benchmarking
@btime diceGame(4, 6, 9, 6)