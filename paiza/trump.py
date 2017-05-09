#!/usr/bin/env python
# -*- coding: utf-8 -*-

""" script for generate process template directories

This is xxx
"""

if __name__ == '__main__':
    l = raw_input().upper().split()
    a = l[0]
    b = l[1]

    if a == 'J' and b == 'J':
        b = 'Q'

    print a + ' ' + b
