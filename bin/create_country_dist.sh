#!/usr/bin/env bash

#Assign value of first argument to variable directory
directory=$1

#Make a temporary file
tempFile=$(mktemp /tmp/tmpFile.XXXXXX)
tempFile2=$(mktemp /tmp/tmpFile2.XXXXXX)

#cd into the directory stored in the variable directory or exit if not possible
cd "$directory" || exit

#Find all files that have name "failed_login_data.txt" in the directory
#After all files with that name have been, concatenate them into one file
#Pipe into awk command that gets the all the usernames from the combined file
#Sort that file
#Count up how many times each user name appears
#Pipe into awk command that grabs the username and the number of times it appears
#Print that and put it in the tempFile
find .  -name "failed_login_data.txt" -exec cat {} +  | awk 'match($0, /[a-zA-Z]{3} [0-9 ]+ [a-zA-Z0-9\w-]+ ([0-9.]+)/, groups) {print groups[1]}' | sort -t . -k 1 > "$tempFile"

cd - || exit
join "$tempFile" ./etc/country_IP_map.txt | awk '{print $2}' |  sort | uniq -c | awk '{print "data.addRow([\x27"$2"\x27, " $1"]);"}'  > "$tempFile2"

#Call wrap_contents to wrap the tempFile in between the username_dist header and footer
#Put that in a file called username_dist.html in the data directory
./bin/wrap_contents.sh "$tempFile2"  html_components/country_dist data/country_dist.html

rm "$tempFile"
rm "$tempFile2"
