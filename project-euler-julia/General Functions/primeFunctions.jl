
function generatePrimes(bound::Int)::Vector{Int}
    # primitive, brute force algorithm
    nPrimeBound::Int = ceil(1.25506 * bound / log(bound))
        # a guaranteed, close upper-bound on the number of primes <= bound

    # creating primes vector
    primes::Vector{Int} = [2]
    sizehint!(primes, nPrimeBound)  # preallocating storage

    # iterating over odd numbers
    for num = 3:2:bound
        # maximum prime factorn num can have must be <= root(num)
        maxPrimeFactor::Int = floor(sqrt(num))
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

function main()
    println("Generating primes...")
    println(length(generatePrimes(10^1)))
    println("Primes generated")
end

main()
