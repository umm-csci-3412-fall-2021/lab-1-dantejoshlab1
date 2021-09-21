#!/usr/bin/env bash

#scratchDir=$(mktemp -d)

for var in "$@"
do
	name=$(basename "$var" .tgz)
        mkdir ./test3/"$name"
	tar -xzf "$var" --directory ./test3/"$name"
	./bin/process_client_logs.sh ./test3/"$name" 
done
