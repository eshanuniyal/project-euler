# ---------------------------------------------------------------
# Project Euler Problem 80 | Eshan Uniyal
# March 2018, Python 3
# In the game Monopoly,
# A player starts on the GO square and adds the scores on two 6-sided dice to determine the number of squares they
#   advance in a clockwise direction. Without any further rules we would expect to visit each square with equal
#   probability: 2.5%. However, landing on G2J (Go To Jail), CC (community chest), and CH (chance) changes this distribution.
# In addition to G2J, and one card from each of CC and CH, that orders the player to go directly to jail, if a player
#   rolls three consecutive doubles, they do not advance the result of their 3rd roll. Instead they proceed directly to jail.
# At the beginning of the game, the CC and CH cards are shuffled. When a player lands on CC or CH they take a card from
#   the top of the respective pile and, after following the instructions, it is returned to the bottom of the pile.
#   There are sixteen cards in each pile, but for the purpose of this problem we are only concerned with cards that
#   order a movement; any instruction not concerned with movement will be ignored and the player will remain on the
#   CC/CH square.
    #     Community Chest (2/16 cards):
    #         Advance to GO
    #         Go to JAIL
    #     Chance (10/16 cards):
    #         Advance to GO
    #         Go to JAIL
    #         Go to C1
    #         Go to E3
    #         Go to H2
    #         Go to R1
    #         Go to next R (railway company)
    #         Go to next R
    #         Go to next U (utility company)
    #         Go back 3 squares.
# The heart of this problem concerns the likelihood of visiting a particular square. That is, the probability of
#   finishing at that square after a roll. For this reason it should be clear that, with the exception of G2J for
#   which the probability of finishing on it is zero, the CH squares will have the lowest probabilities, as 5/8 request
#   a movement to another square, and it is the final square that the player finishes at on each roll that we are
#   interested in. We shall make no distinction between "Just Visiting" and being sent to JAIL, and we shall also
#   ignore the rule about requiring a double to "get out of jail", assuming that they pay to get out on their next turn.
# By starting at GO and numbering the squares sequentially from 00 to 39 we can concatenate these two-digit numbers
#   to produce strings that correspond with sets of squares.
# Statistically it can be shown that the three most popular squares, in order, are JAIL (6.24%) = Square 10,
#   E3 (3.18%) = Square 24, and GO (3.09%) = Square 00. So these three most popular squares can be listed with the
#   six-digit modal string: 102400.
# If, instead of using two 6-sided dice, two 4-sided dice are used, find the six-digit modal string.
# ---------------------------------------------------------------

import timer
from random import randint



rolls = 10 ** 6

def roll():
    """function to generate roll of dice"""
    moves, condition = [], True
        # moves is a list to store the moves
        # condition stores whether there's a need to roll again
    while condition == True and len(moves) != 3:
        d1, d2 = randint(1, 4), randint(1, 4)
        moves.append(d1 + d2)
        if d1 != d2:
            condition = False # terminates rolling of dice
        if len(moves) == 3 and d1 == d2:
            moves[2] = "G2J" # changes third move to "Go to Jail" if three doubles are rolled
    return(moves)

def cChest(cChestCards):
    # function that computes output of community chest
    odds = randint(1, 16)
    if odds <= 2: # if number from random generator is 1 or 2; effectively simulates chance
        # community chest having a move card 2/16
        to_return = cChestCards[0] # selects card at the top of the pile
        cChestCards.remove(to_return) # to shift to_return from the top of the pile to the bottom of the pile
        cChestCards.append(to_return)
        return(to_return)
    else:
        return(None)

def chance(chanceCards):
    # function that computes output of community chest
    odds = randint(1, 16)
    if odds <= 10: # if number from random generator is between 1 and 10; effectively simulates chance
        # chance having a move card has probability 10/16
        to_return = chanceCards[0] # selects card at the top of the pile
        chanceCards.remove(to_return) # to shift to_return from the top of the pile to the bottom of the pile
        chanceCards.append(to_return)
        return(to_return)
    else:
        return(None)


def main(nRolls):
    positions = {0: "GO", 1: "A1", 2: "CC1", 3: "A2", 4: "T1", 5: "R1", 6: "B1", 7: "CH1", 8: "B2", 9: "B3", 10: "JAIL",
                 11: "C1", 12: "U1", 13: "C2", 14: "C3", 15: "R2", 16: "D1", 17: "CC2", 18: "D2", 19: "D3", 20: "FP",
                 21: "E1", 22: "CH2", 23: "E2", 24: "E3", 25: "R3", 26: "F1", 27: "F2", 28: "U2", 29: "F3", 30: "G2J",
                 31: "G1", 32: "G2", 33: "CC3", 34: "G3", 35: "R4", 36: "CH3", 37: "H1", 38: "T2", 39: "H2"}

    landCount = {x : 0 for x in range(0, 40)}

    cChestCards = ['GO', 'JAIL'] # two out of sixteen cards
    chanceCards = ['GO', 'JAIL', 'C1', 'E3', 'H2', 'R1', 'R', 'R', 'U', -3] # ten out of sixteen cards
        # R = next railway station
        # U = next utility
        # -3 = go back three spaces

    currentPos = 0

    for turn in range(0, nRolls):
        moves = roll() # stores the moves the player has to make

        for move in moves:
            if move == "G2J":  # when three doubles are rolled
                currentPos = 10
                landCount[10] += 1
            else:
                if moves.index(move) == len(moves) - 1:
                    condition = True # it's the last move
                else:
                    condition = False # it's not the last move

                currentPos += move # move forward "move" spaces
                currentPos = currentPos % 40 # necessary condition, else currentPos exceeds 39
                if condition == True:
                    landCount[currentPos] += 1 # add one to landCount

                if positions[currentPos] == "G2J":  # if landed on "Go to Jail"
                    currentPos = 10
                    if condition == True:
                        landCount[10] += 1

                elif "CC" in positions[currentPos]: # if first two letters of currentPos key are CC, then land on community chest
                    next = cChest(cChestCards)
                    if next != None:
                        if next == "GO":
                            currentPos = 0
                            if condition == True:
                                landCount[0] += 1
                        elif next == "JAIL":
                            currentPos = 10
                            if condition == True:
                                landCount[10] += 1

                elif "CH" in positions[currentPos]:
                    next = chance(chanceCards)
                    if next != None:
                        if next == -3: # if chance function returns - 3, go back three spaces
                            currentPos -= 3
                            if condition == True:
                                landCount[currentPos] += 1
                        elif next == "R": # if chance function returns 'R', go to next railway station
                            for i in range(currentPos, 40):
                                if i == 6 or i == 16 or i == 26 or i == 36: # condition for i = index of next railway station
                                    currentPos = i
                                    if condition == True:
                                        landCount[currentPos] += 1
                                    break
                        elif next == "U":  # if chance function returns 'U', go to next utility
                            for i in range(currentPos, 40): # condition for i = index of next utility
                                if i == 12 or i == 28:
                                    currentPos = i
                                    if condition == True:
                                        landCount[currentPos] += 1
                                    break
                        else: # condition for possibilities 'GO', 'JAIL', 'C1', 'E3', 'H2', 'R1'
                            for position, value in positions.items():
                                if value == next: # if value in given dictionary corresponding a
                                        # certain key equals next, then said key is the position when moved
                                    currentPos = position
                                    if condition == True:
                                        landCount[currentPos] += 1

    landPercentages = {} # dictionary to store position : landPercentage
    allPercentages = [] # list to store land percentages
    for position, count in landCount.items():
        landPercentages[position] = count * 100 / nRolls
        allPercentages.append(count * 100 / nRolls)
    allPercentages.sort(reverse = True) # sorts the list in reverse, effectively sorting from highest to lowest

    ans = ""
    for percentage in allPercentages[0: 3]:
        for position, value in landPercentages.items():
            if value == percentage:
                if len(str(position)) == 1:
                    ans += "0" + str(position) # if the modal position is, say, 8, we want to add "08" to the string and not "8"
                else:
                    ans += str(position)

    return(ans)

timer.start()
print(main(rolls))
timer.end()