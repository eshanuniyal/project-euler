# Julia Solution to Project Euler Problem 83
# 5 August 2020

using DelimitedFiles # readdlm
using DataStructures # PriorityQueue

mutable struct Node
	r::Int
	c::Int
	val::Int
	adjNodes::Vector{Node}
	shortestPath::Int
	heuristic::Int
end

function generateNodeMatrix(numMatrix::Matrix{Int})::Matrix{Node}

	nRows, nCols = first(size(numMatrix)), last(size(numMatrix))
	nodeMatrix = Matrix{Node}(undef, nRows, nCols)

	# defining heuristic
	heuristic(r, c) = nCols - c + nRows - r

	# setting up nodeMatrix
	emptyAdjNodes::Vector{Node} = []
	for r ∈ 1:nRows
		for c ∈ 1:nCols
			nodeMatrix[r, c] = Node(r, c, numMatrix[r, c], emptyAdjNodes, typemax(Int), heuristic(r, c))
		end
	end

	# finding adjacent nodes
	for r ∈ 1:nRows
		for c ∈ 1:nCols
			adjNodes::Vector{Node} = []
			# pushing right node, if it exists
			c + 1 ≤ nCols && push!(adjNodes, nodeMatrix[r, c + 1])
			# pushing down node, if it exists
			r + 1 ≤ nRows && push!(adjNodes, nodeMatrix[r + 1, c])
			# pushing left node, if it exists
			c - 1 ≥ 1 && push!(adjNodes, nodeMatrix[r, c - 1])
			# pushing up node, if it exists
			r - 1 ≥ 1 && push!(adjNodes, nodeMatrix[r - 1, c])
			nodeMatrix[r, c].adjNodes = adjNodes
		end
	end

	return nodeMatrix
end

function minPathSumFourWays(fileName::String)::Int
    # return minimum path sum across matrix defined in fileName moving up, down, and right

    # extracting matrix
    numMatrix::Matrix{Int} = readdlm(fileName, ',', Int, '\n')
	nodeMatrix::Matrix{Node} = generateNodeMatrix(numMatrix)

	# setting shortest path of first element
	source = nodeMatrix[1, 1]
	source.shortestPath = source.val

	pQueue = PriorityQueue{Node, Int}()
	enqueue!(pQueue, source, source.shortestPath + source.heuristic)

	while !isempty(pQueue)
		# extracting current node
		node = dequeue!(pQueue)
		for adjNode in node.adjNodes
			if node.shortestPath + adjNode.val < adjNode.shortestPath
				adjNode.shortestPath = node.shortestPath + adjNode.val
				enqueue!(pQueue, adjNode, adjNode.shortestPath + adjNode.heuristic)
			end
		end
	end

	return nodeMatrix[end, end].shortestPath
end

function main()
    @time println("Problem 83: ", minPathSumFourWays("Problem Resources\\problems81,82,83test.txt"))
end

main()
