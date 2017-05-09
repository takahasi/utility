#!/usr/bin/env python
# -*- coding: utf-8 -*-

""" script for generate process template directories

This is xxx
"""

if __name__ == '__main__':
    l = raw_input().upper().split()
    m = int(l[0])
    n = int(l[1])

    if m > n:
        print 'No'
    else:
        print n - m
