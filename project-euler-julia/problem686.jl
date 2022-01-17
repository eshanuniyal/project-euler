# Julia Solution to Project Euler Problem 686
# 29 November 2021
# Runtime: 10⁻¹ seconds

function p(L, n)
	# pre-computing logarithms
	log2_L, log2_Lp1, log2_10 = log2.((L, L+1, 10))
	i = isinteger(log2_L) ? 1 : 0  # accounting for case L is a power of 2
	k = 0
	
	while true
		# check for power of 2
		if floor(log2_L + k*log2_10) < floor(log2_Lp1 + k * log2_10)
			i += 1
		end
		i == n && break  # break if sufficiently many powers found
		k += 1  # increment power of 10
	end
	# compute corresponding exponent of 2
	return ceil(Int, log2_L + k*log2_10)
end

@btime p(123, 678910)