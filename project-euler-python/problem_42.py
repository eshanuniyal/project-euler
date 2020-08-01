# ---------------------------------------------------------------
# Project Euler Problem 42 | Eshan Uniyal
# January 2018, Python 3
# The nth term of the sequence of triangle numbers is given by, tn = (1/2)n(n+1); so the first ten triangle numbers are:
# 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
# By converting each letter in a word to a number corresponding to its alphabetical position and adding these values we form a word value.
# For example, the word value for SKY is 19 + 11 + 25 = 55 = t10.
# If the word value is a triangle number then we shall call the word a triangle word.
# Using a 16K text file containing nearly two-thousand common English words, how many are triangle words?

# ---------------------------------------------------------------

import timer



wordsImport = open("Supporting texts\\Problem 42.txt", "r")
words = wordsImport.read().split(',')
alphabet = '"ABCDEFGHIJKLMNOPQRSTUVWXYZ'

def main():
    lettervals = {}
    for letter in alphabet:
        letterval = alphabet.index(letter)
        lettervals[letter] = letterval

    wordvals = []
    for word in words:
        wordval = 0
        for letter in word:
            wordval += lettervals[letter]
        wordvals.append(wordval)

    limit = max(wordvals)

    triangles = [1]
    i = 2
    while max(triangles) < limit:
        triangle = int((1 / 2) * i * (i + 1))
        triangles.append(triangle)
        i += 1

    count = 0
    for wordval in wordvals:
        if wordval in triangles:
            count += 1
    return(count)

timer.start()
print(main())
timer.end()