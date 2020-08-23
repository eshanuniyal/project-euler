# Julia Solution to Project Euler Problem 96
# 23 August 2020
# Runtime: ~4 seconds

using DelimitedFiles  # readdlm


"""
    extractSudokus(fileName)

Returns a vector of sudokus extracted from `fileName`, a .txt file where each sudoku is 
preceded by "Grid <grid number>" and is written such that rows are separated by newline 
characters and digits in each row have no spaces between them.
"""
function extractSudokus(fileName)
    
    # reading lines with numbers
    sudokuLines = readdlm(fileName, ' ', String, '\n', comments = true, comment_char = 'G')
        # comments = true, comment_char = 'G' lets us skip lines starting with "Grid"

    # vector of sudokus
    sudokus = Vector{Matrix{Int8}}()

    # iterating over sudokuLines to generate sudokus
    for s in 0:9:length(sudokuLines)-1
        # generating sudoku (matrix of Int8s)
        sudoku = [parse(Int8, sudokuLines[s + l][d]) for l in 1:9, d in 1:9]
        # pushing to sudokus
        push!(sudokus, sudoku)
    end

    return sudokus
end

"""
    findPossibilities(sudoku, r, c)

Returns a set of possibilities for the digit at `sudoku[r, c]` by examining the 
    row, column, and block `sudoku[r, c]` is in.
"""
function findPossibilities(sudoku, r, c)
    br, bc = (r - 1) ÷ 3, (c - 1) ÷ 3  # br = block row, bc = block column ∈ [0, 1, 2]
    # finding all digits already used in row/column/block
    usedDigits = sudoku[r, :] ∪ sudoku[:, c] ∪ sudoku[3br+1 : 3br+3, 3bc+1 : 3bc+3]
    return setdiff(1:9, usedDigits)  # returning digits not used
end

"""
    bruteForceSolveSudoku(sudoku, sr, sc)

Solves and returns a sudoku by trying all possibilities for missing numbers starting 
    from `sudoku[sr, sc]`.
"""
function bruteForceSolveSudoku(sudoku, sr, sc)

    # finding index for next missing number
    while sudoku[sr, sc] ≠ 0
        if sc < 9 
            sc += 1  # move to next column
        else
            sr, sc = sr + 1, 1  # move to next row
        end
        # ran out of rows -> sudoku is solved
        sr == 10 && return sudoku
    end

    # array of possible values for sudoku[sr, sc]
    pSpace = findPossibilities(sudoku, sr, sc)

    # iterating over possibilities
    for p in pSpace
        # updating sudoku[sr, sc]
        sudoku[sr, sc] = p
        # searching for solution assuming p is the right value
        triedSudoku = bruteForceSolveSudoku(copy(sudoku), sr, sc)
        # if 0 ∉ triedSudoku, sudoku was successfully solved
        0 ∉ triedSudoku && return triedSudoku
    end

    # if there are no possibilities, return sudoku unchanged
    return sudoku
end

"""
    solveSudoku(sudoku)

Solves and returns `sudoku`, a matrix of integers.
"""
function solveSudoku(sudoku)

    # set of CartesianIndices representing all unsolved positions
    unsolvedIndices = Set(findall(k -> k == 0, sudoku))

    # iterating and solving the sudoku deductively
    while true
        progress = false  
            # represents whether any deductions could be made in current iteration
        # iterating over unsolved indices
        for index in unsolvedIndices
            r, c = index[1], index[2]  # extracting row and column
            # finding possibility space for sudoku[r, c]
            pSpace = findPossibilities(sudoku, r, c)
            # if only one possibility, can deduce solution
            if length(pSpace) == 1
                sudoku[r, c] = pSpace[1]  # update sudoku
                progress = true  # deduction made in current iteration of while loop
                delete!(unsolvedIndices, index)  # index no longer unsolved
            end
        end

        # break if sudoku completely solved or cannot solve further deductively
        (isempty(unsolvedIndices) || !progress) && break
    end

    # if matrix not fully solved, solve by brute force
    !isempty(unsolvedIndices) && (sudoku = bruteForceSolveSudoku(sudoku, 1, 1))

    return sudoku
end

"""
    solveAllSudokus(filename)

Returns the sum of three-digit numbers found in the top-left corner of sudokus extracted from `fileName`, 
a .txt file where each sudoku is preceded by "Grid <grid number>" and is written such that 
rows are separated by newline characters and digits in each row have no spaces between them.
"""
function solveAllSudokus(fileName)

    sudokus = extractSudokus(fileName)  # extracted sudokus

    # finding sum of three-digit numbers found in top-left corner for each solved sudoku
    Σ = [parse(Int, solveSudoku(s)[1, 1:3] |> join) for s in sudokus] |> sum
   
    return Σ
end

# function call and benchmarking
@btime solveAllSudokus("Problem Resources\\problem96.txt")# 