#!/bin/bash

# Crop Images
# Uses ImageMagick to create cropped copies of the JPGs in the current
# directory. The coordinates and size of the crop are hardcoded below.

IFS="
"

for ORIG in `find . -name "*.jpg"`; do
   CROP=${ORIG%.jpg}-crop.jpg

   if [ -f "$CROP" ]; then
      echo "Can't convert this image because the name $CROP is already taken."
      continue
   fi

   convert "$ORIG" -crop 640x480+604+360 "$CROP"
done