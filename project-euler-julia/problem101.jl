# Julia Solution to Project Euler Problem 101
# 24 August 2020
# Runtime: 10⁻³ seconds

using SymEngine  # symbolic mathematics
import AuxFunctions: interpolatingPolynomial

"""
    findSumOfFITsForInterpolatingPolynomials(f, d)

Given a polynomial `f` of degree `d`, returns the sum of first-incorrect terms
for polynomials of degree `dₚ = 0, 1, 2, ..., d - 1` that interpolate first `dₚ + 1` terms
    of the sequence given by `f`.
"""
function findSumOfFITsForInterpolatingPolynomials(f, d)

    points = []  # vector of points generated by f
    Σ = 0  # sum of first-incorrect-terms

    # iterating over number of points to interpolate
    for k in 1:d
        # pushing next point to points
        push!(points, (k, f(k)))
        
        # finding interpolating polynomial
        x, pₓ = interpolatingPolynomial(points)

        # finding first incorrect term
        t = k + 1
        while (pₜ = subs(pₓ, x => t)) == f(t)
            t += 1
        end
        
        # updating Σ
        Σ += pₜ
    end

    return Σ
end

# given function
uₙ(n) = 1 - n + n^2 - n^3 + n^4 - n^5 + n^6 - n^7 + n^8 - n^9 + n^10

# function call and benchmarking
@btime findSumOfFITsForInterpolatingPolynomials(uₙ, 10)