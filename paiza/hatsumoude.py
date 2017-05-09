#!/usr/bin/env python
# -*- coding: utf-8 -*-

""" script for generate process template directories

This is xxx
"""

import sys

if __name__ == '__main__':
    ls = raw_input().upper().split()
    l = int(ls[0])
    m = int(ls[1])
    n = int(ls[2])

    for i in xrange(l):
        sys.stdout.write('A')

    for i in xrange(m):
        sys.stdout.write('B')

    for i in xrange(n):
        sys.stdout.write('A')

    print
