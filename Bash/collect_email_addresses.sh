#!/bin/bash

# Collect Email Addresses
# Susses out all email addresses from text files in the directory
# you supply in parameter 1, and saves them in a file in the
# directory specified in parameter 2. Also works on Apple Mail's
# emails if you supply a directory like ~/Library/Mail/V5 and
# change the suffix grep below to "\.emlx".

IFS="
"

SEARCH_DIR=$1
DEST_DIR=$2

for FN in `find "$SEARCH_DIR" | grep "\.txt"`
do
   cat "$FN" | egrep -o "[0-9a-zA-Z._-]*@[0-9a-zA-Z._-]*\.[0-9a-zA-Z._-]*" >> "$DEST_DIR/my_addresses.txt"
done