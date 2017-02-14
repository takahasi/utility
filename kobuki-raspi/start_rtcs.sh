#!/bin/sh

readonly NAMESERVICE=omniorb4-nameserver
readonly RTM_NAMING=/usr/bin/rtm-naming
readonly KOBUKI_RTC=/usr/lib/openrtm-1.1/rtc/KobukiAISTComp
readonly URG_RTC=/home/takahasi/work/github/utility/kobuki-raspi/UrgRTC/build/src/UrgRTCComp
readonly PATHPLANNER_RTC=/home/takahasi/work/github/utility/kobuki-raspi/PathPlanner_MRPT/build/src/PathPlanner_MRPTComp
readonly PATHFOLLOWER_RTC=/home/takahasi/work/github/utility/kobuki-raspi/SimplePathFollower/build/src/SimplePathFollowerComp
readonly LOCALIZATION_RTC=/home/takahasi/work/github/utility/kobuki-raspi/Localization_MRPT/build/src/Localization_MRPTComp
readonly MAPPER_RTC=/home/takahasi/work/github/utility/kobuki-raspi/Mapper_MRPT/build/src/Mapper_MRPTComp

if [ "${IFACE}" != wlan0 ]; then
  exit 0
fi

cd /home/takahasi/work/github/utility/kobuki-raspi

sudo service ${NAMESERVICE} stop
sleep 20
echo y | sudo ${RTM_NAMING}

${KOBUKI_RTC}&
${URG_RTC}&
${PATHPLANNNER_RTC}&
${PATHFOLLOWER_RTC}&
${LOCALIZATION_RTC}&
${MAPPER_RTC}&

exit 0
