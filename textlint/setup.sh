#!/bin/bash

set -ue

packages="textlint \
    textlint-rule-preset-japanese \
    textlint-rule-prh \
    textlint-rule-preset-ja-technical-writing \
    textlint-rule-common-misspellings \
    textlint-rule-spellcheck-tech-word"


if ! type npm > /dev/null 2>&1; then
  sudo apt-get install -y npm
fi

sudo npm i -g $packages

if ! type node > /dev/null 2>&1; then
  sudo ln -s /usr/bin/nodejs /usr/bin/node
fi

rm -rf prh.yml
git clone https://github.com/azu/prh.yml.git

cat << EOS > .textlintrc
{
    "rules": {
        "common-misspellings": true,
        "preset-japanese": true,
        "spellcheck-tech-word": true,
        "preset-ja-technical-writing": true,
        "prh": {
            "rulePaths": [
                "./prh.yml/ja/jser-info.yml",
                "./prh.yml/ja/spoken.yml",
                "./prh.yml/ja/typo.yml",
                "./prh.yml/ja/web+db.yml",
                "./prh.yml/ja/kanji-open.yml"
            ]
        }
    }
}
EOS

exit 0
