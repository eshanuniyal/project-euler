#pragma once
#include <vector>
using namespace std;

namespace prime {
	vector<int> generatePrimes(int primeBound);
	vector<int> generatePrimeFactors(int n, const vector<int>& primes);
	vector<vector<int>> generatePrimeFactorsForAllIntegers(const vector<int>& primes, int bound);
	void generateAndInsertNextPrime(vector<int>& primes);
}