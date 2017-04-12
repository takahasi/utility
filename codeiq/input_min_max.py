#!/usr/bin/env python
# -*- coding: utf-8 -*-

""" script for generate process template directories

This is xxx
"""

import fileinput

if __name__ == '__main__':
    for line in fileinput.input():
        l = list(set(list(line.strip())))
        #print l
        if line.find("0") >= 0:
            l.remove("0")
            print min(l)
        else:
            print max(l)
