#!/usr/bin/env python
# -*- coding: utf-8 -*-

def tsurukame():
  s = raw_input().rstrip().split(' ')
  a = int(s[0])
  b = int(s[1])
  c = int(s[2])
  d = int(s[3])

  # a = (c * x) + (d * y)
  # b = x + y

  match = 0
  for i in xrange(1, 100):
    for j in xrange(1, 100):
      if (a == ((c * i) + (d * j))) and (b == (i + j)):
          match = match + 1
          x = i
          y = j

  if match == 1:
    print str(x) + ' ' + str(y)
  else:
    print "miss"


if __name__ == '__main__':
    tsurukame()

