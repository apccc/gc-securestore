#!/bin/bash
#settings for gc-securestore

#space separated list of source buckets to backup
#(local computer instance service account will need at least read only/viewer permission to project/buckets)
SOURCE_BUCKETS=""

#a unique storage prefix (short and unique)
STORE_PREFIX=""

#default storage info
STORAGE_CLASS="DURABLE_REDUCED_AVAILABILITY"
STORAGE_LOCATION="US"
