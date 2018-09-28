#!/bin/bash

# Resize Images
# Using ImageMagick, all images of a certain size are resized to new dimensions.
# The original is kept as *-old.jpg and the resized takes on the original's name.
# The only parameter is the directory to search. The rest must be hardcoded below.

IFS="
"

for IMAGE in `find "$1" -name "*.jpg"`; do
   IMAGE_WIDTH=$(identify -format "%[fx:w]" $IMAGE)
   IMAGE_HEIGHT=$(identify -format "%[fx:h]" $IMAGE)
   if [ $IMAGE_WIDTH -eq 512 ]; then
      ORIG=${IMAGE%.jpg}-old.jpg
      mv "$IMAGE" "$ORIG"

      # Resize without preserving proportions
      convert "$ORIG" -resize 600x450\! "$IMAGE"
   fi
done