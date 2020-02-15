#!/bin/bash

# Collect File Suffixes
# A script which collects and prints out all the unique file
# suffixes in a directory. The only parameter required is the
# directory to recursively search.

IFS="
"

SEARCH_PATH=$1
declare -a SUFFIXES=()
LOOKED_AT=0

if [ ! -d "$SEARCH_PATH" ]; then
   echo "Error: \"$SEARCH_PATH\" does not exist. Aborting."
   exit
fi

for FILE in `find "$SEARCH_PATH" -type f`; do
   FILE_NAME=$(echo "$FILE" | sed 's/.*\///') # clip file name from whole path

   # If this is not a file with a name and suffix, skip it
   if [[ ! $FILE_NAME =~ [[:print:]]+\.[[:print:]]+$ ]]; then
      continue
   fi

   FILE_SUFFIX=${FILE_NAME##*.} # clip suffix from file name

   # Search for suffix in collection we've made so far
   shopt -s nocasematch
   COLLECTED=0
   for SUFFIX in "${SUFFIXES[@]}"; do
      if [ "$SUFFIX" == $FILE_SUFFIX ]; then
         COLLECTED=1
      fi
   done
   shopt -u nocasematch

   # If we haven't seen this suffix before now, add it to the array
   if [ $COLLECTED -eq 0 ]; then
      SUFFIXES+=($FILE_SUFFIX)
   fi

   let LOOKED_AT+=1
done

declare -a SORTED_SUFFIXES=($(sort <<< "${SUFFIXES[*]}"))
echo "Looked at $LOOKED_AT files. The suffixes found were: ${SORTED_SUFFIXES[@]}."