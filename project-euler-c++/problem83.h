// Header file for Project Euler Problem 83 (https://projecteuler.net/problem=83)
// July 27, 2020
#pragma once

#include <vector>
using namespace std;

enum direction { RIGHT, DOWN, LEFT, UP };

struct Position {
	// class defined to keep track of positions travelled in paths

	// private data members
	int row;
	int col;

	// constructor
	Position(int rowIndex = -1, int colIndex = -1)
		: row(rowIndex), col(colIndex) {}
};

struct Node {
	// const data members
	const Position pos;	// position of node
	const int val;	// value of node
	vector<Node*> adjNodes = vector<Node*> (4, nullptr);	// pointers to adjacent nodes
		// assumed no adjacent nodes by default
		// adjNodePtrs should also be const in theory, but coded non-const to make generateNodeMatrix simpler

	// non-const data members for use in Djikstra's algorithm
	int shortestPath = INT_MAX;	// sentinel for infinity
	Node* shortestPathThrough = nullptr;	// node through which shortest path is attained
		// not strictly necessary for the sum of the shortest path, but can be used to find the shortest path
	int heuristic;	// heuristic (representative of estimated "distance" from node to ending node

	// constructor (if called with no parameters, creates dummy nodes)
	Node(Position pos = Position(-1, -1), int val = -1, int heuristic = 0)
		: pos(pos), val(val), heuristic(heuristic) {}
};

struct NodeComparator {
	// comparator class for min-heap priority queue
	bool operator() (const Node* node1, const Node* node2) {
		return node1->val + node1->heuristic < node2->val + node2->heuristic;
		// returns true if the path through node1 has total estimated cost less than the path through node2
	}
};