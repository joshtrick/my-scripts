#!/bin/bash
TIME=$(date '+%y%m%d-%H%M%S')
if [ ! -d ~/trash ]
then
  mkdir ~/trash
fi
if [ ! -d ~/trash/$TIME ]
then
  mkdir ~/trash/$TIME
fi
mv "$@" ~/trash/$TIME/
