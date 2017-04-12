#!/usr/bin/env python
# -*- coding: utf-8 -*-

""" script for generate process template directories

This is xxx
"""

from collections import Counter

def countbin(n, m):
    count = 0
    for i in range(n + 1):
        string = str(format(i, '016b'))
        counter = Counter(string)
        if counter['1'] == m:
            count = count + 1

    return count

if __name__ == '__main__':
    l = list(raw_input().strip().upper().split())
    print countbin(int(l[0]), int(l[1]))

