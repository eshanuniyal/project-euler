# Julia Solution to Project Euler Problem 2
# 5 August 2020

function findEvenFibonacciSum(bound::Int)::Int

    total = 0  # initialising sum variable

    # initialising base cases
    Fᵢ, Fⱼ = 0, 1
    # iterating until we reach bound
    while Fᵢ + Fⱼ ≤ bound
        # generating next Fibonacci number
        Fₖ = Fᵢ + Fⱼ
        # adding to total if even
        if Fₖ % 2 === 0
            total += Fₖ
        end
        # updating state variables
        Fᵢ, Fⱼ = Fⱼ, Fₖ
    end

    return total
end



function main()
    @time println("Problem 2: ", findEvenFibonacciSum(4 * 10^6))
end

main()
