#!/bin/bash

# Find File Name in File
# Looks in the directory specified in parameter 1 for the file names
# listed in the text file specified in parameter 2. If the file name
# is not found, the file is declared "unique". File suffixes are
# ignored in this search. I have no idea why I wrote this.

IFS="
"

search_dir=$1
search_txt=$2
progress=0
total_files=`ls "$search_dir" | wc -l`

for each_file in `ls "$search_dir"`; do
   let progress+=1
   result=""
   result=`grep "${each_file%.*}" "$search_txt"`
   if [ -z "$result" ]; then
      echo "${each_file%.*} is unique."
   fi
   if [ $(($progress % 707)) == 0 ]; then
      echo "$(($progress / $total_files))% done."
   fi
done