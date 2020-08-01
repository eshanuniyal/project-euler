// Project Euler Problem 64 (https://projecteuler.net/problem=64)
// July 20, 2020

#include<vector>
#include <math.h>	// floor, sqrt
#include "auxFunctions.h"	// checkPerfectSquare, findContinuedFraction
using namespace std;

int oddPeriodSquareRoots(int bound) {
	// returns the number of continued fractions of root(n) that have an odd period for n <= bound
	
	int oddCount = 0;

	// finding continued fractions with odd period
	for (int N = 2; N <= bound; N++)
		if (!aux::checkPerfectSquare(N) && aux::findContinuedFraction(N).size() % 2 == 1)
			oddCount++;

	return oddCount;
}