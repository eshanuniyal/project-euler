# ---------------------------------------------------------------
# Project Euler Problem 89 | Eshan Uniyal
# February 2018, Python 3
# For a number written in Roman numerals to be considered valid there are basic rules which must be followed.
#   Even though the rules allow some numbers to be expressed in more than one way there is always a "best" way of writing a particular number.
# For example, it would appear that there are at least six ways of writing the number sixteen:
    # IIIIIIIIIIIIIIII
    # VIIIIIIIIIII
    # VVIIIIII
    # XIIIIII
    # VVVI
    # XVI
# However, according to the rules only XIIIIII and XVI are valid, and the last example is considered to be the most efficient,
#   as it uses the least number of numerals.
# The 11K text file, roman.txt (right click and 'Save Link/Target As...'), contains one thousand numbers written in valid,
#   but not necessarily minimal, Roman numerals; see About... Roman Numerals for the definitive rules for this problem.
# Find the number of characters saved by writing each of these in their minimal form.
# Note: You can assume that all the Roman numerals in the file contain no more than four consecutive identical units.
# RULES: https://projecteuler.net/about=roman_numerals
# ---------------------------------------------------------------

import timer


numerals = {1 : "I", 5 : "V", 10 : "X", 50 : "L", 100 : "C", 500 : "D", 1000 : "D"}

numeralsImport = open("Supporting texts\\Problem 89.txt", "r")
numerals = numeralsImport.read().split('\n')
# print(numerals)

def roman(num): # function to convert parameter num into a Roman Numeral
    roman = ""
    current = num
    # 1000 +
    if current >= 1000:
        roman += "M" * int(((current - (current % 1000)) / 1000))
    current = current % 1000
    # 100 - 1000
    if current >= 100:
        if current < 400:
            roman += "C" * int(((current - (current % 100)) / 100))
        elif current >= 400 and current < 500:
            roman += "CD"
        elif current >= 500 and current < 900:
            roman += "D"
            current = current % 500
            if current >= 100:
                roman += "C" * int(((current - (current % 100)) / 100))
        elif current >= 900:
            roman += "CM"
        current = current % 100
    # 10 - 100
    if current >= 10:
        if current < 40:
            roman += "X" * int(((current - (current % 10)) / 10))
        elif current >= 40 and current < 50:
            roman += "XL"
        elif current >= 50 and current < 90:
            roman += "L"
            current = current % 50
            if current >= 10:
                roman += "X" * int(((current - (current % 10)) / 10))
        elif current >= 90:
            roman += "XC"
            current = current % 10
        current = current % 10
    # 0 - 10
    if current >= 0:
        if current < 4:
            roman += "I" * current
        elif current == 4:
            roman += "IV"
        elif current > 4 and current < 9:
            roman += "V"
            current = current % 5
            if current >= 1:
                roman += "I" * current
        elif current == 9:
            roman += "IX"
    return(roman)

def arabic(num):
    arabic = 0
    characters = []
    for char in num:
        characters.append(char)
    if "M" in characters:
        if "XM" not in num:
            countM = characters.count("M")
            arabic += 1000 * countM
            for i in range(0, countM):
                characters.remove("M")
        elif "XM" in num:
            countC = characters.count("M") - 1
            arabic += 1000 * countM
            for i in range(0, countM):
                characters.remove("M")
            arabic += 900
            characters.remove("X")
            characters.remove("M")
    if "D" in characters:
        if "CD" not in num:
            countD = characters.count("D")
            arabic += 500 * countD
            for i in range(0, countD):
                characters.remove("D")
        elif "CD" in num:
            countD = characters.count("D") - 1
            arabic += 500 * countD
            for i in range(0, countD):
                characters.remove("D")
            arabic += 400
            characters.remove("C")
            characters.remove("D")
    if "C" in characters:
        if "XC" not in num:
            countC = characters.count("C")
            arabic += 100 * countC
            for i in range(0, countC):
                characters.remove("C")
        elif "XC" in num:
            countC = characters.count("C") - 1
            arabic += 100 * countC
            for i in range(0, countC):
                characters.remove("C")
            arabic += 90
            characters.remove("X")
            characters.remove("C")
    if "L" in characters:
        indexL = characters.index("L")
        if indexL == 0:
            arabic += 50
            characters.remove("L")
        elif characters[0] == "X":
            arabic += 40
            characters.remove("X")
            characters.remove("L")
    if "X" in characters:
        if "IX" not in num:
            countX = characters.count("X")
            arabic += 10 * countX
            for i in range(0, countX):
                characters.remove("X")
        elif "IX" in num:
            countX = characters.count("X") - 1
            arabic += 10 * countX
            for i in range(0, countX):
                characters.remove("X")
            arabic += 9
            characters.remove("I")
            characters.remove("X")
    if "V" in characters:
        indexV = characters.index("V")
        if indexV == 0:
            arabic += 5
            characters.remove("V")
        elif characters[0] == "I":
            arabic += 4
            characters.remove("I")
            characters.remove("V")
    if "I" in characters:
        countI = characters.count("I")
        arabic += 1 * countI
        for i in range(0, countI):
            characters.remove("I")
    return(arabic)

def main():
    romanCount = 0
    optimisedCount = 0
    for numeral in numerals:
        romanCount += len(numeral)
        optimisedCount += len(roman(arabic(numeral)))
    return(romanCount - optimisedCount)

def alt(): # much simpler than the conversion algorithm; would've gone with this,
    # but wanted to see if I can write a program to generate arabic in to roman numerals and vice-versa
    diff = 0

    for numeral in numerals:
        if "VIIII" in numeral:
            diff += 3
        elif "IIII" in numeral:
            diff += 2
        if "LXXXX" in numeral:
            diff += 3
        elif "XXXX" in numeral:
            diff += 2
        if "DCCCC" in numeral:
            diff += 3
        elif "CCCC" in numeral:
            diff += 2

    return(diff)

timer.start()
print(main())
timer.end()