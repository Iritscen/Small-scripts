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
<!--(none)-->
Backs up your shell settings in a single text file.

### [History Check](history_check.sh)
<!--(none)-->
Helps you to avoid exceeding your Bash command history limit and losing old history.

### [Last Boot Times](last_boot_times.sh)
<!--(none)-->
Lists when each mounted volume was last booted from (whether macOS or Windows).

### [List Startup Items](list_startup_items.sh)
<!--(none)-->
Lists all the files registered on a macOS system as launch daemons, launch agents, and general startup items.

### [Man Dump](man_dump.sh)
<!--Name of the Unix command.-->
Saves a readable plain-text copy of the man page for a given command.

### [Update MacPorts](update_macports.sh)
<!--(none)-->
A convenient interactive assistant for updating MacPorts and all installed ports.

---

## General File Management
### [Change File Suffixes](change_file_suffixes.sh)
<!--The directory to search.
The file suffix or suffix regex pattern to look for.
The new suffix to replace it with.-->
Changes all files of suffix X to suffix Y.

### [Collect Email Addresses](collect_email_addresses.sh)
<!--The directory containing the text files to search.
The directory in which to save the text file full of addresses.-->
Saves all email addresses found in a folder's text files or Apple Mail emails (.emlx).

### [Collect File Suffixes](collect_file_suffixes.sh)
<!--The directory to recursively collect suffixes from.-->
Prints out a list of all suffixes used by the files in a directory.

### [Collect Files by Type](collect_files_by_type.sh)
<!--The file type to collect (run script with no params to see your choices).
The directory to search recursively.
The folder in which to place copies of the selected files.
The copy mode ('f' for flat-copy, 'm' for mirror-copy).-->
Copies all files with a given suffix to a new directory.

### [Delete Files by Content](delete_files_by_content.sh)
<!--The directory in which to recursively search files. (Search terms are hardcoded.)-->
Moves files to Trash if they contain any of the specified search terms.

### [Delete Files by Name](delete_files_by_name.sh)
<!--The directory in which to recursively search for file names.
The regex pattern of file names to search for.-->
Moves files to Trash if their names match the given pattern.

### [Duplicate and Name](duplicate_and_name.sh)
<!--The path to the file to copy 'n' times.
The directory of files with the names to use for the copies.
The directory into which to make these copies.-->
Given file X and set of files Y in a given directory, makes one copy of X named for each file in Y.

### [Find Case Conflicts](find_case_conflicts.sh)
<!--(none)-->
Prints out directory items which would have a name conflict in a case-insensitive file system.

### [Find File A in File B](find_file_a_in_file_b.sh)
<!--The text file with a set of search terms.
The text file to search.-->
Prints out matching lines between file A and file B.

### [Find File Name in File](find_file_name_in_file.sh)
<!--The directory in which to recursively search files.
The text file with file names to search for.-->
Looks for items in a directory whose names are *not* listed in a given text file.

### [Find in Files](find_in_files.sh)
<!--The directory which should be recursively searched.
The regex pattern of file names to search for.
The regex pattern to look for in these files.
(optional) The amount of lines before the matching content that should be shown (default = 0).-->
Prints out lines from a folder of files which contain the given search term.

### [Find in Files and Copy](find_in_files_and_copy.sh)
<!--The directory which should be recursively searched. (Search terms and suffixes of files to search in are hardcoded.)
The directory to copy matching files into.-->
Copies files to a folder if they contain the given search term.

### [Find List in Files](find_list_in_files.sh)
<!--The directory in which to recursively search files.
The regex pattern of file names to search.
The text file with the terms to search for in these files.-->
Searches a directory for files containing any of the terms in a given text file.

### [Find Zero-Byte Files](find_zero_byte_files.sh)
<!--(none)-->
What it says on the tin.

### [Get EOL Type](get_eol_type.sh)
<!--The file to examine.-->
Tells user which type(s) of line endings a given file uses.

### [Get Info](get_info.sh)
<!--The directory to get info on.-->
Simulates the Get Info window on the command line by listing the size and item count of a directory.

### [Rename Emails with Dates](rename_emails_with_dates.sh)
<!--The directory of emails.
The directory to which to copy the emails.-->
Given a folder of .emlx files, assigns each one a name based on the date and time it was sent/received.

### [Rename Sequentially](rename_sequentially.sh)
<!--The directory with the files to rename.
The suffix of the files to rename.-->
Given a parent folder X, renames each file of a given suffix in X to be "X-#", where '#' is the alphabetical ordinal position of the file.

### [ZipSafe](zip_safe.sh)
<!--The directory to compress (ZIP is placed next to directory).-->
Creates Windows-friendly ZIPs that lack the Mac's invisible .DS_Store files, also omitting invisible Subversion and Git development directories.  Automator workflow version of this script found [here](../Automator).

---

## Image File Management
### [Convert Images](convert_images.sh)
<!--(none)-->
Converts all images of a given suffix to another format.

### [Create HTML Gallery](create_html_gallery.sh)
<!--The top directory of the folders full of images.-->
Creates an HTML directory listing of all subfolders, and an HTML gallery of all images in each subfolder.

### [Crop Images](crop_images.sh)
<!--The directory of images to create cropped copies of.
The width to crop them to.
The height to crop them to.
The left inset.
The top inset.-->
Crops a folder of images using a certain offset and size.

### [Find Images by Size](find_images_by_size.sh)
<!--The directory to search recursively for images.
The minimum desired width of results.
The word 'and' or 'or' (whether only the min. width or min. height needs to be met, or both).
The minimum desired height of results.
(optional) The word 'port' or 'land' for only portrait or only landscape results.-->
Prints out names of files that meet a minimum specified width/height and optional portrait/landscape orientation.

### [Resize Images](resize_images.sh)
<!--The directory in which to resize images. (Rest of parameters are hardcoded.)-->
Resizes all images of size X to size Y.

---

## Audio File Management
### [Total Sound Times](total_sound_times.sh)
<!--The directory of sound files to examine.-->
Gives the cumulative total time of all AIFFs in a folder.

---

## Development
### [Cloak Dev Paths](cloak_dev_paths.sh)
<!--(none)-->
Prevents your local disk's paths from showing up in an Xcode-built binary.

### [Find Header Comments](find_header_comments.sh)
<!--The directory in which to recursively search source files.-->
Isolates and prints the comment block from the top of each source file in a project.

### [Get Source Count](get_source_count.sh)
<!--(none)-->
Counts the source files in a project.

### [Get Source Length](get_source_length.sh)
<!--(none)-->
Counts the lines of code in a project.

### [Print Certificate Info](print_cert_info.sh)
<!--The directory in which to recursively search for applications.-->
Tells you the developer certificate signing authority for each app in a folder.

---

## Web
### [HTTP Tests](http_tests.sh)
<!--The type of response to obtain (run without parameters to see choices).
The URL to test.-->
Prints the response (status code, header, redirect URL, or Internet Archive status code) received upon querying a given URL.

### [Print Chromium History](print_chromium_history.sh)
<!--The path to the browser's history file (db must be unlocked).
The year of the desired history.
The month of the desired history.
The day of the desired history.
The time zone offset.-->
Tells you all the sites you visited in a Chromium-based browser on a given day.

### [Scrape Smugmug Images](scrape_smugmug_images.sh)
<!--The URL of a Smugmug gallery.
The directory in which to save the images.-->
Saves all images from a Smugmug album.
