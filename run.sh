#!/bin/bash
ROKU_DEV_TARGET=192.168.1.2

# wake up/interrupt Roku - workaround for fw5.4 deadly bug
curl -d '' http://$ROKU_DEV_TARGET:8060/keypress/Home

# build
touch timestamp
zip -FS -r bundle * -x run.sh

# deploy
curl -f -sS --user rokudev:annoying --anyauth -F "mysubmit=Install" -F "archive=@bundle.zip" -F "passwd=" http://$ROKU_DEV_TARGET/plugin_install |  grep -Po '(?<=<font color="red">).*' | sed 's/<\/font>//'