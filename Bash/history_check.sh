#!/bin/bash

# History Check
# Checks the number of commands in your Bash shell history against the maximum
# number of commands that Bash is set to store. Assumes the presence of a
# setting for $HISTFILESIZE in your .bash_profile.

IFS=" "

# This is a hack that allows you to use the 'history' command within a bash script
HISTFILE=~/.bash_history
set -o history

# Get last command's number by getting last line of 'history' output, then
# extracting first word as delimited by the ' ' character
HISTORY_LASTLINE=`history | tail -1`
declare -a HISTORY_LASTLINE_SEP=($HISTORY_LASTLINE)
let HISTORY_CURSIZE+=HISTORY_LASTLINE_SEP[0]

# Get setting for maximum history commands on disk
HISTORY_MAXSIZE=`grep "HISTFILESIZE"  ~/.bash_profile | cut -f 2 -d ' ' | cut -f 2 -d '='`

echo "History is up to $HISTORY_CURSIZE commands, and the max allowed per .bash_profile is $HISTORY_MAXSIZE."