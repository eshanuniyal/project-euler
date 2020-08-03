#include <vector>
#include "primeFunctions.h"
using namespace std;

namespace prime {
	vector<int> generatePrimes(int primeBound) {
		// generates primes in range [2, primeBound] by brute force algorithm
		
		// guaranteed upper bound on number of primes <= primeBound
		int nPrimeBound = ceil(1.25506 * primeBound / log(primeBound));
		vector<int> primes = { 2 };		// vector of all primes upto and including largest factor
		primes.reserve(nPrimeBound);	// reserving storage

		// iterating over odd numbers in [3, primeBound]
		for (int n = 3; n <= primeBound; n += 2) {
			bool primeFound = true;		// we assume we have a prime until and unless we find a prime factor
			int maxPrimeFactor = floor(sqrt(n));

			// searching for prime factor
			for (int prime : primes) {
				if (prime > maxPrimeFactor) {
					primes.push_back(n);
					break;
				}
				if (n % prime == 0)
					break;
			}
		}
		return primes;
	}

	vector<int> generatePrimeFactors(int n, const vector<int>& primes) {
		// generate vector of unique prime factors of n

		vector<int> factors;

		// iterating until n == 1 (i.e. all primes found)
		for (int prime : primes) {
			// checking if k is divisible by prime factor
			if (n % prime == 0) {
				// reducing n
				while (n % prime == 0)
					n /= prime;
				// inserting prime in factors
				factors.push_back(prime);
			}
		}

		return factors;
	}

	vector<vector<int>> generatePrimeFactorsForAllIntegers(const vector<int>& primes, int bound) {
		// return a vector of prime factors for each index

		// vector of prime factors
		vector<vector<int>> factors;
		factors.push_back(vector<int> {});	// for 1-based indexing later
		factors.push_back(vector<int> {});	// for 1-based indexing later

		// iterating up to bound to find prime factorisations for each
		for (int n = 2; n <= bound; n++) {

			// iterating until k == 1 (i.e. all primes found)
			for (int prime : primes) {
				// checking if k is divisible by prime factor
				if (n % prime == 0) {
					// inserting prime in factors[k]
					int k = n;
					while (k % prime == 0)
						k /= prime;
					factors.push_back(factors[k]);
					factors[n].push_back(prime);
					break;

				}
			}
		}
		return factors;
	}

	void generateAndInsertNextPrime(vector<int>& primes) {
		// generates (n+1)th prime given first n primes

		// trivial case: primes is empty
		if (primes.size() == 0) {
			primes.push_back(2);
			return;
		}

		// iterating starting from first possible prime candidate until next prime is found
		for (int k = primes.back() + 1; true; k++) {
			// assumed k is prime by default
			bool primeFound = true;
			// maximal prime factor of k
			int maxPrimeFactor = ceil(sqrt(k));

			// iterating over primes to check primality of k
			for (int prime : primes) {
				// if prime divides k, k is not prime
				if (k % prime == 0)
					primeFound = false;
				// if we've exceed max prime factor (in which case we know k is prime)
					// or primeFound is false (in which case we know k is not prime), break
				if (prime > maxPrimeFactor || !primeFound)
					break;
			}
			// checking if prime found
			if (primeFound) {
				primes.push_back(k);
				return;	// next prime generated and inserted
			}

		}
	}
}