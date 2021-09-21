#!/usr/bin/env bash

scratchDir=$(mktemp -d)

for var in "$@"
do
	name=$(basename "$var" .tgz)
        mkdir "$scratchDir"/"$name"
	tar -xzf "$var" --directory "$scratchDir"/"$name"
	./bin/process_client_logs.sh "$scratchDir"/"$name"	
done
./bin/create_username_dist.sh "$scratchDir"
./bin/create_hours_dist.sh "$scratchDir"
./bin/create_country_dist.sh "$scratchDir"
./bin/assemble_report.sh "$scratchDir"
mv "$scratchDir"/failed_login_summary.html "$PWD"
