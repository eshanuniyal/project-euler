# Project Euler Problem 64 (https://projecteuler.net/problem=64)
# July 20, 2020
# Runtime: 10⁻² seconds

import AuxFunctions: findContinuedFraction

"""
    oddPeriodSquareRoots(bound)

Returns the number of continued fractions of `√n` for `n ≤ bound` that have an odd period. 
"""
function oddPeriodSquareRoots(bound::Integer)
	return count(N -> length(findContinuedFraction(N)) % 2 == 1, 1:bound)
end

# function call
@btime oddPeriodSquareRoots(10000)