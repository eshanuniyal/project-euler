# ---------------------------------------------------------------
# Project Euler Problem 79 | Eshan Uniyal
# February 2018, Python 3
# A common security method used for online banking is to ask the user for three random characters from a passcode.
#   For example, if the passcode was 531278, they may ask for the 2nd, 3rd, and 5th characters; the expected reply would be: 317.
# The text file, keylog.txt, contains fifty successful login attempts.
# Given that the three characters are always asked for in order, analyse the file so as to determine the shortest
# possible secret passcode of unknown length.
# ---------------------------------------------------------------

import timer



loginsImport = open("Supporting texts\\Problem 79.txt", "r")
logins = loginsImport.read().split('\n')

def brute(): # brute force algorithm, slow
    characters = []
    for login in logins:
        for char in login:
            if char not in characters:
                characters.append(char)
    characters.sort()

    condition = False
    i = 1
    while condition == False:
        potential = str(i)
        potentialChars = []
        for char in potential:
            if char not in potentialChars:
                potentialChars.append(char)
        potentialChars.sort()
        if potentialChars == characters:
            condition = True
            for login in logins:
                char1 = login[0]
                char2 = login[1]
                char3 = login[2]
                if potential.index(char1) < potential.index(char2) and potential.index(char2) < potential.index(char3):
                    pass
                else:
                    condition = False
                    i += 1
                    break
        else:
            i += 1
    return(i)

def main():
    index = {}
    for login in logins:
        for char in login:
            if char not in index:
                index[char] = []

    for login in logins:
        for char in login:
            charIndex = login.index(char)
            for i in range(charIndex + 1, 3):
                if login[i] not in index[char]:
                    index[char].append(login[i])

    ans = ""
    maxlen = 0
    for key, value in index.items():
        if len(value) > maxlen:
            maxlen = len(value)

    for i in range(maxlen, -1, -1):
        for key, value in index.items():
            if len(value) == i:
                ans += key
    return(ans)

timer.start()
print(main())
timer.end()