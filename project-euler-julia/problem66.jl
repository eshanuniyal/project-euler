# Julia Solution to Project Euler Problem 88
# 21 August 2020
# Runtime: ~10⁻² seconds

import AuxFunctions: findContinuedFraction

"""
    findMinimalSolution(D)

Return minimal `x` such that `x` solves the Diophantine equation `x² - Dy² = 1` for some `y` given integer `D`
"""
function findMinimalSolution(D::Integer) 
    
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

"""
    diophantineEquation(bound)

Return (non-perfect-square) integer `D` in `[2, bound]` such that the minimal solution `x` for `x² - Dy² = 1` is largest
"""
function diophantineEquation(bound::Integer)

	# tracking max minimal solution found so far and the corresponding value of D
	maxMinimalSolution = 0
	optimalD = 0

    # iterating over [2, D]
    for D in 2:bound
        
        # filtering out perfect squares
        isqrt(D)^2 == D && continue

        # generating minimal solution
        minimalSolution = findMinimalSolution(D)
        
        # updating maxMinimalSolution and optimalD as necessary
        if minimalSolution > maxMinimalSolution
            maxMinimalSolution = minimalSolution
            optimalD = D
        end

    end 

    return optimalD;
end

# function call
@time println(diophantineEquation(1000))