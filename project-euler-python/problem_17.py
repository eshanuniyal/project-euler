# ---------------------------------------------------------------
# Project Euler Problem 17 | Eshan Uniyal
# January 2018, Python 3
# If the numbers 1 to 5 are written out in words: one, two, three, four, five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.
# If all the numbers from 1 to 1000 (one thousand) inclusive were written out in words, how many letters would be used?
# NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and forty-two) contains 23 letters and 115
#   (one hundred and fifteen) contains 20 letters. The use of "and" when writing out numbers is in compliance with British usage.
# ---------------------------------------------------------------

import timer



def main():
    dict = {}
    representations = {1 : "one", 2 : "two", 3 : "three", 4 : "four", 5 : "five", 6 : "six", 7 : "seven", 8 : "eight", 9 : "nine",
              10 : "ten", 11 : "eleven", 12 : "twelve", 13 : "thirteen", 14 : "fourteen", 15 : "fifteen", 16 : "sixteen",
              17 : "seventeen", 18 : "eighteen", 19 : "nineteen", 20 : "twenty", 30 : "thirty", 40 : "forty", 50 : "fifty",
              60 : "sixty", 70 : "seventy", 80 : "eighty", 90 : "ninety", 100 : "hundred", 1000 : "thousand"}
    total = 0

    for i in range(1, 1001):
        if i <= 20:
            wordrep = representations[i]
        elif i > 10 and i < 100:
            j = i % 10
            if j == 0:
                wordrep = representations[i]
            else:
                wordrep = representations[i - j] + "-" + representations[j]
        elif i >= 100 and i < 1000:
            j = i % 100 # last two digits
            k = j % 10 # last digit
            if j == 0:
                wordrep = representations[i / 100] + " " + representations[100]
            else:
                if k == 0:
                    wordrep = representations[(i - j) / 100] + " " + representations[100] +  " and " + representations[j]
                elif j <= 20:
                    wordrep = representations[(i - j) / 100] + " " + representations[100] + " and " + representations[j]
                else:
                    wordrep = representations[(i - j) / 100] + " " + representations[100] + " and " + representations[j - k] + "-" + representations[k]
        else:
            wordrep = "one thousand"
        dict[i] = wordrep
        # print(i, wordrep)

    onelongword = ""
    for key, value in dict.items():
        for letter in value:
            if letter != " " and letter != "-":
                onelongword += (letter)
    return(len(onelongword))

timer.start()
print("The length of all concatenated strings of names of numbers from 0 to 100 is %s." % main())
timer.end()