#!/bin/bash

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

kubectl create namespace "kyma-functions"

FILES="${SCRIPTPATH}/configs/*"
for f in $FILES
do
  echo "Processing $(basename $f) file..."
  kyma apply function -f $f
  echo ""
done

echo "done"