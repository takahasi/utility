#!/bin/bash
# @(#) This is xxxxxxxxxxxx.

# Checks unnecessary paramters
set -ue

# GLOBAL CONSTANTS
# ================
readonly GLOBAL_CONST="xxx"

# GLOBAL VARIABLES
# ================
GLOBAL_VAR=0

# Usage
# =====
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

# FUNCTIONS
# =========

function func1() {
  # local xxx="xxx"
  echo "func1"
  return 0
}

function func2() {
  # local xxx="xxx"
  echo "func2"
  return 0
}


# MAIN ROUTINE
# ============

while (( $# > 0 ))
do
  case "$1" in
    '-h'|'--help' )
      usage
      exit 1
      ;;
    '-a'|'--aaa' )
      echo "$0 $1"
      echo "GLOBAL_VAR=1"
      GLOBAL_VAR=1
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
      echo "[ERROR] invalid option $1 !!"
      ;;
  esac
  shift
done

func1

if [[ $GLOBAL_VAR -eq 1 ]]; then
  func2
fi

exit 0
