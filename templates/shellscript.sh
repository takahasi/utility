#!/bin/bash
# @(#) This is xxxxxxxxxxxx.

# Checks unnecessary paramters
set -ue

####################
# GLOBAL CONSTANTS #
####################
# readonly XXX="xxx"

####################
# GLOBAL VARIABLES #
####################
# XXX="xxx"

## Usage
function usage() {
  cat <<EOF
Usage:
  $0

Description:
  This is xxxxxx.

Options:
  -h       : Print usage
  -a       : aaa
  -b ARGS  : bbb
EOF
  return 1
}

## FunctionXXX
function func() {
  # local xxx="xxx"
  return 0
}

################
# MAIN ROUTINE #
################

while (( $# > 0 ))
do
  case "$1" in
    '-h'|'--help' )
      usage
      exit 1
      ;;
    '-a'|'--aaa' )
      echo "$0 $1"
      ;;
    '-b'|'--bbb' )
      if [[ -z "$2" ]] || [[ "$2" =~ ^-+ ]]; then
        echo "[ERROR] option $1 requred argument!!"
        usage
        exit 1
      fi
      echo "$0 $1 $2"
      ;;
    *)
      #echo "[ERROR] invalid option $1 !!"
      #usage
      #exit 1
      ;;
  esac
  shift
done

func

exit 0
