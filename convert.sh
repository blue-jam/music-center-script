#!/bin/bash

echo $#

if [ $# -lt 2 ]; then
  echo "usage: $0 username directory1 [directory2...]"
  exit 1
fi

IFS=$'\n' # ファイル名に入るスペース対策
USER=$1
TMP_DIR=tmp

mkdir $TMP_DIR

argv=("$@")
i=1
while [ $i -lt $# ]; do
  DIRECTORY=${argv[$i]}
  cp -r "/c/Users/${USER}/Music/Music Center/Shared/Music/${DIRECTORY}" $TMP_DIR

  pushd "${TMP_DIR}/${DIRECTORY##*/}"

  FILE_LIST=`ls`
  for FILE in $FILE_LIST; do
    echo $FILE
    mv $FILE ${FILE%%.mp4}.m4a
  done

  popd

  i=`expr $i + 1`
done
