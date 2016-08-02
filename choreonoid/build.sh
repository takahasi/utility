#!/bin/sh


function extract() {
  readonly repo=https://github.com/s-nakaoka/choreonoid
  git clone $repo
}

function build() {
  opt="-DBUILD_OPENRTM_PLUGIN=ON "
  opt+="-DBUILD_OPENRTM_SAMPLES=ON "
  opt+="-DBUILD_GROBOT_PLUGIN=ON "
  opt+="-DBUILD_CORBA_PLUGIN=ON "
  opt+="-DENABLE_CORBA=ON "

  (mkdir -p choreonoid/build && cd choreonoid/build && cmake .. $opt)
}

extract
build
