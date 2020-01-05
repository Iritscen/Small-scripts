#!/bin/bash

# Get EOL Type
# Print out what sort of line endings a text file uses. Really just a user-
# friendly wrapper for 'dos2unix'.

bold=$(tput bold)
under=$(tput smul)
norm=$(tput sgr0)

RESULTS=$(dos2unix -idum "$1")
EOL_DOS=$(echo $RESULTS | cut -d " " -f 1)
EOL_UNIX=$(echo $RESULTS | cut -d " " -f 2)
EOL_MAC=$(echo $RESULTS | cut -d " " -f 3)

if [ $EOL_DOS != "0" ] && [ $EOL_UNIX == "0" ] && [ $EOL_MAC == "0" ]; then
   echo -e "$1:\n\033[38;5;117mThis is a DOS (CR+LF) file.\033[0m"
elif [ $EOL_DOS == "0" ] && [ $EOL_UNIX != "0" ] && [ $EOL_MAC == "0" ]; then
   echo -e "$1:\n\033[38;5;41mThis is a Unix (CR) file.\033[0m"
elif [ $EOL_DOS == "0" ] && [ $EOL_UNIX == "0" ] && [ $EOL_MAC != "0" ]; then
   echo -e "$1:\n\033[38;5;169mThis is a Mac (LF) file.\033[0m"
elif [ $EOL_DOS == "0" ] && [ $EOL_UNIX == "0" ] && [ $EOL_MAC == "0" ]; then
   echo -e "$1:\n${under}There are no line endings in this file!${norm}"
else
   echo -e "$1:\n${bold}The line endings are mixed: DOS=$EOL_DOS, UNIX=$EOL_UNIX, MAC=$EOL_MAC.${norm}"
fi