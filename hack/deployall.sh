#!/bin/bash

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# create namespace
kubectl create namespace "kyma-functions"

# apply secrets
FILES="${SCRIPTPATH}/private/*"
for f in $FILES
do
  echo "Applying $(basename $f) file..."
  kubectl apply -f $f
  echo ""
done

# apply functions and repos
FILES="${SCRIPTPATH}/configs/*"
for f in $FILES
do
  echo "Processing $(basename $f) file..."
  kyma-dev apply function -f $f
  echo ""
done

echo "done"