#!/usr/bin/env python
# -*- coding: utf-8 -*-

""" script for generate process template directories

This is xxx
"""

def tsubun(n_m, n_d, m_m, m_d):

    m = (n_m * m_d) + (n_d * m_m)
    d = n_d * m_d

    i = 2
    while True:
        if (m % i == 0) and (d % i == 0):
            m = m / i
            d = d / i
            i = 2
        else:
            i = i + 1
            if i >= d:
                break

    if d == 1:
        result = str(m)
    elif m == d:
        result = '1'
    else:
        result = str(m) + '/' + str(d)

    return result

if __name__ == '__main__':
    n = raw_input().strip().upper().split('/')
    m = raw_input().strip().upper().split('/')
    print tsubun(int(n[0]), int(n[1]), int(m[0]), int(m[1]))

