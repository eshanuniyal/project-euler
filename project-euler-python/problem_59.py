# ---------------------------------------------------------------
# Project Euler Problem 59 | Eshan Uniyal
# April 2018, Python 3
# Each character on a computer is assigned a unique code and the preferred standard is ASCII (American Standard Code
#   for Information Interchange). For example, uppercase A = 65, asterisk (*) = 42, and lowercase k = 107.
# A modern encryption method is to take a text file, convert the bytes to ASCII, then XOR each byte with a given value,
#   taken from a secret key. The advantage with the XOR function is that using the same encryption key on the cipher text,
#   restores the plain text; for example, 65 XOR 42 = 107, then 107 XOR 42 = 65.
# For unbreakable encryption, the key is the same length as the plain text message, and the key is made up of random bytes.
#   The user would keep the encrypted message and the encryption key in different locations, and without both "halves",
#   it is impossible to decrypt the message.
# Unfortunately, this method is impractical for most users, so the modified method is to use a password as a key.
#   If the password is shorter than the message, which is likely, the key is repeated cyclically throughout the message.
#   The balance for this method is using a sufficiently long password key for security, but short enough to be memorable.
# Your task has been made easy, as the encryption key consists of three lower case characters.
#   Using cipher.txt, a file containing the encrypted ASCII codes, and the knowledge that the plain text must contain
#   common English words, decrypt the message and find the sum of the ASCII values in the original text.
# ---------------------------------------------------------------

import timer



encryptedImport = open("Supporting texts\\Problem 59.txt", "r")
encrypted = encryptedImport.read().split(",")
encrypted = [int(string) for string in encrypted]


def xor(key, message):
    """function that takes a binary string as input key and another binary string as input message and XORs message with said key"""

    # to find output
    output = ""
    for i in range(0, len(message)):
        if message[i] == key[i]:  # if 0, 0 or 1, 1, XOR = False
            output += "0"
        else:  # if 0, 1 or 1, 0, XOR = True
            output += "1"

    return(output)


def main(to_decipher):
    """function to decipher encrypted input, given key consists of three lower-case letters"""
    alphabet = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u',
                'v', 'w', 'x', 'y', 'z']
    possibleKeys = [alphabet[x] + alphabet[y] + alphabet[z] for x in range(0, 26) for y in range(0, 26) for z in
                    range(0, 26)]

    # to create a dictionary of all possible keys and their associated binary values
    possibleKeysDict = {}
    for key in possibleKeys:
        possibleKeysDict[key] = []
        for char in key:
            charBin = str(bin(ord(char)))[2:]
            while len(charBin) < 8:  # to convert all binary numbers to 8-bits
                charBin = "0" + charBin
            possibleKeysDict[key].append(charBin)

    decryptions = {} # dictionary to store key, message pairs already decrypted

    for key, binKey in possibleKeysDict.items():
        decryptedList = []
        i = 0 # function to store listIndex
        for val in to_decipher:
            if (key[i], val) in decryptions:
                decryptedList.append((decryptions[key[i], val]))
            else:
                binVal = str(bin(val))[2: ]
                while len(binVal) != 8:
                    binVal = '0' + binVal
                valKey = binKey[i]
                decryptedValASCII = int(xor(valKey, binVal), 2)
                decryptedVal = chr(decryptedValASCII)
                decryptedList.append(decryptedVal)
                decryptions[(key[i], val)] = decryptedVal
            i = (i + 1) % 3

        alphaCount = 0
        for item in decryptedList:
            if item.isalpha() == True or item == " ":
                alphaCount += 1
        alphaPercentage = alphaCount / len(to_decipher) * 100
        if alphaPercentage > 90:
            total = 0
            for item in decryptedList:
                total += ord(item)
            print(key, total)


timer.start()
main(encrypted)
timer.end()
