#!/bin/bash

GITHUB_REPO_NAME=someone/hoge

sudo gem install travis
travis login --auto
travis setup releases -r ${GITHUB_REPO_NAME}

