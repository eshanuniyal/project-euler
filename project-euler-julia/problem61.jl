# Julia Solution to Project Euler Problem 61
# 6 August 2020
# Runtime: ~10⁻³ seconds


"""
    findOrderedSetSum()

Returns the sum of the only ordered set of six cyclic 4-digit numbers for which each
polygonal type is represented by a different number in the set.
"""
function findOrderedSetSum()

    # generating all 4-digit figurate numbers

    numbers::Matrix{Set{Int}} = [Set{Int}() for k in 1:8, n in 1:100]
        # first dimension represents type of figurate number (e.g. 5 = pentagonal)
        # second dimension represents first two digits of figurate number (e.g. 81 = 81)
        # numbers[i, j] is a set of figurate numbers of sides i that start with two-digit number k
            # only j ∈ [10, 99] are interesting to us, since other j don't give four-digit numbers

    # iterating over number of sides
    for k in 3:8
        n = 1
        # finding first four-digit figurate number
        while figurate(n, k) < 10^3
            n += 1
        end
        # populating numbers
        while (Pₙ = figurate(n, k)) < 10^4
            # pushing number to appropriate set, incrementing n
            push!(numbers[k, Pₙ ÷ 100], Pₙ)
            n += 1
        end
    end

    # we assume the first number in the cycle is triangular
        # (set is cyclic, so order does not matter)
    # iterating over triangular numbers with valid starting two digits
    for numStart in 10:99, num ∈ numbers[3, numStart]
        # creating usedNums vector
        usedNums::Vector{Int} = [num]
        # creating usedSides vector
        usedSides::BitArray{1} = append!(trues(3), falses(5))
            # usedSides[k] = true if a number with sides k has been used
                # first three are therefore initialised as true, last five as false
        # find longest set that can be constructed with starting number num
        set = findOrderedSet(usedNums, usedSides, numbers)
        # if set has length 6, it should automatically be the cyclic one (∵ line 37)
        if length(set) == 6
            return sum(set)
        end
    end
end


"""
    findOrderedSet(usedNums, usedSides, numbers)

Returns the longest possible extension of `usedNums` that does not repeat sides and is cyclic
(except, possibly, from the last number to the first number)

# Parameter list
- `usedNums::Vector{Int}`: a vector of used integers in cyclic order
- `usedSides::BitArray{1}`: a vector representing which sides are already used corresponding to numbers in `usedNums` 
- `numbers::Matrix{Set{Int}}`: a matrix of pre-generated polygonal numbers, 
    where `numbers[i, j]` is a set of four-digit figurate numbers of number of sides `i` with first two digits `j`
"""
function findOrderedSet(usedNums::Vector{Int}, usedSides::BitArray{1}, numbers::Matrix{Set{Int}})::Vector{Int}

    # finding starting digits of next number
    nextNumStart = last(usedNums) % 100
    # easy check fr whether next number exists
    if nextNumStart < 10
        return usedNums
    end

    # iterating over unused sides
    for k in findall(x -> !x, usedSides)
        # iterating over possible numbers
        for num in numbers[k, nextNumStart]
            # creating copies of usedNums and usedSides for recursive function call
            nextUsedNums = copy(usedNums); nextUsedSides = copy(usedSides)
            push!(nextUsedNums, num); nextUsedSides[k] = true
            # searching for longest ordered set with current numbers
            fullSet = findOrderedSet(nextUsedNums, nextUsedSides, numbers)
            # testing if the set has length 6 and if the last element is cyclic with the first
            if length(fullSet) == 6 && last(fullSet) % 100 == first(fullSet) ÷ 100
                # this return cascades through the function calls
                return fullSet
            end
        end
    end

    return usedNums
end


"""
    figurate(n, k)

Return the `n`th figurate/polygonal number of sides `k` for `k` ∈ [3,8].
"""
function figurate(n::Integer, k::Integer)
    k == 3 && return (n * (n + 1)) ÷ 2
    k == 4 && return  n * n
    k == 5 && return (n * (3n - 1)) ÷ 2
    k == 6 && return  n * (2n - 1)
    k == 7 && return (n * (5n - 3)) ÷ 2
    k == 8 && return  n * (3n - 2)
    # k not in valid range [3, 8]: throw error
    throw(ArgumentError("k = $k out of bounds; required k ∈ [3, 8]."))
end

# function call and benchmarking
@btime findOrderedSetSum()