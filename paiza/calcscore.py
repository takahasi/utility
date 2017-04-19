#!/usr/bin/env python
# -*- coding: utf-8 -*-

""" script for generate process template directories

This is xxx
"""

def calcscore():
  s = raw_input().rstrip().split(' ')
  N = int(s[0])
  M = int(s[1])
  K = int(s[2])

  C = raw_input().rstrip().split(' ')

  score = [0 for i in range(M)]
  for i in xrange(M):
    X = raw_input().rstrip().split(' ')
    score[i] = 0
    for j in xrange(N):
      score[i] = score[i] + int(X[j]) * float(C[j])

  score.sort(reverse=True)

  for i in xrange(K):
    print int(round(score[i], 0))

if __name__ == '__main__':
    calcscore()

