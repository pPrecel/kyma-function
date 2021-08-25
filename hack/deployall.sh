#!/bin/bash

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# create namespace
kubectl create namespace "kyma-functions" &2>/dev/null
echo ""

# apply secrets
SECRETS=0
FILES="${SCRIPTPATH}/private/*"
for f in $FILES
do
  echo "Applying $(basename $f) file..."
  kubectl apply -f $f
  echo ""

  SECRETS=$( expr $SECRETS + 1 )
done

# apply functions and repos
FUNCS=0
FILES="${SCRIPTPATH}/configs/*"
for f in $FILES
do
  echo "Processing $(basename $f) file..."
  kyma-dev apply function -f $f
  echo ""

  FUNCS=$( expr $FUNCS + 1 )
done

echo "Applyed $FUNCS functions and $SECRETS secrets..."
echo "Done"