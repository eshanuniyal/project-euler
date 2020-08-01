# ---------------------------------------------------------------
# Timer Program | Eshan Uniyal
# November 2017, Python 3 | Updated Decemebr 2018
# A simple function to time other programs
# Refers to main timer file in general_programs
# ---------------------------------------------------------------

# reference to original timer program
import sys

sys.path.append('C:\\Users\\eshan\\Desktop\\python_projects')

from general_programs import timer

def start():
    timer.start()
def end():
    timer.end()

# use following syntax to print runtime of main() in some other Python file:
# timer.start()
# main()
# timer.end()