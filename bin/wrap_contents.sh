#!/usr/bin/env bash
# sets the variable first_file equal to the first argument passed to the script
first_file=$1
# sets the variable desired_name equal to the second argument passed to the script
desired_name=$2
# sets the variable second_file equal to the third argument passed to the script
second_file=$3
# wrap the first argument with the header.html and footer.html then places in the second file
cat "${desired_name}_header.html" "$first_file" "${desired_name}_footer.html" > "$second_file"
