
function generatePrimes(bound::Int)::Vector{Int}
    # primitive, brute force algorithm
    primes::Vector{Int} = [2]
    for k = 3:2:bound
        primeFound::Bool = true
        maxPrimeFactor::Int = ceil(sqrt(k))
        for prime in primes
            if (!primeFound || prime > maxPrimeFactor)
                break
            end
            if k % prime == 0
                primeFound = false
            end
        end
        if primeFound push!(primes, k) end
    end
    return primes
end

function main()
    println("Generating primes...")
    println(generatePrimes(10^7)[end])
    println("Primes generated")
end

main()
