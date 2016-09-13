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
  --cppcheck      : analyze with cppcheck
  --cccc          : analyze with cccc
  --sloccount     : analyze with sloccount
  --cpd           : analyze with cpd
  --cpplint       : analyze with cpplint
  --all           : analyze with all methods
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
  local CPPCHECK_HTML_BIN=cppcheck/htmlreport/cppcheck-htmlreport
  local CPPCHECK_RESULTS_DIR=${RESULTS_DIR}/cppcheck
  local CPPCHECK_RESULT=${CPPCHECK_RESULTS_DIR}/cppcheck
  local CPPCHECK_RESULT_XML=${CPPCHECK_RESULT}.xml
  local CPPCHECK_RESULT_CSV=${CPPCHECK_RESULT}.csv
  local CPPCHECK_RESULT_HTML=${CPPCHECK_RESULT}.html
  local CPPCHECK_OPTION="--quiet --enable=all --file-list=-"
  local CPPCHECK_OPTION_XML="${CPPCHECK_OPTION} --xml"
  local CPPCHECK_OPTION_CSV="${CPPCHECK_OPTION}"
  local CPPCHECK_HTML_OPTION="--file=${CPPCHECK_RESULT_XML} --report-dir ${CPPCHECK_RESULT_HTML}"

  if [ ! -f ${CPPCHECK_BIN} ]; then
    install_cppcheck
  fi

  if [ ! -d ${CPPCHECK_RESULTS_DIR} ]; then
    mkdir -p ${CPPCHECK_RESULTS_DIR}
  fi

  find_sources | ${CPPCHECK_BIN} ${CPPCHECK_OPTION_XML} 2> ${CPPCHECK_RESULT_XML}
  find_sources | ${CPPCHECK_BIN} ${CPPCHECK_OPTION_CSV} 2> ${CPPCHECK_RESULT_CSV}
  ${CPPCHECK_HTML_BIN} ${CPPCHECK_HTML_OPTION}

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
  local CPPLINT_RESULTS_DIR=${RESULTS_DIR}/cpplint
  local CPPLINT_RESULT=${CPPLINT_RESULTS_DIR}/cpplint.xml

  if [ ! -f ${CPPLINT_BIN} ]; then
    install_cpplint
  fi

  if [ ! -d ${CPPLINT_RESULTS_DIR} ]; then
    mkdir -p ${CPPLINT_RESULTS_DIR}
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
  local CPD_RESULTS_DIR=${RESULTS_DIR}/cpd
  local CPD_RESULT=${CPD_RESULTS_DIR}/cpd_results
  local CPD_RESULT_XML=${CPD_RESULT}.xml
  local CPD_RESULT_CSV=${CPD_RESULT}.csv
  local CPD_OPTION="--minimum-tokens 50 --files --language cpp"
  local CPD_OPTION_XML="${CPD_OPTION} --format xml"
  local CPD_OPTION_CSV="${CPD_OPTION} --format csv"

  if [ ! -f ${CPD_BIN} ]; then
    install_cpd
  fi

  if [ ! -d ${CPD_RESULTS_DIR} ]; then
    mkdir -p ${CPD_RESULTS_DIR}
  fi

  ${CPD_BIN} cpd ${CPD_OPTION_XML} --files ${SRC_DIR} > ${CPD_RESULT_XML} &> /dev/null &
  ${CPD_BIN} cpd ${CPD_OPTION_CSV} --files ${SRC_DIR} > ${CPD_RESULT_CSV} &> /dev/null &

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
  --all)
      echo "[CONF] Enabled all"
      ENABLE_CPPCHECK=y
      ENABLE_CCCC=y
      ENABLE_CPD=y
      ENABLE_SLOCCOUNT=y
      ENABLE_CPPLINT=y
      ;;
  *)
      echo "[CONF] invalid options $1"
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
