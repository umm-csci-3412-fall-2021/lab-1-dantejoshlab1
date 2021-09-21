#!/usr/bin/env bash

#Assign value of first argument to variable directory
directory=$1

#Make temporary files
tempFile=$(mktemp /tmp/tmpFile.XXXXXX)
tempFile2=$(mktemp /tmp/tmpFile2.XXXXXX)

#cd into the directory stored in the variable directory or exit if not possible
cd "$directory" || exit

#Find all files that have name "failed_login_data.txt" in the directory
#After all files with that name have been, concatenate them into one file
#Pipe into awk command that gets the all the IP addresses from the combined file
#Sort IP addresses 
#Put that output in the tempFile
find .  -name "failed_login_data.txt" -exec cat {} +  | awk 'match($0, /[a-zA-Z]{3} [0-9 ]+ [a-zA-Z0-9\w-]+ ([0-9.]+)/, groups) {print groups[1]}' | sort -t . -k 1 > "$tempFile"


#cd into previous working directory or exit if failure
cd - || exit

#Join the temp file with the country_IP_map file to map IP addresses to country codes
#Pipe into awk command that grabs the second column, the country codes, and prints those
#Sort the country codes 
#Count how many times the country codes show up
#Pipe into awk command that grabs the country codes and number of occurences and prints them in the proper format
#Put that in that in tempFile2
join "$tempFile" ./etc/country_IP_map.txt |  awk '{print $2}' |  sort | uniq -c | awk '{print "data.addRow([\x27"$2"\x27, " $1"]);"}'  > "$tempFile2"

#Call wrap_contents to wrap tempFile2 in between the country_dist  header and footer
#Put that in a file called country_dist.html in the data directory
./bin/wrap_contents.sh "$tempFile2"  html_components/country_dist "$directory"/country_dist.html

#Remove the temporary files
rm "$tempFile"
rm "$tempFile2"
