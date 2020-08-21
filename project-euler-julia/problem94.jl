# Julia Solution to Project Euler Problem 94
# 21 August 2020
# Runtime: ~10⁻⁴ seconds

import AuxFunctions: findMinimalPellSolution

""" Problem Analysis 
Assume we have a triangle of sides α, α, α ± 1. If the height of the triangle from the base of
length α ± 1 is h, we have
    α² = h² + ((α ± 1)/2)²  
        ⟹ 4α² = 4h² + (α ± 1)²
        ⟹ 3α² = 4h² ± 2α + 1
        ⟹ 9α² = 12h² ± 6α + 3   
        ⟹ 9α² ∓ 6α + 1 = 12h² + 4
        ⟹ (3α ∓ 1)² = 12h² + 4
        ⟹ ((3α ∓ 1)/2)² - 3h² = 1
which is simply Pell's Equation for x = (3α ∓ 1)/2, y = h. We therefore want solutions to the
(Pell's) equation x² - 3y² = 1 such that side α and the area of the triangle are both integral.
The area of the triangle is given by
    area = bh/2 = (α ± 1)h/2
We rewrite this in terms of x and y:
    h = y;  x = (3α ∓ 1)/2 ⟹ 2x ± 4 = 3α ± 3 ⟹ b = α ± 1 = (2x ± 4)/3 (⟹ α = (2x ± 1)/3)
        ⟹ area = bh/2 = (2x ± 4)/3 * y/2 = y(x ± 2)/3
So, for a solution (x, y) (where x and y are integers) to the equation x² - 3y² = 1,
    we can have a triangles of side α = (2x ± 1)/3, α, α ± 1 and perimeter 2x ± 2
If area = y(x ± 2)/3 and α = (2x ± 1)/3 are both integral, we have an almost equilateral triangle.
"""

"""
    almostEquilateralTriangles(perimeterBound)

Return the sum of all almost equilateral triangles that have perimeter ≤ `perimeterBound`.
"""
function almostEquilateralTriangles(perimeterBound)
    
    # finding fundamental solution to Pell's Equation
    x₁ = findMinimalPellSolution(3)  
    y₁ = isqrt((x₁^2 - 1) ÷ 3)
    
    # Once a fundamental solution (x₁, y₁) is found, all remaining solutions may be found
    # from the recurrence relations xₖ₊₁ = x₁xₖ + ny₁yₖ, yₖ₊₁ = x₁yₖ + y₁xₖ
    # (source: https://en.wikipedia.org/wiki/Pell%27s_equation#Fundamental_solution_via_continued_fractions)
    xₖ₊₁(xₖ, yₖ) = x₁*xₖ + 3y₁*yₖ
    yₖ₊₁(xₖ, yₖ) = x₁*yₖ + y₁*xₖ

    xₖ, yₖ = xₖ₊₁(x₁, y₁), yₖ₊₁(x₁, y₁)  
        # we start with (x₂, y₂) since (x₁, y₁) doesn't give a triangle at all

    Σ = 0  # sum of perimeters
    
    # iterating over all solutions (that give perimeter ≤ perimeterBound)
    while 2xₖ + 2 ≤ perimeterBound

        # checking triangle with sides α = (2xₖ + 1)/3, α, α + 1
        ((2xₖ + 1) % 3 == 0 && (yₖ * (xₖ + 2)) % 3 == 0) && (Σ += 2xₖ + 2)
        # checking triangle with sides α = (2xₖ - 1)/3, α, α - 1
        ((2xₖ - 1) % 3 == 0 && (yₖ * (xₖ - 2)) % 3 == 0) && (Σ += 2xₖ - 2)

        # finding next solution
        xₖ, yₖ = xₖ₊₁(xₖ, yₖ), yₖ₊₁(xₖ, yₖ)
    end

    # edge case: only smaller triangle from last solution gives perimter ≤ perimeterBound
    if 2xₖ - 2 ≤ perimeterBound
        ((2xₖ - 1) % 3 == 0 && (yₖ * (xₖ - 2)) % 3 == 0) && (Σ += 2xₖ - 2)
    end

    return Σ
end


"""
    almostEquilateralTrianglesBruteForce(perimeterBound)

Return the sum of all almost equilateral triangles that have perimeter ≤ `perimeterBound`
    using a brute force algorithm. For `perimeterBound = 10⁹`, runs in ~20 seconds.
"""
function almostEquilateralTrianglesBruteForce(perimeterBound)

    αBound = (perimeterBound - 1) ÷ 3   
        # maximum α that gives triangle of sides α, α, α ± 1 with perimeter ≤ perimeterBound

    """
    From Heron's Formula, the area of a triangle with sides α, α, α ± 1 is given by
        area = ((α ± 1)√(3α² ∓ 2α - 1))/4
    Therefore, for α ≥ 2, the area of a triangle with sides α, α, α ± 1 is integral iff
        (3α² ∓ 2α - 1) is a perfect square and (α ± 1)√(3α² ∓ 2α - 1) is divisible by 4
    """
    function givesIntegralArea(insideRoot, outsideNum)
        # returns true if outsideNum*(√insideRoot)/4 is an integer
        root = isqrt(insideRoot)
        return (root^2 == insideRoot && (outsideNum * root) % 4 == 0)
            # if insideRoot is a perfect square and √insideRoot is divisible by 4, return true
    end

    ∑ = 0 # sum of perimeters

    for α in 2:αBound
        # checking whether area of triangle of sides α, α, α + 1 is integral
        givesIntegralArea(3α^2 - 2α - 1, α + 1) && (∑ += 3α + 1)
        # checking whether area of triangle of sides α, α, α - 1 is integral
        givesIntegralArea(3α^2 + 2α - 1, α - 1) && (∑ += 3α - 1)
    end

    return ∑
end

# function call and benchmarking
@btime almostEquilateralTriangles(10^9)