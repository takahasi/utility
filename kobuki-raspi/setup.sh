#!/bin/bash

# @(#) This is setup script for raspberrypi & kobuki & URG
# Please check the below URL
# http://www.openrtm.org/openrtm/ja/content/raspberrypi_kobuki_control

# Checks unnecessary paramters
set -ue

####################
# GLOBAL CONSTANTS #
####################
readonly HOSTNAME=kobuki00

## Usage
function usage()
{
  cat <<EOF
Usage:
  $0

Description:
  This is setup script for raspberrypi & kobuki & URG

Options:
  -h, --help     : Show usage
  -d, --download : Downloads necessary packages from internet
  -i, --install  : Installs downloaded packages

EOF
  return 1
}

function download_all_repositories()
{
  rm -rf rpi.sh
  wget http://svn.openrtm.org/Embedded/trunk/RaspberryPi/tools/rpi.sh
  chmod a+x rpi.sh

  rm -rf kobuki
  svn co http://svn.openrtm.org/components/trunk/mobile_robots/kobuki

  rm -rf UrgRTC
  git clone https://github.com/sugarsweetrobotics/UrgRTC.git

  rm -rf MobileRobotNavigationFramework_dist
  git clone https://github.com/sugarsweetrobotics/MobileRobotNavigationFramework_dist

  rm -rf mrpt-1.4.0.tar.gz
  wget https://github.com/jlblancoc/mrpt/archive/1.4.0.tar.gz -O mrpt-1.4.0.tar.gz

  zip downloaded_raspi_packages -r rpi.sh kobuki UrgRTC MobileRobotNavigationFramework_dist mrpt-1.4.0.tar.gz

  return 0
}

function setup_raspberrypi()
{
  sudo aptitude update
  sudo aptitude install -y git subversion

  sudo ./rpi.sh ${HOSTNAME} --type basic

  sudo aptitude install -y hostapd
  sudo zcat /usr/share/doc/hostapd/examples/hostapd.conf.gz > /etc/hostapd/hostapd.conf

  return 0
}

function build_kobuki()
{
  ( \
    cd kobuki && mkdir build && cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr .. && make && \
    cd src && sudo make install \
  )

  return 0
}

function generate_script()
{
  readonly script_name=start_rtcs.sh
  cat << EOF > $script_name
#!/bin/sh

readonly NAMESERVICE=omniorb4-nameserver
readonly RTM_NAMING=/usr/bin/rtm-naming
readonly KOBUKI_RTC=/usr/lib/openrtm-1.1/rtc/KobukiAISTComp
readonly MRPT_FW_DIR=`pwd`/MobileRobotNavigationFramework_dist/src
readonly URG_RTC=\${MRPT_FW_DIR}/UrgRTC/build-linux/src/UrgRTCComp
readonly PATHPLANNER_RTC=\${MRPT_FW_DIR}/PathPlanner_MRPT/build-linux/src/PathPlanner_MRPTComp
readonly PATHFOLLOWER_RTC=\${MRPT_FW_DIR}/SimplePathFollower/build-linux/src/SimplePathFollowerComp
readonly LOCALIZATION_RTC=\${MRPT_FW_DIR}/Localization_MRPT/build-linux/sec/Localization_MRPTComp
readonly MAPPER_RTC=\${MRPT_FW_DIR}/Mapper_MRPT/build-linux/src/Mapper_MRPTComp

if [ "\${IFACE}" != wlan0 ]; then
  exit 0
fi

cd `pwd`

sudo service \${NAMESERVICE} stop
sleep 20
echo y | sudo \${RTM_NAMING}

\${KOBUKI_RTC}&
\${URG_RTC}&
\${PATHPLANNNER_RTC}&
\${PATHFOLLOWER_RTC}&
\${LOCALIZATION_RTC}&
\${MAPPER_RTC}&

exit 0
EOF

  chmod a+x $script_name

  return 0
}

function build_urg()
{
  ( \
    cd UrgRTC && \
    git submodule init && git submodule update && \
    cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr .. && make && \
    cd src && sudo make install \
  )

  return 0
}

function build_navigation()
{
  readonly URG_RTC_CONF=MobileRobotNavigationFramework_dist/conf/UrgRTC0.conf

  # Patch for default COM port
  sed -ie  's/.*conf.default.port_name:.*//g' ${URG_RTC_CONF}
  echo "conf.default.port_name:/dev/ttyACM0" >> ${URG_RTC_CONF}

  return 0
}

function build_mrpt()
{
  sudo aptitude install -y build-essential pkg-config cmake \
      libwxgtk2.8-dev libftdi-dev freeglut3-dev \
      zlib1g-dev libusb-1.0-0-dev libudev-dev libfreenect-dev \
      libdc1394-22-dev libavformat-dev libswscale-dev \
      libassimp-dev libjpeg-dev libopencv-dev libgtest-dev \
      libeigen3-dev libsuitesparse-dev libpcap-dev

  tar xzf mrpt-1.4.0.tar.gz
  (cd mrpt-1.4.0 && cmake . && make -j2 && make install)

  return 0
}

#==============
# Main routine
#==============
while (( $# > 0 ))
do
  case "$1" in
    '-h'|'--help' )
      usage
      exit 1
      ;;
    '-d'|'--download' )
      download_all_repositories
      ;;
    '-i'|'--install' )
      setup_raspberrypi
      build_kobuki
      build_navigation
      build_mrpt
      generate_script
      ;;
    *)
      #echo "[ERROR] invalid option $1 !!"
      #usage
      #exit 1
      ;;
  esac
  shift
done

exit 0
