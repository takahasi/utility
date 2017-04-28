#!/usr/bin/env python
# -*- coding: utf-8 -*-

""" script for generate process template directories

This is xxx
"""


def colorize(pattern, l):
    colored = ''
    for i,s in enumerate(l):
        if s == pattern:
            colored += s.replace(pattern, '[' + pattern + ']')
        else:
            colored += s.replace(pattern, '=' + pattern + '=')

        if s != l[-1]:
            colored += ' '

    return colored

if __name__ == '__main__':
    pattern = raw_input().strip().split()
    l = list(raw_input().strip().split())
    print colorize(pattern[0], l)

