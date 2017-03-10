#!/bin/bash
#run the auto snapshot bucket process

echo "Auto Snapshotting Buckets into Secure Store!"
date
CURRENT_DIR=`dirname "$0"`
if [ ! -f ~/gc-securestore-config.sh ];then
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

  MONTH_TARGET_BUCKET=`echo "${STORE_PREFIX}${MM}${SOURCE_BUCKET}" | cut -c 1-61`"-m"
  WEEK_TARGET_BUCKET=`echo "${STORE_PREFIX}${W}${SOURCE_BUCKET}" | cut -c 1-61`"-w"

  echo "MONTH TARGET BUCKET: $MONTH_TARGET_BUCKET"
  echo "WEEK TARGET BUCKET: $WEEK_TARGET_BUCKET"
  gsutil mb -p "$PROJECTID" -c "$STORAGE_CLASS" -l "$STORAGE_LOCATION" "gs://$MONTH_TARGET_BUCKET"
  gsutil mb -p "$PROJECTID" -c "$STORAGE_CLASS" -l "$STORAGE_LOCATION" "gs://$WEEK_TARGET_BUCKET"
  gsutil -m rsync -d -r "gs://$SOURCE_BUCKET" "gs://$MONTH_TARGET_BUCKET"
  gsutil -m rsync -d -r "gs://$SOURCE_BUCKET" "gs://$WEEK_TARGET_BUCKET"
  echo ""
done
echo "Done auto snapshotting!"
date
exit 0
