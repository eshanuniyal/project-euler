# Julia Solution to Project Euler Problem 82
# 5 August 2020

using DelimitedFiles # readdlm

# creating enumeration for directions
@enum Direction begin
	UP = 1;	DOWN = 2; RIGHT = 3
end

Base.to_index(dir::Direction)::Int = Int(dir)

function minPathSum(sr::Int, sc::Int, dir::Direction, matrix::Matrix{Int},  minPathSums::Array{Union{Nothing, Int}, 3})::Int
    # (sr, sc) = index of starting element
    # matrix = matrix of entries

	# base case: can travel in any direction, and already found minimal path in any direction
	if dir == RIGHT && nothing ∉ minPathSums[:, sr, sc]
		return minimum(minPathSums[:, sr, sc])
	# base case: travel is limited to two directions (up/right or down/right) and already found minimal path up/down
	elseif dir ≠ RIGHT && minPathSums[dir, sr, sc] ≠ nothing
        return minPathSums[dir, sr, sc]
	end

    # not at end point -> find minimal path from right element and below element (if they exist)
	paths = fill(typemax(Int), 3)
		# paths[d] stores minimal path in direction d

	# checking if we can travel right
	if checkbounds(Bool, matrix, sr, sc + 1)
		paths[RIGHT] = minPathSum(sr, sc + 1, RIGHT, matrix, minPathSums) + matrix[sr, sc]
	end
	# checking if we can travel up
	if dir ≠ DOWN && checkbounds(Bool, matrix, sr - 1, sc)
		# checking if minimal path up/right already known
		if minPathSums[UP, sr, sc] ≠ nothing
			paths[UP] = minPathSums[UP, sr, sc]
		# minimal path up/right not already known -> find path
		else
			paths[UP] = minPathSum(sr - 1, sc, UP, matrix, minPathSums) + matrix[sr, sc]
			minPathSums[UP, sr, sc] = min(paths[UP], paths[RIGHT]) #updating minPathSums
		end
	end
	# checking if we can travel down
	if dir ≠ UP && checkbounds(Bool, matrix, sr + 1, sc)
		# checking if minimal path up/right already known
		if minPathSums[DOWN, sr, sc] ≠ nothing
			paths[DOWN] = minPathSums[DOWN, sr, sc]
		# minimal path up/right not already known -> find path
		else
			paths[DOWN] = minPathSum(sr + 1, sc, DOWN, matrix, minPathSums) + matrix[sr, sc]
			minPathSums[DOWN, sr, sc] = min(paths[DOWN], paths[RIGHT])	# updating minPathSums
		end
	end

	# at this point, all paths have either been found or don't exist (in which case, paths[dir] = typemax(Int))
	# returning minimal path
	return minimum(paths)

end

function minPathSumThreeWays(fileName::String)::Int
    # return minimum path sum across matrix defined in fileName moving up, down, and right

    # extracting matrix
    matrix::Matrix{Int} = readdlm(fileName, ',', Int, '\n')
	nRows, nCols = first(size(matrix)), last(size(matrix))
	# defining minPathSums matrices
	minPathSums = Array{Union{Int, Nothing}, 3}(nothing, 2, nRows, nCols)
		# minPathSums[UP, i, j] stores min path going up/right for i ≠ 1
		# minPathSums[DOWN, i, j] stores min path going down/right for i ≠ first(size(matrix))
	# setting base case: minimum path from element in last row to itself is the element itself
	for sr ∈ 1:nRows
		minPathSums[UP, sr, end] = matrix[sr, end]
		minPathSums[DOWN, sr, end] = matrix[sr, end]
	end

	# finding minimal path from each starting index in first column
	bestMinPathSum = typemax(Int)	# sentinel
	# iterating over rows
	for sr ∈ 1:nRows
		# finding min path sum from (sr, 1)
		currentMinPathSum = minPathSum(sr, 1, RIGHT, matrix, minPathSums)
		if (currentMinPathSum < bestMinPathSum)
			bestMinPathSum = currentMinPathSum
		end
	end

	return bestMinPathSum
end

function main()
    @time println("Problem 82: ", minPathSumThreeWays("Problem Resources\\problems81,82,83.txt"))
end

main()
