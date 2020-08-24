# Julia Solution to Project Euler Problem 104
# 24 August 2020
# Runtime: ~1 second

"""
    pandigitalFibonacciEnds()

Return smallest `k` such that the first nine digits and last nine digits of Fibonacci number
`Fₖ` are 1-9 pandigital.
"""
function pandigitalFibonacciEnds()

    # returns true if input string numStr is 1-9 pandigital
    isPandigital(numStr) = !any(d -> d ∉ numStr, "123456789")

    # initialising base cases
    Fₖ₋₁, Fₖ, k = Int128(1), Int128(1), 2
    # number of digits we'll keep track at the head and tail of Fibonacci numbers
    nDigits = Int(floor(log10(typemax(Int128))) ÷ 2) - 1  
        # maximum number of digits (18) we can keep on each end working with Int128s

    # iterating until we get Fibonacci numbers with nDigits digits on each end
    while log10(Fₖ₋₁) ≤ 2 * nDigits
        # generating next Fibonacci number and updating state variables
        Fₖ₋₁, Fₖ = Fₖ, Fₖ₋₁ + Fₖ  
        k += 1
    end

    # at this point, both Fₖ₋₁ and Fₖ are exactly 2 * nDigits digits
    power = Int128(10)^nDigits  # power of 10 with nDigits 0s

    # creating Fibonacci sequence for head of Fibonacci numbers
    firstFₖ₋₁, firstFₖ = Fₖ₋₁ ÷ power, Fₖ ÷ power
    # creating Fibonacci sequence for tail of Fibonacci numbers
    lastFₖ₋₁, lastFₖ = Fₖ₋₁ % power, Fₖ % power

    # iterating till we find solution
    while true

        # updating Fibonacci numbers and k
        firstFₖ₋₁, firstFₖ = firstFₖ, firstFₖ₋₁ + firstFₖ
        lastFₖ₋₁, lastFₖ = lastFₖ, lastFₖ₋₁ + lastFₖ
        k += 1

        # ensuring all variables have exactly nDigits digits
        # if firstFₖ has an extra digit, remove last digit from firstFₖ₋₁, firstFₖ
        if log10(firstFₖ) > nDigits
            firstFₖ₋₁, firstFₖ = firstFₖ₋₁ ÷ 10, firstFₖ ÷ 10
        end
        # if lastFₖ has an extra digit, remove first digit from lastFₖ
        if log10(lastFₖ) > nDigits
            lastFₖ = lastFₖ % power
        end

        # generating strings of first and last nine digits
        firstStr, lastStr = string(firstFₖ)[1:9], string(lastFₖ)[end - 8 : end]      
        # returning k if firstStr and lastStr both pandigital  
        isPandigital(firstStr) && isPandigital(lastStr) && break
    end
   
    return k
end

@btime pandigitalFibonacciEnds()