import DataStructures.IntSet
# using TimerOutputs

to = TimerOutput()

function generatePrimes(bound::Int)::Vector{Int}
    # primitive, brute force algorithm
    nPrimeBound::Int = ceil(1.25506 * bound / log(bound))
        # a guaranteed, close upper-bound on the number of primes <= bound

    # creating primes vector
    primes::Vector{Int} = [2]
    sizehint!(primes, nPrimeBound)  # preallocating storage

    # iterating over odd numbers
    for num in 3:2:bound
        # maximum prime factorn num can have must be <= root(num)
        maxPrimeFactor::Int = isqrt(num)\flo
        # iterating over primes
        for prime in primes
            # no prime factors -> num is prime
            if (prime > maxPrimeFactor)
                push!(primes, num)
                break
            end
            if num % prime == 0
                break
            end
        end
    end
    return primes
end

function sieve(n::Int)::Vector{Int}
    numbers::Vector{Bool} = fill(true,n)
    numbers[1] = false
    for i in 2:isqrt(n)
        if numbers[i]
            for j = 2*i:i:n
            numbers[j] = false
            end
        end
    end
    primes = findall(x -> x, numbers)
    return primes
end

function main()
    @time sieve(10^4)
end

main()
