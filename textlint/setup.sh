#!/bin/bash

if type npm > /dev/null 2>&1; then
  sudo apt-get install -y npm
fi

sudo npm i -g textlint textlint-rule-preset-japanese textlint-rule-prh

if type node > /dev/null 2>&1; then
  sudo ln -s /usr/bin/nodejs /usr/bin/node
fi

git clone https://github.com/azu/prh.yml.git
cp -rf prh.yml/ja/jser-info.yml .
cp -rf prh.yml/ja/typo.yml .
cp -rf prh.yml/ja/web+db.yml .
cp -rf prh.yml/ja/kanji-open.yml .

cat << EOS > .textlintrc
 {
   "rules": {
       "preset-japanese": true,
       "prh": {
           "rulePaths": [
               "./jser-info.yml",
               "./spoken.yml",
               "./typo.yml",
               "./web+db.yml",
               "./kanji-open.yml"
           ]
        }
    }
 }
EOS

exit 0
