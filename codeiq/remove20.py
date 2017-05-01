#!/usr/bin/env python
# -*- coding: utf-8 -*-

""" script for generate process template directories

This is xxx
"""


def remove20():
    while True:
        try:
            l = list(str(raw_input().strip().upper()))
            i = 0
            while True:
                if (int(l[i]) == (int(l[i+1]) + 1)) or (int(l[i]) == (int(l[i+1]) - 1)):
                    l.pop(i+1)
                    l.pop(i)
                    i = 0
                else:
                    i = i + 1
                    if i >= (len(l) - 1):
                        print(('{:}' * len(l)).format(*l))
                        break
        except EOFError:
            break
    return l

if __name__ == '__main__':
    remove20()

