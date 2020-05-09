#!/bin/bash

set -ue

BASE_URL=https://thebraithwaites.co.uk/wp-content/uploads/2016/09
DL_DIR=world
WORLD_DIR=~/.minecraft/games/com.mojang/minecraftWorlds/

function download_unzip(){
  wget $1
  unzip `basename $1`
}

mkdir -p $DL_DIR
cd $DL_DIR

download_unzip $BASE_URL/Tnt-Trouble.zip
download_unzip $BASE_URL/The-Grid-2.zip
download_unzip $BASE_URL/Canyons.zip
download_unzip $BASE_URL/Columbia-Bioshock-Infinite.zip
download_unzip $BASE_URL/Deep-Ocean.zip
download_unzip $BASE_URL/Dense-Forest.zip
download_unzip $BASE_URL/Lava-Citadel.zip
download_unzip $BASE_URL/Level-Screenshots.zip
download_unzip $BASE_URL/Nether-Nightmare.zip
download_unzip $BASE_URL/Paradise-Cove.zip
download_unzip $BASE_URL/Plaza.zip
download_unzip $BASE_URL/prisonEscape.zip
download_unzip $BASE_URL/Temple-of-Notch.zip
download_unzip $BASE_URL/The-Grid.zip
download_unzip $BASE_URL/The-Island.zip
download_unzip $BASE_URL/The-N.R.A.M-world-save.zip
download_unzip $BASE_URL/The-Underground.zip
download_unzip $BASE_URL/Volcano.zip
download_unzip $BASE_URL/Canyons.zip
download_unzip $BASE_URL/MW3-Seatown.zip
download_unzip $BASE_URL/Hamster-Escape-Part-1.zip

cp -rf world/* $WORLD_DIR

exit 0
