#!/usr/bin/env python
# -*- coding: utf-8 -*-
# -*- Python -*-

import sys
import time
import numpy as np
import cv2
import math
import matplotlib.pyplot as plt
import subprocess as sub

class OpticalFlow:
    def __init__(self):

        # params for ShiTomasi corner detection
        self._feature_params = dict(maxCorners = 100,
                                   qualityLevel = 0.3,
                                   minDistance = 7,
                                   blockSize = 7)

        # Parameters for lucas kanade optical flow
        self._lk_params = dict(winSize = (15,15),
                              maxLevel = 2,
                              criteria = (cv2.TERM_CRITERIA_EPS | cv2.TERM_CRITERIA_COUNT, 10, 0.03))

        # Create some random colors
        self._color = np.random.randint(0,255,(100,3))

        # switch for capture device
        self._cap = cv2.VideoCapture('Video6.wmv')
        #self._cap = cv2.VideoCapture(1)

        # switch for plotter
        self._plotter = 'gnuplot'
        #self._plotter = 'matplotlib'

        self._count = 0
        self._cost = 0

        if self._plotter == 'gnuplot':
            self._f = open('plot.txt', 'w')
            self._plot = sub.Popen(["gnuplot", '-p'], stdin=sub.PIPE,)
            self._plot.stdin.write("plot \"plot.txt\" using 1:2 w l\n")
            time.sleep(0.1)
        else:
            self._plt = plt
            self._plt.ion()

    def capture(self):
        return self._cap.read()

    def plot(self):
        if self._plotter == 'gnuplot':
            self._plot.stdin.write("plot \"plot.txt\" using 1:2 w l\n")
        else:
            line, = self._plt.plot(self._count, self._cost, "ro", label="moving")
            line.set_ydata(self._cost)
            self._plt.draw()

    def record(self):
        print 'avg: ' + str(self._cost)

        # record to file for plot
        self._count +=1
        if self._plotter == 'gnuplot':
            self._f.write(str(self._count) + ' ' + str(self._cost) + '\n')
            self._f.flush()

    def release(self):
        print 'please hit key to finish'
        raw_input()

        self._cap.release()
        if self._plotter == 'gnuplot':
            self._plot.stdin.write("exit\n")
            self._f.close()
        else:
            self._plt.close()

    def set1stFrame(self, frame):
        self.old_gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
        self.p0 = cv2.goodFeaturesToTrack(self.old_gray,
                                          mask = None,
                                          **self._feature_params)
        # Create a mask image for drawing purposes
        self.mask = np.zeros_like(frame)

    def apply(self, frame):
        frame_gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

        # calculate optical flow
        p1, st, err = cv2.calcOpticalFlowPyrLK(self.old_gray,
                                               frame_gray,
                                               self.p0,
                                               None,
                                               **self._lk_params)

        # Select good points
        good_new = p1[st==1]
        good_old = self.p0[st==1]

        # draw the tracks
        total = 0
        for i, (new,old) in enumerate(zip(good_new,good_old)):
            a,b = new.ravel()
            c,d = old.ravel()
            # calc moving range
            #total += math.sqrt(pow(a-c,2) + pow(b-d,2))
            total += ((a-c) + (b-d)) / 2
            # draw moving line & focus circle
            self.mask = cv2.line(self.mask, (a,b), (c,d), self._color[i].tolist(), 2)
            frame = cv2.circle(frame, (a,b), 5, self._color[i].tolist(), -1)

        img = cv2.add(frame, self.mask)

        # update previous frame and points
        self.old_gray = frame_gray.copy()
        self.p0 = good_new.reshape(-1,1,2)

        # store average of moving
        self._cost = total / len(p1)

        return img


def main():
    flow = OpticalFlow()
    ret, frame = flow.capture()
    cv2.namedWindow("preview")
    flow.set1stFrame(frame)


    while ret:
        ret, frame = flow.capture()
        if not ret:
            # detect end of file/image
            break

        img = flow.apply(frame)
        cv2.imshow("preview", img)

        # 'q' key to finish
        if cv2.waitKey(30) == ord('q'):
            break

        flow.record()
        flow.plot()

    flow.release()

if __name__ == '__main__':
    main()
