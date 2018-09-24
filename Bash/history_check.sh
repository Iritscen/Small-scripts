#!/bin/bash

# History Check
# Checks the number of commands in your Bash shell history against the maximum
# number of commands that Bash is set to store. Assumes the presence of a
# setting for $HISTFILESIZE in your .bash_profile.

# This is a hack that allows you to use the 'history' command within a bash script
HISTFILE=~/.bash_history
set -o history

# Get last command's number by getting last line of 'history' output, then
# extracting field 2 as delimited by the ' ' character
HISTORY_CURSIZE=`history | tail -1 | cut -f 2 -d ' '`

# Get setting for maximum history commands on disk
HISTORY_MAXSIZE=`grep "HISTFILESIZE"  ~/.bash_profile | cut -f 2 -d ' ' | cut -f 2 -d '='`

echo "History is up to $HISTORY_CURSIZE commands, and the max allowed in .bash_profile is $HISTORY_MAXSIZE."