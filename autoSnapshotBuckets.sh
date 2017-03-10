#!/bin/bash
#run the auto snapshot bucket process

echo "Auto Snapshotting Buckets into Secure Store!"
CURRENT_DIR=`dirname "$0"`
if [ ! -f ~/gc-securestore-config.sh ];then
  touch ~/gc-securestore-config.sh
  chmod 600 ~/gc-securestore-config.sh
  cp "$CURRENT_DIR/gc-securestore-config-template.sh" ~/gc-securestore-config.sh
  echo "Please setup config file! ~/gc-securestore-config.sh"
  exit
fi

source ~/gc-securestore-config.sh
for SOURCE_BUCKET in `echo "$SOURCE_BUCKETS"`;do
  echo "SOURCE BUCKET: $SOURCE_BUCKET"
  MM=$(date +%m)
  W=$(($((7+$(date +%-d)))/7))
done
exit 0
