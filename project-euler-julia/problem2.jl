
function findEvenFibonacciSum(bound::Int)::Int

    total::Int = 0  # initialising sum variable

    # initialising base cases
    Fnm1::Int = 0
    Fn::Int = 1
    # iterating until we reach bound
    while Fnm1 + Fn <= bound
        # generating next Fibonacci number
        Fnp1 = Fnm1 + Fn
        # adding to total if even
        if Fnp1 % 2 == 0
            total += Fnp1
        end
        # updating state variables
        Fnm1 = Fn; Fn = Fnp1;
    end
    return total
end

println("Problem 2: ", findEvenFibonacciSum(4 * 10^6))
