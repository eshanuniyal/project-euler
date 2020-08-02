function findSumOfMultiples(factors::Array{Int}, bound::Int)::Int
    # generic solution; takes input factors and returns the sum of all numbers
    # in [1, bound] that are divisible by at least one factor in factors
    total::Int = 0
    for k = 1:bound
        for factor in factors
            if k % factor == 0
                total += k
                break
            end
        end
    end
    return total
end

function findSumOfMultiplesFast(bound::Int)::Int
    # solution tailored to problem 1
    return sum([k for k in 1:bound if k % 3 == 0 || k % 5 == 0])
end

println("Problem 1: ", findSumOfMultiplesFast([3, 5], 1000))
