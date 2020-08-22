# Julia Solution to Project Euler Problem 90
# 22 August 2020
# Runtime: 10⁻³ seconds

using Combinatorics  # combinations

function cubeDigitPairsFast()

    # generating tuples of digits of squares
    squares = [(sq ÷ 10, sq % 10) for sq in [x^2 for x in 1:9]]

    # generating all possible unique dices
    dices = collect(combinations(0:9, 6))

    # extending dices that have sixes and nines
    for dice in dices
        for k in [6, 9]
            (k ∈ dice && 15 - k ∉ dice) && push!(dice, 15 - k)
        end
    end
    
    nPairs = 0  # number of pairs of dices that allow all squares to be generated

    # iterating over all unique pairs of dices
    for i in 1:length(dices), j in i+1:length(dices)
        # extracting current dices
        dice₁, dice₂ = dices[i], dices[j]

        # iterating over squares
        for (d₁, d₂) in squares
            # break if pair does not contain current square
            (d₁ ∉ dice₁ || d₂ ∉ dice₂) && (d₂ ∉ dice₁ || d₁ ∉ dice₂) && break
            10d₁ + d₂ == 81 && (nPairs += 1)
                # all squares checked, increment nPairs
        end
    end

    return nPairs
end

# function call and benchmarking
@btime cubeDigitPairsFast()