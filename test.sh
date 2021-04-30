#!/bin/bash

docker run --rm -it -v $PWD:/temp debian /bin/bash -c "cd /temp;./install.sh;sleep 1;./uninstall.sh"
