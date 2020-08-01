#include <vector>
#include <iostream>
#include <fstream>	// defines ifstream
#include <string>
#include "primeFunctions.h"
using namespace std;
using namespace prime;

namespace aux {
	vector<vector<int>> loadMatrix(string fileName, int dim) {
		// loads matrix defined in input file with address "fileName" (rows separated by '\n', ints separated by ", ")
			// into square, 2D vector matrix

		vector<vector<int>> matrix;

		// loading file into inputFile
		ifstream inputFile(fileName);

		// file could not be found
		if (!inputFile) {
			cerr << "File could not be found." << endl;
			exit(1);
		}

		// iterate over rows; with each iteration, we generate a row vector
		for (int rowNum = 0; rowNum < dim; rowNum++) {
			vector<int> row;
			// iterating over each element in row (except last)
			for (int colNum = 0; colNum < dim; colNum++) {
				int rowElem;
				inputFile >> rowElem;	// extracting row element
				if (colNum < dim - 1)
					inputFile.ignore(10000, ',');	// skip comma before next element 
						// (only exists if not last element)
				row.push_back(rowElem);	// inserting row element into row
			}
			matrix.push_back(row);	// inserting row
		}

		return matrix;
	}

	bool checkPerfectSquare(int N) {
		// checks whether a number is a perfect square
		if (pow(int(sqrt(N)), 2) == N)
			return true;
		else return false;
	}

	vector<int> findContinuedFraction(int N) {
		// returns the period of the continued fraction for root n

		const int aStart = int(floor(sqrt(N)));	// termination check: when our next expression is root(n) - aStart, we can terminate

		// sequence of a's (until sequence starts repeating
		vector<int> fractionConstants = { };

		int nK = 1;
		int dK = -aStart;	// in reality, denominator is root(n) - denominatorTerm

		do {
			// rationalising numerator / (root(n) - denominatorTerm)
			int dKp1 = -dK;	// (tentative) next denominator
			int nKp1 = (N - int(pow(dK, 2))) / nK;	// next numerator

			int aKp1 = 0;

			// transforming dKp1 to appropriate form
			while (N - int(pow(dKp1 - nKp1, 2)) > 0) {
				dKp1 -= nKp1;
				aKp1++;
			}

			// updating nK, dK, fractionConstants
			nK = nKp1; dK = dKp1;
			fractionConstants.push_back(aKp1);

		} while (nK != 1 || dK != -aStart);
		// if while condition is met, we're back to the first iteration and constants will repeat

	// returning period of root
		return fractionConstants;
	}

	int eulerTotient(int n, const vector<int>& primes) {
		// returns totient(n) given vector of all primes at least up to n
		return generatePrimeFactors(n, primes).size();
	}

	int eulerTotient(unsigned int n, const vector<int>& primes, vector<int>& totients) {
		// returns totient(n) given vector of primes at least up to n and vector of prime factorisations of numbers in range [2, n - 1]
		// faster than more primitive implementation of eulerTotient
		// also inserts unique prime factors of n into primeFactorisations at index n

		// ensuring totients of 0 and 1 are available
		while (totients.size() < 2)
			totients.push_back(0);

		// if totient already found, return totient
		if (n < totients.size())
			return totients[n];
		// for correctness
		else if (n > totients.size()) {
			cerr << "For correctness of eulerTotient, totients must contain totient(k) of each integer k in [2, n]" << endl;
			exit(0);
		}

		// iterating over primes to find first divisible prime
		for (int prime : primes) {
			// first divisible prime found
			if (n % prime == 0) {
				// reducing n
				int nReduced = n;
				while (nReduced % prime == 0)
					nReduced /= prime;
				long long totient = n - n / prime;
				if (nReduced > 1) {
					totient *= totients[nReduced];
					totient /= nReduced;
				}
				// prime factors of n = prime factors of nReduced (union) prime
				totients.push_back(int(totient));
				return int(totient);
			}
		}
	}
}