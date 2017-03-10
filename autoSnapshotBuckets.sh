#!/bin/bash
#run the auto snapshot bucket process

echo "Auto Snapshotting Buckets into Secure Store!"
date
CURRENT_DIR=`dirname "$0"`
if [ ! -f ~/gc-securestore-config.sh ];then
  touch ~/gc-securestore-config.sh
  chmod 600 ~/gc-securestore-config.sh
  cp "$CURRENT_DIR/gc-securestore-config-template.sh" ~/gc-securestore-config.sh
  echo "Please setup config file! ~/gc-securestore-config.sh"
  exit
fi

source ~/gc-securestore-config.sh
PROJECTID=$("$CURRENT_DIR/getProjectId.sh")
for SOURCE_BUCKET in `echo "$SOURCE_BUCKETS"`;do
  echo "SOURCE BUCKET: $SOURCE_BUCKET"
  MM=$(date +%m)
  W=$(($((7+$(date +%-d)))/7))

  MONTH_TARGET_BUCKET=`echo "${STORE_PREFIX}-M${MM}-${SOURCE_BUCKET}" | cut -c 1-63`
  WEEK_TARGET_BUCKET=`echo "${STORE_PREFIX}-W${W}-${SOURCE_BUCKET}" | cut -c 1-63`

  echo "MONTH TARGET BUCKET: $MONTH_TARGET_BUCKET"
  echo "WEEK TARGET BUCKET: $WEEK_TARGET_BUCKET"
  gsutil mb -p "$PROJECTID" -c "$STORAGE_CLASS" -l "$STORAGE_LOCATION" "gs://$MONTH_TARGET_BUCKET"
  gsutil mb -p "$PROJECTID" -c "$STORAGE_CLASS" -l "$STORAGE_LOCATION" "gs://$WEEK_TARGET_BUCKET"
  echo ""
done
echo "Done auto snapshotting!"
date
exit 0
