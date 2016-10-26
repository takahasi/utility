#!/bin/bash
# @(#) This is xxxxxxxxxxxx.

# Checks unnecessary paramters
#set -ue

####################
# GLOBAL VARIABLES #
####################
URL=$1

## Usage
function usage() {
  cat <<EOF
---
  Usage:
    $0 "URL"
  Description:
    This is speed checker script to access target URL.
  Options:
    None
EOF
  return 1
}


################
# MAIN ROUTINE #
################

if [ -z "$URL" ] ; then
  echo "Target URL is empty!"
  usage
  exit 1
fi

echo "Target URL = $URL"

curl -s  -o /dev/null ${URL};
if [ $? -ne  0 ] ; then
  echo "Cannot access to $URL!"
  usage
  exit 1
fi

for i in {1..50};
do
  curl -s  -o /dev/null ${URL}  -w  '%{speed_download}\n' ;
done \
 |  awk '{sum += ($1/1024/1024) ; count +=1; } END {print "Ave. = "sum/count" [Mbyte/s]" }'

exit 0
