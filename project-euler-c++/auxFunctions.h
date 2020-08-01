#pragma once
#include <vector>
#include <string>
using namespace std;

namespace aux {
	// used for problems 81, 82, 83
	vector<vector<int>> loadMatrix(string fileName, int dim);
	// used for problems 64, 66
	bool checkPerfectSquare(int N);
	vector<int> findContinuedFraction(int N);
	// used for problem 243
	int eulerTotient(int n, const vector<int>& primes);
	int eulerTotient(unsigned int n, const vector<int>& primes, vector<int>& totients);
}