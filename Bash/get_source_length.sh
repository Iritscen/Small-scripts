#!/bin/bash

# Get Source Length
# Prints the total lines of code in the current directory (recursive).
# File name pattern to search for is hardcoded below.

IFS="
"

COUNT=0
for FN in `find . | grep "\.[cmh]$"`; do
   CUR=`cat "$FN" | wc -l`
   COUNT=`echo $CUR+$COUNT | bc`
done
echo $COUNT