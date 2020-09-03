# Julia Solution to Project Euler Problem 135
# 2 September 2020
# Runtime: 10⁻⁴ seconds
# Solution based on solution to Problem 191

"""
    hexadecimalNumbers(reqDigits, maxLength)

Returns the number of hexadecimal numbers of length at most `maxLength` that use each character
in `reqDigits` at least once.
"""
function hexadecimalNumbers(reqDigits, maxLength)

    # creating a dictionary to store known results
    knownCounts = Dict{Tuple{Int, Int}, Int}()
        # knownCounts[(n, r)] = number of hexadecimal strings (including strings starting with '0')
        # of length n that must use r distinct characters at least

    totalCount = 0  # total number of valid hexadecimal numbers

    # iterating over possible lengths
    for l in length(reqDigits):maxLength

        # iterating over valid starting digits
        for sd in hexDigits[2:end]
            # creating set of remaining required digits
            r = Set(reqDigits); delete!(r, sd)
            # finding number of hexadecimal strings of length l - 1 that use all digits in rNext
            totalCount += countHexadecimalNumbers(knownCounts, l - 1, r)
        end
    end

    # converting totalCount to base 16 and returning
    return string(totalCount, base = 16) |> uppercase
end


"""
    countHexadecimalNumbers(knownCounts, n, r)

Return the number of hexadecimal strings (including strings starting with '0') of length
`n` that use `r` particular distinct characters at least once, given `knownCounts`, a dictionary
such that `knownCounts[(n, r)]`, if it exists, is the number of such strings
"""
function countHexadecimalNumbers(knownCounts, n, r)
    
    # number of required digits that are yet to be added
    remDigits = length(r)  # number of true values in r
    
    # base case: can't fit remaining required digits
    remDigits > n && return 0

    # base case: no more digits to fill
    n == 0 && return 1

    # base case: number of choices going forward already known
    (n, remDigits) in keys(knownCounts) && return knownCounts[(n, remDigits)]

    count = 0  # number of choices going forward

    # iterating over possibilities for next digit
    for d in "0123456789ABCDEF"
        # creating rNext (updated version of if hexdigits[d] is next digit)
        rNext = copy(r); delete!(rNext, d)
        # adding number of hexadecimal strings of length n - 1 that use all digits in rNext
        count += countHexadecimalNumbers(knownCounts, n - 1, rNext)
    end

    # updating known choices and returning count
    return knownCounts[(n, remDigits)] = count
end

# function call and benchmarking
@btime hexadecimalNumbers("01A", 16)