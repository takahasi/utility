#!/bin/bash

function build()
{
  local image=$1

  cat <<EOF

=============================================
 Start build $image image...
=============================================

EOF

  docker build -t $image -q $image

  return 0
}

function check()
{
  local image=$1

  cat <<EOF

=============================================
 Start test $image image...
=============================================

EOF
  echo -n "OpenRTM-aist C++    : "
  docker run -i --rm $image "test -e /usr/share/openrtm-1.2/components/c++ && echo OK"
  echo -n "OpenRTM-aist Python : "
  docker run -i --rm $image "test -e /usr/share/openrtm-1.2/components/python && echo OK"
  echo -n "OpenRTM-aist Java   : "
  docker run -i --rm $image "test -e /usr/share/openrtm-1.2/components/java && echo OK"
  echo -n "RTShell             : "
  docker run -i --rm $image "which rtls > /dev/null && echo OK"
  echo -n "OpenRTP             : "
  docker run -i --rm $image "which openrtp >/dev/null && echo OK"

  return 0
}

python gen_dockerfile.py

build ubuntu1204x64-openrtm120
build ubuntu1404x64-openrtm120
build ubuntu1604x64-openrtm120
build ubuntu1610x64-openrtm120
build ubuntu1704x64-openrtm120

check ubuntu1204x64-openrtm120
check ubuntu1404x64-openrtm120
check ubuntu1604x64-openrtm120
check ubuntu1610x64-openrtm120
check ubuntu1704x64-openrtm120

exit 0
