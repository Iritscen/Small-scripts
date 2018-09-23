#!/bin/bash

# Convert Images
# Converts the images in the current directory from BMP to JPG using ImageMagick.

IFS="
"

for ORIG in `find . -name "*.bmp"`; do
   CONV=${ORIG%.bmp}.jpg

   if [ -f "$CONV" ]; then
      echo "Can't convert this image because the name $CONV is already taken."
      continue
   fi

   convert "$ORIG" "$CONV"
done