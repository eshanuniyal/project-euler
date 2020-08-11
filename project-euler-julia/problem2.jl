# Julia Solution to Project Euler Problem 2
# 5 August 2020

function findEvenFibonacciSum(bound::Int)::Int

    ∑ = 0  # initialising sum variable

    # initialising base cases
    Fᵢ₋₁, Fᵢ = 0, 1
    # iterating until we reach bound 
    while Fᵢ₋₁ + Fᵢ ≤  bound
        # generating next Fibonacci number
        Fᵢ₊₁ = Fᵢ₋₁ + Fᵢ
        # adding to total if even
        if Fᵢ₊₁ % 2 == 0
            ∑ += Fᵢ₊₁
        end
        # updating state variables
        Fᵢ₋₁, Fᵢ = Fᵢ, Fᵢ₊₁
    end

    return ∑
end



function main()
    @time println("Problem 2: ", findEvenFibonacciSum(4 * 10^6))
end

main()