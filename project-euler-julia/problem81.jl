# Julia Solution to Project Euler Problem 81
# 5 August 2020

using DelimitedFiles # readdlm

function minPathSum(sr::Int, sc::Int, matrix::Matrix{Int},  minPathSums::Matrix{Union{Int, Nothing}})::Int
    # (sr, sc) = index of starting element
    # matrix = matrix of entries
    # minPathSums = matrix of minimal path sums from (1, 1) to (i, j)

	# out of bounds, can't travel -> return "infinity"
	if !checkbounds(Bool, matrix, sr, sc)
		return typemax(Int)	# sentinel for infinity
	end

    # base case: already found minimal path
    if minPathSums[sr, sc] ≠ nothing
        return minPathSums[sr, sc]
	end

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


function main()
    @time println(minPathSumTwoWays("Problem Resources\\problems81,82,83.txt"))
end

main()
