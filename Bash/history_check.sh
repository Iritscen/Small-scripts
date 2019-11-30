#!/bin/bash

# History Check
# Checks the number of commands in your Bash shell history against the maximum
# number of commands that Bash is set to store. Assumes the presence of a
# setting for $HISTFILESIZE in your .bash_profile.

# Get line count of history file by extracting first word of 'wc' output as
# delimited by the ' ' character
IFS=" "
HISTORY_WC_OUTPUT=`wc -l $HOME/.bash_history`
declare -a HISTORY_WC_OUTPUT_ARRAY=($HISTORY_WC_OUTPUT)
HISTORY_LINE_COUNT=${HISTORY_WC_OUTPUT_ARRAY[0]}

# Get setting for maximum history commands on disk
HISTORY_MAXSIZE=`grep "HISTFILESIZE"  $HOME/.bash_profile | cut -f 2 -d ' ' | cut -f 2 -d '='`

echo "History is up to $HISTORY_LINE_COUNT commands, and the max allowed per .bash_profile is $HISTORY_MAXSIZE."