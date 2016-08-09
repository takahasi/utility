#!/bin/sh

# @(#) This is setup script for raspberrypi & kobuki & URG
# Please check the below URL
# http://www.openrtm.org/openrtm/ja/content/raspberrypi_kobuki_control

# Checks unnecessary paramters
set -ue

## Usage
function usage()
{
  cat <<EOF
Usage:
  $0

Description:
  This is setup script for raspberrypi & kobuki & URG

Options:

EOF
  return 1
}

function setup_raspberrypi()
{
  wget http://svn.openrtm.org/Embedded/trunk/RaspberryPi/tools/rpi.sh
  chmod a+x rpi.sh
  sudo ./rpi.sh hostname --type kobuki

  return 0
}

function build_kobuki()
{
  rm -rf kobuki
  svn co http://svn.openrtm.org/components/trunk/mobile_robots/kobuki
  ( \
    cd kobuki && mkdir build && cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr .. && make && \
    cd src && sudo make install \
  )

  return 0
}

function generate_script()
{
  readonly script_name=start_kobuki_urg.sh
  cat << EOF > $script_name
#!/bin/sh

readonly NAMESERVER=/usr/bin/rtm-naming
readonly KOBUKI_RTC=/usr/lib/openrtm-1.1/rtc/KobukiAISTComp
readonly URG_RTC=/usr/components/bin/UrgRTCComp
readonly WORKDIR=/tmp/kobuki

\$NAMESERVER
sleep 5

if test -d \$WORKDIR ; then
  echo ""
else
  mkdir \$WORKDIR
fi
cd \$WORKDIR
while :
do
  rm -f \$WORKDIR/*.log
  \$KOBUKI_RTC
  \$URG_RTC
  sleep 5
done
EOF

  chmod a+x $script_name

  return 0
}

function build_urg()
{
  rm -rf UrgRTC
  git clone https://github.com/sugarsweetrobotics/UrgRTC.git
  ( \
    cd UrgRTC && \
    git submodule init && git submodule update && \
    cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr .. && make && \
    cd src && sudo make install \
  )

  return 0
}

#==============
# Main routine
#==============
setup_raspberrypi
build_kobuki
build_urg
generate_script

exit 0
