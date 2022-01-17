# Julia Solution to Project Euler Problem 700
# 30 November 2021
# Runtime: ~10⁻³ seconds

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

@btime eulercoin_sum(1504170715041707, 4503599627370517)