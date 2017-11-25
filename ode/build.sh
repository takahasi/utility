#!/bin/bash


sudo apt-get install automake libtool freeglut3-dev

wget https://downloads.sourceforge.net/project/opende/ODE/0.13/ode-0.13.tar.gz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fopende%2Ffiles%2FODE%2F0.13%2F&ts=1511611602&use_mirror=jaist -O ode-0.13.tar.gz

./bootstrap
./configure --with-trimesh=opcode --enable-new-trimesh --enable-shared  --enable-release --with-x --enable-double-precision --with-libccd
make
sudo make install

exit 0
