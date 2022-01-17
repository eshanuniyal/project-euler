# Julia Solution to Project Euler Problem 719
# 2 December 2021
# Runtime: 10 seconds

function g(n, s)
    n ≤ s && return n == s
    for i in 1:ndigits(n)-1
        g(n % 10^i, s - n ÷ 10^i) && return true
    end
    return false
end

T(N) = sum(n^2 for n in 2:isqrt(N) if g(n^2, n))

@btime T(10^12)