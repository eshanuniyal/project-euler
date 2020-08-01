# ---------------------------------------------------------------
# Project Euler Problem 100 | Eshan Uniyal
# May 2018, Python 3
# If a box contains twenty-one coloured discs, composed of fifteen blue discs and six red discs, and two discs were
#   taken at random, it can be seen that the probability of taking two blue discs, P(BB) = (15/21)×(14/20) = 1/2.
# The next such arrangement, for which there is exactly 50% chance of taking two blue discs at random, is a box
#   containing eighty-five blue discs and thirty-five red discs.
# By finding the first arrangement to contain over 10^12 = 1,000,000,000,000 discs in total, determine the number of
#   blue discs that the box would contain.
# ---------------------------------------------------------------

import timer



floor = 10 ** 12

def brute_force(low_t): # takes too long
    low_b = int((1 + 2*(low_t**2 - low_t)) ** 0.5) // 2
    print(low_b)
    root_2 = 2 ** 0.5

    condition, b = False, low_b
    while condition == False:
        t = int(b * root_2)
        print(t)
        if t % 4 == 0 or (t - 1) % 4 == 0:
            # print(b, t)
            if 2*b * (b - 1) == t * (t - 1):
                print(b, t)
                # return(b, t)
        b += 1

def main(low_t): # based on Dario Alpern's Generic two-integer equation solver
    bt_pairs = [[15, 21]]

    while bt_pairs[-1][1] < low_t:
        old_b = bt_pairs[-1][0]
        old_t = bt_pairs[-1][1]
        new_b = 3*old_b + 2*old_t - 2
        new_t = 4*old_b + 3*old_t - 3
        bt_pairs.append([new_b, new_t])
     return(bt_pairs[-1])



timer.start()
print(main(floor))
timer.end()
