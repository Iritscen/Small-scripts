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
### [Back Up Unix Settings](back_up_unix_settings.sh)
Backs up your shell settings in a single text file.

### [History Check](history_check.sh)
Helps you to avoid exceeding your Bash command history limit and losing old history.

### [Last Boot Times](last_boot_times.sh)
Lists when each mounted volume was last booted from (whether macOS or Windows).

### [Man Dump](man_dump.sh)
Save a plain-text copy of the man page for a given command.

### [Update MacPorts](update_macports.sh)
A convenient interactive assistant for updating MacPorts and all installed ports.

---

## General File Management
### [Change File Suffixes](change_file_suffixes.sh)
Changes all files of suffix X to suffix Y.

### [Collect Email Addresses](collect_email_addresses.sh)
Saves all email addresses found in a folder's text files or Apple Mail emails (.emlx).

### [Collect File Suffixes](collect_file_suffixes.sh)
Prints out a list of all suffixes used by the files in a directory.

### [Collect Files by Type](collect_files_by_type.sh)
Copies all files with a given suffix to a new directory.

### [Delete Files by Content](delete_files_by_content.sh)
Moves files to Trash if they contain any of the specified search terms.

### [Delete Files by Name](delete_files_by_name.sh)
Moves files to Trash if their names match the given pattern.

### [Duplicate and Name](duplicate_and_name.sh)
Given file X and set of files Y in a given directory, copy X once for every file in Y and apply the names in Y to those copies.

### [Find Case Conflicts](find_case_conflicts.sh)
Print out directory items which would have a name conflict if they weren't stored in a case-sensitive file system.

### [Find File A in File B](find_file_a_in_file_b.sh)
Print out matching lines between file A and B.

### [Find File Name in File](find_file_name_in_file.sh)
Look for items in a directory which are *not* listed in a given text file.

### [Find in Files](find_in_files.sh)
Print out lines from a folder of files which contain the given search term.

### [Find in Files and Copy](find_in_files_and_copy.sh)
Copy files to another folder if they contain the specified search term.

### [Find List in Files](find_list_in_files.sh)
Search a directory for files containing any of the terms in a given text file.

### [Find Zero-Byte Files](find_zero_byte_files.sh)
What it says on the tin.

### [Get EOL Type](get_eol_type.sh)
Tells user which type(s) of line endings a given file uses.

### [Rename Emails with Dates](rename_emails_with_dates.sh)
Given a folder of .emlx files, assigns each one a name based on the date and time it was sent/received.

### [Rename Sequentially](rename_sequentially.sh)
Given a parent folder X, renames each file of a given suffix in X to be "X-#", where '#' is the alphabetical ordinal position of the file.

### [ZipSafe](zip_safe.sh)
Creates Windows-friendly ZIPs that lack the Mac's invisible .DS_Store files, also omitting invisible Subversion and Git development directories.  Automator workflow version of this script found [here](../Automator).

---

## Image File Management
### [Convert Images](convert_images.sh)
Converts all images of a given suffix to another format.

### [Create HTML Gallery](create_html_gallery.sh)
Creates a directory listing of all subfolders, and a gallery of all images in each subfolder.

### [Crop Images](crop_images.sh)
Crops a folder of images using a certain offset and size.

### [Resize Images](resize_images.sh)
Resize all images of size X to size Y.

---

## Audio File Management
### [Total Sound Times](total_sound_times.sh)
Gives the cumulative total time of all AIFFs in a folder.

---

## Development
### [Cloak Dev Paths](cloak_dev_paths.sh)
Prevent your local disk's paths from showing up in an Xcode-built binary.

### [Find Header Comments](find_header_comments.sh)
Extract and print comment blocks from the tops of all source files in a project.

### [Get Source Count](get_source_count.sh)
Count the source files in a project.

### [Get Source Length](get_source_length.sh)
Count the lines of code in a project.

### [Print Certificate Info](print_cert_info.sh)
Tells you the developer certificate signing authority for each app in a folder.

---

## Web
### [HTTP Tests](http_tests.sh)
Print the response (status code, header, redirect URL, or Internet Archive status code) received upon querying a given URL.

### [Print Chromium History](print_chromium_history.sh)
Tells you all the sites you visited in a Chromium-based browser on a given day.

### [Scrape Smugmug Images](scrape_smugmug_images.sh)
Saves all images from a Smugmug album.
