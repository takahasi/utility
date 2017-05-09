#!/usr/bin/env python
# -*- coding: utf-8 -*-

""" script for generate process template directories

This is xxx
"""

from collections import Counter

if __name__ == '__main__':
    l = raw_input().upper().split('+')

    s = 0
    for i in xrange(len(l)):
        c = Counter(l[i])
        s += c['/'] + (c['<'] * 10)

    print s
