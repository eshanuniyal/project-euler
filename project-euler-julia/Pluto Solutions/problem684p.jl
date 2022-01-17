### A Pluto.jl notebook ###
# v0.17.2

using Markdown
using InteractiveUtils

# ╔═╡ ab9aad52-4f4e-4173-93d2-715b9b779920
begin
	using OffsetArrays
	
	# generate and return all Fibonacci numbers Fᵢ for 0 ≤ i ≤ k
	function generate_fibonacci(k)
	
	    F = OffsetArray(zeros(Int, k + 1), 0:k)
	    F[0], F[1] = 0, 1
	
	    # iterating until we reach bound
	    for i in 2:k
	        F[i] = F[i-1] + F[i-2]
	    end
	    return F[1:end] # skip past the first Fibonacci number
	end
end

# ╔═╡ fcaebfee-47cd-483e-b434-d96fae842e49
using BenchmarkTools

# ╔═╡ 98ecdeb2-8a49-4627-a46b-50f713e84d33
md"""
$\newcommand{\Mod}[1]{\ (\mathrm{mod}\ #1)}$
$\newcommand{\floor}[1]{\left \lfloor #1 \right \rfloor }$
"""

# ╔═╡ 34c77a97-a8bc-4e40-b059-7b3da84371aa
md"""
# Project Euler #684: Inverse Digit Sum
**Solved 29 November, 2021**

Define $s(n)$ to be the smallest number that has a digit sum of $n$. For example $s(10) = 19$.

Let $\displaystyle S(k) = \sum_{n=1}^k$. You are given $S(20) = 1074$.

Further let $f_i$ be the Fibonacci sequence defined by $f_0 = 0, f_1 = 1$ and $f_i = f_{i-2} + f_{i-1}$ for all $i \ge 2$.

Find $\displaystyle \sum_{i=2}^{90} S(f_i)$. Give your answer modulo $1\ 000\ 000\ 007$.
"""

# ╔═╡ f07a17ba-71ed-42ba-a37c-a982f4743318
md"""
# Analysis
First, we notice that to generate $s(n)$, we must use each digit optimally, i.e., use as many nines as needed. $s(n)$ must therefore be $\lfloor n/9 \rfloor$ nines trailing the remainder after selecting this many nines, i.e., $n - 9\floor{n/9}$ or $n \Mod 9$.

For example, $s(10) = 19, s(11) = 29,\ \dots\ , s(25) = 799, s(50) = 599999$. It's easy to observe

$$s(n) = (n\Mod 9 + 1) \cdot 10^{\floor{n/9}} - 1$$

Now, we simplify $S(k)$. Defining $\tilde{s}(n) := s(n) + 1$, we have

$$\begin{aligned}
	S(k) &= \sum_{n=1}^k s(n)
		= \sum_{n=1}^k \tilde{s}(n) - k
		= \sum_{n=1}^{9\floor{k/9}} \tilde{s}(n) + \sum_{n=9\floor{k/9} + 1}^k \tilde{s}(n) - k \\
		&= \sum_{j=0}^{\floor{k/9} - 1} \sum_{i=0}^8 ((i + 1)\cdot 10^j) + \sum_{n=9\floor{k/9} + 1}^k ((n\Mod 9 + 1) \cdot 10^{\floor{n/9}}) - k \\ 
		&= \sum_{j=0}^{\floor{k/9} - 1} \left( 10^j \sum_{i=1}^9 i \right) + \sum_{h=1}^{k - 9\floor{k/9}}(i + 1)\cdot 10^{\floor{k/9}} - k \\
		&= 45\sum_{j=0}^{\floor{k/9} - 1} 10^j + 10^{\floor{k/9}}\sum_{h=2}^{k - 9\floor{k/9} + 1} i  - k \\
		&= 45 \frac{10^{\floor{k/9}} - 1}{10 - 1} + 10^{\floor{k/9}}\sum_{h=1}^{k \Mod 9 + 1} i - 1  - k \\
		&= 5\cdot (10^\floor{k/9} - 1) + 10^{\floor{k/9}} \cdot \frac{(k \Mod 9 + 1)(k \Mod 9 + 2)}{2} - 1 - k \\
		&= 10^\floor{k/9} \cdot \left(5 + \frac{(r + 1)(r + 2)}{2}\right) - (k + 6) \quad \text{for } r := k \Mod 9 \\
\end{aligned}$$

Thus we have a closed form formula for $S(k)$. However, computing $S(k)$ directly is impractical, since for large inputs such as $f_{90}$ (which is of the order $10^{18}$), $s(k)$ has $\approx 10^{17}$ digits and $S(k)$ far more. We must therefore apply modulo $m$ in intermediate steps of the calculation:

$$\begin{aligned}
S(k) \Mod m &\equiv \left(10^\floor{k/9} \cdot \left(5 + \frac{(r + 1)(r + 2)}{2}\right) - (k + 6)\right) \Mod m \\
	&\equiv \left( 10^\floor{k/9} \Mod m \cdot \left(5 + \frac{(r + 1)(r + 2)}{2}\right) + (M - (k + 6)) \right) \Mod m \\  
\end{aligned}$$
where $M := m \cdot \floor{(k+6)/m}$, i.e., the smallest multiple of $m$ larger than or equal to $k+6$.

Now, with the help of the `powermod` function, we can easily calculate $S(k) \Mod m$ for even large $k$. Taking the summation of $S(k)$ for the first ninety Fibonacci numbers modulo $m$ is then trivial.
"""

# ╔═╡ 733f608b-f612-4c0b-9e0f-ec87fc07c519
md"# Solution"

# ╔═╡ a1ed560e-9e57-44a2-81cc-a91b4d88761a
k_bound, modulo = 90, 1000000007;

# ╔═╡ 7f33c57c-7d2b-4bcd-87eb-72b374595d87
S(k, m) = (powermod(10, k ÷ 9, m) * (5 + (k % 9 + 1) * (k % 9 + 2) ÷ 2)  
	+ m * ((k + 6) ÷ m) - (k + 6)) % m

# ╔═╡ d5b648ce-184f-48a8-903a-2205b42c4466
function inverse_digit_sum(k_bound, m)
    F = generate_fibonacci(k_bound)
	return sum(S.(F[2:end], m)) % m
end

# ╔═╡ 45c76c18-7076-42a2-8e77-e64f6c81e374
inverse_digit_sum(k_bound, modulo)

# ╔═╡ a3e139bb-28ba-47b7-b1dc-f8acbb5e4672
md"# Benchmark"

# ╔═╡ 639e06b1-c317-4d46-8596-7861faf480a6
@benchmark inverse_digit_sum(k_bound, modulo)

# ╔═╡ 4de26cf2-b521-48a9-8a35-bd0c935d6a2b
md"""
# Validation
"""

# ╔═╡ c3018178-0911-4538-8033-3477c0b49a95
function brute_S(k, modulo)
    ans = 0
    for n in 1:k
        s_n = (n % 9 + 1) * big(10)^(floor(Int, n/9)) - 1
        ans += s_n % modulo
		ans %= modulo
    end
    return ans
end

# ╔═╡ 72adb368-e74e-406b-8f54-0ad9bafcc208
@assert S(20, modulo) == 1074

# ╔═╡ 9a8ea920-0a3f-41bc-b111-73fd67993a85
for i in 1:1000
    @assert S(i, modulo) == brute_S(i, modulo)
end

# ╔═╡ 63f844db-5bd1-4d78-a275-1820aac43b7e
# Computes b^x % m (wrote this before I knew Julia has a built-in powermod function)
function ladder_mod(b, x, m)

    x == 0 && return 1 % m

    j = floor(Int, log2(x))  # 2^j is the highest power of 2 less than or equal to x

    mods = OffsetArray(zeros(Int, j+1), 0:j)  # mods[i] := b^(2^i) % m
        # i.e., mods[0] = b % m, mods[1] = b^2 % m, mods[2] = b^4 % m, ...

    # setting base case
    mods[0] = b % m
    # calculating modulo values for successive powers
    for i in 1:j
        mods[i] = mods[i-1]^2 % m
    end

    # calculating modulo for desired power x
    rem_power = x - 2^j  # b^rem_power % m still unknown
    ans = mods[j]  # b^(2^j) currently known

    # iterating from j downwards
    for i in j:-1:0
        # if b^(2^i) known, can factor that into the answer and decrease rem_power
        if 2^i ≤ rem_power
            ans = (ans * mods[i]) % m
            rem_power -= 2^i
        end
        rem_power == 0 && break
    end

    return ans
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
BenchmarkTools = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
OffsetArrays = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"

[compat]
BenchmarkTools = "~1.2.0"
OffsetArrays = "~1.10.8"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[Adapt]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "84918055d15b3114ede17ac6a7182f68870c16f7"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.3.1"

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

[[OffsetArrays]]
deps = ["Adapt"]
git-tree-sha1 = "043017e0bdeff61cfbb7afeb558ab29536bbb5ed"
uuid = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"
version = "1.10.8"

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
# ╟─98ecdeb2-8a49-4627-a46b-50f713e84d33
# ╟─34c77a97-a8bc-4e40-b059-7b3da84371aa
# ╟─f07a17ba-71ed-42ba-a37c-a982f4743318
# ╟─733f608b-f612-4c0b-9e0f-ec87fc07c519
# ╠═a1ed560e-9e57-44a2-81cc-a91b4d88761a
# ╟─ab9aad52-4f4e-4173-93d2-715b9b779920
# ╠═7f33c57c-7d2b-4bcd-87eb-72b374595d87
# ╠═d5b648ce-184f-48a8-903a-2205b42c4466
# ╠═45c76c18-7076-42a2-8e77-e64f6c81e374
# ╟─a3e139bb-28ba-47b7-b1dc-f8acbb5e4672
# ╠═fcaebfee-47cd-483e-b434-d96fae842e49
# ╠═639e06b1-c317-4d46-8596-7861faf480a6
# ╟─4de26cf2-b521-48a9-8a35-bd0c935d6a2b
# ╟─c3018178-0911-4538-8033-3477c0b49a95
# ╠═72adb368-e74e-406b-8f54-0ad9bafcc208
# ╠═9a8ea920-0a3f-41bc-b111-73fd67993a85
# ╟─63f844db-5bd1-4d78-a275-1820aac43b7e
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
