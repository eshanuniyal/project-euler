# Julia Solution to Project Euler Problem 387
# 26 December 2021
# Runtime: 2 seconds

import PrimeFunctions: generatePrimes

is_harshad(n) = n % sum(digits(n)) == 0

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

# check whether num is a prime
function check_prime(
		num, 
		primes_vec = generatePrimes(isqrt(num)), 
		primes_set = Set(primes_vec)
	)
	@assert num ≤ last(primes_vec)^2
	num ≤ last(primes_vec) && return num ∈ primes_set
	return !any(p -> num % p == 0, primes_vec)
end

# returns all strong right-truncatable Harshad (SRTH) numbers ≤ lim
function strong_right_truncatable_harshads(lim, 
		primes_vec = generatePrimes(isqrt(lim)), 
		primes_set = Set(primes_vec)
	)
	# filter RTH numbers that yield a prime when divided by sum of digits
	return filter!(
		k -> check_prime(k ÷ sum(digits(k)), primes_vec, primes_set),
		right_truncatable_harshads(lim)
	)
end

function srth_primes_sum(lim)
	# generate vector and set of primes necessary for primality tests up to lim
	primes_vec = generatePrimes(isqrt(lim))
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

@btime srth_primes_sum(10^14)