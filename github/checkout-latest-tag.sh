#!/bin/bash

git checkout $(git describe --tags --abbrev=0)

exit 0
