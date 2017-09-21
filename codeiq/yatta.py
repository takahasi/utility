#!/usr/bin/env python
# -*- coding: utf-8 -*-

""" script for generate process template directories

This is xxx
"""

from __future__ import print_function

def yatta(n):
    if n % 2 == 0:
        print("invalid")
        return

    m = int(n / 2) + 1
    for i in reversed(range(n)):
        if i < m:
            for j in range(n):
                if j == m - 1:
                    print("y", end="")
                else:
                    print(".", end="")
            print("")
        else:
            for j in range(n):
                p = n - i -1
                if (j == p) | (j == (n - p - 1)):
                    print("y", end="")
                else:
                    print(".", end="")
            print("")

    return

if __name__ == '__main__':
    yatta(int(raw_input()))
