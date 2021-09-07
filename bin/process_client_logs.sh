#!/usr/bin/env bash

directory=$1

cd "$directory"

cat * |  awk 'match($0, /([a-zA-z]{3} [0-9]{2}) ([0-9]{2})[0-9:]+ ([a-zA-z]+).+ Failed password .+ ([a-zA-z ]+) from ([0-9.]+)/, groups) {print groups[1] groups[2] groups[3] groups[4] groups[5] "\n"}' > failed_login_data.txt
