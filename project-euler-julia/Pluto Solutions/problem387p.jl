### A Pluto.jl notebook ###
# v0.17.2

using Markdown
using InteractiveUtils

# ╔═╡ 0d43d73e-d0a2-4982-b390-d302c6f8ddf4
using Pkg; Pkg.activate(".");

# ╔═╡ 427969b8-7b31-4d8e-98c8-cd31f1833ad9
using BenchmarkTools

# ╔═╡ c09c01a9-01d3-4011-a9ed-936e5e6122ea
include("General Functions/PrimeFunctions.jl")

# ╔═╡ 9778c896-4b9b-4ff7-a496-a7d8bb1e1efa
md"""
# Problem #387: Harshad Numbers

**Solved 26 December, 2021**

A Harshad or Niven number is a number that is divisible by the sum of its digits.
201 is a Harshad number because it is divisible by 3 (the sum of its digits.)
When we truncate the last digit from 201, we get 20, which is a Harshad number.
When we truncate the last digit from 20, we get 2, which is also a Harshad number.
Let's call a Harshad number that, while recursively truncating the last digit, always results in a Harshad number a *right truncatable Harshad number*.

Also: 201/3=67 which is prime. Let's call a Harshad number that, when divided by the sum of its digits, results in a prime a *strong Harshad number*.

Now take the number 2011 which is prime.
When we truncate the last digit from it we get 201, a strong Harshad number that is also right truncatable.
Let's call such primes *strong, right truncatable Harshad primes*.

You are given that the sum of the strong, right truncatable Harshad primes less than 10000 is 90619.

Find the sum of the strong, right truncatable Harshad primes less than $10^{14}$.
"""

# ╔═╡ 56a825b9-f2a6-461a-a174-ea8b33c80e95
md"# Solution"

# ╔═╡ 7393c704-6516-11ec-2cd8-2fb207819d21
# returns true if n is a Harshad number
is_harshad(n) = n % sum(digits(n)) == 0

# ╔═╡ c725e760-8345-44c0-ba7f-d803816323bd
# returns all the right-truncatable Harshad (RTH) numbers less than or equal to limit
function right_truncatable_harshads(lim)
	# set up base-case: all one-digit numbers are trivially Harshad
	rth_nums = [collect(1:9)]
	# in each iteration, add RTH numbers of one larger order of magnitude 
	for _ in 2:ceil(Int, log10(lim))
		new_rth_nums = Int[]
		# test new candidates for RTH numbers 
	 	for num in rth_nums[end], i in 0:9
			candidate = 10*num + i
			candidate > lim && break
			is_harshad(candidate) && push!(new_rth_nums, candidate)
		end
		# insert new RTH numbers 
		push!(rth_nums, new_rth_nums)
	end
	# concatenate and return all found RTH numbers
	return reduce(vcat, rth_nums)
end

# ╔═╡ 8af1b5a1-b5c0-401b-87c2-8ac2a2802aea
# check whether num is a prime
function check_prime(
		num, 
		primes_vec = PrimeFunctions.generatePrimes(isqrt(num)), 
		primes_set = Set(primes_vec)
	)
	@assert num ≤ last(primes_vec)^2
	num ≤ last(primes_vec) && return num ∈ primes_set
	return !any(p -> num % p == 0, primes_vec)
end

# ╔═╡ 4faacce3-8732-401e-bc9d-6c3306676b16
# returns all strong right-truncatable Harshad (SRTH) numbers ≤ lim
function strong_right_truncatable_harshads(lim, 
		primes_vec = PrimeFunctions.generatePrimes(isqrt(lim)), 
		primes_set = Set(primes_vec)
	)
	# filter RTH numbers that yield a prime when divided by sum of digits
	return filter!(
		k -> check_prime(k ÷ sum(digits(k)), primes_vec, primes_set),
		right_truncatable_harshads(lim)
	)
end

# ╔═╡ a86df354-1e72-43b7-a715-6f49f4ec5f0c
function srth_primes_sum(lim)
	# generate vector and set of primes necessary for primality tests up to lim
	primes_vec = PrimeFunctions.generatePrimes(isqrt(lim))
	primes_set = Set(primes_vec)
	# generate strong right-truncatable Harshad numbers
	srths = strong_right_truncatable_harshads(lim÷ 10, primes_vec, primes_set)
	srthp_sum = 0 
	# iterate over SRTH, adding each possible digit at its end to check for primes
	for srth in srths, i in 1:min(9, lim - 10*srth - 1)
		candidate = 10srth + i
		check_prime(candidate, primes_vec, primes_set) && (srthp_sum += candidate)
	end
	return srthp_sum
end

# ╔═╡ 7946ca50-4f02-4590-bcbd-49c486072039
srth_primes_sum(10^14)

# ╔═╡ 5f367311-ed94-4d7d-9e89-bb7d636ebe6a
md"# Benchmark"

# ╔═╡ 62fbc9fe-633c-4fe7-a15a-7ca103c52dd8
b = @benchmarkable srth_primes_sum(10^14); run(b, seconds=60)

# ╔═╡ d316ae35-21d8-4330-b376-10483c325c0a
md"# Validation"

# ╔═╡ 298419ab-976a-49d7-8056-938e8b776ce5
@assert is_harshad(201)

# ╔═╡ 6286bc36-3099-4672-a46d-36d0bb2a7690
@assert 201 ∈ right_truncatable_harshads(201)

# ╔═╡ 4e7d3031-2bb7-4525-b2d1-478f6fd90b8c
@assert 201 ∈ strong_right_truncatable_harshads(201)

# ╔═╡ dcf7efb3-f614-4e6c-9740-a696eeaf45b3
@assert srth_primes_sum(10000) == 90619

# ╔═╡ Cell order:
# ╟─9778c896-4b9b-4ff7-a496-a7d8bb1e1efa
# ╟─56a825b9-f2a6-461a-a174-ea8b33c80e95
# ╠═0d43d73e-d0a2-4982-b390-d302c6f8ddf4
# ╠═c09c01a9-01d3-4011-a9ed-936e5e6122ea
# ╠═7393c704-6516-11ec-2cd8-2fb207819d21
# ╠═c725e760-8345-44c0-ba7f-d803816323bd
# ╠═8af1b5a1-b5c0-401b-87c2-8ac2a2802aea
# ╠═4faacce3-8732-401e-bc9d-6c3306676b16
# ╠═a86df354-1e72-43b7-a715-6f49f4ec5f0c
# ╠═7946ca50-4f02-4590-bcbd-49c486072039
# ╟─5f367311-ed94-4d7d-9e89-bb7d636ebe6a
# ╠═427969b8-7b31-4d8e-98c8-cd31f1833ad9
# ╠═62fbc9fe-633c-4fe7-a15a-7ca103c52dd8
# ╟─d316ae35-21d8-4330-b376-10483c325c0a
# ╠═298419ab-976a-49d7-8056-938e8b776ce5
# ╠═6286bc36-3099-4672-a46d-36d0bb2a7690
# ╠═4e7d3031-2bb7-4525-b2d1-478f6fd90b8c
# ╠═dcf7efb3-f614-4e6c-9740-a696eeaf45b3
