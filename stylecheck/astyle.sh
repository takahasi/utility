#!/bin/bash

# install
sudo apt-get install astyle

# dry run
astyle --style=google --mode=c -X -r -v --dry-run *.c

# overwrite
astyle --style=google -n --mode=c -X -r -v --dry-run *.c

exit 0
