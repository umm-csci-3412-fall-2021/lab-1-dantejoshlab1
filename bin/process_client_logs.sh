#!/usr/bin/env bash

directory=$1

cd "$directory"/var/log || exit

cat ./* | awk 'match($0, /([a-zA-z]{3} [ 0-9]{2}) ([0-9]{2})[0-9:]+ [a-zA-Z]+.+ Failed password .+ ([a-zA-Z0-9 ]+) from ([0-9.]+)/, groups) {print groups[1] " " groups[2] " " groups[3] " " groups[4]}' >  failed_login_data.txt

mv failed_login_data.txt ../../
