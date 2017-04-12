#!/usr/bin/env python
# -*- coding: utf-8 -*-

""" script for generate process template directories

This is xxx
"""

def sumcalc(l):
    for nidx, n in enumerate(l):
        for midx, m in enumerate(l):
            if nidx != midx:
                sum = int(n) + int(m)
                if sum == 256:
                    return "yes"
    return "no"

if __name__ == '__main__':
    l = list(raw_input().strip().upper().split())
    l = l + list(raw_input().strip().upper().split())
    print sumcalc(l)

