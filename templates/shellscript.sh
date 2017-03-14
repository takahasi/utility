#!/bin/bash
#<help>
#
# This is xxxxxxxxxxxx.
#
# Usage:
#   ./shellscript.sh
#
# Description:
#   This is xxxxxx.
#
# Options:
#   -h       : Print usage
#   -a       : aaa
#   -b ARGS  : bbb
#
#</help>

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
  sed -n '/^#<help>/, /^#<\/help>/p' $0  | sed -e '1d;$d' | cut -b3-
  return 0
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
