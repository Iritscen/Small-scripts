#!/bin/bash

# Back Up Unix Settings
# Saves the contents of your shell settings files into a text file, created
# at the path you set below.

WROTE_FIRST_FILE=0
BACKUP_DEST="$1"
WRITE_SEP1="echo \"----\" >> \"$BACKUP_DEST\""
WRITE_SEP2="echo -e \"\n----\n----\" >> \"$BACKUP_DEST\""

function backupSettingsFile()
{
  if [ $WROTE_FIRST_FILE -eq 0 ]; then
    echo "$1:" > "$BACKUP_DEST"
    WROTE_FIRST_FILE=1
  else
    echo "$1:" >> "$BACKUP_DEST"
  fi

  eval $WRITE_SEP1
  cat "$1" >> "$BACKUP_DEST"
  eval $WRITE_SEP2
}

backupSettingsFile "/etc/profile"
backupSettingsFile "/etc/bashrc"
backupSettingsFile "$HOME/.inputrc"
backupSettingsFile "$HOME/.bash_profile"