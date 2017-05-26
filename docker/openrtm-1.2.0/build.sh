#!/bin/bash

function build()
{
  image=$1

  cat <<EOF

===================================
 Start build $image image..."
===================================

EOF

  docker build -t $image $1/

  cat <<EOF

===================================
 Start test $image image..."
===================================

EOF
  docker run -i --rm $image which rtls
  docker run -i --rm $image which openrtp
}

python gen_dockerfile.py

build ubuntu1204x64-openrtm120
build ubuntu1404x64-openrtm120
build ubuntu1604x64-openrtm120
build ubuntu1610x64-openrtm120
build ubuntu1704x64-openrtm120

