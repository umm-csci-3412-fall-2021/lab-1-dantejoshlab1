#!/usr/bin/env bash

directory=$1

tempFile=$(mktemp /tmp/tmpFile.XXXXXX)
cd "$directory" || exit
find .  -name "failed_login_data.txt" -exec cat {} +  | awk 'match($0, /[a-zA-Z]{3} [0-9 ]+ ([a-zA-Z0-9\w-]+)/, groups) {print groups[1]}' | sort| uniq -c | awk 'match($0, / + ([0-9]+) ([a-zA-Z0-9\w-]+)/, groups) {print "data.addRow([\x27"groups[2]"\x27, " groups[1]"]);"}' > "$tempFile"

cd - || exit
./bin/wrap_contents.sh "$tempFile"  html_components/username_dist data/username_dist.html
rm "$tempFile"


