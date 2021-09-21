#!/usr/bin/env bash

#Store directory given as the first argument
directory=$1

#Create temp file
tempFile=$(mktemp /tmp/tmpFile.XXXXXX)

#Cd into directory given as an argument or exit if not possible
cd "$directory" || exit

#Cat all files that end in .html and put that in the temp file
cat ./*.html > "$tempFile" 

#Cd into the previous working directory
cd - || exit

#Call wrap contents on the temp file and wrap it between the summary_plots headers and footers
#Put that in a file with the path data/failed_login_summary.html
./bin/wrap_contents.sh  "$tempFile" ./html_components/summary_plots "$directory"/failed_login_summary.html

#Remove the temp file
rm "$tempFile"

