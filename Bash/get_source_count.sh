#!/bin/bash

# Get Source Count
# Prints the number of source files (going by file name pattern hardcoded
# below) in the current directory (recursive).

COUNT=0
for FN in `find . | grep "\.[cm]$"`; do
   COUNT=`echo 1+$COUNT | bc`
done
echo $COUNT