# Julia Solution to Project Euler Problem 82
# 5 August 2020
# Runtime: ~10⁻³ seconds

using DelimitedFiles # readdlm

"""
	minPathSumTwoWays(fileName)

Returns sum of the minimum path from the top-left element of a grid defined in `fileName` 
to the bottom-right element moving only up, down, and right.
"""
function minPathSumThreeWays(fileName::String)::Int

    # extracting matrix
    matrix::Matrix{Int} = readdlm(fileName, ',', Int, '\n')
	rₙ, cₙ = first(size(matrix)), last(size(matrix))
	# defining minPathSums matrices
	minPathSums = Array{Union{Int, Nothing}, 3}(nothing, 2, rₙ, cₙ)
		# minPathSums[UP, i, j] stores min path going up/right for i ≠ 1
		# minPathSums[DOWN, i, j] stores min path going down/right for i ≠ first(size(matrix))
	
	# setting base case: minimum path from element in last row to itself is the element itself
	for sr ∈ 1:rₙ
		minPathSums[UP, sr, end] = matrix[sr, end]
		minPathSums[DOWN, sr, end] = matrix[sr, end]
	end

	# finding minimal path from each starting index in first column
	bestMinPathSum = typemax(Int)	# sentinel
	# iterating over rows
	for sr ∈ 1:rₙ
		# finding min path sum from (sr, 1)
		currentMinPathSum = minPathSum(sr, 1, RIGHT, matrix, minPathSums)
		currentMinPathSum < bestMinPathSum && (bestMinPathSum = currentMinPathSum)
	end

	return bestMinPathSum
end


# creating enumeration for directions
@enum Direction begin
	UP = 1;	DOWN = 2; RIGHT = 3
end

Base.to_index(dir::Direction)::Int = Int(dir)


"""
	minPathSum(sr, sc, dir, matrix, minPathSums)

Recursive function which returns the sum of the minimal path from `matrix[sr, sc]` to `matrix[end, end]`
	going only down, up and to the right and excluding the element that came before [sr, sc] 
	(as indicated) by `dir`.

# Arguments
- `sr::Int`: row number of starting element
- `sc::Int`: column number of starting element
- `dir::Direction`: enum type representing direction we came to `matrix[sr, sc]` from; `UP = 1`, `DOWN = 2`, `RIGHT = 3`
- `matrix::Matrix{Int}`: matrix representing a grid of integers
- `minPathSums::Array{Union{Int, Nothing}, 3}`: matrix representing minimal path sums such that `minPathSums[d, i, j]` for `d` ∈ [UP, DOWN] is the sum of the minimal path from `matrix[i, j]` to `matrix[end, end]` starting in direction `d` or right if known, and `nothing` otherwise
"""
function minPathSum(sr::Int, sc::Int, dir::Direction, matrix::Matrix{Int},  minPathSums::Array{Union{Nothing, Int}, 3})

	# base case: can travel in any direction, and already found minimal path in any direction
	dir == RIGHT && nothing ∉ minPathSums[:, sr, sc] && return minimum(minPathSums[:, sr, sc])
	# base case: travel is limited to two directions (up/right or down/right) and already found minimal path up/down
	dir ≠ RIGHT && minPathSums[dir, sr, sc] ≠ nothing && return minPathSums[dir, sr, sc]

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

# function call and benchmarking
@btime minPathSumThreeWays("Problem Resources\\problems81,82,83.txt")