#!/bin/bash

# Back Up Unix Settings
# Saves the contents of your shell settings files into a text file, created
# at the path you set below.

HAVEWRITTENFIRSTFILE=0
UNIXSETTINGSBACKUP="/your/path/to/Unix settings backup.txt"
WRITESEPARATOR1="echo \"----\" >> \"$UNIXSETTINGSBACKUP\""
WRITESEPARATOR2="echo -e \"\n----\n----\" >> \"$UNIXSETTINGSBACKUP\""

function backupSettingsFile()
{
  if [ $HAVEWRITTENFIRSTFILE -eq 0 ]; then
    echo "$1:" > "$UNIXSETTINGSBACKUP"
    HAVEWRITTENFIRSTFILE=1
  else
    echo "$1:" >> "$UNIXSETTINGSBACKUP"
  fi

  eval $WRITESEPARATOR1
  cat "$1" >> "$UNIXSETTINGSBACKUP"
  eval $WRITESEPARATOR2
}

backupSettingsFile "/etc/profile"
backupSettingsFile "/etc/bashrc"
backupSettingsFile "/Users/you/.inputrc"
backupSettingsFile "/Users/you/.bash_profile"