#!/bin/bash
if [ "$1" = "" ]
then
  echo "usage: bash-with-log script_name [log_file_path]"
else
  if [ "$2" = "" ]
  then
    if [ ! -d ./output-logs ]
    then
      mkdir output-logs
    fi
    bash $1 | tee ./output-logs/$(date '+%y%m%d_%H%M%S')_$(basename $(pwd))_"${1%.*}".log
  else
    if [ ! -d "$2" ]
    then
      mkdir -p $2
    fi
    bash $1 | tee $2/$(date '+%y%m%d_%H%M%S')_$(basename $(pwd))_"${1%.*}".log
  fi
fi
