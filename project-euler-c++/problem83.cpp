// Project Euler Problem 83 (https://projecteuler.net/problem=83)
// July 27, 2020

#include <vector>
#include <queue>
#include <string>
#include "problem83.h"	// contains definitions for Node, Position
#include "auxFunctions.h"	// loadMatrix
using namespace std;

struct Node; struct Position; struct NodeComparator;

vector<vector<Node*>> generateNodeMatrix(vector<vector<int>>& numMatrix);
	// generates and returns a matrix of nodes
bool withinBounds(Position& pos, int dim);
	// returns whether a position is in bounds
int findHeuristic(Position& pos, int min, int dim);
	// finds estimated "distance" from pos to last position

int minPathSumFourWays(string fileName, int dim) {
	// implements Djikstra's algorithm to find the minimal path top-left to bottom-right element
	
	// loading matrix
	vector<vector<int>> numMatrix = aux::loadMatrix(fileName, dim);
	// matrix of nodes
	vector<vector<Node*>> nodeMatrix = generateNodeMatrix(numMatrix);

	// initialising algorithm
	priority_queue<Node*, vector<Node*>, NodeComparator> pQueue;	// priority queue for Djikstra' algorithm
	nodeMatrix[0][0]->shortestPath = nodeMatrix[0][0]->val;	
		// our path starts with cost of first node
	pQueue.push(nodeMatrix[0][0]);

	// implementing Djikstra's algorithm based off of Computerphile video (https://www.youtube.com/watch?v=GazC3A4OQTE)
	while (!pQueue.empty()) {
		// extracting current node
		Node* node = pQueue.top(); pQueue.pop();

		// iterating over current nodes neighbours
		for (Node* adjNode : node->adjNodes) {
			// if adjacent node exists, updating adjacent node's shortest path as necessary
			if (adjNode != nullptr && node->shortestPath + adjNode->val < adjNode->shortestPath ) {
				// update shortest path and shortestPath through
				adjNode->shortestPath = node->shortestPath + adjNode->val;
				adjNode->shortestPathThrough = node;
				// examine (or re-examine) neighbours of adjNode with new shortest path
				pQueue.push(adjNode);
			}
		}
	}

	// storing answer
	int answer = nodeMatrix[dim - 1][dim - 1]->shortestPath;

	// free memory taken by Nodes
	for (vector<Node*> row : nodeMatrix)
		for (Node* nodePtr : row)
			delete nodePtr;

	// return shortest path to last node
	return answer;
}

vector<vector<Node*>> generateNodeMatrix(vector<vector<int>>& numMatrix) {
	// generate node matrix from number matrix

	const int dim = numMatrix.size();

	// finding minimum of numMatrix (for admissible heuristic)
	int minNum = INT_MAX;
	for (int rowNum = 0; rowNum < dim; rowNum++)
		for (int colNum = 0; colNum < dim; colNum++)
			if (numMatrix[rowNum][colNum] < minNum)
				minNum = numMatrix[rowNum][colNum];
	
	vector<vector<Node*>> nodeMatrix(dim, vector<Node*>(dim, nullptr));

	// creating node matrix (graph representation)
	for (int rowNum = 0; rowNum < dim; rowNum++) {
		for (int colNum = 0; colNum < dim; colNum++) {

			// generating position and value of current node
			Position pos = Position(rowNum, colNum);
			int val = numMatrix[rowNum][colNum];

			// generating and storing node
			nodeMatrix[pos.row][pos.col] = new Node(pos, val, findHeuristic(pos, minNum, dim));
		}
	}

	// for each node, creating pointers to adjacent nodes
	for (int rowNum = 0; rowNum < dim; rowNum++) {
		for (int colNum = 0; colNum < dim; colNum++) {
			
			Position pos = nodeMatrix[rowNum][colNum]->pos;
			vector<Node*> adjNodes(4, nullptr);

			// generating adjacent positions
			Position rightPos = Position(rowNum, colNum + 1);
			Position downPos = Position(rowNum + 1, colNum);
			Position leftPos = Position(rowNum, colNum - 1);;
			Position upPos = Position(rowNum - 1, colNum);

			// for each adjacent position, if position is in bounds, 
				// insert a pointer to the corresponding node in adjNodePtrs
			if (withinBounds(rightPos, dim))
				adjNodes[RIGHT] = nodeMatrix[rightPos.row][rightPos.col];
			if (withinBounds(downPos, dim))
				adjNodes[DOWN] = nodeMatrix[downPos.row][downPos.col];
			if (withinBounds(leftPos, dim))
				adjNodes[LEFT] = nodeMatrix[leftPos.row][leftPos.col];
			if (withinBounds(upPos, dim))
				adjNodes[UP] = nodeMatrix[upPos.row][upPos.col];

			// storing adjNodePtrs
			nodeMatrix[pos.row][pos.col]->adjNodes = adjNodes;
		}
	}

	return nodeMatrix;
}

bool withinBounds(Position& pos, int dim) {
	// checks whether a given position is within bounds
	return (pos.row >= 0 && pos.row < dim && pos.col >= 0 && pos.col < dim);
}

int findHeuristic(Position& pos, int min, int dim) {
	// note: for the heuristic to be admissible, we want to ensure we never overestimate the actual cost of getting
		// from a node to the last node. We therefore define the heuristic of a given node to be the total cost of getting from 
		// the node the last node assuming the shortest-length path is followed and each element is the smallest in the matrix
	return min * ((dim - pos.row - 1) + (dim - pos.col - 1));
}