#!/usr/bin/env python
# -*- coding: utf-8 -*-

""" script for generate process template directories

This is xxx
"""
import sys

sys.setrecursionlimit(10000)

l = [1, 5, 10, 50, 100, 500]
m = [0, 0, 0, 0, 0, 0]

def countyen(rest, idx):
    if rest == 0:
        return 1
    else:
        count = 0
        for i in reversed(xrange(idx + 1)):
            if rest >= l[i]:
                m[i] = m[i] + 1
                if m[i] <= 1000:
                    count += countyen(rest - l[i], i)
                m[i] = m[i] - 1
        return count

if __name__ == '__main__':
    y = int(raw_input().strip().upper())
    print countyen(y, 5)

