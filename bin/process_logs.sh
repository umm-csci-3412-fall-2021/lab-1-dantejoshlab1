#!/usr/bin/env bash

scratchDir=$(mktemp -d)
for var in "$@"
do
	name=$(basename "$var" .tgz)
	tar -zxf "$var" --directory "$scratchDir"
	./bin/process_client_logs.sh "$scratchDir"/"$name" 
done
