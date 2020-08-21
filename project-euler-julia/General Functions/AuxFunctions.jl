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

"""
    findMinimalPellSolution(D)

Return minimal `x` such that `x` solves Pell's equation `x² - Dy² = 1` for some `y` given integer `D`
"""
function findMinimalPellSolution(D::Integer) 
    
	continuedFraction::Vector{Int} = findContinuedFraction(D)
        # constants in continued fraction of root D (assumed D is not a square)
    period = length(continuedFraction)

	# initialising constants (all BigInts)
    Aₖ₋₁, Bₖ₋₁ = one(BigInt), zero(BigInt)
	Aₖ, Bₖ = BigInt(isqrt(D)), one(BigInt)
	k = 0
	
	# while we don't have a solution to the Diophantine equation
	while Aₖ^2 - D * Bₖ^2 ≠ 1
		
		# generating next convergent Aₖ₊₁/Bₖ₊₁
		# formula for next convergent verified from https://mathworld.wolfram.com/Convergent.html
		Aₖ₊₁ = continuedFraction[k % period + 1] * Aₖ + Aₖ₋₁  # +1 since indexing is 1-based
        Bₖ₊₁ = continuedFraction[k % period + 1] * Bₖ + Bₖ₋₁

		# updating variables
		Aₖ₋₁, Bₖ₋₁ = Aₖ, Bₖ
		Aₖ, Bₖ = Aₖ₊₁, Bₖ₊₁
		k += 1
    end

	return Aₖ
end

end  # module
