#!/bin/bash

# Rename Emails with Dates
# Changes the name of an email to be its date, since the usual name, e.g. 18642.emlx,
# is hardly useful, and this allows us to sort a folder of emails by their dates. To
# avoid serious malfunctions, copies of the emails are renamed, not the originals. Pass
# in the folder with the emails as parameter 1, and the path to a folder that can hold
# the renamed copies of the emails as parameter 2.
# Recommended width:
# |-----------------------------------------------------------------------------------|

SEARCH_PATH="$1"
DEST_PATH="$2"

# Set the field separator to a newline to avoid spaces in paths breaking our
# variable-setting
IFS="
"

for THE_FILE in `find "$SEARCH_PATH" | grep ".emlx$"`; do
   DATE_LINE=`grep --max-count=1 "^Date:" "$THE_FILE"`
   JUST_DATE=${DATE_LINE#Date: }
   SAFE_DATE=`date -j -f "%a, %d %b %Y %H:%M:%S %z" $JUST_DATE "+%Y-%m-%d--%H-%M-%S"`
   cp "$THE_FILE" "$DEST_PATH/$SAFE_DATE.emlx"
done