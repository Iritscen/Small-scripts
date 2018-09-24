#!/bin/bash

# Find Zero-Byte Files
# Lists all files in the current directory that are zero bytes in size.

ls -ilR | egrep ^[[:digit:]]+[[:space:]]+[drwx@-]+[[:space:]]+[[:digit:]]+[[:space:]]+[[:alpha:]]+[[:space:]]+[[:alpha:]]+[[:space:]]+0