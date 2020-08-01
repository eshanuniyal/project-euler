# ---------------------------------------------------------------
# Project Euler Problem 54 | Eshan Uniyal
# January 2018, Python 3
# In the card game poker, a hand consists of five cards and are ranked, from lowest to highest, in the following way:
#
#     High Card: Highest value card.
#     One Pair: Two cards of the same value.
#     Two Pairs: Two different pairs.
#     Three of a Kind: Three cards of the same value.
#     Straight: All cards are consecutive values.
#     Flush: All cards of the same suit.
#     Full House: Three of a kind and a pair.
#     Four of a Kind: Four cards of the same value.
#     Straight Flush: All cards are consecutive values of same suit.
#     Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.
#
# The cards are valued in the order:
# 2, 3, 4, 5, 6, 7, 8, 9, 10, Jack, Queen, King, Ace.
#
# If two players have the same ranked hands then the rank made up of the highest value wins;
# for example, a pair of eights beats a pair of fives. But if two ranks tie, for example, both players have a pair of
# queens, then highest cards in each hand are compared ; if the highest cards tie then the next highest cards are compared, and so on.
# The file, poker.txt, contains one-thousand random hands dealt to two players.
# Each line of the file contains ten cards (separated by a single space):
# the first five are Player 1's cards and the last five are Player 2's cards.
# You can assume that all hands are valid (no invalid characters or repeated cards), each player's hand is in no specific order,
# and in each hand there is a clear winner.
#
# How many hands does Player 1 win?
# ---------------------------------------------------------------

import time



games1Import = open("Supporting texts\\Problem 54.txt", "r")
games1 = games1Import.read().split('\n')
games = []

for game in games1:
    game = game.split(' ')
    games.append(game)
games.pop(-1)

for game in games: #code to change all T, J, Q, K, A to 10, 11, 12, 13, 14
    for card in game:
        gameIndex = games.index(game)
        cardIndex = game.index(card)
        if card[0] == 'T':
            games[gameIndex][cardIndex] = '10' + card[1]
        elif card[0] == 'J':
            games[gameIndex][cardIndex] = '11' + card[1]
        if card[0] == 'Q':
            games[gameIndex][cardIndex] = '12' + card[1]
        if card[0] == 'K':
            games[gameIndex][cardIndex] = '13' + card[1]
        if card[0] == 'A':
            games[gameIndex][cardIndex] = '14' + card[1]

def main():
    wincount = 0 # creates a variable to store win count for player 1
    for game in games:

        vals = [] # list to store values generated for each hand in game
        hands = [game[0:5], game[5:10]] # distinguishes player one hand from that of player 2

        for hand in hands:
            nums = [] # stores the numbers of each card
            suits = [] # stores the suits of each card

            for card in hand:
                suits.append(card[-1]) # appends the last character of each card i.e. the suit to "suits"
                if len(card) == 2:
                    nums.append(int(card[0])) # appends the first character of each card i.e. range(0, 10) to "nums"
                else:
                    nums.append(int(card[0:2])) #appends the first two characters of each card i.e. range(10, 15) to "nums"
            # high card
            high = max(nums) # stores the highest card

            # pairs, three of a kind, four of a kind
            pairs = [] # stores the value of the pairs
            triplets = [] # stores the value of triplets, if any (maximum number of triplets is 1)
            quadruplets = [] # stores the value of quadruplets
            threeofakind = False
            fourofakind = False
            for num in nums:
                if nums.count(num) == 2 and num not in pairs:
                    pairs.append(num)
                if nums.count(num) == 3 and num not in triplets:
                    triplets.append(num)
                    threeofakind = True
                if nums.count(num) == 4 and num not in quadruplets:
                    quadruplets.append(num)
                    fourofakind = True
            onepair = False
            twopair = False
            if len(pairs) == 1:
                onepair = True
            elif len(pairs) == 2:
                twopair = True
            pairs.sort()

            # straight
            mincard = min(nums)
            straight = False
            count = 0
            for i in range(0, 5):
                if mincard + i in nums:
                    count += 1
            if count == 5:
                straight = True

            # flush
            flush = False
            for suit in suits:
                if suits.count(suit) == 5:
                    flush = True
                    break

            # full house
            fullhouse = False
            if triplets == True and onepair == True and triplets[0] != pairs[0]:
                fullhouse = True

            # straight flush
            straightflush = False
            if straight == True and flush == True:
                straightflush = True

            # royal flush
            royalflush = False
            if flush == True and [x for x in range(10, 15)] in nums:
                royalflush = True

            val = []
            if royalflush == True:
                val.append(10)
                val.append(0)
            elif straightflush == True:
                val.append(9)
                val.append(high)
            elif fourofakind == True:
                val.append(8)
                val.append(quadruplets[0])
            elif fullhouse == True:
                val.append(7)
                val.append(triplets[0])
            elif flush == True:
                val.append(6)
                val.append(high)
            elif straight == True:
                val.append(5)
                val.append(high)
            elif threeofakind == True:
                val.append(4)
                val.append(triplets[0])
            elif twopair == True:
                val.append(3)
                val.append(pairs[1])
                val.append(pairs[0])
                if high not in pairs:
                    val.append(high)
                else:
                    rem = nums
                    rem.remove(pairs[0])
                    rem.remove(pairs[1])
                    val.append(max(rem))
            elif onepair == True:
                val.append(2)
                val.append(max(pairs))
                if high not in pairs:
                    val.append(high)
                else:
                    rem = nums
                    rem.remove(pairs[0])
                    val.append(max(rem))
            else:
                val.append(1)
                val.append(high)
            vals.append(val)

        val1 = vals[0] # stores the value for player 1
        val2 = vals[1] # stores the value for player 2

        i = 0
        victor = 0  # stores the player number that wins
        while victor == 0:
            if val1[i] > val2[i]:
                victor = 1
                wincount += 1
            elif val1[i] < val2[i]:
                victor = 2
            else:
                i += 1  # i increased to reiterate and compare next important value

    return(wincount) # returns the win count for player 1

timer.start()
print(main())
timer.end()