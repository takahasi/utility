#!/bin/bash
# @(#) This is xxxxxxxxxxxx.

# Checks unnecessary paramters
set -ue

####################
# GLOBAL CONSTANTS #
####################
readonly DATE=`date +%Y%m%d`
readonly RESULTS_DIR=results_${DATE}

####################
# GLOBAL VARIABLES #
####################
EXTENSION=

## Usage
function usage() {
  cat <<EOF
Usage:
  $0 [option] URL

Description:
  This is script for web crawler.

Environment:
  RESULTS DIRECTORY = ${RESULTS_DIR}

Options:
  -h,--help       : Print usage
  -extension      : Target file extension

Examples:
   Get jpg files;
    \$ $0 --extension jpg http://hogehoge.com
   Show help message;
    \$ $0 --help

EOF
  return 1
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
    '--extension' )
      echo "[CONF] set extenstion as $2"
      EXTENSION=$2
      shift 1
      ;;
    *)
      break
      ;;
  esac
  shift
done

if [ $1 = "" ]; then
    echo "[ERROR] No input URL"
    usage
    exit 1
fi

if [ ! -d ${RESULTS_DIR} ]; then
    mkdir -p ${RESULTS_DIR}
fi

opt="--recursive --level inf --no-clobber -w 3 --restrict-file-names=windows --convert-links --no-parent --adjust-extension -nd -P ${RESULTS_DIR}"

if [ ! ${EXTENSION} = "" ]; then
    opt+=" -A ${EXTENSION}"
fi

wget $opt $1

exit 0
