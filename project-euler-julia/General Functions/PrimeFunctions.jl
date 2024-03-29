module PrimeFunctions
using TimerOutputs

function generatePrimes(bound::Integer)

    # sieve sufficiently fast for bound < 10⁷ 
    bound < 10^7 && return sieve(bound)
    # segmentedSieve generally faster for bound ≥ 10⁷
    return segmentedSieve(bound)
end


function sieve(bound::Integer)
    """Primitive sieve of Eratosthenes
    ~1 second for bound = 10⁸, ~15 seconds for bound = 10⁹
    """
    πₙ = ceil(Int, 1.25506 * bound / log(bound))
        # a guaranteed, close upper-bound on the number of primes <= bound

    # initialising primes vector
    primes = Vector{Int}()
    sizehint!(primes, πₙ)

    # initialising numbers vector (sieve)
    numbers = trues(bound)  # BitArray, space-efficient
    numbers[1] = false

    # iterating over numbers to find primes
    for i in 2:isqrt(bound)
        # numbers[i] == true -> i is a prime
        if numbers[i]
            # inserting in primes
            push!(primes, i)
            # sieving multiples
            numbers[i^2:i:bound] .= false
        end
    end

    # inserting all remaining primes
    for k in isqrt(bound) + 1 : bound
        numbers[k] && push!(primes, k)
    end

    # return primes vector
    return primes
end


function segmentedSieve(bound::Integer)
    """
    Segmented sieve of Eratosthenes; same time complexity as primitive sieve, better space complexity
    ~1 second for bound = 10⁸, ~10 seconds for bound = 10⁹
    """
    # a guaranteed, close upper-bound on the number of primes <= bound
    πₙ = ceil(Int, 1.25506 * bound / log(bound))
    Δ = isqrt(bound)  # segment size

    # finding primes in first segment
    primes = sieve(Δ)
    sizehint!(primes, πₙ)

    # iterating over remaining segments
    for s in 2 : ceil(Int, bound / Δ)
        sₗ, sₘ = (s - 1)Δ, min(s * Δ, bound)  # current segment has range (sₗ, sₘ]
        isPrimeArr = trues(sₘ - sₗ)  # BitArray
        sₘroot = √sₘ

        for p in primes
            p > sₘroot && break
            minMultₚ = (sₗ ÷ p)p
            minMultₚ ≤ sₗ && (minMultₚ += p)
            isPrimeArr[minMultₚ - sₗ : p : sₘ - sₗ] .= false
        end

        for k in 1 : sₘ - sₗ
            isPrimeArr[k] && push!(primes, k + sₗ)
        end
    end

    return primes
end


function insertNextPrime(primes::Vector{Int})
    """insert next prime"""

    # base case: primes is empty
    if length(primes) == 0
        push!(primes, 2)
        return
    end

    k = last(primes) + 1
    while true
        # maximum prime factor num can have must be <= root(num)
        maxPrimeFactor::Int = isqrt(k)
        # iterating over primes
        for prime in primes
            # no prime factors k num is prime
            if (prime > maxPrimeFactor)
                push!(primes, k)
                return
            end
            # prime factor found ⇒ not a prime ⇒ increment k and break
            if k % prime == 0
                k += 1
                break
            end
        end
    end
end

end