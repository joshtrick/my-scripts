#!/bin/bash
DATE=$(date '+%Y%m%d_%H%M%S')
LOG_DATE="$(date '+%Y-%m-%d %H:%M:%S')"
BASE_PATH=$(basename $(pwd))
PERSON_NAME="Mystic"
LOG_DIR="./output-logs"
CUSTOM_MSG=""
HELP_MSG_01="usage: bash-with-log -i|--input  file         #Script file name"
HELP_MSG_02="                    [-o|--output path]        #[Optional] Output path of log file, default=./output-logs"
HELP_MSG_03="                    [-w|--who    name]        #[Optional] Name of person running the command, default=Mystic"
HELP_MSG_04="                    [-c|--custom information] #[Optional] A custom info. added to log name"
HELP_MSG_05="                    [-h|--help]               #[Optional] Usage"
if [ -z "${1}" ]
then
  echo "$HELP_MSG_01"
  echo "$HELP_MSG_02"
  echo "$HELP_MSG_03"
  echo "$HELP_MSG_04"
  echo "$HELP_MSG_05"
  exit 0
fi
while [[ $# -gt 0 ]]
do
  key="${1}"
  case ${key} in
    -i|--input)
      CMD_NAME="${2}"
      shift # past argument
      shift # past value
      ;;
    -o|--output)
      LOG_DIR="${2}"
      shift # past argument
      shift # past value
      ;;
    -w|--who)
      PERSON_NAME="${2}"
      shift # past argument
      shift # past value
      ;;
    -c|--custom)
      CUSTOM_MSG="${2}"
      shift # past argument
      shift # past value
      ;;
    -h|--help)
      echo "$HELP_MSG_01"
      echo "$HELP_MSG_02"
      echo "$HELP_MSG_03"
      echo "$HELP_MSG_04"
      echo "$HELP_MSG_05"
      shift # past argument
      ;;
    *)    # unknown option
      shift # past argument
      ;;
  esac
done

if [ -z "${CUSTOM_MSG}" ]
then
  LOG_NAME="$DATE"_"$BASE_PATH"_"${CMD_NAME%.*}".log
else
  LOG_NAME="$DATE"_"$BASE_PATH"_"${CMD_NAME%.*}"_"$CUSTOM_MSG".log
fi

if [ -z "${CMD_NAME}" ]
then
  echo "Script to run not set."
  exit 0
fi

if [ ! -f $CMD_NAME ]
then
  echo "File '$CMD_NAME' not found."
  exit 0
fi

if [ "${PERSON_NAME}" = "Mystic" ]
then
  echo "------------------------------"
  echo "[WARNING] Whoever ran this command didn't record her/his name."
  echo "[WARNING] Please make sure this is allowed."
fi

if [ ! -d "$LOG_DIR" ]
then
  mkdir "$LOG_DIR"
fi
echo "Operation Date: $LOG_DATE"                         >> "$LOG_DIR"/"$LOG_NAME"
echo "Current Path  : $(pwd)"                            >> "$LOG_DIR"/"$LOG_NAME"
echo "Name          : $PERSON_NAME"                      >> "$LOG_DIR"/"$LOG_NAME"
echo "Script Name   : $CMD_NAME"                         >> "$LOG_DIR"/"$LOG_NAME"
echo "Command in Use:"                                   >> "$LOG_DIR"/"$LOG_NAME"
echo "------------------------------"                    >> "$LOG_DIR"/"$LOG_NAME"
echo "------------------------------"
cat $CMD_NAME |                                      tee -a "$LOG_DIR"/"$LOG_NAME"
echo "------------------------------"                    >> "$LOG_DIR"/"$LOG_NAME"
echo ""                                                  >> "$LOG_DIR"/"$LOG_NAME"
echo "Running Report:"                                   >> "$LOG_DIR"/"$LOG_NAME"
echo "------------------------------"                    >> "$LOG_DIR"/"$LOG_NAME"
echo "------------------------------"
bash $CMD_NAME |                                     tee -a "$LOG_DIR"/"$LOG_NAME"
echo "------------------------------"                    >> "$LOG_DIR"/"$LOG_NAME"
echo $CMD_NAME" finished @ $(date '+%Y-%m-%d %H:%M:%S')" >> "$LOG_DIR"/"$LOG_NAME"
if [ $PERSON_NAME = "Mystic" ]
then
  echo "------------------------------"
  echo "[WARNING] Whoever ran this command didn't record her/his name."
  echo "[WARNING] Please make sure this is allowed."
fi
