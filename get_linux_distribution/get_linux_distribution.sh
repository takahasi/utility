#!/bin/bash
# @(#) This is xxxxxxxxxxxxxx

# Checks unnecessary paramters
set -ue

# Get Linux distribution
function get_os_distribution() {
  local _dist=""

  if   [ -e /etc/debian_version ] || [ -e /etc/debian_release ]; then
    # Check Ubuntu or Debian
    if [ -e /etc/lsb-release ]; then
      # Ubuntu
      _dist="ubuntu"
    else
      # Debian
      _dist="debian"
    fi
  elif [ -e /etc/fedora-release ]; then
    # Fedra
    _dist="fedora"
  elif [ -e /etc/vine-release ]; then
    # Vine
    _dist="vine"
  else
    # Other
    echo "unkown distribution"
    usage
    exit 1
  fi

  echo $_dist
  return 0
}

# Get OS version
function get_os_version() {
  local readonly _dist=`get_os_distribution`
  local _version=""

  if [ "$_dist" = "ubuntu" ]; then
    _version=`awk '/RELEASE=/' /etc/lsb-release | sed 's/DISTRIB_RELEASE=//'`
  elif [ "$_dist" = "debian" ]; then
    _version=`awk '/VERSION/' /etc/debian-release | sed 's/VERSION=\"\(.*\).*(.*)\"/\1/'`
  fi

  echo $_version
  return 0
}

get_os_distribution
get_os_version
