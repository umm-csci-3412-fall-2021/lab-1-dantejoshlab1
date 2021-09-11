#!/usr/bin/env bash

directory=$1

cd "$directory" || exit
find .  -name "failed_login_data.txt" -exec cat {} +  | awk 'match($0, /[a-zA-z]{3} [0-9]{2} [0-9]{2} [+ [a-zA-z]+ ([a-zA-z0-9 ]+) /, groups) {print groups[1]}' > output2.txt
sort output2.txt | uniq -c | awk 'match($0, / + ([0-9]+) ([a-zA-Z]+)/, groups) {print "data.addRow([\x27"groups[2]"\x27, " groups[1]"]);"}' > output4.txt  

