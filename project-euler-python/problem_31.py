# ---------------------------------------------------------------
# Project Euler Problem 31 | Eshan Uniyal
# January 2018, Python 3
# In England the currency is made up of pound, £, and pence, p, and there are eight coins in general circulation:
#     1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p).
# It is possible to make £2 in the following way:
#     1×£1 + 1×50p + 2×20p + 1×5p + 1×2p + 3×1p
# How many different ways can £2 be made using any number of coins?
# ---------------------------------------------------------------

import timer



def main():
    ways = []
    total = 0
    for num1p in range(0, 200 + 1):
        total = num1p * 1

        for num2p in range(0, int(((200 - total)/ 2)) + 1):
            total = num1p * 1 + num2p * 2

            for num5p in range(0, int((200 - total)/5) + 1):
                total = num1p * 1 + num2p * 2 + num5p * 5

                for num10p in range(0, int((200 - total)/10) + 1):
                    total = num1p * 1 + num2p * 2 + num5p * 5 + num10p * 10

                    for num20p in range(0, int((200 - total)/20) + 1):
                        total = num1p * 1 + num2p * 2 + num5p * 5 + num10p * 10 + num20p * 20

                        for num50p in range(0, int((200 - total)/50) + 1):
                            total = num1p * 1 + num2p * 2 + num5p * 5 + num10p * 10 + num20p * 20 + num50p * 50

                            for num100p in range(0, int((200 - total)/100) + 1):
                                total = num1p * 1 + num2p * 2 + num5p * 5 + num10p * 10 + num20p * 20 + num50p * 50 + num100p * 100

                                for num200p in range(0, int((200 - total)/100) + 1):
                                    total = num1p * 1 + num2p * 2 + num5p * 5 + num10p * 10 + num20p * 20 + num50p * 50 + num100p * 100 + num200p * 200

                                    if total == 200:
                                        way = [num1p, num2p, num5p, num10p, num20p, num50p, num100p, num200p]
                                        ways.append(way)
    return(len(ways))

timer.start()
print(main())
timer.end()