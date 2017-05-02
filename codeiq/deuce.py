#!/usr/bin/env python
# -*- coding: utf-8 -*-

""" script for generate process template directories

This is xxx
"""

from collections import Counter

def deuce(n, a, b):
    first_deuce = (n - 1) * 2
    n1 = 2 ** first_deuce
    #l1 = []
    count1 = 0
    for i in xrange(0, n1):
        s = format(i, '0' + str(first_deuce) + 'b')
        c = Counter(s)
        if (c['0'] == c['1']):
             #l1.append(s)
             count1 = count1 + 1

    #l2 = []
    count2 = 0
    if a > first_deuce or b > first_deuce:
        r_a = a - first_deuce
        r_b = b - first_deuce
        r = r_a + r_b
        for i in xrange(r):
            s = format(i, '0' + str(r) + 'b')
            c = Counter(s)
            if (c['0'] == r_a) and (c['1'] == r_b):
                #l2.append(s)
                count2 = count2 + 1

    #print l1
    #print l2

    #if len(l2) == 0:
    if count2 == 0:
        #patterns = len(l1)
        patterns = count1
    else:
        #patterns = len(l1) * len(l2)
        patterns = count1 * count2

    return patterns

if __name__ == '__main__':
    n = raw_input().strip().upper().split()
    print deuce(int(n[0]), int(n[1]), int(n[2]))

