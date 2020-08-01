# ---------------------------------------------------------------
# Project Euler Problem 22 | Eshan Uniyal
# November 2017, Python 3
# Using names.txt, a 46K text file containing over five-thousand first names, begin by sorting it into alphabetical order.
# Then working out the alphabetical value for each name, multiply this value by its alphabetical position in the list to obtain a name score.
# For example, when the list is sorted into alphabetical order,
#   COLIN, which is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list.
#   So, COLIN would obtain a score of 938 × 53 = 49714.
# What is the total of all the name scores in the file?
# ---------------------------------------------------------------

import timer



namesImport = open("Supporting texts\\Problem 22.txt", "r")
names = namesImport.read().split(',')
names.sort()

alphabet = '"ABCDEFGHIJKLMNOPQRSTUVWXYZ'

def nameVal(name):
    total = 0
    for letter in name:
        letterVal = alphabet.index(letter)
        total += letterVal
    return(total * (names.index(name) + 1))

def main(lst):
    finalVals = list(map(nameVal, lst))
    return(sum(finalVals))

print(main(names))

# 871198282