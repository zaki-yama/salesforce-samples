#!/bin/bash

while getopts p:t: OPT
do
  case $OPT in
    p)  PROPERTY=$OPTARG
      ;;
    t)  TARGET=$OPTARG
      ;;
  esac
done

if [ -n "$PROPERTY" ]; then
  OPT_PROPERTY="-Dproperty=$PROPERTY"
fi

if [ -n "$TARGET" ]; then
  OPT_TARGET="-DretrieveTarget=$TARGET"
fi

ant retrieveCode $OPT_PROPERTY $OPT_TARGET
