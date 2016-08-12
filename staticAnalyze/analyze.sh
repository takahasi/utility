#!/bin/bash
# @(#) This is xxxxxxxxxxxx.

# Checks unnecessary paramters
set -ue

####################
# GLOBAL CONSTANTS #
####################
readonly DATE=`date +%Y%m%d`
readonly WORKSPACE=.
readonly SRC_DIR=${WORKSPACE}/src
readonly RESULTS_DIR=results_${DATE}

####################
# GLOBAL VARIABLES #
####################
ENABLE_CPPCHECK=n
ENABLE_CCCC=n
ENABLE_CPD=n
ENABLE_SLOCCOUNT=n
ENABLE_CPPLINT=n

## Usage
function usage() {
  cat <<EOF
Usage:
  $0

Description:
  This is xxxxxx.

Options:
  -h,--help       : Print usage
  --all           : analyze with all tools
  --cppcheck      : analyze with cppcheck
  --cccc          : analyze with cccc
  --sloccount     : analyze with sloccount
  --cpd           : analyze with cpd
  --cpplint       : analyze with cpplint
EOF
  return 1
}

## FunctionXXX
find_sources() {
  find ${SRC_DIR} -name "*.cpp" -o -name "*.h"
}

## FunctionXXX
function install_cppcheck() {
  local CPPCHECK_REPOSITORY=git://github.com/danmar/cppcheck.git
  local CPPCHECK_BUILD_OPTION='SRCDIR=build CFGDIR=cppcheck/cfg HAVE_RULES=yes CXXFLAGS=-O2 CXXFLAGS+=-DNDEBUG CXXFLAGS+=-Wall CXXFLAGS+=-Wno-sign-compare CXXFLAGS+=-Wno-unused-function'

  rm -rf cppcheck
  git clone ${CPPCHECK_REPOSITORY} cppcheck
  (cd cppcheck && make ${CPPCHECK_BUILD_OPTION})

  return 0
}
## FunctionXXX
function do_cppcheck() {
  echo '[ANALYZE] Start cppcheck...'
  local CPPCHECK_BIN=cppcheck/cppcheck
  local CPPCHECK_RESULT=${RESULTS_DIR}/cppcheck_results.xml
  local CPPCHECK_OPTION="--quiet --enable=all --xml --file-list=-"

  if [ ! -f ${CPPCHECK_BIN} ]; then
    install_cppcheck
  fi

  find_sources | ${CPPCHECK_BIN} ${CPPCHECK_OPTION} 2> ${CPPCHECK_RESULT}

  echo '[ANALYZE] Finish cppcheck'
  return 0
}

## FunctionXXX
function install_cccc() {
  local CCCC_REPOSITORY=git://github.com/sarnold/cccc.git

  rm -rf cccc
  git clone ${CCCC_REPOSITORY} cccc
  (cd cccc && make)

  return 0
}

## FunctionXXX
function do_cccc() {
  echo '[ANALYZE] Start cccc...'
  local CCCC_BIN=cccc/cccc/cccc
  local CCCC_RESULT=${RESULTS_DIR}/cccc

  if [ ! -f ${CCCC_BIN} ]; then
    install_cccc
  fi

  find_sources | xargs ${CCCC_BIN} --outdir="${CCCC_RESULT}"

  echo '[ANALYZE] Finish cccc'
  return 0
}

## FunctionXXX
function install_sloccount() {
  local SLOCCOUNT_REPOSITORY=git://git.code.sf.net/p/sloccount/code

  rm -rf sloccount
  git clone ${SLOCCOUNT_REPOSITORY} sloccount
  (cd sloccount && make)

  return 0
}

## FunctionXXX
function do_sloccount() {
  echo '[ANALYZE] Start sloccount...'
  local SLOCCOUNT_BIN=sloccount/sloccount
  local SLOCCOUNT_RESULT=${RESULTS_DIR}/sloccount.sc
  local SLOCCOUNT_OPTION="--duplicates --wide"

  if [ ! -f ${SLOCCOUNT_BIN} ]; then
    install_sloccount
  fi

  # patch for issue of sloccount path
  export PATH=$PATH:${PWD}/sloccount

  ${SLOCCOUNT_BIN} ${SLOCCOUNT_OPTION} ${SRC_DIR} > ${SLOCCOUNT_RESULT}

  echo '[ANALYZE] Finish sloccount'
  return 0
}

## FunctionXXX
function install_cpplint() {
  local CPPLINT_REPOSITORY=git://github.com/google/styleguide.git

  rm -rf cpplint
  git clone ${CPPLINT_REPOSITORY} cpplint

  return 0
}

## FunctionXXX
function do_cpplint() {
  echo '[ANALYZE] Start cpplint...'
  local CPPLINT_BIN=cpplint/cpplint/cpplint.py
  local CPPLINT_RESULT=${RESULTS_DIR}/cpplint.xml

  if [ ! -f ${CPPLINT_BIN} ]; then
    install_cpplint
  fi

  ${CPPLINT_BIN} `find ${SRC_DIR} -name *.cpp` 2>&1 | cat > ${CPPLINT_RESULT}

  echo '[ANALYZE] Finish cpplint'
  return 0
}

## FunctionXXX
function install_cpd() {
  local PMD_VERSION=5.3.7
  local PMD_ZIP=https://sourceforge.net/projects/pmd/files/pmd/${PMD_VERSION}/pmd-bin-${PMD_VERSION}.zip

  rm -rf pmd*.zip pmd
  wget ${PMD_ZIP}
  unzip `basename ${PMD_ZIP}`
  mv pmd-bin-${PMD_VERSION} pmd

  return 0
}

## FunctionXXX
function do_cpd() {
  echo '[ANALYZE] Start cpd...'
  local CPD_BIN=pmd/bin/run.sh
  local CPD_RESULT=${RESULTS_DIR}/cpd_results.xml
  local CPD_OPTION="--minimum-tokens 50 --files --language cpp --format xml"

  if [ ! -f ${CPD_BIN} ]; then
    install_cpd
  fi

  ${CPD_BIN} cpd ${CPD_OPTION} --files ${SRC_DIR} > ${CPD_RESULT}

  echo '[ANALYZE] Finish cpd'
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
    '--cppcheck' )
      echo "[CONF] Enabled cppcheck"
      ENABLE_CPPCHECK=y
      ;;
    '--cccc' )
      echo "[CONF] Enabled cccc"
      ENABLE_CCCC=y
      ;;
    '--cpd' )
      echo "[CONF] Enabled cpd"
      ENABLE_CPD=y
      ;;
    '--sloccount' )
      echo "[CONF] Enabled sloccount"
      ENABLE_SLOCCOUNT=y
      ;;
    '--cpplint' )
      echo "[CONF] Enabled cpplint"
      ENABLE_CPPLINT=y
      ;;
    '--all' )
      echo "[CONF] Enabled all"
      ENABLE_CPPCHECK=y
      ENABLE_CCCC=y
      ENABE_CPD=y
      ENABE_SLOCCOUNT=y
      ENABE_CPPLINT=y
      ;;
    *)
      echo "[CONF] Unknown options! $1"
      usage
      exit 1
      ;;
  esac
  shift
done

if [ ! -d ${RESULTS_DIR} ]; then
    mkdir -p ${RESULTS_DIR}
fi

if [ "$ENABLE_CPPCHECK" = "y" ]; then
    do_cppcheck
fi
if [ "$ENABLE_CCCC" = "y" ]; then
    do_cccc
fi
if [ "$ENABLE_SLOCCOUNT" = "y" ]; then
    do_sloccount
fi
if [ "$ENABLE_CPD" = "y" ]; then
    do_cpd
fi
if [ "$ENABLE_CPPLINT" = "y" ]; then
    do_cpplint
fi

exit 0
