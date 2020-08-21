# Project Euler Problem 64 (https://projecteuler.net/problem=64)
# July 20, 2020
# Runtime: 10⁻⁵ seconds

import AuxFunctions: findContinuedFraction

"""
    oddPeriodSquareRoots(bound)

Returns the number of continued fractions of `√n` for `n ≤ bound` that have an odd period. 
"""
function oddPeriodSquareRoots(bound::Integer)
	
	oddCount = 0

	# finding continued fractions with odd period
    for N in 1:bound
        # check if continued fraction for √N has odd period
        length(findContinuedFraction(N)) % 2 == 1 && (oddCount += 1)
            # note: for perfect squares, findContinuedFraction returns empty vector (even period)
    end

	return oddCount
end

# function call
@btime oddPeriodSquareRoots(10000)