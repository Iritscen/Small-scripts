#!/bin/bash

# Collect Files by Type
# A script that copies files of the desired type from the subfolders in a directory to
# a new folder, preserving the original folder structure if desired. See below for usage.
# Recommended width:
# |--------------------------------------------------------------------------------------|

# Set the field separator to a newline to avoid spaces in paths breaking our
# variable-setting
IFS="
"

DESIRED_TYPE=$1
SEARCH_PATH="$2"
DEST_FOLDER="$3"
COPY_MODE=$4
declare -a BIOS_SUFFIXES=(bin rom0)
declare -a IMAGE_SUFFIXES=(gif jpg jpeg png tiff)
declare -a SOURCE_SUFFIXES=(c cc cpp cs h hpp js mm)
FOUND=0
STR_FILES="files"

# Help user if they are lost
if [ "$#" -lt 4 ] || [ $1 == "help" ]; then
   echo "You need to supply the following parameters:"
   echo "1. Desired file type. Use one of the following options:"
   echo "   'bios' (${BIOS_SUFFIXES[@]}),"
   echo "   'image' (${IMAGE_SUFFIXES[@]}), or"
   echo "   'source' (${SOURCE_SUFFIXES[@]})."
   echo "2. The directory to search recursively."
   echo "3. The folder in which to place copies of the selected files."
   echo "4. The mode in which to copy the files:"
   echo "   'm' will mirror the original folder structure, and"
   echo "   'f' will copy all files directly into the destination folder."
   exit
fi

# Process arguments
if [ $DESIRED_TYPE == "bios" ]; then
   declare -a DESIRED_SUFFIXES=(${BIOS_SUFFIXES[@]})
elif [ $DESIRED_TYPE == "image" ]; then
   declare -a DESIRED_SUFFIXES=(${IMAGE_SUFFIXES[@]})
elif [ $DESIRED_TYPE == "source" ]; then
   declare -a DESIRED_SUFFIXES=(${SOURCE_SUFFIXES[@]})
else
   echo "Unrecognized option for parameter 1! Read the help page for accepted options."
   exit
fi

if [ ! -d "$SEARCH_PATH" ]; then
   echo "Folder '$SEARCH_PATH' does not exist. Aborting."
   exit
fi

if [ ! -d "$DEST_FOLDER" ]; then
   echo "Folder '$DEST_FOLDER' does not exist. Aborting."
   exit
fi

if [ $COPY_MODE != "m" ] && [ $COPY_MODE != "f" ]; then
   echo "Unrecognized option for parameter 4! Read the help page for accepted options."
   exit
fi

# Checks to see if file name passed in is taken; if so, it attempts to add a number to
# the file name, and passes back the first available path that is found; function will
# exit script if no available path is found
function correctForPathConflict()
{
   isFile=

   if ! [ -a "$1" ]; then
      echo "$1"
      return
   elif [ -f "$1" ]; then
      isFile=true
   elif [ -d "$1" ]; then
      isFile=false
   else
      echo "Error: Encountered something that is not a file or directory: $1."
      exit 56
   fi

   ct=0
   TEST_PATH="$1"
   until [ $ct -eq 3000 ]
   do
      if [ -a "$TEST_PATH" ]; then
      let ct+=1
      # If this is a file, and it has a suffix, break the name up at the period so we
      # can insert the unique number at the end of the name and not the suffix
      if $isFile && [[ $1 == *.* ]]; then
         preDot=${1%.*}
         postDot=${1##*.}
         TEST_PATH="$preDot $ct.$postDot"
      else
         TEST_PATH="$1 $ct"
      fi
    else
       break
    fi
  done
  if [ $ct -eq 3000 ]; then
     # Just quit, because something is probably wrong
     echo "Error: Cannot find a place in $(dirname $1) for $(basename $1)."
     exit 57
  else
     echo "$TEST_PATH"
  fi
}

## MAIN SCRIPT ##
for FILE in `find "$SEARCH_PATH"`; do
   if ! [ -f "$FILE" ]; then
      continue
   fi

   FILE_NAME=$(echo "$FILE" | sed 's/.*\///') # clip file name from whole path

   # If this is not a file with a name and suffix, skip it
   if [[ ! $FILE_NAME =~ [[:print:]]+\.[[:print:]]+$ ]]; then
      continue
   fi

   FILE_SUFFIX=${FILE_NAME##*.} # clip suffix from file name

   # Search for suffix in list of desirable suffixes
   shopt -s nocasematch
   MATCH=0
   for SUFFIX in "${DESIRED_SUFFIXES[@]}"; do
      if [ "$SUFFIX" == $FILE_SUFFIX ]; then
         MATCH=1
         let FOUND+=1
      fi
   done
   shopt -u nocasematch

   if [ $MATCH -eq 1 ]; then
      if [ $COPY_MODE == "m" ]; then
         REL_PATH="${FILE#$SEARCH_PATH/}" # get path to file relative to starting dir.
         REL_PATH="${REL_PATH%$(basename $FILE)}" # cut file name from end
         mkdir -p "$DEST_FOLDER/$REL_PATH" && cp "$FILE" "$DEST_FOLDER/$REL_PATH"
      elif [ $COPY_MODE == "f" ]; then
         DESIRED_PATH="$DEST_FOLDER/$(basename $FILE)"
         CORRECTED_PATH=$(correctForPathConflict "$DESIRED_PATH")
         cp "$FILE" "$CORRECTED_PATH"
      fi
   fi
done

if [ $FOUND -eq 1 ]; then
   STR_FILES="file"
fi

echo "Collected $FOUND $DESIRED_TYPE $STR_FILES."