import DataStructures   # LinkedLists
# using TimerOutputs

# to = TimerOutput()

function generatePrimes(bound::Int)::Vector{Int}
    # primitive, brute force algorithm
    πₙ::Int = ceil(1.25506 * bound / log(bound))
        # a guaranteed, close upper-bound on the number of primes <= bound

    # creating primes vector
    primes::Vector{Int} = [2]
    sizehint!(primes, πₙ)  # preallocating storage

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
    # primitive sieve of Eratosthenes
    # primes up to 10^8 in ~2 seconds

    πₙ = Int(ceil(1.25506 * n / log(n)))
        # a guaranteed, close upper-bound on the number of primes <= bound

    # initialising primes vector
    primes::Vector{Int} = []
    sizehint!(primes, πₙ)

    # initialising numbers vector (sieve)
    numbers::Vector{Bool} = fill(true,n)
    numbers[1] = false

    # iterating over numbers to find primes
    for i in 2:isqrt(n)
        # numbers[i] == true -> i is a prime
        if numbers[i]
            # inserting in primes
            push!(primes, i)
            # sieving multiples
            for j in 2*i:i:n
                numbers[j] = false
            end
        end
    end

    # return primes vector
    return primes
end

function main()
    @time println(length(sieve(10^8)))
end

main()
