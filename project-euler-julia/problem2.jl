# Julia Solution to Project Euler Problem 2
# 5 August 2020

function findEvenFibonacciSum(bound::Int)::Int

    ∑ = 0  # initialising sum variable
    Fᵢ₋₁, Fᵢ = 0, 1  # initialising base cases

    # iterating until we reach bound 
    while Fᵢ₋₁ + Fᵢ ≤  bound
        Fᵢ₋₁, Fᵢ = Fᵢ, Fᵢ₋₁ + Fᵢ  # generating next Fibonacci number and updating state variables
        Fᵢ % 2 == 0 && (∑ += Fᵢ)  # adding to total if even
    end

    return ∑
end



function main()
    @time println("Problem 2: ", findEvenFibonacciSum(4 * 10^6))
end

main()