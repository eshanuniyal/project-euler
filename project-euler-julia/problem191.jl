# Julia Solution to Project Euler Problem 191
# 27 August 2020
# Runtime: ~10⁻⁵ seconds

"""
    prizeStrings(ndays)

Returns the number of prize strings that exist in an `nDays`-period, as defined in Problem 191.
"""
function prizeStrings(nDays)
    
    # creating a dictionary to store known results
    knownChoices = Dict{Tuple{Char, Int, Bool, Bool}, Int}()

    # finding and returning number of winning strings
    return countPrizeStrings(knownChoices, 'O', nDays, true, true)
        # choosing 'O' guarantees we will look at all prize strings of length 30
end

"""
    countPrizeStrings(knownChoices, p, n, Aₚ, Lₚ)

Returns the number of prize strings of length `n` given previous choice was `p` and booleans representing
whether or not 'A' is allowed in the first position and 'L' is allowed anywhere.

# Parameter list
- `knownChoices::Dict{Tuple{Char, Int, Bool, Bool}, Int}`: a dictionary of stored results, where 
each key corresponds to (p, n, Aₚ, Lₚ)
- `p::Char`: the last choice that was made; `p` ∈ ['O', 'A', 'L']
- `n::Int`: the desired length of the string 
- `Aₚ::Bool`: `true` if we can choose 'A' in the first position, false otherwise
- `Lₚ::Bool`: `true` if we can still choose 'L' somewhere, false otherwise 
"""
function countPrizeStrings(knownChoices, p, n, Aₚ, Lₚ)

    # base case: no more choices
    n == 0 && return 1

    # base case: number of choices going forward already known
    (p, n, Aₚ, Lₚ) in keys(knownChoices) && return knownChoices[(p, n, Aₚ, Lₚ)]

    count = 0  # number of choices going forward

    # we can always choose O; adding number of choices going forward if O is chosen
    count += countPrizeStrings(knownChoices, 'O', n - 1, true, Lₚ)
        # if we choose O, A is automatically possible ⟹ Aₚ = true
        # whether or not L is possible remains unchanged

    # if we can choose A, adding number of choices going forward if A is chosen
    Aₚ && (count += countPrizeStrings(knownChoices, 'A', n - 1, p ≠ 'A', Lₚ))
        # if we choose A, whether or not we can choose A again depends on whether
        # previous choice (p) was also A; if not, Aₚ = true going forward
        # whether or not L is possible remains unchanged

    # if we can choose L, adding number of choices going forward if L is chosen
    Lₚ && (count += countPrizeStrings(knownChoices, 'L', n - 1, true, false))
        # if we choose L, A is automatically possible ⟹ Aₚ = true
        # if we choose L, we can no longer choose L going forward ⟹ Lₚ = false

    # updating known choices and returning count
    return knownChoices[(p, n, Aₚ, Lₚ)] = count
end

@btime prizeStrings(30)