#!/bin/bash

# Find in Files and Copy
# A program that copies files to the specified folder based on their content.
# The search terms and file name search pattern are hardcoded out of sheer
# laziness. Parameter 1 is the folder to search and parameter 2 is the
# location to move matching files to.

declare -a SEARCH_TERMS=("Term 1" "Term 2")
SEARCH_PATH=$1
DEST_FOLDER=$2
SEARCH_FILES=.emlx$ # regex; the pattern "\.[ch]$" would search all files ending in ".c" or ".h"
SCANNED=0
FOUND=0

STR_FILES="files"

# Set the field separator to a newline to avoid spaces in paths breaking our
# variable-setting
IFS="
"

if [ ! -d "$DEST_FOLDER" ]; then
   echo "Error: Did not find the folder \"$DEST_FOLDER\". Aborting."
   exit
fi

for THE_FILE in `find "$SEARCH_PATH" | grep $SEARCH_FILES`; do
   let SCANNED+=1
   CONTENTS=`cat "$THE_FILE"`
   RESULT=""
   for THE_TERM in "${SEARCH_TERMS[@]}"; do
      RESULT=`echo $CONTENTS | grep --max-count=1 "$THE_TERM"`
      RESULT_CHARS=`echo -n "$RESULT" | wc -c`
      if [ $RESULT_CHARS -gt 1 ]; then
         THE_FILE_NAME=$(echo "$THE_FILE" | sed 's/.*\///') # clip file name from whole path
         echo "$THE_FILE_NAME matches search term \"$THE_TERM\". Copying."
         cp "$THE_FILE" "$DEST_FOLDER"
         let FOUND+=1
         break
      fi
   done
done

if [ $FOUND -eq 1 ]; then
   STR_FILES="file"
fi

echo "Scanned $SCANNED files matching pattern \"$SEARCH_FILES\". Matched and copied $FOUND $STR_FILES."