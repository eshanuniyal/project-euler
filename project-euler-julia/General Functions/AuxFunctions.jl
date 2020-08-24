module AuxFunctions

import PrimeFunctions: insertNextPrime
using SymEngine  # symbolic mathematics

"""
    findContinuedFraction(num)

Return a vector representing a block of constants that repeats indefinitely in the continued fraction of root of integer `num`.
"""
function findContinuedFraction(num::Integer)

    # if num is a perfect square, return empty continued fraction
    isqrt(num)^2 == num && return Vector{Int}()

    # sequence of a's (until sequence starts repeating)
    fractionConstants = Vector{Int}()

    # first constant
    aStart = isqrt(num)
    nₖ, dₖ = 1, -aStart
    
    while true
        # rationalising numerator / (√num - denominatorTerm)
        dₖ₊₁ = -dₖ                  # (tentative) next denominator
        nₖ₊₁ = (num - dₖ^2) ÷ nₖ    # next numerator
        aₖ₊₁ = 0                   # (tentative) next constant

        # transforming dₖ₊₁ to appropriate form
        while num > (dₖ₊₁ - nₖ₊₁)^2
            dₖ₊₁ -= nₖ₊₁
            aₖ₊₁ += 1
        end

        # updating nₖ, dₖ, fractionConstants
        nₖ, dₖ = nₖ₊₁, dₖ₊₁
        push!(fractionConstants, aₖ₊₁)
        
        # terminating condition: we're back to the first iteration
        (nₖ == 1 && dₖ == -aStart) && break
    end 

    return fractionConstants
end

"""
    findMinimalPellSolution(D)

Return minimal `x` such that `x` solves Pell's equation `x² - Dy² = 1` for some `y` given integer `D`
"""
function findMinimalPellSolution(D::Integer) 
    
	continuedFraction::Vector{Int} = findContinuedFraction(D)
        # constants in continued fraction of root D (assumed D is not a square)
    period = length(continuedFraction)

	# initialising constants (all BigInts)
    Aₖ₋₁, Bₖ₋₁ = one(BigInt), zero(BigInt)
	Aₖ, Bₖ = BigInt(isqrt(D)), one(BigInt)
	k = 0
	
	# while we don't have a solution to the Diophantine equation
	while Aₖ^2 - D * Bₖ^2 ≠ 1
		
		# generating next convergent Aₖ₊₁/Bₖ₊₁
		# formula for next convergent verified from https://mathworld.wolfram.com/Convergent.html
		Aₖ₊₁ = continuedFraction[k % period + 1] * Aₖ + Aₖ₋₁  # +1 since indexing is 1-based
        Bₖ₊₁ = continuedFraction[k % period + 1] * Bₖ + Bₖ₋₁

		# updating variables
		Aₖ₋₁, Bₖ₋₁ = Aₖ, Bₖ
		Aₖ, Bₖ = Aₖ₊₁, Bₖ₊₁
		k += 1
    end

	return Aₖ
end

"""
    insertNextProperDivisors(divisors, primes)

Given `divisors`, a Vector{Set{Int}} of length `n - 1` such that `divisors[k]` is a 
set of all proper divisors of `k`, and `primes`, an ordered vector of prime numbers, 
inserts set of proper divisors of `n` at index `n`.
"""
function insertNextProperDivisors(divisors::Vector{Set{Int}}, primes::Vector{Int})

    n = length(divisors) + 1

    # base case: 1 has no proper divisors
    if n == 1
        push!(divisors, Set([]))
        return
    end

    nRoot = isqrt(n)  # root(n)

    # ensuring sufficient primes (assuming ordered) have been generated
    while nRoot > (isempty(primes) ? 0 : last(primes))
        insertNextPrime(primes)
    end

    nDivisors = Set{Int}()  # set to store proper divisors of n
    
    # iterating over primes
    for p in primes
        # breaking condition: no prime divisor exists if p > nRoot
        p > nRoot && break
        # checking if p divides n
        if n % p == 0
            k = n ÷ p  # largest proper divisor of n
            nDivisors = ∪(divisors[k], p.*divisors[k], Set([k]))
                # proper divisors of n = proper divisors of k ∪ p * proper divisors of k ∪ k
            break
        end
    end

    # if nDivisors is empty, no factor was found; 1 is the only proper divisor
    isempty(nDivisors) && push!(nDivisors, 1)

    # updating divisors
    push!(divisors, nDivisors)
end

"""
    insertNextFactorisations(divisors, primes)

Given `factorisations`, a Vector{Set{Vector{Int}}} of length `n - 1` such that 
`factorisations[k]` is a set of all (ordered) factorisations of `k`, and `primes`, 
an ordered vector of prime numbers, inserts set of ordered factorisations of `n` at index `n`.
"""
function insertNextFactorisations(factorisations::Vector{Set{Vector{Int}}}, primes::Vector{Int})

    # finding n (number for which factorisations have to be generated)
    n = length(factorisations) + 1 
    
    # base case: 1 has no "proper" factorisations
    if n == 1
        push!(factorisations, Set{Vector{Int}}())
        return
    end

    nRoot = isqrt(n)  # root(n)

    # ensuring sufficient primes (assuming ordered) have been generated
    while nRoot > (isempty(primes) ? 0 : last(primes))
        insertNextPrime(primes)
    end

    nFactorisations = Set{Vector{Int}}()  # set to store ordered factorisations of n

    # iterating over primes
    for p in primes
        # breaking condition: no prime divisor exists if p > nRoot
        p > nRoot && break
        # checking if p divides n
        if n % p == 0
            # iterating over factorisations of largest factor of n
            for fs in factorisations[n ÷ p]
                # appending p gives a factorisation of n
                push!(nFactorisations, sort(vcat(fs, p)))
                # multiplying exactly one of the factors in a factorisation gives another
                    # factorisation for each such number
                for k in 1:length(fs)
                    fs[k] *= p
                    push!(nFactorisations, sort(fs))  # sorting and pushing to nFactorisations
                    fs[k] ÷= p  # fs should remain unmodified
                end
            end
        end
    end

    # no proper divisor exists -> n is a prime
    isempty(nFactorisations) && push!(nFactorisations, [n])

    # updating factorisations
    push!(factorisations, nFactorisations)
end

"""
    interpolatingPolynomial(points)

Returns the interpolating polynomial of some unknown function `f` given vector of tuples 
    `points` defined such that `points[k] = (xₖ, f(xₖ))`.
"""
function interpolatingPolynomial(points)
    
    n = length(points) - 1  # degree of interpolating polynomial
    xᵥ = [first(point) for point in points]  # x-coordinates
    fᵥ = [last(point) for point in points]  # y-coordinates

    # computing Vandermonde matrix
    V = [Rational(xᵥ[r + 1]^p) for r in 0:n, p in 0:n]  # (note: we add 1 ∵ 1-based indexing)
    aᵥ = V \ fᵥ  # coefficients of interpolating polynomial
    # (from Newton form of interpolating polynomial, we know V × aᵥ = fᵥ ⟹ aᵥ = V⁻¹ × fᵥ)

    # creating symbol x
    x = symbols(:x)
    # generating interpolating polynomial: p(x) = Σaₖxᵏ for k in [0, n]
    pₓ = sum([aᵥ[k + 1]*x^k for k in 0:n])  # (note: we add 1 ∵ 1-based indexing)

    # return symbolic parameter and interpolating polynomial
    return x, pₓ
end


end  # module