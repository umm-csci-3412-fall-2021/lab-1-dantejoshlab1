#!/usr/bin/env bash

#Create variable named directory that has the value of the first argument that is passed into the script
directory=$1

#cd into the directory and go into its subdirectories or exit if the cd failed
cd "$directory"/var/log || exit


#Concatenate all files in the directory and then pipe that into an awk command that uses the following regex expression to match the required lines and then prints the capture groups in that regex expression and put that into a file called failed_login_data.txt
cat ./* | awk 'match($0, /([a-zA-z]{3} [ 0-9]{2}) ([0-9]{2})[0-9:]+ [a-zA-Z]+.+ Failed password .+ ([a-zA-Z0-9 ]+) from ([0-9.]+)/, groups) {print groups[1] " " groups[2] " " groups[3] " " groups[4]}' >  failed_login_data.txt


#Move the failed_login_data.txt file back into directory stored in the directory variable
mv failed_login_data.txt ../../
