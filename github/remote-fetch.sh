#!/bin/bash

# git remote add upstream git://github.com/xxx/xxx.git
git fetch upstream
git merge upstream/master
git push

exit 0
