# Julia Solution to Project Euler Problem 345
# 25 August 2020
# Runtime: ~1 second

using DelimitedFiles  # readdlm

"""
    extractMatrix(fileName)

Returns a matrix of numbers extracted from `fileName`, a .txt file where each row is separated 
by newline characters and and distinct numbers in each row have space(s) between them.
"""
function extractMatrix(fileName)
    
    # reading in rows
    matrixStr = readdlm(fileName, ' ', String, '\n')
    # finding number of rows and columns (some columns include "")
    rₙ, cₙ = size(matrixStr, 1), size(matrixStr, 2)
    
    # creating matrix to store numbers
    matrix = fill(0, (rₙ, rₙ))
    # inserting rows in matrix
    for r in 1:rₙ
        matrix[r, :] = [parse(Int, matrixStr[r, c]) for c in 1:cₙ if matrixStr[r, c] ≠ ""]
    end

    return matrix
end

"""
    findMaxMatrixSum(M, matrixSums)

Returns the maximum possible sum of elements in matrix `M` such that none of the selected 
elements share the same row or column given dictionary of known sums `matrixSums`.
"""
function findMaxMatrixSum(M, matrixSums)

    # if maximal matrix sum already known, return sum
    M ∈ keys(matrixSums) && return matrixSums[M]

    # base case: matrix has one element
    length(M) == 1 && return M[1, 1]
    
    # finding maximal matrix sum
    max = 0
    # iterating over different columns
    for c in 1:size(M, 2)
        # finding matrix sum if we choose M[1, c]
        matrixSum = M[1, c] + findMaxMatrixSum(hcat(M[2:end, 1:c-1], M[2:end, c+1:end]), matrixSums)
        # updating max if necessary
        matrixSum > max && (max = matrixSum)
    end

    # updating matrixSums and returning max
    matrixSums[M] = max
    return max
end

"""
    matrixSum(fileName)

Returns the maximum possible sum of elements in a matrix defined in `fileName` such that 
none of the selected  elements share the same row or column.
"""
function matrixSum(fileName)

    # extracting matrix
    matrix = extractMatrix(fileName)
    # creating dictionary to store maximal matrix sums
    matrixSums = Dict{Matrix{Int}, Int}()

    # returning maximal matrix sum
    return findMaxMatrixSum(matrix, matrixSums)
end

# function call and benchmarking
@btime matrixSum("Problem Resources/problem345.txt")