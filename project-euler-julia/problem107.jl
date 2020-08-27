# Julia Solution to Project Euler Problem 107
# 25 August 2020
# Runtime: 10⁻³ seconds

using DelimitedFiles  # readdlm
using DataStructures  # priority queue

"""
    minimumSpanningTree(fileName)

Returns the maximum possible saving, using Prim's Algorithm, by removing edges from a 
connected network/graph provided in `fileName` such that the tree is still connected.
"""
function minimumSpanningTree(fileName)

    A = extractGraph(fileName)  # extracted adjacency matrix
    V = collect(1:size(A, 1))  # vector of vertices

    # finding weight of full tree by adding all weights above diagonal
    treeWeight = [A[r, c] for r in 1:length(V) for c in r + 1:length(V) if A[r, c] ≠ -1] |> sum

    # defining weight and adjacent functions
    w(vᵢ, vⱼ) = A[vᵢ, vⱼ] == -1 ? nothing : A[vᵢ, vⱼ]
    Adj(vᵢ) = [vⱼ for vⱼ in 1:length(V) if w(vᵢ, vⱼ) ≠ nothing]

    π = Dict(vᵢ => -1 for vᵢ in 1:length(V))  # dictionary of predecessor vertices
        # π[vᵢ] = predecessor of vᵢ
    Adj = Dict(vᵢ => Adj(vᵢ) for vᵢ in keys(V))  # dictionary of adjacent verticies
        # Adj[vᵢ] = vector of vertices that share an edge with vᵢ

    # creating priority queue of all vertices not already in spanning tree
    Q = PriorityQueue{Int, Int}()
    # enqueuing all vertices with priority ∞
    for vᵢ in V
        enqueue!(Q, vᵢ, typemax(Int))
    end
    Q[1] = 0  # we start with vertex 1 (arbitrary choice)

    # iterating while Q is nonempty (i.e., tree is incomplete)
    while !isempty(Q)
        # dequeueing vertex with least priority
        u = dequeue!(Q) 
        # iterating over vertices adjacent to u
        for v in Adj[u]
            wᵤᵥ = w(u, v)  # weight of edge connecting u, v
            # if v is unexplored and w(u, v) is shorter edge to v, update variables
            if v in keys(Q) && wᵤᵥ < Q[v]
                # updating predecessors and priority queue
                π[v], Q[v] = u, wᵤᵥ
            end
        end
    end
    
    # finding weight of minimum spanning tree
    minTreeWeight = [w(v, pred) for (v, pred) in π if pred ≠ -1] |> sum

    # returning savings
    return treeWeight - minTreeWeight
end


"""
    extractGraph(fileName)

Returns an adjacency matrix representing a graph given in `fileName`.
"""
function extractGraph(fileName)
    A = readdlm(fileName, ',', String, '\n',)  # adjacency matrix
    n = size(A, 1)  # number of vertices
    # creating adjacency matrix of integer weights; -1 indicates no edge between vertices
    return [A[r, c] == "-" ? -1 : parse(Int, A[r, c]) for r in 1:n, c in 1:n]
end

# function call and benchmarking
@btime minimumSpanningTree("Problem Resources\\problem107.txt")