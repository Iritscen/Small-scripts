#!/bin/bash

# Change File Suffixes
# A mass suffix-changing tool, for when the Finder's File>Rename option is too slow
# (it currently asks you to confirm a notable change to a suffix for each file).
# Parameter 1 is the file suffix to look for, and parameter 2 is the new suffix to
# replace it with.

OLD_SUFFIX=$1
NEW_SUFFIX=$2
FOUND=0

# Set the field separator to a newline to avoid spaces in paths breaking our
# variable-setting
IFS="
"

for FN in `find . | grep $OLD_SUFFIX `
do
   mv $FN ${FN%$OLD_SUFFIX}$NEW_SUFFIX
   let FOUND+=1
done

if [ $FOUND -eq 1 ]; then
   FILES="file"
fi

echo "Renamed $FOUND files."