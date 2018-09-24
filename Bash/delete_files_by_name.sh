#!/bin/bash

# Delete Files by Name
# A program that moves files to the Trash based on their name.
# Parameter 1 is the path to search recursively, and parameter 2 is the regex pattern
# to match file names against.

SEARCH_PATH=$1
SEARCH_FILES=$2
FOUND=0
THE_TIME=$(date "+%Y-%m-%d--%H-%M-%S")
TRASH_FOLDER="$HOME/.Trash/Deleted files ($THE_TIME)"
STR_FILES="files"

# Set the field separator to a newline to avoid spaces in paths breaking our
# variable-setting
IFS="
"

mkdir "$TRASH_FOLDER"
if [ ! -d "$TRASH_FOLDER" ]; then
   echo "Error: I could not create the folder \"$TRASH_FOLDER\". Aborting."
   exit
fi

for THE_FILE in `find "$SEARCH_PATH" | grep "$SEARCH_FILES"`; do
   THE_FILE_NAME=$(echo "$THE_FILE" | sed 's/.*\///') # clip file name from whole path
   mv "$THE_FILE" "$TRASH_FOLDER"
   let FOUND+=1
done

if [ $FOUND -eq 1 ]; then
   STR_FILES="file"
fi

echo "Matched and deleted $FOUND $STR_FILES."