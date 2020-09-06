module AuxFunctions

import PrimeFunctions: insertNextPrime
using SymEngine  # symbolic mathematics

"""
    findContinuedFraction(num)

Return a vector representing a block of constants that repeats indefinitely in the continued fraction of root of integer `num`.
"""
function findContinuedFraction(num::T) where T <: Integer

    # if num is a perfect square, return empty continued fraction
    isqrt(num)^2 == num && return Vector{T}()

    # sequence of a's (until sequence starts repeating)
    fractionConstants = Vector{T}()

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
function findMinimalPellSolution(D::T) where T <: Integer 
    
	continuedFraction::Vector{T} = findContinuedFraction(D)
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
    primeFactorisation(n, primes, primesSet)

Returns a dictionary representing the prime factorisation of `n` (each key a prime factor, associated value its multiplicity) given `primes` and `primesSet`, an ordered vector and (optional) set of prime numbers respectively.
"""
function primeFactorisation(n::T, primes::Vector{T}, primesSet = Set{T}()) where T <: Integer

    # base case: 1 has no prime factorisation
    n == 1 && return Dict{T, T}()

    # ensuring sufficient primes (assuming ordered) have been generated
    while n > (isempty(primes) ? 0 : last(primes))
        insertNextPrime(primes)
        push!(primesSet, primes[end])
    end

    # base case: n is prime, prime factorisation is n : 1
    n ∈ primesSet && return Dict(n => 1)

    nFactorisation = Dict{T, T}()

    # iterating over primes
    for p in primes
        # checking if p divides n
        if n % p == 0
            # finding geometric multiplicity of p in prime factorisation of n
            nFactorisation[p] = 0
            while n % p == 0
                n ÷= p
                nFactorisation[p] += 1
            end
            # n is fully reduced -> return pFactorisation
            n == 1 && return nFactorisation
            # optimisation: n is now prime, cannot be reduced further
            if n ∈ primesSet
                nFactorisation[n] = 1
                return nFactorisation
            end
        end
    end
end

"""
    divisorCount(n, primes, primesSet)

Return the number of divisors of `n` given `primes` and `primesSet`, an ordered vector and (optional) set of prime numbers respectively.
"""
function divisorCount(n, primes::Vector{T}, primesSet = Set{T}()) where T <: Integer
    
    # base case: 1 has only one divisor
    n == 1 && return 1

    # ensuring sufficient primes (assuming ordered) have been generated
    while n > (isempty(primes) ? 0 : last(primes))
        insertNextPrime(primes)
        push!(primesSet, primes[end])
    end

    nFactorisation = primeFactorisation(n, primes, primesSet)

    return ([m + 1 for m in values(nFactorisation)] |> prod)

end
"""
    nextProperDivisors(divisors, primes)

Given `divisors`, a Vector{Set{T}} of length `n - 1` such that `divisors[k]` is a 
set of all proper divisors of `k`, and `primes`, an ordered vector of prime numbers, 
inserts set of proper divisors of `n` at index `n` and returns the same.
"""
function nextProperDivisors(divisors::Vector{Set{T}}, primes::Vector{T}, primesSet = Set{T}()) where T <: Integer

    n = length(divisors) + 1

    # base case: 1 has no proper divisors
    n == 1 && return push!(divisors, Set([]))[end]

    nRoot = isqrt(n)  # root(n)

    # ensuring sufficient primes (assuming ordered) have been generated
    while nRoot > (isempty(primes) ? 0 : last(primes))
        insertNextPrime(primes)
        push!(primesSet, primes[end])
    end

    # base case: n is prime, only proper divisor is 1 (this is useful if primesSet is given)
    n ∈ primesSet && return push!(divisors, Set([1]))[end]
    
    # iterating over primes
    for p in primes
        # breaking condition: no prime divisor exists if p > nRoot
        p > nRoot && break
        # checking if p divides n
        if n % p == 0
            k = n ÷ p  # largest proper divisor of n
            nDivisors = ∪(divisors[k], p.*divisors[k], Set([k]))
                # proper divisors of n = proper divisors of k ∪ p * proper divisors of k ∪ k
            return push!(divisors, nDivisors)[end]
        end
    end

    # no factor was found; 1 is the only proper divisor
    return push!(divisors, Set([1]))[end]
end

"""
    nextFactorisations(divisors, primes)

Given `factorisations`, a Vector{Set{Vector{T}}} of length `n - 1` such that `factorisations[k]` 
is a set of all (ordered) factorisations of `k`, and `primes`, an ordered vector of prime numbers, 
inserts and returns a set of ordered factorisations of `n` at index `n`.
"""
function nextFactorisations(fs::Vector{Set{Vector{T}}}, primes::Vector{T}, primesSet = Set{T}()) where T <: Integer

    # finding n (number for which factorisations have to be generated)
    n = length(fs) + 1 
    
    # base case: 1 has no "proper" factorisations
    n == 1 && return push!(fs, Set{Vector{T}}())[end]

    nRoot = isqrt(n)  # root(n)

    # ensuring sufficient primes (assuming ordered) have been generated
    while nRoot > (isempty(primes) ? 0 : last(primes))
        insertNextPrime(primes)
        push!(primesSet, primes[end])
    end
    
    # base case: n is prime, only factorisation is [1, n] (this is useful if primesSet is given)
    n ∈ primesSet && return push!(fs, Set([[n]]))[end]

    # iterating over primes
    for p in primes
        # breaking condition: no prime divisor exists if p > nRoot
        p > nRoot && break
        # checking if p divides n
        if n % p == 0
            fₙ = Set{Vector{T}}()  # set to store ordered factorisations of n
            # iterating over factorisations of largest factor of n
            for f in fs[n ÷ p]
                # appending p gives a factorisation of n
                push!(fₙ, sort(vcat(f, p)))
                # multiplying exactly one of the factors in a factorisation gives another
                    # factorisation for each such number
                for k in 1:length(f)
                    f[k] *= p
                    push!(fₙ, sort(f))  # sorting and pushing to nFactorisations
                    f[k] ÷= p  # fs should remain unmodified
                end
            end
            return push!(fs, fₙ)[end]
        end
    end

    # no proper divisor exists -> n is a prime
    return push!(fs, Set([[n]]))[end]
end

"""
    nextPrimeFactorisation(fs, primes, primesSet)

Inserts into `fs` a dictionary representing the prime factorisation of `n` and returns the same, where `fs` is a vector of length `n - 1` such that `dCounts[k]` is a dictionary representing the prime factorisation of `k`, and `primes` and `primesSet` are an ordered vector and set of prime numbers respectively.
"""
function nextPrimeFactorisation(fs::Vector{Dict{T, T}}, primes::Vector{T}, primesSet::Set{T}) where T <: Integer

    # finding n, the number for which we need to find a prime factorisation
    n = length(fs) + 1

    # base case: n = 1, no prime factorisation
    n == 1 && return push!(fs, Dict{T, T}())[end]

    nRoot = isqrt(n)  # root(n)

    # ensuring sufficient primes (assuming ordered) have been generated
    while nRoot > (isempty(primes) ? 0 : last(primes))
        insertNextPrime(primes)
        push!(primesSet, primes[end])
    end

    # base case: n is prime, prime factorisation is simply (n => 1)
    n ∈ primesSet && return push!(fs, Dict{T, T}(n => 1))[end]
    
    # iterating over primes to find smallest prime factor
    for p in primes
        if n % p == 0
            # creating copy of prime factorisations of largest proper divisor of n
            fₙ = copy(fs[n ÷ p])
            # adding 1 to number of occurrences of prime factor p
            p in keys(fₙ) ? fₙ[p] += 1 : fₙ[p] = 1
            # updating prime factorisations and returning value
            return push!(fs, fₙ)[end]
        end
    end

    # no prime factor -> n is prime
    return push!(fs, Dict{T, T}(n => 1))[end]
end

"""
    nextDivisorCount(dCounts, primes, primesSet)

Inserts into `dCounts` the number of divisors of `n` and returns the same where `dCounts` is a vector of length 
`n - 1` such that `dCounts[k]` is the number of divisors of `k`, and `primes` and `primesSet` are an ordered vector 
and set of prime numbers respectively.
"""
function nextDivisorCount(dCounts::Vector{T}, primes::Vector{T}, primesSet::Set{T})::T where T <: Integer

    # finding n, the number for which we need to find the number of positive divisors
    n = length(dCounts) + 1

    # base case: n = 1, only one proper divisor
    n == 1 && return push!(dCounts, 1)[end]

    nRoot = isqrt(n)  # root(n)

    # ensuring sufficient primes (assuming ordered) have been generated
    while nRoot > (isempty(primes) ? 0 : last(primes))
        insertNextPrime(primes)
        push!(primesSet, primes[end])
    end

    # base case: n is prime, only two proper divisors
    n ∈ primesSet && return push!(dCounts, 2)[end]

    """
    Generally, if z = p₁^t₁ × p₂^t₂ ... pₘ^tₘ, then dCount[z] = Π(tᵢ + 1) for i = 1, 2, ..., m.
    If n = p^t × p₁^t₁ × p₂^t₂ ... pₘ^tₘ, then dCount[n] = (t + 1) × Π(tᵢ + 1) for i = 1, 2, ..., m
    and dCount[k] = t × Π(tᵢ + 1) for i = 1, 2, ..., m (∵ k = n ÷ p)
    ∴ If t is the multiplicity of prime p in the prime factorisation of n, then
        dCount[n] = dCount[k] ÷ t * (t + 1)
    """
    # iterating over primes to find smallest prime factor of n
    for p in primes
        if n % p == 0
            k = n ÷ p  # k = largest proper divisor of number
            # calculating multiplicity of p in prime factorisation of n
            nₜ, t = n ÷ p, 1 
            while nₜ % p == 0
                nₜ ÷= p; t += 1
            end
            # finding number of divisors of n and updating dCounts
            return push!(dCounts, dCounts[k] ÷ t * (t + 1))[end]
        end
    end
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