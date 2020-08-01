# ---------------------------------------------------------------
# Project Euler Problem 98 | Eshan Uniyal
# January 2018, Python 3
# By replacing each of the letters in the word CARE with 1, 2, 9, and 6 respectively, we form a square number: 1296 = 362.
# What is remarkable is that, by using the same digital substitutions, the anagram, RACE, also forms a square number:
# 9216 = 962. We shall call CARE (and RACE) a square anagram word pair and specify further that leading zeroes are not permitted,
# neither may a different letter have the same digital value as another letter.

# Using words.txt (right click and 'Save Link/Target As...'), a 16K text file containing nearly two-thousand common English words,
# find all the square anagram word pairs (a palindromic word is NOT considered to be an anagram of itself).
# What is the largest square number formed by any member of such a pair?
# NOTE: All anagrams formed must be contained in the given text file.
# ---------------------------------------------------------------

import timer



wordsImport = open("Supporting texts\\Problem 98.txt", "r")
words = wordsImport.read().split(',')
words.sort()

finalWords = []
for word in words:
    finalWords.append(word[1: len(word) - 1])

def isSquare(num):
    if (num ** 0.5) % 1 == 0:
        return(True)
    else:
        return(False)

def main(words):
    print("Running...")
    anagrams = []
    for word1 in words:
        word1_index = words.index(word1)
        for word2 in words[word1_index + 1: ]:
            if len(word1) == len(word2):
                condition = True
                for letter in word1:
                    count = word1.count(letter)
                    if word2.count(letter) != count:
                        condition = False
                        break
                if condition == True: #and len(word1) < 6: # SECOND CONDITION TO BE REMOVED
                    anagrams.append([word1, word2])

    wordlens = []
    for pair in anagrams:
        wordlens.append(len(pair[0]))
    maxlen = max(wordlens)
    squares = [1]
    limit = 10 ** maxlen
    i = 2
    while squares[-1] < limit:
        squares.append(i ** 2)
        i += 1

    squaresDict = {}
    for i in range(1, maxlen + 1):
        validSquares = []
        for square in squares:
            if len(str(square)) == i:
                validSquares.append(square)
        squaresDict[i] = validSquares
    # print(squaresDict)

    anagramSquares = {}
    for key, value in squaresDict.items():
        sqAnagrams = []
        for square1 in value:
            square1_index = value.index(square1)
            for square2 in value[square1_index + 1:]:
                condition = True
                for digit in str(square1):
                    count = str(square1).count(digit)
                    if str(square2).count(digit) != count:
                        condition = False
                        break
                if condition == True:
                    sqAnagrams.append([square1, square2])
        # print(sqAnagrams)
        # print(len(sqAnagrams))
        anagramSquares[key] = sqAnagrams

    answers = {}

    for pair in anagrams:
        word1 = pair[0]
        word2 = pair[1]
        length = len(word1)
        letters = []
        for letter in word1:
            if letter not in letters:
                letters.append(letter)
        lettercounts = []
        for letter in letters:
            lettercounts.append(word1.count(letter))
        lettercounts.sort()

        potentials = []

        for squareset in anagramSquares[length]:
            square1 = squareset[0]
            digits = []

            for digit in str(square1):
                if int(digit) not in digits:
                    digits.append(int(digit))
            digitcounts = []

            for digit in digits:
                digitcounts.append(str(square1).count(str(digit)))
            digitcounts.sort()

            if digitcounts == lettercounts:
                potentials.append(squareset)
        print(word1, word2, potentials)

        lettercounts = {}
        for letter in word1:
            lettercounts[letter] = word1.count(letter)
        singleletters = []
        doubleletters = []
        tripleletters = []
        for key, value in lettercounts.items():
            if value == 1:
                singleletters.append(key)
            elif value == 2:
                doubleletters.append(key)
            elif value == 3:
                tripleletters.append(key)
        singleLen = len(singleletters)
        doubleLen = len(doubleletters)
        tripleLen = len(tripleletters)

        for squareset in potentials:
            for square in squareset:
                square1 = square
                square1index = squareset.index(square)
                if square1index == 0:
                    square2index = 1
                else:
                    square2index = 0
                square2 = squareset[square2index]

                digits = []
                for digit in str(square1):
                    if int(digit) not in digits:
                        digits.append((int(digit)))
                digitcounts = {}
                for digit in digits:
                    digitcounts[digit] = str(square1).count(str(digit))

                singledigits = []
                doubledigits = []
                tripledigits = []

                for key, value in digitcounts.items():
                    if value == 1:
                        singledigits.append(key)
                    elif value == 2:
                        doubledigits.append(key)
                    elif value == 3:
                        doubledigits.append(key)

                index = {}
                for i in range(0, singleLen):
                    index[singleletters[i]] = singledigits[i]
                for i in range(0, doubleLen):
                    index[doubleletters[i]] = doubledigits[i]
                for i in range(0, tripleLen):
                    index[tripleletters[i]] = tripledigits[i]

                value1str = ""
                value2str = ""

                for letter in word1:
                    value1str += str(index[letter])
                for letter in word2:
                    value2str += str(index[letter])

                value1 = int(value1str)
                value2 = int(value2str)

                if value1 and value2 in squareset and isSquare(value1) == True and isSquare(value2) == True:
                    answers[word1, word2] = [value1, value2]
    print(answers)
    maximum = 0
    for key, value in answers.items():
        for square in value:
            if square > maximum:
                maximum = square

    return(maximum)

timer.start()
print(main(finalWords))
timer.end()