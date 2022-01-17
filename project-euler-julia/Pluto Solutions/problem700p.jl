### A Pluto.jl notebook ###
# v0.17.2

using Markdown
using InteractiveUtils

# ╔═╡ 30e211e6-f47a-4d08-abfa-012175bd373d
using BenchmarkTools

# ╔═╡ 1cfa000b-b394-425e-8ea6-b7b938c45a23
md"""
$\newcommand{\Mod}[1]{\ (\mathrm{mod}\ #1)}$
"""

# ╔═╡ 9ab91cf2-5234-11ec-349c-e1e57aae3d06
md"""
# Project Euler #700: Eulercoin
**Solved 30 November, 2021**

Leonhard Euler was born on 15 April 1707.

Consider the sequence $1504170715041707n \Mod{4503599627370517}$.

An element of this sequence is defined to be an Eulercoin if it is strictly smaller than all previously found Eulercoins.

For example, the first term is $1504170715041707$ which is the first Eulercoin. The second term is $3008341430083414$ which is greater than $1504170715041707$ and so is not an Eulercoin. However, the third term is $8912517754604$ which is small enough to be a new Eulercoin.

The sum of the first two Eulercoins is therefore $1513083232796311$.

Find the sum of all Eulercoins.
"""

# ╔═╡ 05d42e2a-515d-4a9b-bf1c-47f035ab253c
md"""
# Analysis

Let an $\text{coin}(k, m, i)$ be the $i$th element of the sequence $kn \Mod m$ that is strictly smaller than all previous elements in the sequence. 

Given $k$, $m$, and $i$, define $c_i := \text{coin}(k, m, i)$ and $n_i$ the smallest integer such that $kn_i \Mod m = e_i$. Let $\tilde{n}$ be the smallest positive integer such that $n_i + \tilde{n}$ yields a coin, i.e., $k(n_i + \tilde{n}) \Mod m < c_i$, or equivalently, $(c_i + k\tilde{n}) \Mod m < c_i$.

If $c_i + k\tilde{n} \Mod m < m$, the inequality cannot hold since then $(c_i + k\tilde{n}) \Mod m = c_i + k\tilde{n} > c_i$. We must therefore have $c_i + k\tilde{n} \Mod m \ge m$, and so 

$$c_{i+1} = (c_i + k\tilde{n}) \Mod m = (c_i + k\tilde{n} \Mod m) \Mod m$$

Clearly, $k\tilde{n} \Mod m$ is itself an element of the sequence. We prove that it must be an element of the sequence strictly larger than element before it; let this class of elements be termed *anticoins*.

Assume towards contradiction the desired $\tilde{n}$ does not yield an anticoin. In other words, there exists some $n' < n$ such that $kn' \Mod m > k\tilde{n} \Mod m$. Also note that since $c_i < m$ and $kn \Mod m < m$ for all $n$, we have $c_i + kn \Mod m < 2m$ for all $n$. Furthermore, $c_i + k\tilde{n} \Mod m \ge m$ implies $c_i + kn' \Mod m > m$, and so $m < c_i + kn' \Mod m< 2m$. Thus 

$$(c_i + kn') \Mod m = (c_i + kn' \Mod m) \Mod m = c_i + kn' \Mod m - m < c_i$$

which implies $(c_i + kn') \Mod m$ is a coin. However, this contradicts our assumption $\tilde{n}$ (which is greater than $n'$) is the smallest integer such that $(c_i + k\tilde{n}) \Mod m$ is a coin. Thus $\tilde{n}$ does yield an anticoin.

Thus, given $c_i$, we can generate $c_{i+1}$ by testing successive anticoins $a$ until we find one satisfying $(c_i + a) \Mod m < c_i$. It remains to show we can also generate every anticoin from a coin and a preceding anticoin.
"""

# ╔═╡ 76fb9eed-64c4-4c33-9b51-5685c6b6a626
md"# Solution"

# ╔═╡ 0913b84e-7649-4ced-8a64-45dca73fa942
k, m = 1504170715041707, 4503599627370517

# ╔═╡ 228010a0-6216-415e-b31f-a7b4970163b4
function eulercoin_sum(k, m)
	last_coin, last_coin_n = k % m, 1
	anticoins, anticoins_ns = [k % m], [1]
	coins_sum = last_coin
	
	while last_coin_n < m
		new_mods = (last_coin .+ anticoins) .% m
		new_ns = last_coin_n .+ anticoins_ns
		
		for i in eachindex(new_mods)
			if new_mods[i] > anticoins[end]
				push!(anticoins, new_mods[i])
				push!(anticoins_ns, new_ns[i])
			end
			
			if new_mods[i] < last_coin
				last_coin, last_coin_n = new_mods[i], new_ns[i]
				coins_sum += last_coin
			end
		end
	end
	
	return coins_sum
end

# ╔═╡ bf8cfa82-60cc-4287-8931-da63c61ff4c6
eulercoin_sum(k, m)

# ╔═╡ 45ef7dd9-c123-4706-ac0c-231da6e3d53e
md"# Benchmark"

# ╔═╡ 95210c3a-58fa-46ad-954e-a3eb58457223
@benchmark eulercoin_sum(k, m)

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
# ╟─1cfa000b-b394-425e-8ea6-b7b938c45a23
# ╟─9ab91cf2-5234-11ec-349c-e1e57aae3d06
# ╟─05d42e2a-515d-4a9b-bf1c-47f035ab253c
# ╟─76fb9eed-64c4-4c33-9b51-5685c6b6a626
# ╠═0913b84e-7649-4ced-8a64-45dca73fa942
# ╠═228010a0-6216-415e-b31f-a7b4970163b4
# ╠═bf8cfa82-60cc-4287-8931-da63c61ff4c6
# ╟─45ef7dd9-c123-4706-ac0c-231da6e3d53e
# ╠═30e211e6-f47a-4d08-abfa-012175bd373d
# ╠═95210c3a-58fa-46ad-954e-a3eb58457223
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
