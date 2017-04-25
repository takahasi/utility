#!/usr/bin/env python
# -*- coding: utf-8 -*-

""" script for generate process template directories

This is xxx
"""

def countrev():
    count = 0
    score = 0
    while True:
        try:
            s = raw_input().rstrip().split(',')
            difficulty = int(s[0])
            review = int(s[1])

            if difficulty == 4:
                score = score + 1
            elif difficulty == 5:
                score = score + 2
            elif difficulty == 6:
                score = score + 3
            elif difficulty == 7:
                score = score + 4
            elif difficulty == 8:
                score = score + 5
            elif difficulty == 9:
                score = score + 6
            elif difficulty == 10:
                score = score + 7

            if review == 1:
                score = score + 4
            elif review == 2:
                score = score + 3
            elif review == 3:
                score = score + 2
            elif review == 4:
                score = score + 1

            count = count + 1

        except EOFError:
            break

    if count == 4:
        score = score + 1
    elif count == 5:
        score = score + 2
    elif count == 6:
        score = score + 3
    elif count == 7:
        score = score + 4
    elif count == 8:
        score = score + 5
    elif count == 9:
        score = score + 6
    elif count == 10:
        score = score + 7

    return score

if __name__ == '__main__':
    print countrev()

