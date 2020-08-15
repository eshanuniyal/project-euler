# Julia Solution to Project Euler Problem 81
# 5 August 2020
# Runtime: ~10⁻³ seconds

using DelimitedFiles # readdlm

"""
	minPathSum(sr, sc, matrix, minPathSums)

Recursive function which returns the sum of the minimal path from `matrix[sr, sc]` to `matrix[end, end]`
	going only down and right.

# Arguments
- `sr::Int`: row number of starting element
- `sc::Int`: column number of starting element
- `matrix::Matrix{Int}`: matrix representing a grid of integers
- `minPathSums::Matrix{Union{Int, Nothing}}`: matrix representing minimal path sums such that `minPathSums[i, j]` is the sum of the minimal path from `matrix[i, j]` to `matrix[end, end]` if known, and `nothing` otherwise
"""
function minPathSum(sr::Int, sc::Int, matrix::Matrix{Int},  minPathSums::Matrix{Union{Int, Nothing}})::Int

	# out of bounds, can't travel -> return "infinity"
	!checkbounds(Bool, matrix, sr, sc) && return typemax(Int)	# sentinel for infinity
    # base case: already found minimal path
    minPathSums[sr, sc] ≠ nothing && return minPathSums[sr, sc]

    # not at end point -> find minimal path from right element and below element (if they exist)
		# if they don't exist, line 10 returns infinity
	rightPath = minPathSum(sr, sc + 1, matrix, minPathSums)
	 	# minimal path from the right
	downPath = minPathSum(sr + 1, sc, matrix, minPathSums)
		# minimal path from below

	# finding minimal path and updating minPathSums
	minPathSums[sr, sc] = min(rightPath, downPath) + matrix[sr, sc]

	# returning minimal path
	return minPathSums[sr, sc]

end

"""
	minPathSumTwoWays(fileName)

Returns sum of the minimum path from the top-left element of a grid defined in `fileName` 
to the bottom-right element moving only down and right.
"""
function minPathSumTwoWays(fileName::String)::Int
    # return minimum path sum across matrix defined in fileName moving only down and right

    # extracting matrix
    matrix::Matrix{Int} = readdlm(fileName, ',', Int, '\n')
    # defining minPathSums matrix
    minPathSums = Matrix{Union{Int, Nothing}}(nothing, size(matrix))
		# -1 by default; if minPathSums[i, j] == -1, the minimal path from (1, 1) to (i, j) has not been found

	# setting base case: minimum path from last element to last element is the element itself
	minPathSums[end, end] = matrix[end, end]

	return minPathSum(1, 1, matrix, minPathSums)
end

# function call
@time println(minPathSumTwoWays("Problem Resources\\problems81,82,83.txt"))