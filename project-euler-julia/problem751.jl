# Julia Solution to Project Euler Problem 751
# 23 December 2021
# Runtime: 10⁻⁴ seconds

function generate_series(θ, dec_places = 100)
	# set starting conditions
	B, A = [θ], [floor(Int, θ)]
	str_A_dec = ""
	# iterate until sufficiently many digits calculated
	while length(str_A_dec) < dec_places
		# generate b and a
		push!(B, floor(B[end]) * (B[end] - floor(B[end]) + 1))
		push!(A, floor(B[end]))
		# update string representation of decimal places
		str_A_dec *= string(A[end])
	end
	# construct complete concatenation
	str_A = string(A[1]) * '.' * str_A_dec[1:dec_places]
	return str_A
end 

function concatenation_coincidence(a₁, dec_places, iters=1000)
	# set starting conditions
	θ, str_θ = a₁, string(a₁)
	# iterate towards solution
	for _ in 1:iters
		# generate series concatenation from current θ
		str_τ = generate_series(θ, dec_places)
		# if generated concatenation equals θ, return solution
		str_τ == str_θ && return str_θ
		# update θ to series concatenation
		θ, str_θ = parse(BigFloat, str_τ), str_τ
	end
	return "No θ found in $iters iterations."
end

# ╔═╡ 316fdd35-794f-4fdf-b73b-01ff22b838ac
@btime concatenation_coincidence(2, 24)