### A Pluto.jl notebook ###
# v0.17.2

using Markdown
using InteractiveUtils

# ╔═╡ ec93b69f-710a-46bd-b259-641f99d9932d
using BenchmarkTools

# ╔═╡ dfe7fbc2-3322-4dae-b7e5-8b557aa37396
md"""
# Project Euler #686: Powers of Two
**Solved 29 November, 2021**

 $2^7 = 128$ is the first power of two whose leading digits are "12".
The next power of two whose leading digits are "12" is $2^{80}$.

Define $p(L, n)$ to be the $n$th-smallest value of $j$ such that the base 10 representation of $2^j$ begins with the digits of $L$. So $p(12, 1) = 7$ and $p(12, 2) = 80$.

You are also given that $p(123, 45) = 12710$.

Find $p(123, 678910)$.
"""

# ╔═╡ 9fc9e1de-806e-4114-a700-a2835d6d3261
md"""
# Analysis
For given $L$, we iterate through $k$ and check whether there is a power of $2$ between $L\cdot 10^k$ and $(L + 1)\cdot 10^k$, i.e., $\exists j \in \mathbb{Z}^{\ge 0}\ [L\cdot 10^k \le 2^j < (L + 1)\cdot 10^k]$. For each such $k$ we find, we have a corresponding $j$ such that the base 10 representation of $2^j$ begins with the digits of $L$. We thus need to find $n$ such $k$'s and return the value of $j$ that corresponds with the last $k$.

If there is a power of $2$ strictly between $L\cdot 10^k$ and $(L + 1)\cdot 10^k$, we must have for $j \in \mathbb{Z^{\ge 0}}$

$$\begin{aligned}
L\cdot 10^k < 2^j < (L + 1)\cdot 10^k
&\Longleftrightarrow \log_2 (L\cdot 10^k) < j < \log_2((L + 1)\cdot 10^k) \\
&\Longleftrightarrow \log_2 L + k\cdot \log_2 10 < j < \log_2(L + 1) + k\cdot log_2 10 \\
&\Longleftrightarrow \lfloor \log_2 L + k\cdot \log_2 10 \rfloor < \lfloor \log_2(L + 1) + k\cdot log_2 10 \rfloor
\end{aligned}$$

The case where $L\cdot 10^k$ is itself a power of $2$ is only possible when $k=0$, since powers of $2$ always end in $2, 4, 6,$ or $8$. We can therefore account for it simply by checking whether $L$ is a power of $2$.

Given $k$, the relationship $2^{j-1} < L\cdot 10^k \le 2^j < (L + 1) \cdot 10^k$ implies $j = \lceil \log_2 L + k\cdot \log_2 10 \rceil$.
"""

# ╔═╡ d9553119-fdc1-4919-b44d-dba45834168a
md"# Solution"

# ╔═╡ a08f53cc-3a23-4a00-9202-3be1e49e64ce
L, n = 123, 678910;

# ╔═╡ 51e2cde4-51ac-11ec-0b87-37d17990ca61
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

# ╔═╡ 35026836-4e1c-4919-bb5f-8fdea144201f
p(L, n)

# ╔═╡ e384453a-31e3-4dbd-88b2-bb3701911e76
md"# Benchmark"

# ╔═╡ 8d52d19a-f841-4ea9-9f82-12bfdcb978b7
@benchmark p(L, n)

# ╔═╡ d94002ea-e3c5-4020-85fa-e253ae88baca
md"# Validation"

# ╔═╡ 8125c0f6-03b1-4f90-9e82-470402048bdd
@assert p(12, 1) == 7

# ╔═╡ 4db64a8c-de33-4273-a17d-fda4690d5b21
@assert p(12, 2) == 80

# ╔═╡ ce6e7ed5-02ab-4a5f-a36d-51283704fe20
@assert p(123, 45) == 12710

# ╔═╡ c6595558-182c-4cef-8d8e-f6c28885ad4a
@assert p(128, 1) == 7  # tests edge case where L is a power of 2

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
BenchmarkTools = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"

[compat]
BenchmarkTools = "~1.2.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[BenchmarkTools]]
deps = ["JSON", "Logging", "Printf", "Profile", "Statistics", "UUIDs"]
git-tree-sha1 = "61adeb0823084487000600ef8b1c00cc2474cd47"
uuid = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
version = "1.2.0"

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
git-tree-sha1 = "ae4bbcadb2906ccc085cf52ac286dc1377dceccc"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.1.2"

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
# ╟─dfe7fbc2-3322-4dae-b7e5-8b557aa37396
# ╟─9fc9e1de-806e-4114-a700-a2835d6d3261
# ╟─d9553119-fdc1-4919-b44d-dba45834168a
# ╠═a08f53cc-3a23-4a00-9202-3be1e49e64ce
# ╠═51e2cde4-51ac-11ec-0b87-37d17990ca61
# ╠═35026836-4e1c-4919-bb5f-8fdea144201f
# ╟─e384453a-31e3-4dbd-88b2-bb3701911e76
# ╠═ec93b69f-710a-46bd-b259-641f99d9932d
# ╠═8d52d19a-f841-4ea9-9f82-12bfdcb978b7
# ╟─d94002ea-e3c5-4020-85fa-e253ae88baca
# ╠═8125c0f6-03b1-4f90-9e82-470402048bdd
# ╠═4db64a8c-de33-4273-a17d-fda4690d5b21
# ╠═ce6e7ed5-02ab-4a5f-a36d-51283704fe20
# ╠═c6595558-182c-4cef-8d8e-f6c28885ad4a
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
