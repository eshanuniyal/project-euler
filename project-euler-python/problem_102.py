# ---------------------------------------------------------------
# Project Euler Problem 102 | Eshan Uniyal
# February 2018, Python 3
# Three distinct points are plotted at random on a Cartesian plane, for which -1000 ≤ x, y ≤ 1000, such that a triangle is formed.
# Consider the following two triangles:
#    A(-340,495), B(-153,-910), C(835,-947)
#   X(-175,41), Y(-421,-714), Z(574,-645)
# It can be verified that triangle ABC contains the origin, whereas triangle XYZ does not.
# Using triangles.txt (right click and 'Save Link/Target As...'), a 27K text file containing the co-ordinates of
# one thousand "random" triangles, find the number of triangles for which the interior contains the origin.
# NOTE: The first two examples in the file represent the triangles in the example given above.
# ---------------------------------------------------------------

import timer



def area(point1, point2, point3):
    area = 0.5 * abs((point1[0] - point3[0]) * (point2[1] - point1[1]) - (point1[0] - point2[0]) * (point3[1] - point1[1]))
    return(area)

def checker(coordinateSet):
    A = coordinateSet[0 : 2]
    B = coordinateSet[2 : 4]
    C = coordinateSet[4 : 6]
    O = [0, 0]
    if area(A, B, C) == (area(A, B, O) + area(B, C, O) + area(C, A, O)):
        return(True)
    else:
        return(False)

def main():
    coordinatesImport = open("Supporting texts\\Problem 102.txt", "r")
    strcoordinates = coordinatesImport.read().split('\n')
    strTriangles = []
    for triangle in strcoordinates:
        strTriangles.append(triangle.split(','))
    strTriangles.remove([''])
    # print(strTriangles)

    triangles = []
    for set in strTriangles:
        triangle = []
        for coordinate in set:
            intCoordinate = int(coordinate)
            triangle.append(intCoordinate)
        triangles.append(triangle)

    count = 0
    for triangle in triangles:
        if checker(triangle) == True:
            count += 1
    return(count)

timer.start()
print(main())
timer.end()