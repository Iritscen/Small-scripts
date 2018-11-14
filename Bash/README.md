# Small Scripts/Bash
Miscellaneous scripts that I've written for my own convenience. Hopefully you find them useful too. Comments in each script provide documentation. Intended to run in the latest version of the Bash shell that is provided in macOS.

Feel free to file an issue if a script is not working for you. Although I originally wrote these for myself, I would like them to be robust and reliable for other users too.

## Contents
[Unix/System](#unixsystem-management)

[General Files](#general-file-management)

[Image Files](#image-file-management)

[Audio Files](#audio-file-management)

[Development](#development)

[Web](#web)

---

## Unix/System Management
### Back Up Unix Settings
Backs up your shell settings in a single text file.

### History Check
Helps you to avoid exceeding your Bash command history limit and losing old history.

### Last Boot Times
Lists when each mounted volume was last booted from (whether macOS or Windows).

### Man Dump
Save a plain-text copy of the man page for a given command.

### Update MacPorts
A convenient interactive assistant for updating MacPorts and all installed ports.

---

## General File Management### Change File Suffixes
Changes all files of suffix X to suffix Y.

### Collect Email Addresses
Saves all email addresses found in a folder's text files or Apple Mail emails (.emlx).

### Collect File Suffixes
Prints out a list of all suffixes used by the files in a directory.

### Collect Files by Type
Copies all files with a given suffix to a new directory.

### Delete Files by Content
Moves files to Trash if they contain any of the specified search terms.

### Delete Files by Name
Moves files to Trash if their names match the given pattern.

### Duplicate and Name
Given file X and set of files Y in a given directory, copy X once for every file in Y and apply the names in Y to those copies.

### Find Case Conflicts
Print out directory items which would have a name conflict if they weren't stored in a case-sensitive file system.

### Find File A in File B
Print out matching lines between file A and B.

### Find File Name in File
Look for items in a directory which are *not* listed in a given text file.

### Find in Files
Print out lines from a folder of files which contain the given search term.

### Find in Files and Copy
Copy files to another folder if they contain the specified search term.

### Find List in Files
Search a directory for files containing any of the terms in a given text file.

### Find Zero-Byte Files
What it says on the tin.

### Get EOL Type
Tells user which type(s) of line endings a given file uses.

### Rename Emails with Dates
Given a folder of .emlx files, assigns each one a name based on the date and time it was sent/received.

### Rename Sequentially
Given a parent folder X, renames each file of a given suffix in X to be "X-#", where '#' is the alphabetical ordinal position of the file.

### ZipSafe
Creates Windows-friendly ZIPs that lack the Mac's invisible .DS_Store files, also omitting invisible Subversion and Git development directories.  Automator workflow version of this script found [here](../Automator).

---

## Image File Management
### Convert Images
Converts all images of a given suffix to another format.

### Create HTML Gallery
Creates a directory listing of all subfolders, and a gallery of all images in each subfolder.

### Crop Images
Crops a folder of images using a certain offset and size.

### Resize Images
Resize all images of size X to size Y.
---## Audio File Management
### Total Sound Times
Gives the cumulative total time of all AIFFs in a folder.

---

## Development
### Cloak Dev Paths
Prevent your local disk's paths from showing up in an Xcode-built binary.

### Find Header Comments
Extract and print comment blocks from the tops of all source files in a project.

### Get Source Count
Count the source files in a project.

### Get Source Length
Count the lines of code in a project.

### Print Certificate Info
Tells you the developer certificate signing authority for each app in a folder.
---## Web### HTTP Tests
Print the response (status code, header, redirect URL, or Internet Archive status code) received upon querying a given URL.

### Print Chromium History
Tells you all the sites you visited in a Chromium-based browser on a given day.

### Scrape Smugmug Images
Saves all images from a Smugmug album.