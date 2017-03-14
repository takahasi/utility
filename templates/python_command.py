#!/usr/bin/env python
# -*- coding: utf-8 -*-

""" python script for sample

This is xxx
"""

import sys
import argparse


def func(xxx):
    """ This functions is xxx """
    print(xxx)


def main(args):
    """ Main routine """
    parser = argparse.ArgumentParser(description='This is command for xxx')
    parser.add_argument('bar')
    parser.add_argument('-f', '--foo', help='foo help')
    parser.add_argument('-r', required=True, help='xxx help')
    parser.add_argument('--version', action='version', version='%(prog)s 1.0')

    args = parser.parse_args()

    print(args)

    func(args.bar)
    func(args.foo)
    func(args.r)


if __name__ == '__main__':
    if len(sys.argv) > 1:
        main(sys.argv)
