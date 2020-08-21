module AuxFunctions
export findContinuedFraction

"""
    findContinuedFraction(num)

Return a vector representing a block of constants that repeats indefinitely in the continued fraction of root of integer `num`.
"""
function findContinuedFraction(num::Integer)

    # if num is a perfect square, return empty continued fraction
    isqrt(num)^2 == num && return Vector{Int}()

    # sequence of a's (until sequence starts repeating)
    fractionConstants = Vector{Int}()

    # first constant
    aStart = isqrt(num)
    nₖ, dₖ = 1, -aStart
    
    while true
        # rationalising numerator / (√num - denominatorTerm)
        dₖ₊₁ = -dₖ                  # (tentative) next denominator
        nₖ₊₁ = (num - dₖ^2) ÷ nₖ    # next numerator
        aₖ₊₁ = 0                   # (tentative) next constant

        # transforming dₖ₊₁ to appropriate form
        while num > (dₖ₊₁ - nₖ₊₁)^2
            dₖ₊₁ -= nₖ₊₁
            aₖ₊₁ += 1
        end

        # updating nₖ, dₖ, fractionConstants
        nₖ, dₖ = nₖ₊₁, dₖ₊₁
        push!(fractionConstants, aₖ₊₁)
        
        # terminating condition: we're back to the first iteration
        (nₖ == 1 && dₖ == -aStart) && break
    end 

    return fractionConstants
end

end  # module
