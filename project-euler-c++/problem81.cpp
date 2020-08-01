// Project Euler Problem 81 (https://projecteuler.net/problem=81)
// July 26, 2020
// Problem already solved in Python; writing C++ solution (without reference to Python solution) 
	// to eventually solve Problems 82 and 83

#include <vector>
#include <string>
#include "auxFunctions.h"
using namespace std;

int minPathSum(int startRow, int startCol, const vector<vector<int>>& matrix, vector<vector<int>>& minPathSums);
	// recursively finds minimal path sum from (startRow, startIndex) to last element

int minPathSumTwoWays(string fileName, int dim) {

	vector<vector<int>> matrix = aux::loadMatrix(fileName, dim);
	vector<vector<int>> minPathSums(dim, vector<int>(dim, -1));
		// create a 2D matrix to store the length of minimal path sums to end point
		// -1 indicates min path sum not found yet
	
	return minPathSum(0, 0, matrix, minPathSums);
}

int minPathSum(int startRow, int startCol, const vector<vector<int>>& matrix, vector<vector<int>>& minPathSums) {
	// recursively finds the minimal path from starting index (startRow, startCol) to last element
		// moving only right and down

	// size of matrix
	const int matrixDim = matrix.size();

	// base case: already at end point
	if (startCol == matrixDim - 1 && startRow == matrixDim - 1)
		return matrix[matrixDim - 1][matrixDim - 1];
	// base case: already found minimal path
	if (minPathSums[startRow][startCol] != -1)
		return minPathSums[startRow][startCol];

	int currentElem = matrix[startRow][startCol];	// current element
	int minSum;	// minimal path sum from current index

	// not at end point -> find minimal path from right element and below element (if they exist)
	// case 1: there exists a path to the right and below
	if (startCol < matrixDim - 1 && startRow < matrixDim - 1) {
		int rightPath = minPathSum(startRow, startCol + 1, matrix, minPathSums);
			// minimal path from the right
		int downPath = minPathSum(startRow + 1, startCol, matrix, minPathSums);
			// minimal path from below
		// finding minimal path
		if (rightPath < downPath)
			minSum = rightPath + currentElem;
		else
			minSum = downPath + currentElem;
	}
	// case 2: there only exists a path to the right
	else if (startCol < matrixDim - 1)
		minSum = minPathSum(startRow, startCol + 1, matrix, minPathSums) + currentElem;
	// case 3: there only exists a path below
	else
		minSum = minPathSum(startRow + 1, startCol, matrix, minPathSums) + currentElem;

	// update minimal paths
	minPathSums[startRow][startCol] = minSum;

	// return minimal path
	return minSum;
}