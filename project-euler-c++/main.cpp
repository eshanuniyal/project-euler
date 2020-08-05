#include <iostream>
#include <vector>
#include "problemFunctions.h"	// function declarations
#include "primeFunctions.h"
using namespace std;

void solve(vector<int> problems);
int solve(int problem);

int main() {

	// solved problems
	vector<int> solvedProblems = { 64, 81, 82, 83, 66 };
	solve(82);


	// current problem
	// cout << solve(243);
}

void solve(vector<int> problems) {
	// solve each problem in problems and print solution

	// iterating over problems
	for (int p : problems) {
		cout << "Problem " << p << ": " << solve(p) << endl;
	}
}

int solve(int problem) {
	switch (problem) {
		case 64:
			return oddPeriodSquareRoots(10000);
		case 81:
			return minPathSumTwoWays("Problem Resources/problems81,82,83.txt", 80);
		case 82:
			return minPathSumThreeWays("Problem Resources/problems81,82,83test.txt", 5);
		case 83:
			return minPathSumFourWays("Problem Resources/problems81,82,83.txt", 80);
		case 66:
			return diophantineEquation(1000);
		case 243:
			return smallestResilientFractionNumerator(15499, 94744);
	}
}