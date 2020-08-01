// Project Euler Problem 82 (https://projecteuler.net/problem=82)
// July 26, 2020

#include <vector>
#include <string>
#include "auxFunctions.h"	// loadMatrix
using namespace std;

enum direction { UP, DOWN, RIGHT };
// for reference in minPathSum

int minPathSum(int startRow, int startCol, direction dir,
	const vector<vector<int>>& matrix, vector<vector<int>>& upMinPathSums, vector<vector<int>>& downMinPathSums);
	// recursively finds minimal path sum from (startRow, startIndex) to last element


int minPathSumThreeWays(string fileName, int dim) {

	vector<vector<int>> matrix = aux::loadMatrix(fileName, dim);
	
	// create 2D matrices to store the length of minimal path sums to end point
		// -1 indicates min path sum not found yet
	vector<vector<int>> upMinPathSums(dim, vector<int>(dim, -1));	// stores min path sums going up and to the right
	vector<vector<int>> downMinPathSums(dim, vector<int>(dim, -1));	// stores min path sums going down and to the right


	int bestMinPathSum = INT_MAX;	// best minimal path sum; INT_MAX is sentinel for infinity
	// finding minimal path from every element in first column
	for (int rowNum = 0; rowNum < dim; rowNum++) {
		// finding minimal path sum from element at (rowNum, 0)
		int currentMinPathSum = minPathSum(rowNum, 0, RIGHT, matrix, upMinPathSums, downMinPathSums);
		// updating bestMinPathSum if necessary
		if (currentMinPathSum < bestMinPathSum)
			bestMinPathSum = currentMinPathSum;
	}

	/*for (vector<int> rowSums : minPathSums) {
		for (int elemSum : rowSums)
			cerr << elemSum << " ";
		cerr << endl;
	}*/

	return bestMinPathSum;
}

int minPathSum(int startRow, int startCol, direction dir, 
	const vector<vector<int>>& matrix, vector<vector<int>>& upMinPathSums, vector<vector<int>>& downMinPathSums) {
	// recursively finds the minimal path from starting index (startRow, startCol) to any element in the last column
		// moving only right, up and down

	// size of matrix
	const int matrixDim = matrix.size();

	// checking base cases
	int upPath = upMinPathSums[startRow][startCol];
	int downPath = downMinPathSums[startRow][startCol];
	// base case: already found minimal path
	// case 1: travelled up to current index, and minimal path up and to the right is known
	if (dir == UP && upPath != -1)
		return upPath;
	// case 2: travelled down to current index, and minimal path down and to the right is known
	else if (dir == DOWN && downPath != -1)
		return downPath;
	// case 3: travelled right and minimal path up, down, and to the right is known
	else if (dir == RIGHT && upPath != -1 && downPath != -1) {
		// returning best path, up or down
		if (upPath < downPath)
			return upPath;
		else return downPath;
	}

	// base case: already at the last column
	if (startCol == matrixDim - 1) {
		//minPathSums[startRow][startCol] = matrix[startRow][startCol];	// not strictly necessary
		return matrix[startRow][startCol];
	}

	int currentElem = matrix[startRow][startCol];	// current element

	// generate minimal paths from valid adjacent (right, up, down) elements that haven't already been visited

	// finding minimal path to the right (always exists)
	int rightPath = minPathSum(startRow, startCol + 1, RIGHT, matrix, upMinPathSums, downMinPathSums) + currentElem;
	int minSum = rightPath;	// minimal path sum from current index (assumed rightPath by default)

	// finding minimal path below (only valid if there are rows below and we didn't reach current element by going up)
	if (dir != UP && startRow < matrixDim - 1) {
		downPath = minPathSum(startRow + 1, startCol, DOWN, matrix, upMinPathSums, downMinPathSums) + currentElem;
		// update minSum if necessary
		if (downPath < minSum)
			minSum = downPath;
	}

	// finding minimal path above (only valid if there are rows above and we didn't reach current element by going down)
	if (dir != DOWN && startRow > 0) {
		upPath = minPathSum(startRow - 1, startCol, UP, matrix, upMinPathSums, downMinPathSums) + currentElem;
		// update minSum if necessary
		if (upPath < minSum)
			minSum = upPath;
	}

	// update minimal paths
	upMinPathSums[startRow][startCol] = upPath;
	downMinPathSums[startRow][startCol] = downPath;
	if (rightPath < upPath)
		upMinPathSums[startRow][startCol] = rightPath;
	if (rightPath < downPath)
		downMinPathSums[startRow][startCol] = rightPath;

	// return minimal path
	return minSum;
}