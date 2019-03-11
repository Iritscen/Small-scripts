#!/bin/bash

# Find in Files and Delete
# A program that moves files to the Trash based on their content.
# Recommended width:
# |---------------------------------------------------------------------------------------------|

declare -a SEARCH_TERMS=("Term 1" "Term 2")
SEARCH_PATH=$1
SEARCH_FILES=.emlx$ # regex; the pattern "\.[ch]$" would search all files ending in ".c" or ".h"
FOUND=0
THE_TIME=$(date "+%Y-%m-%d--%H-%M-%S")
TRASH_FOLDER="$HOME/.Trash/Deleted files ($THE_TIME)"
STR_FILES="files"

# Set the field separator to a newline to avoid spaces in paths breaking our variable-setting
IFS="
"

mkdir "$TRASH_FOLDER"
if [ ! -d "$TRASH_FOLDER" ]; then
   echo "Error: I could not create the folder \"$TRASH_FOLDER\". Aborting."
   exit
fi

for THE_FILE in `find "$SEARCH_PATH" | grep $SEARCH_FILES`; do
   CONTENTS=`cat "$THE_FILE"`
   RESULT=""
   for THE_TERM in "${SEARCH_TERMS[@]}"; do
      RESULT=`echo $CONTENTS | grep --max-count=1 "$THE_TERM"`
      RESULT_CHARS=`echo -n "$RESULT" | wc -c`
      if [ $RESULT_CHARS -gt 1 ]; then
         THE_FILE_NAME=$(echo "$THE_FILE" | sed 's/.*\///') # clip file name from whole path
         echo "$THE_FILE_NAME matches search term \"$THE_TERM\". Deleting."
         mv "$THE_FILE" "$TRASH_FOLDER"
         let FOUND+=1
         break
      fi
   done
done

if [ $FOUND -eq 1 ]; then
   STR_FILES="file"
fi

echo "Matched and deleted $FOUND $STR_FILES."