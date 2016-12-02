#!/bin/bash

git clone https://github.com/fluent/fluent-bit.git

(cd fluent-bit/build && cmake .. && make && suo make install)

exit 0
