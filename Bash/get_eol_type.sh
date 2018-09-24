#!/bin/bash

# Get EOL Type
# Print out what sort of line endings a text file uses. Really just a user-
# friendly wrapper for 'dos2unix'.

RESULTS=$(dos2unix -idum "$1")
EOL_DOS=$(echo $RESULTS | cut -d " " -f 1)
EOL_UNIX=$(echo $RESULTS | cut -d " " -f 2)
EOL_MAC=$(echo $RESULTS | cut -d " " -f 3)

if [ $EOL_DOS != "0" ] && [ $EOL_UNIX == "0" ] && [ $EOL_MAC == "0" ]; then
   echo "This is a DOS (CR+LF) file."
elif [ $EOL_DOS == "0" ] && [ $EOL_UNIX != "0" ] && [ $EOL_MAC == "0" ]; then
   echo "This is a Unix (CR) file."
elif [ $EOL_DOS == "0" ] && [ $EOL_UNIX == "0" ] && [ $EOL_MAC != "0" ]; then
   echo "This is a Mac (LF) file."
else
   echo "The line endings are mixed: DOS=$EOL_DOS, UNIX=$EOL_UNIX, MAC=$EOL_MAC."
fi