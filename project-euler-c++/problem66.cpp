// Project Euler Problem 66 (https://projecteuler.net/problem=66)
// July 27, 2020

#include <vector>
#include <boost/multiprecision/cpp_int.hpp>	// for large ints, from the non-standard boost library
#include "auxFunctions.h"	// findContinuedFraction, checkPerfectSquare
using namespace boost::multiprecision;
using namespace std;

cpp_int findMinimalSolution(int D);

int diophantineEquation(int bound) {
	// return  non-perfect-square D in [2, bound] such that the minimal solution x for x^2 - Dy^2 = 1 is maximal

	// tracking max minimal solution found so far and the corresponding value of D
	cpp_int maxMinimalSolution = 0;
	int optimalD = 0;
	// iterating over [2, D]
	for (int D = 2; D <= bound; D++) {
		// filtering out perfect squares
		if (!aux::checkPerfectSquare(D)) {
			// generating minimal solution
			cpp_int minimalSolution = findMinimalSolution(D);
			// updating maxMinimalSolution and optimalD as necessary
			if (minimalSolution > maxMinimalSolution) {
				maxMinimalSolution = minimalSolution;
				optimalD = D;
			}
		}
	}
	// return optimal D
	return optimalD;
}

cpp_int findMinimalSolution(int D) {
	// finds minimal x such that x^2 - Dy^2 = 1 for some y given D
	
	vector<int> continuedFraction = aux::findContinuedFraction(D);
		// constants in continued fraction of root D
	int period = continuedFraction.size();

	// initialising constants
	cpp_int Akm1 = 1;
	cpp_int Bkm1 = 0;
	cpp_int Ak = int(floor(pow(D, 0.5)));	// floor of root D
	cpp_int Bk = 1;
	int k = 0;
	
	// while we don't have a solution to the Diophantine equation
	while (Ak * Ak - D * Bk * Bk != 1) {
		
		// generating next convergent Akp1/Bkp1
		// formula for next convergent verified from https://mathworld.wolfram.com/Convergent.html
		cpp_int Akp1 = continuedFraction[k % period] * Ak + Akm1;
		cpp_int Bkp1 = continuedFraction[k % period] * Bk + Bkm1;

		// updating variables
		Akm1 = Ak; Bkm1 = Bk;
		Ak = Akp1; Bk = Bkp1;
		k++;
	}

	return Ak;
}