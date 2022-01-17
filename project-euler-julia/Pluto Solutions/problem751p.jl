### A Pluto.jl notebook ###
# v0.17.2

using Markdown
using InteractiveUtils

# ╔═╡ 323be1e4-4641-4508-9e74-b01b4ad019c8
using BenchmarkTools

# ╔═╡ 5ff83f50-35a9-4680-81a9-40afaffe0b88
md"""
## Project Euler #751: Concatenation Coincidence
**Solved 23 December, 2021**

A non-decreasing sequence of integers $a_n$ can be generated from any positive real value $\theta$ by the following procedure: 

$$\begin{align}
b_1 &= \theta \\
b_n &= \lfloor b_{n-1} \rfloor (b_{n-1} - \lfloor b_{n-1} \rfloor + 1)\ \ \forall n \ge 2 \\
a_n &= \lfloor b_n \rfloor
\end{align}$$

where $\lfloor . \rfloor$ is the floor function.

For example, $\theta = 2.956938891377988\dots$ generates the Fibonacci sequence: $2,3,5,8,13,21,34,55,89,\dots$. 

The *concatenation* of a sequence of positive integers $a_n$ is a real value denoted $\tau$ constructed by concatenating the elements of the sequence after the decimal point, starting at $a_1$: $a_1.a_2 a_3 a_4\dots$ 

For example, the Fibonacci sequence constructed from $\theta = 2.956938891377988\dots$ yields the concatenation $\tau = 2.3581321345589\dots$ Clearly, $\tau \ne \theta$ for this value of $\theta$.

Find the only value of $\theta$ for which the generated sequence starts at $a_1 = 2$ and the concatenation of the generated sequence equals the original value: $\tau = \theta$. Give your answer rounded to 24 places after the decimal point.
"""

# ╔═╡ 3df2b369-545b-462a-9151-08e6d5c24981
md"""## Solution"""

# ╔═╡ 23bb0910-6465-11ec-0a22-0faceb4c60c4
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

# ╔═╡ 43a8f6fe-4a00-45a8-b50b-fd369273e98c
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
concatenation_coincidence(2, 24)

# ╔═╡ 7b80b622-710c-4820-8c6e-1d4653144292
md"## Benchmark"

# ╔═╡ d0f1618b-8f03-4d40-94a4-a02f0c49c5f6
@benchmark concatenation_coincidence(2, 24)

# ╔═╡ e35636a3-b997-4379-88d7-7c74fc12f58f
md"## Validation"

# ╔═╡ 16160499-777e-4e8b-8448-0519452b3209
@assert generate_series(2.956938891377988)[1:15] == "2.3581321345589"

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
BenchmarkTools = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"

[compat]
BenchmarkTools = "~1.2.2"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[BenchmarkTools]]
deps = ["JSON", "Logging", "Printf", "Profile", "Statistics", "UUIDs"]
git-tree-sha1 = "940001114a0147b6e4d10624276d56d531dd9b49"
uuid = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
version = "1.2.2"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "8076680b162ada2a031f707ac7b4953e30667a37"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.2"

[[Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[LinearAlgebra]]
deps = ["Libdl"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[Parsers]]
deps = ["Dates"]
git-tree-sha1 = "d7fa6237da8004be601e19bd6666083056649918"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.1.3"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[Profile]]
deps = ["Printf"]
uuid = "9abbd945-dff8-562f-b5e8-e1ebf5ef1b79"

[[Random]]
deps = ["Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
"""

# ╔═╡ Cell order:
# ╟─5ff83f50-35a9-4680-81a9-40afaffe0b88
# ╟─3df2b369-545b-462a-9151-08e6d5c24981
# ╠═23bb0910-6465-11ec-0a22-0faceb4c60c4
# ╠═43a8f6fe-4a00-45a8-b50b-fd369273e98c
# ╠═316fdd35-794f-4fdf-b73b-01ff22b838ac
# ╟─7b80b622-710c-4820-8c6e-1d4653144292
# ╠═323be1e4-4641-4508-9e74-b01b4ad019c8
# ╠═d0f1618b-8f03-4d40-94a4-a02f0c49c5f6
# ╟─e35636a3-b997-4379-88d7-7c74fc12f58f
# ╠═16160499-777e-4e8b-8448-0519452b3209
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
