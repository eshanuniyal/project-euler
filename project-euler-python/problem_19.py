# ---------------------------------------------------------------
# Project Euler Problem 19 | Eshan Uniyal
# November 2017, Python 3
# How many Sundays fell on the first of the month during
#   the twentieth century (1 Jan 1901 to 31 Dec 2000)?
# Given:
#     1 Jan 1900 was a Monday.
#     September, April, June and November have 30 days
#     February has 28, 29 during leap years
#     All the rest have 31
# Leap year: All years divisible by four, minus years divisible by hundred plus years divisible by 400
# Non-leap year: All years non-divisible by four plus years divisible by hundred minus years divisible by 400
# ---------------------------------------------------------------

import timer



years = [x for x in range(1900, 2001)]
    # creates a list of years from 1900 to 2001 (1900 because Jan 1 1900 is given to be Monday)
months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]  # list of months
weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]  # list of years


def main(years):
    cal = []  # empty list to story calendar dates

    for year in years:  # cycles through each year in range to test for leap and execute accordingly
        if year % 4 == 0 and (year % 100 != 0 or year % 400 == 0):  # test for leap years
            mdays = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30,
                     31]  # defines number of days in each month with 29 in Feb
        else:  # test for leap year
            mdays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30,
                     31]  # mdays defined differently because non-leap year, rest remains the same
        for month in months:
            i = months.index(month) # assigns i the index value of each month
            ndays = mdays[i] # uses previously assigned i to calculate corresponding number of days from mdays
            listndays = [x for x in range(1, ndays + 1)] # creates a list of all days (1, 2, 3...) in the month
            for day in listndays: # cycles through days 1, 2, 3...
                cal.append(str(day) + " " + month + " " + str(year)) # appends to calendar a full date ex. 1 Jan 1900

    cal = cal[365:]  # removes the dates from the first year (1900) from the list, as problem asks to start at Jan 1901
    calendarDays = {}  # creates an empty dictionary to host all dates (1 Apr 1990) and days (Sunday)
    i = 365  # i starts at 365 so as to accommodate for having skipped 1900 (which has 365 days as a non-leap year)

    for date in cal:
        dayIndex = i % 7  # calculates remainder of i when divided by 7
        calendarDays[date] = weekdays[dayIndex]  # assigns a weekday to each date basis i
        i += 1  # i += 1 ensures days are cycled through (Monday, Tuesday, Wednesday...)

    firstSundays = {}  # creates an empty dictionary to host all dates that are Sundays

    for key, value in calendarDays.items():  # cycles through calendarDays
        if value == "Sun" and key[0] == "1" and key[1] == " ":  # checks value of each key for "Sun"
            firstSundays[key] = value
                # appends key-value pairs where value is "Sun" and key starts with "1 " to firsTsundays

    print("The number of Sundays that fall on the first of the month during the twentieth century is %s. " % (
    len(firstSundays)))  # calculates and prints number of such Sundays


timer.start()
main(years)
timer.end()