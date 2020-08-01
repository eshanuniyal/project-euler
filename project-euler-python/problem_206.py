# ---------------------------------------------------------------
# Project Euler Problem 206 | Eshan Uniyal
# February 2018, Python 3
# Find the unique positive integer whose square has the form 1_2_3_4_5_6_7_8_9_0,
#   where each “_” is a single digit.
# ---------------------------------------------------------------

import timer



def main():
    i = 10 ** 9
    ans = 0
    while ans == 0: # and i < limit:
        strsq = str(i ** 2)
        if strsq[0] == "1" and strsq[2] == "2" and strsq[4] == "3" and strsq[6] == "4" and strsq[8] == "5" and \
                strsq[10] == "6" and strsq[12] == "7" and strsq[14] == "8" and strsq[16] == "9" and strsq[18] == "0":
                ans = i
        i += 1
    return(ans)

timer.start()
print(main())
timer.end()