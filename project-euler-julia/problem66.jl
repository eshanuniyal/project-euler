# Julia Solution to Project Euler Problem 88
# 21 August 2020
# Runtime: ~10⁻² seconds

import AuxFunctions: findMinimalPellSolution

"""
    diophantineEquation(bound)

Return (non-perfect-square) integer `D` in `[2, bound]` such that the minimal solution `x` for `x² - Dy² = 1` is largest
"""
function diophantineEquation(bound::Integer)

	# tracking max minimal solution found so far and the corresponding value of D
	maxMinimalSolution, optimalD = 0, 0

    # iterating over [2, D]
    for D in 2:bound
        
        # filtering out perfect squares
        isqrt(D)^2 == D && continue

        # generating minimal solution
        minimalSolution = findMinimalPellSolution(D)
        
        # updating maxMinimalSolution and optimalD as necessary
        if minimalSolution > maxMinimalSolution
            maxMinimalSolution = minimalSolution
            optimalD = D
        end

    end 

    return optimalD
end

# function call and benchmark
@btime diophantineEquation(1000)