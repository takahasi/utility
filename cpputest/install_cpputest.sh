#!/bin/bash
# @(#) This is setup script for cpputest.

# Checks unnecessary paramters
set -ue

####################
# GLOBAL CONSTANTS #
####################
readonly PROJECT_NAME=sample_project
readonly PACKAGE_NAME=sample_package
readonly CLASS_NAME=sample_class
readonly INTERFACE_NAME=sample_interface
readonly CPPUTEST_URL=git://github.com/cpputest/cpputest.git
readonly SETENV_SCRIPT=setenv_cpputest.sh
readonly CPPUTEST_HOME=${PWD}/cpputest
readonly CPPUTEST_SCRIPT_DIR=${CPPUTEST_HOME}/scripts

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
  This is setup script for cpputest.

Options:
  -h       : Print usage
EOF
  return 1
}

## FunctionXXX
function install() {
  # remove old environment
  rm -rf cpputest

  # download & make
  git clone ${CPPUTEST_URL}
  ( \
    cd cpputest/cpputest_build \
    && autoreconf .. -i \
    && ../configure && make -j \
  )

  return 0
}

## FunctionXXX
function create_project() {
  # patch for wrong CPPUTEST_HOME of sample makefile
  cp -rf cpputest/cpputest_build/lib cpputest/

  # create script for environment patrameter
  echo "export CPPUTEST_HOME=${CPPUTEST_HOME}" > ${SETENV_SCRIPT}
  chmod a+x ${SETENV_SCRIPT}

  # patch for defect of permimssion
  chmod a+x ${CPPUTEST_SCRIPT_DIR}/NewProject.sh

  # create project
  rm -rf ${PROJECT_NAME}
  ${CPPUTEST_SCRIPT_DIR}/NewProject.sh ${PROJECT_NAME}
  ( \
    cd ${PROJECT_NAME} \
    && ${CPPUTEST_SCRIPT_DIR}/NewPackageDirs.sh ${PACKAGE_NAME} \
    && ${CPPUTEST_SCRIPT_DIR}/NewClass.sh ${CLASS_NAME} ${PACKAGE_NAME} \
    && ${CPPUTEST_SCRIPT_DIR}/NewInterface.sh ${INTERFACE_NAME} ${PACKAGE_NAME} \
    && make \
  )

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
    *)
      #echo "[ERROR] invalid option $1 !!"
      #usage
      #exit 1
      ;;
  esac
  shift
done

install
create_project

exit 0
