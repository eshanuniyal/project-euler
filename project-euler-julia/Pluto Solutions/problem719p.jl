### A Pluto.jl notebook ###
# v0.17.2

using Markdown
using InteractiveUtils

# ╔═╡ 74456783-56a2-4807-9d01-b9bb78ee910d
using BenchmarkTools

# ╔═╡ fe2d1c6a-5395-11ec-39d5-11f145d561b4
md"""
# Project Euler #719: Number Splitting

**Solved December 2, 2021**

We define an $S$-number to be a natural number, $n$, that is a perfect square and its square root can be obtained by splitting the decimal representation of $n$ into two or more numbers then adding the numbers.

For example, $81$ is an $S$-number because $\sqrt{81} = 8 + 1$.\
$6724$ is an $S$-number: $\sqrt{6724} = 6 + 72 + 4$.\
$8281$ is an $S$-number: $\sqrt{8281} = 82 + 8 + 1$.\
$9801$ is an $S$-number: $\sqrt{9801} = 98 + 0 + 1$.

Further we define $T(N)$ to be the sum of all $S$ numbers $n \le N$. You are given $T(10^4) = 41333$.

Find $T(10^{12})$.
"""

# ╔═╡ eed7d45d-f6ae-4565-82be-2d25f30962e9
md"# Solution"

# ╔═╡ aa455a3c-5ff7-49bb-930d-b8cfca61d35b
N = 10^12;

# ╔═╡ ba70864e-d09f-4c2b-bd05-48d37cc2b28e
function g(n, s)
    n ≤ s && return n == s
    for i in 1:ndigits(n)-1
        g(n % 10^i, s - n ÷ 10^i) && return true
    end
    return false
end

# ╔═╡ 2d0f5cc4-afdf-4369-be8e-20d82d01545b
T(N) = sum(n^2 for n in 2:isqrt(N) if g(n^2, n))

# ╔═╡ d415b92c-4626-4f41-9bf9-553bd5942e1c
T(10^12)

# ╔═╡ c0c1c00c-fd55-41fc-aa33-a042e8988857
md"# Benchmark"

# ╔═╡ b21ce297-4c4d-4223-8197-54835f161f9b
b = @benchmarkable T(10^12); run(b, seconds=60)

# ╔═╡ a9218801-33d0-45ca-9cbf-982e2b71215c
md"# Validation"

# ╔═╡ d2d9d494-3f42-4bc6-b8c8-bd0d87625339
@assert T(10^4) == 41333

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
git-tree-sha1 = "92f91ba9e5941fc781fecf5494ac1da87bdac775"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.2.0"

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
# ╟─fe2d1c6a-5395-11ec-39d5-11f145d561b4
# ╟─eed7d45d-f6ae-4565-82be-2d25f30962e9
# ╠═aa455a3c-5ff7-49bb-930d-b8cfca61d35b
# ╠═ba70864e-d09f-4c2b-bd05-48d37cc2b28e
# ╠═2d0f5cc4-afdf-4369-be8e-20d82d01545b
# ╠═d415b92c-4626-4f41-9bf9-553bd5942e1c
# ╟─c0c1c00c-fd55-41fc-aa33-a042e8988857
# ╠═74456783-56a2-4807-9d01-b9bb78ee910d
# ╟─b21ce297-4c4d-4223-8197-54835f161f9b
# ╟─a9218801-33d0-45ca-9cbf-982e2b71215c
# ╠═d2d9d494-3f42-4bc6-b8c8-bd0d87625339
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
