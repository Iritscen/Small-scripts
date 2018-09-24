#!/bin/bash

# Find In Files
# A simple file content search program. Usage details below.

# Set the field separator to a newline to avoid spaces in paths breaking our
# variable-setting
IFS="
"

# Show help if called without enough args
if [ "$#" -lt 3 ]; then
   echo "You need to supply the following three or four parameters:"
   echo "1. The directory which should be recursively searched."
   echo "2. The names of the files to be searched (regex permitted). For example, \"\.[ch]$\" would search all files ending in \".c\" or \".h\". \"\.[c]+$\" would find all .c and .cc files."
   echo "3. The search term to look for in these files (regex permitted)."
   echo "4. (optional) The amount of lines before the matching content that should be shown (zero by default)."
   exit 1
fi

# Set up globals
SEARCHDIR=$1
SEARCHFILES=$2
SEARCHTERM=$3
LOOKBACK=0
FOUND=0
FILES_STR="files"

# Set lookback if user specified it
if [ "$#" -eq 4 ]; then
   LOOKBACK=$4
fi

# Main loop
for FN in `find "$SEARCHDIR" | grep -E $SEARCHFILES`
do
   RESULT=""
   RESULT=`cat "$FN" | grep "$SEARCHTERM"`
   RESULT_CHARS=`echo -n "$RESULT" | wc -c`
   if [ $RESULT_CHARS -gt 1 ]; then
      RESULT_LINES=`echo "$RESULT" | wc -l | tr -d '[:space:]'`
      MATCHES_STR="matches"
      if [ $RESULT_LINES -eq 1 ]; then
         MATCHES_STR="match"
      fi
      echo -e "\033[1m$FN\033[0m ($RESULT_LINES $MATCHES_STR)" # print file name in bold
      cat "$FN" | grep -B $LOOKBACK "$SEARCHTERM" # then print grep results to screen
      echo - - - - - - - -
      let FOUND+=1
   fi
done

# Plural check the word "files"
if [ $FOUND -eq 1 ]; then
   FILES_STR="file"
fi

# Wrap-up message
echo "Found term in $FOUND $FILES_STR."
exit 0