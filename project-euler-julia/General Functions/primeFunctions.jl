using DataStructures   # LinkedLists
import Base.delete!
# using TimerOutputs

# to = TimerOutput()

module primes

function generatePrimes(bound::Int)::Vector{Int}
    """primitive, brute force algorithm"""
    πₙ::Int = ceil(1.25506 * bound / log(bound))
        # a guaranteed, close upper-bound on the number of primes <= bound

    # creating primes vector
    primes::Vector{Int} = [2]
    sizehint!(primes, πₙ)  # preallocating storage

    # iterating over odd numbers
    for num in 3:2:bound
        # maximum prime factor num can have must be <= root(num)
        maxPrimeFactor::Int = isqrt(num)
        # iterating over primes
        for prime in primes
            # no prime factors ⇒ num is prime
            if (prime > maxPrimeFactor)
                push!(primes, num)
                break
            end
            # prime factor found ⇒ break
            num % prime == 0 && break
        end
    end
    return primes
end

function sieve(n::Int)::Vector{Int}
    """ primitive sieve of Eratosthenes; generates primes up to 10^8 in ~2 seconds """
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

    # inserting all remaining primes
    for k in isqrt(n) + 1 : n
        if numbers[k]
            push!(primes, k)
        end
    end

    # return primes vector
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

module primesExtra
"""non-optimal / non-practical prime-generating functions that
(in theory) have better time complexity """

function delete!(l::MutableLinkedList{Int}, r::StepRange{Int})
    """delete! function overloaded for sieveLinkedList"""
    cVal = first(r)
    node = l.node.next

    while cVal ≤ last(r)
        # finding next node ≥ cVal
        while node.data < cVal
            node = node.next
        end
        # matching node found -> removing node
        if node.data == cVal
            prev = node.prev
            next = node.next
            prev.next = next
            next.prev = prev
            l.len -= 1
        end
        cVal += step(r)
    end

    return l

end

function sieveLinkedList(n::Int)::Vector{Int}
    """ primitive sieve of eratosthenes; this version uses a linked list
    and has better time complexity, but much larger constants; the other algorithm
    therefore works better
    """

    πₙ = Int(ceil(1.25506 * n / log(n)))
        # a guaranteed, close upper-bound on the number of primes <= bound

    # initialising primes vector
    primes::Vector{Int} = []
    sizehint!(primes, πₙ)

    numbers = MutableLinkedList{Int}()
    for k in n:-1:2
        pushfirst!(numbers, k)
    end

    while !isempty(numbers)
        p = popfirst!(numbers)
        push!(primes, p)
        delete!(numbers, 2*p:p:n)
    end

    return primes
end

end

function main()
    @time sieve(10^8)
end

main()
