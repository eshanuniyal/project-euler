#include <iostream>
#include <vector>
#include "primeFunctions.h"		// generateAndInsertNextPrime
#include "auxFunctions.h"	// eulerTotient
using namespace std;

int smallestResilientFractionNumerator(int num, int den) {
	// returns the first value of d such that totient(d)/(d-1) < num/den
	
	vector<int> primes;
	prime::generateAndInsertNextPrime(primes);

	// stored prime factorisations for 1 through d
	vector<int> totients;

	double ratioBound = double(num) / den;
	double minRatioFound = 1;

	for (int d = 2; true; d++) {
		// ensuring primes at least up to d have been generated
		while (d > primes.back())
			prime::generateAndInsertNextPrime(primes);
		// finding R(d) = totient(d) / (d - 1)
		int resilientFractions = aux::eulerTotient(d, primes, totients);
		double R = resilientFractions / (double(d) - 1);

		if (R < ratioBound) {
			cerr << ratioBound << " " << d << " " << resilientFractions << " " << R << endl;
			return d;
		}
		if (R < minRatioFound) {
			minRatioFound = R;
			cerr << ratioBound << " " << d << " " << resilientFractions << " " << R << endl;
		}
	}
}